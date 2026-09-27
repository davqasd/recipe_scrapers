# frozen_string_literal: true

RecipeScrapers.register "amazingoriental.com" do
  title "h1"
  ingredients rows: "div.ingredients-wrap li"
  ingredient_groups heading: "div.ingredients-wrap h5", item: "div.ingredients-wrap li"
  instructions rows: "div.text-wrap > h2 + ul > li", skip: "span.number"
end
