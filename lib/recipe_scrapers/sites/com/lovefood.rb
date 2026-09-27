# frozen_string_literal: true

RecipeScrapers.register "lovefood.com" do
  ingredients rows: "div.post__body ul:not(.u-visuallyhidden):has(+ ul.u-visuallyhidden) > li"
  instructions rows: "div.content__step-by-step li"
end
