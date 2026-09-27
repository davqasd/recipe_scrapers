# frozen_string_literal: true

RecipeScrapers.register "juliegoodwin.com.au" do
  title "h1"
  ingredients rows: "#ingredients-field p", split: true
  instructions rows: "#methods-fields li"
end
