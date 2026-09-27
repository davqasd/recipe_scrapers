# frozen_string_literal: true

module RecipeScrapers
  # Read what a page says. {SchemaOrg} is the one to subclass for a site.
  module Sources
    # Reads the fields of the schema.org Recipe a page publishes, from JSON-LD or from microdata.
    #
    # Every method answers the field of the same name on {Scraper}. A site that structures its markup
    # in its own way subclasses this class and overrides a method, then names the subclass with
    # {Scraper.schema_reader}. The steps of recipeInstructions are read by private methods that can be
    # overridden one at a time: steps_in, section_steps, step_steps and step_heading.
    class SchemaOrg
      FACET = /\A[\w-]+: /
      private_constant :FACET
      # @param readers [Array<Sources::JsonLd, Sources::Microdata>] the first one that finds a Recipe wins
      def initialize(*readers)
        @source = readers.find(&:recipe) || readers.first
        @data = @source.recipe || {}
      end

      # (see Models::Recipe#title)
      def title = Text.normalize(@data["name"])
      # (see Models::Recipe#description)
      def description = Text.normalize(@data["description"])
      # (see Models::Recipe#language)
      def language = Text.normalize(@data["inLanguage"])
      # (see Models::Recipe#site_name)
      def site_name = @source.website_name
      # (see Models::Recipe#category)
      def category = first_text(@data["recipeCategory"])
      # (see Models::Recipe#cuisine)
      def cuisine = first_text(@data["recipeCuisine"])
      # (see Models::Recipe#cooking_method)
      def cooking_method = first_text(@data["cookingMethod"])
      # (see Models::Recipe#yields)
      def yields = Parsers::Yields.parse(@data["recipeYield"])
      # (see Models::Recipe#total_time)
      def total_time = Parsers::Durations.minutes(@data["totalTime"])
      # (see Models::Recipe#cook_time)
      def cook_time = Parsers::Durations.minutes(@data["cookTime"])
      # (see Models::Recipe#prep_time)
      def prep_time = Parsers::Durations.minutes(@data["prepTime"])

      # (see Models::Recipe#author)
      def author
        names = [@data["author"]].flatten.filter_map { |entry| author_name(dereference(entry, :person)) }
        names.empty? ? nil : names.join(", ")
      end

      # (see Models::Recipe#ingredients)
      def ingredients = IngredientList.parse(@data["recipeIngredient"] || @data["ingredients"])

      # (see Models::Recipe#instructions_list)
      def instructions_list
        steps = steps_in(@data["recipeInstructions"])
        steps.empty? ? nil : steps
      end

      # (see Models::Recipe#instructions)
      def instructions = instructions_list&.join("\n")
      # (see Models::Recipe#image)
      def image = Text.normalize(url_in(@data["image"]))

      # (see Models::Recipe#keywords)
      def keywords
        words = [@data["keywords"]].flatten.flat_map { |entry| entry.to_s.split(",") }
        cleaned = words.filter_map { |word| Text.normalize(word) }.grep_v(FACET)
        cleaned.empty? ? nil : cleaned
      end

      # (see Models::Recipe#nutrients)
      def nutrients = NutritionFacts.parse(first_hash(@data["nutrition"]))

      # (see Models::Recipe#dietary_restrictions)
      def dietary_restrictions
        diets = Array(@data["suitableForDiet"]).filter_map do |diet|
          Text.normalize(diet.is_a?(Hash) ? diet["name"] : diet.to_s.split("/").last)
        end
        diets.empty? ? nil : diets
      end

      # (see Models::Recipe#ratings)
      def ratings = Parsers::Ratings.average(rating_node)
      # (see Models::Recipe#ratings_count)
      def ratings_count = Parsers::Ratings.count(rating_node)

      private

      def rating_node
        @rating_node ||= first_hash(dereference(first_hash(@data["aggregateRating"]), :rating))
      end

      def author_name(value) = Text.normalize(value.is_a?(Hash) ? value["name"] : value)

      def first_hash(value) = [value].flatten.grep(Hash).first

      def dereference(value, kind)
        return value unless value.is_a?(Hash) && value.keys == ["@id"]

        @source.public_send(kind, value["@id"])
      end

      def first_text(value) = Text.normalize(value.is_a?(Array) ? value.first : value)

      def url_in(value)
        case value
        when Array then url_in(value.first)
        when Hash then url_in(value["url"])
        else value
        end
      end

      def steps_in(value)
        case value
        when String then string_steps(value)
        when Array then value.flat_map { |item| listed_step(item) }
        when Hash then steps_in_hash(value)
        else []
        end
      end

      def string_steps(value)
        Text.split_lines(value).filter_map { |line| Text.normalize(line) }
      end

      def listed_step(value) = value.is_a?(String) ? [Text.normalize(value)].compact : steps_in(value)

      def steps_in_hash(value)
        types = Array(value["@type"]).map { |name| name.to_s.downcase }
        return section_steps(value) if types.include?("howtosection")
        return step_steps(value) if types.include?("howtostep")

        untyped_steps(value)
      end

      def section_steps(value)
        heading = Text.normalize(value["name"] || value["Name"])
        [heading].compact + steps_in(value["itemListElement"])
      end

      def step_steps(value)
        nested = value["itemListElement"]
        return [step_heading(value)].compact + steps_in(nested) if nested.is_a?(Array)

        text = nested.is_a?(Hash) ? nested["text"] : value["text"]
        [step_heading(value), Text.normalize(text)].compact
      end

      def step_heading(value)
        name = value["name"]
        return nil unless name.is_a?(String)
        return nil if value["text"].to_s.start_with?(name.sub(/\.+\z/, ""))

        Text.normalize(name)
      end

      def untyped_steps(value)
        return steps_in(value["itemListElement"]) if value["itemListElement"]

        [Text.normalize(value["text"] || value["name"])].compact
      end
    end
  end
end
