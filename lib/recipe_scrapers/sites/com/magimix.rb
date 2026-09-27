# frozen_string_literal: true

RecipeScrapers.register "magimix.com" do
  title "h1.recipe-title"
  ingredients rows: "div.recipe-ingredients-content p"
  instructions rows: "div.recipe-step-title", skip: "span.step-number"
end
