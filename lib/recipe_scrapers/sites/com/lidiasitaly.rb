# frozen_string_literal: true

RecipeScrapers.register "lidiasitaly.com" do
  title "div.inner-banner h1"
  ingredients rows: "div.box-ingredients li"
  instructions rows: "div.recipe-text p"
end
