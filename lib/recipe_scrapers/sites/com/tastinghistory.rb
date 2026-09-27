# frozen_string_literal: true

RecipeScrapers.register "tastinghistory.com" do
  title "h1.entry-title"
  ingredients rows: "div.website-component-block ul > li"
  instructions rows: "div.website-component-block ol > li"
end
