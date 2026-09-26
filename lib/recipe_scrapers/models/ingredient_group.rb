# frozen_string_literal: true

module RecipeScrapers
  module Models
    # The ingredients under one heading of the page. {Models::Recipe#ingredient_groups} holds these.
    #
    # @!attribute [r] purpose
    #   @return [String, nil] the heading, such as "For the sauce", or nil for ungrouped ingredients
    # @!attribute [r] ingredients
    #   @return [Array<String>] the ingredient lines of the group
    # @!attribute [r] parsed_ingredients
    #   @return [Array<Models::Ingredient>, nil] the same lines split into an amount, a unit and a
    #     name, in the same order
    IngredientGroup = Data.define(:purpose, :ingredients, :parsed_ingredients) do
      def initialize(purpose:, ingredients:, parsed_ingredients: nil)
        super
      end
    end
  end
end
