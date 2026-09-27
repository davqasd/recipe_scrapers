# frozen_string_literal: true

RecipeScrapers.register "veroniquecloutier.com" do
  ingredients rows: "div.text-section div.content h2 + ul > li"
  instructions rows: "div.text-section div.content h2 + ol > li"
end
