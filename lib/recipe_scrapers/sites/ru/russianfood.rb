# frozen_string_literal: true

RecipeScrapers.register "russianfood.com" do
  encoding "windows-1251"
  title "h1"
  ingredients rows: "tr.ingr_tr_0, tr.ingr_tr_1"
  instructions rows: "div.step_n"
end
