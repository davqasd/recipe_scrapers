# frozen_string_literal: true

module RecipeScrapers
  module Parsers
    module Ratings
      DECIMAL = /\d+(?:[.,]\d+)?/
      DIGIT_GROUPING = /[,. ]/

      class << self
        def average(node)
          return nil if node.nil?

          value = node["ratingValue"].to_s[DECIMAL]&.tr(",", ".")&.to_f
          value&.positive? ? value : nil
        end

        def count(node)
          return nil if node.nil?

          total = (node["ratingCount"] || node["reviewCount"]).to_s.gsub(DIGIT_GROUPING, "")[/\A\d+/]&.to_i
          total&.positive? ? total : nil
        end
      end
    end
  end
end
