# frozen_string_literal: true

RSpec.describe "rosannapansino.com" do
  subject(:recipe) { scrape_cassette("com/rosannapansino", url: "https://rosannapansino.com/blogs/recipes/mama-mias-banana-bread-recipe") }

  it "reads the title" do
    expect(recipe.title).to eq("Moist Banana Bread")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups all-purpose flour (unsifted)",
      "1 tsp baking soda",
      "1/4 tbsp salt",
      "1/2 cup soft butter or margarine",
      "1 cup sugar",
      "2 eggs",
      "1 1/3 cups mashed ripe bananas (3-4 medium)",
      "1 tsp milk",
      "1 tsp vanilla extract",
      "1/2 cup chopped nuts"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "all-purpose flour" },
      { amount: 1.0, unit: "tsp", name: "baking soda" },
      { amount: 0.25, unit: "tbsp", name: "salt" },
      { amount: 0.5, unit: "cup", name: "soft butter or margarine" },
      { amount: 1.0, unit: "cup", name: "sugar" },
      { amount: 2.0, unit: nil, name: "eggs" },
      { amount: 1.33, unit: "cups", name: "mashed ripe bananas" },
      { amount: 1.0, unit: "tsp", name: "milk" },
      { amount: 1.0, unit: "tsp", name: "vanilla extract" },
      { amount: 0.5, unit: "cup", name: "chopped nuts" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 350°F. Lightly grease a 9x5 inch loaf pan.",
      "In a medium bowl, whisk together the flour, baking soda and salt.",
      "In a large bowl, cream together the butter and sugar until light and fluffy.",
      "Beat in the eggs one at a time, scraping the sides.",
      "In a medium bowl, mash the bananas then add in the milk and the vanilla extract.",
      "Alternate adding the dry ingredients and banana mixture into the egg mixture.",
      "Fold in the nuts.",
      "Scoop the batter into the prepared pan.",
      "Baked for 1 hour and 10 minutes or until a wooden pick inserted into the center comes out clean.",
      "Cool 10 minutes in the pan. Transfer to a wire rack to cool completely."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 350°F. Lightly grease a 9x5 inch loaf pan.\nIn a medium bowl, whisk together the flour, baking soda and salt.\nIn a large bowl, cream together the butter and sugar until light and fluffy.\nBeat in the eggs one at a time, scraping the sides.\nIn a medium bowl, mash the bananas then add in the milk and the vanilla extract.\nAlternate adding the dry ingredients and banana mixture into the egg mixture.\nFold in the nuts.\nScoop the batter into the prepared pan.\nBaked for 1 hour and 10 minutes or until a wooden pick inserted into the center comes out clean.\nCool 10 minutes in the pan. Transfer to a wire rack to cool completely.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("rosannapansino.com")
    expect(recipe.canonical_url).to eq("https://rosannapansino.com/blogs/recipes/mama-mias-banana-bread-recipe")
    expect(recipe.site_name).to eq("Rosanna Pansino")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Loved making this simple banana bread recipe! This recipe doesn't use any yeast and only takes an hour to make! It's also perfect for when you have left over bananas. Yield: makes 1 loaf Things you'll need Ingredients 2 cups all-purpose flour (unsifted) 1 tsp baking soda 1/4 tbsp salt 1/2 cup soft butter or margarine 1 cup sugar 2 eggs 1 1/3 cups mashed ripe bananas (3-4 medium) 1 tsp milk 1 tsp vanilla extract 1/2 cup chopped nuts Equipment 9x5 Loaf pan Hand mixer Let's get started! Preheat the oven to 350°F. Lightly grease a 9x5 inch loaf pan. In a medium bowl, whisk together the flour, baking soda and salt. In a large bowl, cream together the butter and sugar until light and fluffy. Beat in the eggs one at a time, scraping the sides. In a medium bowl, mash the bananas then add in the milk and the vanilla extract. Alternate adding the dry ingredients and banana mixture into the egg mixture. Fold in the nuts. Scoop the batter into the prepared pan. Baked for 1 hour and 10 minutes or until a wooden pick inserted into the center comes out clean. Cool 10 minutes in the pan. Transfer to a wire rack to cool completely. Written By Rosanna Pansino")
    expect(recipe.image).to eq("http://rosannapansino.com/cdn/shop/articles/banana.jpg?v=1589038874")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#MainContent")
  end
end
