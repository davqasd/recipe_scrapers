# frozen_string_literal: true

RecipeScrapers.register "dish.co.nz" do
  ingredients rows: "div.ingredients-block__list p", split: true
  ingredient_groups heading: "div.ingredients-block__list strong"
  instructions rows: "div.recipe-block div.recipe > p"
end
