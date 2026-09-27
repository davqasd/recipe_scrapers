# frozen_string_literal: true

RecipeScrapers.register "thecookingguy.com" do
  ingredients rows: "div.card-text-holder div.w-richtext ul li"
  instructions rows: "div.card-text-holder div.w-richtext ol li"
end
