# frozen_string_literal: true

RecipeScrapers.register "iamcook.ru" do
  ingredients rows: "div.ingredients div.ilist > div > p"
  instructions rows: "div.instructions > p"
end
