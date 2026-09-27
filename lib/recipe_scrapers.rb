# frozen_string_literal: true

require_relative "recipe_scrapers/version"
require_relative "recipe_scrapers/errors"
require_relative "recipe_scrapers/error_tracker"
require_relative "recipe_scrapers/text"
require_relative "recipe_scrapers/models/ingredient"
require_relative "recipe_scrapers/models/nutrient"
require_relative "recipe_scrapers/models/ingredient_group"
require_relative "recipe_scrapers/models/recipe"
require_relative "recipe_scrapers/parsers/quantity"
require_relative "recipe_scrapers/parsers/vocabulary"
require_relative "recipe_scrapers/parsers/ingredients"
require_relative "recipe_scrapers/parsers/nutrients"
require_relative "recipe_scrapers/parsers/chain"
require_relative "recipe_scrapers/parsers/durations"
require_relative "recipe_scrapers/parsers/yields"
require_relative "recipe_scrapers/parsers/ratings"
require_relative "recipe_scrapers/sources/json_ld"
require_relative "recipe_scrapers/sources/microdata"
require_relative "recipe_scrapers/sources/open_graph"
require_relative "recipe_scrapers/sources/declared"
require_relative "recipe_scrapers/sources/ingredient_groups"
require_relative "recipe_scrapers/sources/schema_org"
require_relative "recipe_scrapers/sources/schema_org/ingredient_list"
require_relative "recipe_scrapers/sources/schema_org/step_labels"
require_relative "recipe_scrapers/sources/schema_org/nutrition_facts"
require_relative "recipe_scrapers/scraper/parsed_fields"
require_relative "recipe_scrapers/scraper"
require_relative "recipe_scrapers/declaration"
require_relative "recipe_scrapers/registry"
require_relative "recipe_scrapers/site_path"
require_relative "recipe_scrapers/http/address_guard"
require_relative "recipe_scrapers/http/adapter"
require_relative "recipe_scrapers/http/follow_redirects"
require_relative "recipe_scrapers/http/body_limit"
require_relative "recipe_scrapers/http/encoding"
require_relative "recipe_scrapers/configuration"

# Reads structured recipes from cooking websites.
#
# The gem reads the schema.org JSON-LD or microdata a page publishes, falls back to OpenGraph, and
# takes a site declaration where a site publishes neither. {scrape} fetches a page, {parse} reads
# HTML you already have, and both return a {Models::Recipe}.
#
# @example Fetch and read a recipe
#   recipe = RecipeScrapers.scrape("https://www.recipetineats.com/crispy-potato-straws-pommes-paille/")
#   recipe.title       # => "Crispy potato straws (Pommes Paille)"
#   recipe.ingredients # => ["1 potato (Aus: Sebago, US: russet, UK: Maris Piper), ...", ...]
module RecipeScrapers
  class << self
    # Reads a recipe from HTML that is already fetched.
    #
    # @param html [String] the page source
    # @param url [String] the address of the page, used to pick the site and to resolve relative links
    # @param supported_only [Boolean] raise for a host the gem does not support. Pass false to read
    #   any page that publishes schema.org or OpenGraph markup
    # @return [Models::Recipe]
    # @raise [UnsupportedSite] when the host is not registered and supported_only is true
    # @raise [RecipeNotFound] when the page has no title or no ingredients
    def parse(html, url:, supported_only: true)
      entry = Registry.for(url)
      raise UnsupportedSite, "no scraper registered for #{url}" if entry.nil? && supported_only

      scraper = build_scraper(entry, html, url)
      raise RecipeNotFound, "no recipe found at #{url}" unless scraper.recipe?

      scraper.to_recipe
    end

    # Fetches a page and reads its recipe.
    #
    # The page is fetched through {Configuration#connection}, which follows redirects, refuses private
    # addresses and caps the body size, unless you pass your own connection.
    #
    # @param url [String] the address of the recipe page
    # @param connection [Faraday::Connection, nil] the connection to fetch with
    # @param supported_only [Boolean] see {parse}
    # @return [Models::Recipe]
    # @raise [UnsupportedSite] see {parse}
    # @raise [RecipeNotFound] see {parse}
    # @raise [BlockedAddress, TooManyRedirects, ResponseTooLarge] when the fetch is refused
    # @raise [Faraday::Error] when the fetch fails after the configured retries
    def scrape(url, connection: nil, supported_only: true)
      response = (connection || config.connection).get(url)
      parse(response.body, url: url, supported_only: supported_only)
    end

    # Registers a site by declaration. A shortcut for {Registry.register}.
    #
    # @example
    #   RecipeScrapers.register "example.com" do
    #     title "h1.recipe-title"
    #     ingredients rows: "ul.ingredients li"
    #   end
    # @return [Declaration]
    def register(...)
      Registry.register(...)
    end

    # The settings every fetch and parse uses.
    #
    # @return [Configuration]
    def config
      @config ||= Configuration.new
    end

    # Changes the settings in a block.
    #
    # @example
    #   RecipeScrapers.configure do |config|
    #     config.timeout = 30
    #   end
    # @yieldparam config [Configuration]
    # @return [Configuration]
    def configure
      yield(config)
      config
    end

    # Throws the settings away, so the next {config} call starts from the defaults.
    #
    # @return [void]
    def reset_config!
      @config = nil
    end

    private

    def build_scraper(entry, html, url)
      return entry.new(html, url: url) if entry.is_a?(Class)

      Scraper.new(html, url: url, declaration: entry)
    end
  end
end

Dir[File.expand_path("recipe_scrapers/sites/**/*.rb", __dir__)].each { |file| require file }
