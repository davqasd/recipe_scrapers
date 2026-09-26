# frozen_string_literal: true

module RecipeScrapers
  module Models
    # One nutrition fact split into its parts. {Models::Recipe#parsed_nutrients} holds these.
    #
    # @!attribute [r] name
    #   @return [String, nil] the key the page uses, such as "calories" or "fatContent"
    # @!attribute [r] unit
    #   @return [String, nil] "g", "mg", "µg", "kcal" or "kJ" for mass and energy, any other unit as written
    # @!attribute [r] amount
    #   @return [Float, nil] the number, with every decimal the page writes
    Nutrient = Data.define(:name, :unit, :amount) do
      def initialize(name: nil, unit: nil, amount: nil)
        super
      end
    end
  end
end
