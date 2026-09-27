# frozen_string_literal: true

RecipeScrapers.register "donalskehan.com" do
  title "h1"
  ingredients rows: "div#us p"
  instructions rows: "ol.list-group li"
end
