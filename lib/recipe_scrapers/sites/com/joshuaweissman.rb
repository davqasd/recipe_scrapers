# frozen_string_literal: true

RecipeScrapers.register "joshuaweissman.com" do
  ingredients rows: "article.ingredients-list li"
  instructions rows: "div.directions-list li"
end
