# frozen_string_literal: true

RecipeScrapers.register "scrambledandscrumptious.com" do
  ingredients rows: "#recipe-card ul li"
  instructions rows: "#recipe-card ol li"
end
