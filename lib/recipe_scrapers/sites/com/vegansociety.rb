# frozen_string_literal: true

RecipeScrapers.register "vegansociety.com" do
  ingredients rows: "div.field-name-body ul li"
  instructions rows: "div.field-name-body ol li"
end
