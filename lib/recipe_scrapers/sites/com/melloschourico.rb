# frozen_string_literal: true

RecipeScrapers.register "melloschourico.com" do
  title "h1.BlogItem-title"
  ingredients rows: "div.sqs-html-content ul li"
  instructions rows: "div.sqs-html-content ol li"
end
