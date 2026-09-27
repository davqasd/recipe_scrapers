# frozen_string_literal: true

RecipeScrapers.register "donnahay.com.au" do
  title "h1.recipe-title__mobile"
  ingredients rows: "div#ingredients li"
  instructions rows: "div#method li"
end
