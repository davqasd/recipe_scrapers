# frozen_string_literal: true

RecipeScrapers.register "pauladeen.com" do
  ingredients rows: "section#ingredients li"
  instructions rows: "section.directions div.directions__content p"
end
