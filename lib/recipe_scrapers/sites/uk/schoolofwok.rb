# frozen_string_literal: true

RecipeScrapers.register "schoolofwok.co.uk" do
  ingredients rows: "section#recipe-ingredients h3 + div.text-reset > p:first-of-type", split: true
  ingredient_groups heading: "section#recipe-ingredients h3 + div.text-reset > p:first-of-type strong"
  instructions rows: "section#recipe-ingredients h3 + div.text-reset > ol > li"
end
