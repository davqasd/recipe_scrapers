# frozen_string_literal: true

RecipeScrapers.register "ahealthysliceoflife.com" do
  ingredients rows: ".tasty-recipes-ingredients-body p"
end
