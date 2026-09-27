# frozen_string_literal: true

RecipeScrapers.register "barefootcontessa.com" do
  title "h1.alt-persist-title"
  ingredients rows: ":has(> div.EntryPost__text) > div > ul > li"
  instructions rows: "div.EntryPost__text p"
end
