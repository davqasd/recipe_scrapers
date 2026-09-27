# frozen_string_literal: true

RecipeScrapers.register "aldi.it" do
  title "h1.base-title"
  ingredients rows: "div.base-rich-text ul li"
  instructions rows: "div.base-rich-text ol li"
end
