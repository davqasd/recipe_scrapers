# frozen_string_literal: true

RecipeScrapers.register "zaubertopf.de" do
  ingredients rows: "div.entry-content > ul:first-of-type li"
  instructions rows: "div.entry-content > ol:first-of-type li"
end
