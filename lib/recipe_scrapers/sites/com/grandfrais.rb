# frozen_string_literal: true

RecipeScrapers.register "grandfrais.com" do
  ingredients rows: "div.ingredients-texte p"
end
