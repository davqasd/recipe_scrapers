# frozen_string_literal: true

RecipeScrapers.register "bongeats.com" do
  ingredients rows: "div.recipe-ingredients li"
  instructions rows: "div.recipe-process li"
end
