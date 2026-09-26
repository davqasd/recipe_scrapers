# frozen_string_literal: true

module RecipeScrapers
  class Scraper
    # The fields that split text into value objects, with the parsers {Configuration#parsers} holds.
    module ParsedFields
      # @param scraper [Class<Scraper>] gets {ClassMethods}
      # @return [void]
      #
      # @api private
      def self.included(scraper)
        scraper.extend(ClassMethods)
      end

      # The class methods a scraper class gets from {ParsedFields}.
      module ClassMethods
        # Sets the parsers of a field for every page of this scraper class. It wins over the site
        # declaration and the configuration.
        #
        # @param field [Symbol] :ingredients or :nutrients
        # @param parsers [Array<#call>] tried in order, the first result that is not nil wins
        # @raise [ArgumentError] for a field that takes no parser
        def parser(field, *parsers)
          own_parsers[Parsers::Chain.field!(field)] = parsers
        end

        # @return [Hash{Symbol => Array<#call>}] the parsers this class sets with {#parser}
        #
        # @api private
        def own_parsers
          @own_parsers ||= {}
        end
      end

      # (see Models::Recipe#parsed_ingredients)
      def parsed_ingredients
        spoken = language
        ingredients&.map { |line| parse(:ingredients, line, spoken) }
      end

      # (see Models::Recipe#parsed_nutrients)
      def parsed_nutrients
        spoken = language
        parsed = nutrients.to_h.filter_map do |name, text|
          nutrient = parse(:nutrients, text, spoken)
          nutrient && (nutrient.name ? nutrient : nutrient.with(name: name))
        end
        parsed.empty? ? nil : parsed
      end

      private

      def with_parsed_ingredients(groups)
        spoken = language
        groups.map do |group|
          group.with(parsed_ingredients: group.ingredients.map { |line| parse(:ingredients, line, spoken) })
        end
      end

      def parse(field, text, spoken)
        Parsers::Chain.run(field, parsers_for(field), text, language: spoken)
      end

      def parsers_for(field)
        self.class.own_parsers[field] || @declaration&.parsers_for(field) || RecipeScrapers.config.parsers.fetch(field)
      end
    end
  end
end
