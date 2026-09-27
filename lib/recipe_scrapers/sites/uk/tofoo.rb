# frozen_string_literal: true

RecipeScrapers.register "tofoo.co.uk" do
  title "h1"
  ingredients rows: "div.recipe_details__ingredients li"
  instructions rows: "div.recipe_details__steps li"
end
