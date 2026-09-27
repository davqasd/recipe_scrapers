# frozen_string_literal: true

RecipeScrapers.register "festligare.se" do
  ingredients rows: "section.ArticleContent div.Recipe-ingredientsContent li"
  instructions rows: "section.ArticleContent div.Recipe-cookingContent li"
end
