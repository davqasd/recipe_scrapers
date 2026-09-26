# frozen_string_literal: true

require "nokogiri"
require "uri"

module RecipeScrapers
  # Reads the recipe fields of one page. {RecipeScrapers.parse} builds one and returns its
  # {#to_recipe}, so an application gets a {Models::Recipe} and never the page itself. A field the
  # page does not publish is nil.
  #
  # Every field reads the site declaration first, then the schema.org recipe, then OpenGraph where
  # that applies. A site that needs code subclasses Scraper, names its host with {.host} and
  # registers with {Registry.register_class}.
  #
  # @example A site with its own schema.org reader
  #   class Chefkoch < RecipeScrapers::Scraper
  #     class SchemaReader < RecipeScrapers::Sources::SchemaOrg
  #       def ingredients = super&.map(&:strip)
  #     end
  #
  #     host "chefkoch.de"
  #     schema_reader SchemaReader
  #   end
  #   RecipeScrapers::Registry.register_class(Chefkoch)
  class Scraper
    include ParsedFields

    # Every field a scraper answers, in the order {#to_h} returns them.
    CONTRACT = (Models::Recipe.members - %i[url]).freeze

    class << self
      # Names the host a subclass reads, or returns it.
      #
      # @param value [String, nil]
      # @return [String, nil]
      def host(value = nil)
        @declared_host = value if value
        @declared_host
      end

      alias declared_host host

      # Sets the class that reads the schema.org recipe for a subclass, or returns it.
      #
      # @param value [Class<Sources::SchemaOrg>, nil]
      # @return [Class<Sources::SchemaOrg>] {Sources::SchemaOrg} unless a subclass sets its own
      def schema_reader(value = nil)
        @schema_reader = value if value
        @schema_reader || Sources::SchemaOrg
      end
    end

    # @return [String] the address the page was read from
    attr_reader :url

    # @return [Nokogiri::HTML5::Document] the parsed page, for a subclass that reads it directly
    attr_reader :document

    # @param html [String] the page source
    # @param url [String] the address of the page
    # @param declaration [Declaration, nil] the declaration of the site
    def initialize(html, url:, declaration: nil)
      @url = url
      @declaration = declaration
      @document = Nokogiri::HTML5(Text.recode(html, declaration&.encoding_name))
      @schema = self.class.schema_reader.new(Sources::JsonLd.new(@document), Sources::Microdata.new(@document))
      @open_graph = Sources::OpenGraph.new(@document)
      @declared = Sources::Declared.new(@document, declaration)
    end

    # (see Models::Recipe#host)
    def host
      URI.parse(url).host.to_s.delete_prefix("www.")
    end

    # (see Models::Recipe#canonical_url)
    def canonical_url
      link = document.at_css('link[rel="canonical"][href]')
      return url unless link

      URI.join(url, link["href"]).to_s
    rescue URI::Error
      url
    end

    # (see Models::Recipe#title)
    def title = @declared.text(:title) || @schema.title || @open_graph.title
    # (see Models::Recipe#author)
    def author = @declared.text(:author) || @schema.author
    # (see Models::Recipe#site_name)
    def site_name = @declared.text(:site_name) || @schema.site_name || @open_graph.site_name
    # (see Models::Recipe#language)
    def language = @declared.text(:language) || @schema.language || document_language
    # (see Models::Recipe#description)
    def description = @declared.text(:description) || @schema.description || @open_graph.description
    # (see Models::Recipe#category)
    def category = @declared.text(:category) || @schema.category
    # (see Models::Recipe#cuisine)
    def cuisine = @declared.text(:cuisine) || @schema.cuisine
    # (see Models::Recipe#cooking_method)
    def cooking_method = @declared.text(:cooking_method) || @schema.cooking_method
    # (see Models::Recipe#keywords)
    def keywords = @declared.rows(:keywords) || @schema.keywords
    # (see Models::Recipe#equipment)
    def equipment = @declared.rows(:equipment)
    # (see Models::Recipe#nutrients)
    def nutrients = @schema.nutrients
    # (see Models::Recipe#dietary_restrictions)
    def dietary_restrictions = @schema.dietary_restrictions
    # (see Models::Recipe#ratings)
    def ratings = @schema.ratings
    # (see Models::Recipe#ratings_count)
    def ratings_count = @schema.ratings_count

    # (see Models::Recipe#yields)
    def yields = Parsers::Yields.parse(@declared.text(:yields)) || @schema.yields
    # (see Models::Recipe#total_time)
    def total_time = Parsers::Durations.minutes(@declared.text(:total_time)) || @schema.total_time
    # (see Models::Recipe#cook_time)
    def cook_time = Parsers::Durations.minutes(@declared.text(:cook_time)) || @schema.cook_time
    # (see Models::Recipe#prep_time)
    def prep_time = Parsers::Durations.minutes(@declared.text(:prep_time)) || @schema.prep_time

    # (see Models::Recipe#ingredients)
    def ingredients
      lines = ingredient_sections.flat_map(&:last)
      lines.empty? ? nil : lines
    end

    # (see Models::Recipe#instructions_list)
    def instructions_list = @declared.rows(:instructions) || @schema.instructions_list
    # (see Models::Recipe#instructions)
    def instructions = instructions_list&.join("\n")

    # (see Models::Recipe#ingredient_groups)
    def ingredient_groups
      lines = ingredients
      return nil if lines.nil?

      marked = marked_groups(lines)
      groups = marked.any?(&:purpose) ? marked : Sources::IngredientGroups.from_sections(ingredient_sections)
      with_parsed_ingredients(groups)
    end

    # (see Models::Recipe#image)
    def image
      address = @declared.text(:image) || @schema.image || @open_graph.image
      address && URI.join(url, address).to_s
    rescue URI::Error
      address
    end

    # (see Models::Recipe#links)
    def links
      document.css("a[href]").map { |anchor| anchor["href"] }
    end

    # @return [Hash{Symbol => Object}] every field of {CONTRACT} with its value
    #
    # @api private
    def to_h
      CONTRACT.to_h { |field| [field, public_send(field)] }
    end

    # Reads every field once and returns them without the page.
    #
    # @return [Models::Recipe]
    #
    # @api private
    def to_recipe
      Models::Recipe.new(url: url, **to_h)
    end

    # @return [Boolean] whether the page has a title and ingredients
    #
    # @api private
    def recipe?
      !title.nil? && !ingredients.nil?
    end

    private

    def ingredient_sections
      @ingredient_sections ||=
        Sources::IngredientGroups.sections(@declared.rows(:ingredients) || @schema.ingredients || [])
    end

    def marked_groups(lines)
      rule = @declared.rule(:ingredient_groups)
      return Sources::IngredientGroups.detect(document: document, ingredients: lines) if rule.nil?

      Sources::IngredientGroups.call(document: document, ingredients: lines, heading: rule[:heading], item: rule[:item])
    end

    def document_language
      Text.normalize(document.at_css("html")&.[]("lang"))
    end
  end
end
