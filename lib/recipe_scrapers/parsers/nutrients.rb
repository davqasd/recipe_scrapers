# frozen_string_literal: true

module RecipeScrapers
  module Parsers
    # The bundled parser of nutrient values. It reads the first number and the word after it, and
    # drops text in parentheses. Mass and energy units are written as symbols, so "grams" and "г" become
    # "g" and "calories" becomes "kcal".
    #
    # @example
    #   RecipeScrapers::Parsers::Nutrients.call("12.5 grams").to_h # => { name: nil, unit: "g", amount: 12.5 }
    module Nutrients
      PARENTHESES = /\([^()]*\)/
      CONNECTORS = %w[of de di].freeze
      MEASURE = /(?<amount>#{Quantity::QUANTITY})\s*(?<unit>[\p{L}µ][\p{L}-]*)?/o
      CANONICAL_UNITS = {
        "g" => %w[g gr grs gram grams gramm gramos gramas grammi gramme grammes г гр грамм грамма граммов],
        "mg" => %w[mg milligram milligrams milligramm мг],
        "µg" => %w[µg μg mcg microgram micrograms мкг],
        "kcal" => %w[
          kcal kcals kkal cal cals calorie calories kalorien kalorier calorías calorias ккал калорий калории
        ],
        "kJ" => %w[kj кдж]
      }.flat_map { |canonical, spellings| spellings.map { |spelling| [spelling, canonical] } }.to_h.freeze
      private_constant :PARENTHESES, :CONNECTORS, :MEASURE, :CANONICAL_UNITS

      class << self
        # @param text [String] one nutrient value
        # @return [Models::Nutrient, nil] without a name, which {Models::Recipe#parsed_nutrients} fills in. Nil
        #   when the value has no number
        def call(text, **)
          match = text.to_s.gsub(PARENTHESES, " ").match(MEASURE)
          return nil if match.nil?

          Models::Nutrient.new(amount: Quantity.total(match[:amount]), unit: unit(match[:unit]))
        end

        private

        def unit(written)
          return nil if written.nil? || CONNECTORS.include?(written.downcase)

          CANONICAL_UNITS.fetch(written.downcase, written)
        end
      end
    end
  end
end
