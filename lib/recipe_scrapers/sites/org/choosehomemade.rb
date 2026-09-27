# frozen_string_literal: true

RecipeScrapers.register "choosehomemade.org" do
  title "h1.recipe-layout__content-title"
  ingredients rows: "ul.recipe-ingredients__inner-list li"
  instructions rows: "ol.recipe-steps__inner li"
end
