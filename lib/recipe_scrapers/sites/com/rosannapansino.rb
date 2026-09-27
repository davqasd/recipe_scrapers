# frozen_string_literal: true

RecipeScrapers.register "rosannapansino.com" do
  ingredients rows: "div.recipe-content div.recipe-left > ul:first-of-type > li"
  instructions rows: "div.recipe-content div.recipe-right li"
end
