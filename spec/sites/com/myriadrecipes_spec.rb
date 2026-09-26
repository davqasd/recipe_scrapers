# frozen_string_literal: true

RSpec.describe "myriadrecipes.com" do
  subject(:recipe) { scrape_cassette("com/myriadrecipes", url: "https://myriadrecipes.com/homemade-ice-cream-sandwich/") }

  it "reads the title" do
    expect(recipe.title).to eq("Homemade Ice Cream Sandwich")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "500 ml double cream",
      "375 g condensed milk (one tin)",
      "1 tsp vanilla essence",
      "75 g chocolate chips",
      "8 cookies/biscuits",
      "1 large bar of milk chocolate"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 500.0, unit: "ml", name: "double cream" },
      { amount: 375.0, unit: "g", name: "condensed milk" },
      { amount: 1.0, unit: "tsp", name: "vanilla essence" },
      { amount: 75.0, unit: "g", name: "chocolate chips" },
      { amount: 8.0, unit: nil, name: "cookies/biscuits" },
      { amount: 1.0, unit: "bar", name: "milk chocolate" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a bowl, pour in your double cream. Using an electric whisk, whip up your double cream until thickened. If you lift up the bowl and tilt it, the cream should stay firm and still.",
      "In another bowl, pour in your condensed milk and tsp of vanilla essence. Combine the two ingredients.",
      "Gently fold your whipped cream into the condensed milk mixture until well combined.",
      "Pour in your chocolate chips and gently stir them into the mixture.",
      "Transfer the mixture into a metal tin (I used a banana loaf baking tin). Spread it out evenly and then place it into the freezer for around 6 hours.",
      "Once your ice cream is set, get your cookies ready (I got some chocolate chip biscuits from Tesco). Place a scoopful of ice cream into the center of a cookie, place another cookie on top and press down. Repeat this step and then place all of the sandwiches back into the tin and into the freezer.",
      "Meanwhile, make your chocolate dipping sauce by placing a bowl into a small saucepan of boiling water. Make sure the bowl doesn't touch the water. On medium heat, crack in the chocolate and stir until it's completely melted down.",
      "Get your ice cream sandwiches and dunk them into the chocolate sauce so that half of the biscuit is covered. Place them back into the freezer for 30 minutes and then serve up and enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a bowl, pour in your double cream. Using an electric whisk, whip up your double cream until thickened. If you lift up the bowl and tilt it, the cream should stay firm and still.\nIn another bowl, pour in your condensed milk and tsp of vanilla essence. Combine the two ingredients.\nGently fold your whipped cream into the condensed milk mixture until well combined.\nPour in your chocolate chips and gently stir them into the mixture.\nTransfer the mixture into a metal tin (I used a banana loaf baking tin). Spread it out evenly and then place it into the freezer for around 6 hours.\nOnce your ice cream is set, get your cookies ready (I got some chocolate chip biscuits from Tesco). Place a scoopful of ice cream into the center of a cookie, place another cookie on top and press down. Repeat this step and then place all of the sandwiches back into the tin and into the freezer.\nMeanwhile, make your chocolate dipping sauce by placing a bowl into a small saucepan of boiling water. Make sure the bowl doesn't touch the water. On medium heat, crack in the chocolate and stir until it's completely melted down.\nGet your ice cream sandwiches and dunk them into the chocolate sauce so that half of the biscuit is covered. Place them back into the freezer for 30 minutes and then serve up and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("myriadrecipes.com")
    expect(recipe.canonical_url).to eq("https://myriadrecipes.com/homemade-ice-cream-sandwich/")
    expect(recipe.site_name).to eq("Myriad Recipes")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Emily Roz")
    expect(recipe.description).to eq("If you've never made ice cream from scratch before, then you have got to try out this super simple 4-ingredient ice cream sandwich recipe!")
    expect(recipe.image).to eq("https://myriadrecipes.com/wp-content/uploads/2022/07/IMG_8975.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(6)
    expect(recipe.keywords).to eq(["Sandwich"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://myriadrecipes.com/")
  end
end
