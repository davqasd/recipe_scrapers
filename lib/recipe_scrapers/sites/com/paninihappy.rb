# frozen_string_literal: true

RecipeScrapers.register "paninihappy.com" do
  title "h1.entry-title"
  ingredients rows: "div.hrecipe ul li"
  instructions rows: "div.hrecipe ol.instructions li"
end
