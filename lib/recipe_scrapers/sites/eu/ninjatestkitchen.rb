# frozen_string_literal: true

RecipeScrapers.register "ninjatestkitchen.eu" do
  instructions rows: "div.recipe-pdp-instructions__steps p", split: true, skip: "strong"
end
