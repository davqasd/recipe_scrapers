# frozen_string_literal: true

RecipeScrapers.register "recipe.yamasa.com" do
  ingredients rows: "table.ingredients tr"
  instructions rows: "div.hidden-xs ol.instructions li"
end
