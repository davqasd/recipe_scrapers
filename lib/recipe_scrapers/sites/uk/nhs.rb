# frozen_string_literal: true

RecipeScrapers.register "nhs.uk" do
  instructions rows: "div.bh-recipe-instructions__method > ol > li", skip: "div.nhsuk-inset-text"
end
