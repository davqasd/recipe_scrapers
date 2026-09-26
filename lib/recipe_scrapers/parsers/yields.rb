# frozen_string_literal: true

module RecipeScrapers
  module Parsers
    module Yields
      SERVING_WORDS = /serv|portion|порц|person|people/i
      NUMBER = /(\d+)/

      class << self
        def parse(value)
          return nil if value.nil?

          text = Text.normalize(value.is_a?(Array) ? value.first : value)
          return nil if text.nil?

          count = text[NUMBER, 1]
          return nil if count.nil?

          "#{count} #{noun_for(text, count)}"
        end

        private

        def noun_for(text, count)
          text.match?(SERVING_WORDS) || text == count ? "servings" : "items"
        end
      end
    end
  end
end
