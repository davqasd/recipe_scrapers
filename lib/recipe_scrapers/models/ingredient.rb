# frozen_string_literal: true

module RecipeScrapers
  # The value objects the gem returns.
  module Models
    # One ingredient line split into its parts. {Models::Recipe#parsed_ingredients} holds these.
    #
    # @!attribute [r] amount
    #   @return [Float, nil] the quantity, rounded to two places. A range keeps its lower bound
    # @!attribute [r] unit
    #   @return [String, nil] the unit as the page writes it, such as "cups" or "g"
    # @!attribute [r] name
    #   @return [String, nil] the ingredient, without text in parentheses
    Ingredient = Data.define(:amount, :unit, :name) do
      def initialize(amount: nil, unit: nil, name: nil)
        super
      end
    end
  end
end
