# frozen_string_literal: true

module RecipeScrapers
  module Models
    # The recipe a page holds, with every field already read. {RecipeScrapers.scrape} and
    # {RecipeScrapers.parse} return one. It is a Ruby Data object: frozen, compared by value, and free
    # of the page it came from. A field the page does not publish is nil.
    #
    # {#to_h} converts the nested value objects too, so the result holds only strings, numbers,
    # arrays and hashes, ready for JSON.
    #
    # @example
    #   recipe = RecipeScrapers.scrape("https://www.recipetineats.com/crispy-potato-straws-pommes-paille/")
    #   recipe.title                          # => "Crispy potato straws (Pommes Paille)"
    #   recipe.to_h[:parsed_ingredients].first
    #   # => { amount: 1.0, unit: nil, name: "potato, or other starchy or all-rounder potato" }
    #
    # @!attribute [r] url
    #   @return [String] the address the recipe was read from
    # @!attribute [r] title
    #   @return [String, nil] the name of the recipe
    # @!attribute [r] author
    #   @return [String, nil] the author, several joined with ", "
    # @!attribute [r] site_name
    #   @return [String, nil] the name of the website
    # @!attribute [r] language
    #   @return [String, nil] the language tag of the recipe, such as "en-US"
    # @!attribute [r] canonical_url
    #   @return [String] the canonical link of the page resolved against {Models::Recipe#url}, or the
    #     url itself when the page has none
    # @!attribute [r] host
    #   @return [String] the host of {Models::Recipe#url}, without "www."
    # @!attribute [r] description
    #   @return [String, nil] a sentence or short paragraph about the recipe
    # @!attribute [r] image
    #   @return [String, nil] the address of the main image, resolved against {Models::Recipe#url}
    # @!attribute [r] ingredients
    #   The ingredient lines as the page writes them. A line with no letter and no digit, such as
    #   "*", is a separator and left out. A line that ends in a colon and has no digit, such as
    #   "For the sauce:", is a group heading and goes to {Models::Recipe#ingredient_groups}
    #   instead. See {Models::Recipe#parsed_ingredients}.
    #
    #   @return [Array<String>, nil]
    # @!attribute [r] parsed_ingredients
    #   Every line of {Models::Recipe#ingredients}, in the same order, split into an amount, a unit and a name.
    #
    #   @example
    #     recipe.parsed_ingredients.first.to_h # => { amount: 1.5, unit: "cups", name: "vegetable oil" }
    #   @return [Array<Models::Ingredient>, nil]
    # @!attribute [r] ingredient_groups
    #   The ingredients in the groups the page shows, such as "For the sauce". The groups come from
    #   the HTML when the page marks them up, otherwise from the heading lines of the ingredient
    #   list. A page without groups gives one group with a nil purpose.
    #
    #   @return [Array<Models::IngredientGroup>, nil] nil when the page has no ingredients
    # @!attribute [r] instructions_list
    #   @return [Array<String>, nil] the steps, with section headings as their own entries
    # @!attribute [r] instructions
    #   @return [String, nil] the steps joined with newlines
    # @!attribute [r] category
    #   @return [String, nil] the course, such as "Dessert"
    # @!attribute [r] cuisine
    #   @return [String, nil] the cuisine, such as "Italian"
    # @!attribute [r] cooking_method
    #   @return [String, nil] how it is cooked, such as "Baking"
    # @!attribute [r] keywords
    #   @return [Array<String>, nil] the keywords, without facet entries such as "diet: vegan"
    # @!attribute [r] dietary_restrictions
    #   @return [Array<String>, nil] the diets the recipe suits, such as "VeganDiet"
    # @!attribute [r] equipment
    #   @return [Array<String>, nil] the tools a site declares, schema.org has none
    # @!attribute [r] yields
    #   @return [String, nil] how much it makes, as "4 servings" or "12 items"
    # @!attribute [r] total_time
    #   @return [Integer, nil] the total time in minutes
    # @!attribute [r] prep_time
    #   @return [Integer, nil] the preparation time in minutes
    # @!attribute [r] cook_time
    #   @return [Integer, nil] the cooking time in minutes
    # @!attribute [r] nutrients
    #   The nutrition facts as the page publishes them, keyed by the schema.org property name.
    #   Nothing is parsed here. See {Models::Recipe#parsed_nutrients}.
    #
    #   @example
    #     recipe.nutrients # => { "calories" => "219 kcal", "fatContent" => "7 g" }
    #   @return [Hash{String => String}, nil]
    # @!attribute [r] parsed_nutrients
    #   Every entry of {Models::Recipe#nutrients}, in the order the page lists them, split into a name, a unit
    #   and an amount. The name is the key the page uses. A value with no number is left out.
    #
    #   @example
    #     recipe.parsed_nutrients.first.to_h # => { name: "calories", unit: "kcal", amount: 219.0 }
    #   @return [Array<Models::Nutrient>, nil]
    # @!attribute [r] ratings
    #   @return [Float, nil] the average rating
    # @!attribute [r] ratings_count
    #   @return [Integer, nil] how many ratings the average is made of
    # @!attribute [r] links
    #   @return [Array<String>] the href of every link on the page, as written
    Recipe = Data.define(
      :url, :title, :author, :site_name, :language, :canonical_url, :host, :description, :image, :ingredients,
      :parsed_ingredients, :ingredient_groups, :instructions_list, :instructions, :category, :cuisine,
      :cooking_method, :keywords, :dietary_restrictions, :equipment, :yields, :total_time, :prep_time, :cook_time,
      :nutrients, :parsed_nutrients, :ratings, :ratings_count, :links
    ) do
      # The recipe as plain data. Every nested value object becomes a hash as well.
      #
      # @return [Hash{Symbol => Object}]
      def to_h(&)
        super.transform_values { |value| plain(value) }.to_h(&)
      end

      private

      def plain(value)
        case value
        when Data then plain(value.to_h)
        when Hash then value.transform_values { |item| plain(item) }
        when Array then value.map { |item| plain(item) }
        else value
        end
      end
    end
  end
end
