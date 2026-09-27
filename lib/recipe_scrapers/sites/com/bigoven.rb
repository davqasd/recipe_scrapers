# frozen_string_literal: true

RecipeScrapers.register "bigoven.com" do
  instructions rows: "div#instr p"
  ingredient_groups heading: "span.ingHeading", item: "span.ingredient:not(.ingHeading)"
end
