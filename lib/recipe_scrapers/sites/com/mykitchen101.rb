# frozen_string_literal: true

RecipeScrapers.register "mykitchen101.com" do
  title "h1.entry-title"
  ingredients rows: "div.wprm-fallback-recipe-ingredients li"
  instructions rows: "div.wprm-fallback-recipe-instructions li"
end
