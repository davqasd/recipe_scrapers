# frozen_string_literal: true

RecipeScrapers.register "editions-larousse.fr" do
  ingredients rows: "div.Ingredients p"
  ingredient_groups heading: "div.Ingredients > h2", item: "div.Ingredients p"
  instructions rows: "div.Step p"
end
