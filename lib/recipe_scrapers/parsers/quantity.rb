# frozen_string_literal: true

module RecipeScrapers
  module Parsers
    module Quantity
      NUMBER = /\d+(?:[.,]\d+)?/
      SLASH_FRACTION = %r{\d+\s*[/⁄]\s*\d+}
      VULGAR = /[½⅓⅔¼¾⅕⅖⅗⅘⅙⅚⅐⅛⅜⅝⅞⅑⅒]/
      JOINER = /\s+(?:and|und|y|e)\s+|\s*と\s*/
      QUANTITY = /
        \d+(?:#{JOINER}|\s*)#{VULGAR}|\d+(?:#{JOINER}|\s+)#{SLASH_FRACTION}|#{SLASH_FRACTION}|#{NUMBER}|#{VULGAR}
      /xo
      PLUS = /\s*\+\s*/
      SUM = /#{QUANTITY}(?:#{PLUS}#{QUANTITY})*/o
      SLASH_SPACING = %r{\s*([/⁄])\s*}
      WHOLE_AND_FRACTION = /#{JOINER}|\s+|(?=#{VULGAR})/o

      class << self
        def value(sum)
          amount = total(sum).round(2)
          amount.zero? ? nil : amount
        end

        def total(sum)
          sum.split(PLUS).sum { |term| term_value(term) }.to_f
        end

        private

        def term_value(term)
          whole, fraction = term.gsub(SLASH_SPACING, "\\1").split(WHOLE_AND_FRACTION, 2)
          part_value(whole) + part_value(fraction)
        end

        def part_value(part)
          return 0 if part.nil?

          numerator, denominator = part.unicode_normalize(:nfkd).split(%r{[/⁄]})
          return Rational(numerator.to_i, denominator.to_i) if denominator.to_i.positive?

          Rational(numerator.tr(",", "."))
        end
      end
    end
  end
end
