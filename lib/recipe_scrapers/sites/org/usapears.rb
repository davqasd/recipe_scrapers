# frozen_string_literal: true

RecipeScrapers.register "usapears.org" do
  title "h1"
  ingredients rows: "#print-content ul li"
  instructions rows: "#print-content ol li"
end
