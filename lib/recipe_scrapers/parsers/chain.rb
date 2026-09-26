# frozen_string_literal: true

module RecipeScrapers
  # Turn text into values.
  module Parsers
    # Runs the parsers of a field in order until one returns something. A parser returns a hash of
    # the model's attributes, which becomes the model, or nil. A parser that raises, or returns a
    # hash with an unknown key, goes to {Configuration#error_tracker}, and the next one is tried.
    #
    # @api private
    module Chain
      FIELDS = %i[ingredients nutrients].freeze
      MODELS = { ingredients: Models::Ingredient, nutrients: Models::Nutrient }.freeze
      private_constant :MODELS

      class << self
        def defaults
          { ingredients: [Ingredients], nutrients: [Nutrients] }
        end

        def field!(field)
          return field if FIELDS.include?(field)

          raise ArgumentError, "no parser can be set for #{field.inspect}, only for #{FIELDS.join(", ")}"
        end

        def run(field, parsers, text, language:)
          parsers.each do |parser|
            result = attempt(field, parser, text, language)
            return result unless result.nil?
          end
          nil
        end

        private

        def attempt(field, parser, text, language)
          model(field, parser.call(text, language: language))
        rescue StandardError => e
          RecipeScrapers.config.error_tracker.call(e)
          nil
        end

        def model(field, result)
          return result if result.nil? || result.is_a?(Data)

          MODELS.fetch(field).new(**result)
        end
      end
    end
  end
end
