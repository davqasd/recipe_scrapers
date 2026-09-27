# frozen_string_literal: true

RSpec.describe "whole30.com" do
  subject(:recipe) { scrape_cassette("com/whole30", url: "https://whole30.com/recipes/whole30-beef-stew/") }

  it "reads the title" do
    expect(recipe.title).to eq("Whole30 Beef Stew")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 tbsp olive or avocado oil",
      "2-2.5 lbs stew meat",
      "2 tsp salt (divided)",
      "1/2 tsp pepper",
      "1.5 lbs yellow potatoes (cut into small ½” pieces)",
      "3 medium carrots (cut into ¼” pieces)",
      "1 medium yellow onion (dices)",
      "1 tbsp minced garlic",
      "4 cups beef broth or bone broth",
      "2 tbsp coconut aminos",
      "1/4 cup tomato paste",
      "2 bay leaves",
      "1 tbsp dried parsley",
      "1 tsp dried thyme",
      "2 cups frozen peas"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "tbsp", name: "olive or avocado oil" },
      { amount: 2.0, unit: "lbs", name: "stew meat" },
      { amount: 2.0, unit: "tsp", name: "salt" },
      { amount: 0.5, unit: "tsp", name: "pepper" },
      { amount: 1.5, unit: "lbs", name: "yellow potatoes" },
      { amount: 3.0, unit: nil, name: "medium carrots" },
      { amount: 1.0, unit: nil, name: "medium yellow onion" },
      { amount: 1.0, unit: "tbsp", name: "minced garlic" },
      { amount: 4.0, unit: "cups", name: "beef broth or bone broth" },
      { amount: 2.0, unit: "tbsp", name: "coconut aminos" },
      { amount: 0.25, unit: "cup", name: "tomato paste" },
      { amount: 2.0, unit: nil, name: "bay leaves" },
      { amount: 1.0, unit: "tbsp", name: "dried parsley" },
      { amount: 1.0, unit: "tsp", name: "dried thyme" },
      { amount: 2.0, unit: "cups", name: "frozen peas" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "HEAT oil on the stove over medium-high heat in a large pot or in the bottom of an Instant Pot on Sauté. Add stew meat, sprinkle with 1 teaspoon salt and the pepper, and cook for 5 minutes, or until browned on the outside.",
      "ADD all the ingredients, including the second teaspoon of salt, to either the large pot, a slow cooker, or an Instant Pot and seal.",
      "STOVE - Bring the mixture to a boil, reduce the heat to a simmer, and cook covered for 40 minutes, or until veggies are tender.",
      "SLOW COOKER - Cook on low for 8 hours or high for 4 hours.",
      "INSTANT POT - Cook on Stew for 35 minutes.",
      "OPTIONAL - For a thicker stew, after cooking time, blend 1 cup cooked potatoes with 1 cup broth and then add back into the stew.",
      "ADD frozen peas and remove bay leaves. Stir well to combine and let sit for 5 minutes before serving.",
      "STORE in the fridge for up to 1 week or freeze for up to 3 months in a sealed container."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("HEAT oil on the stove over medium-high heat in a large pot or in the bottom of an Instant Pot on Sauté. Add stew meat, sprinkle with 1 teaspoon salt and the pepper, and cook for 5 minutes, or until browned on the outside.\nADD all the ingredients, including the second teaspoon of salt, to either the large pot, a slow cooker, or an Instant Pot and seal.\nSTOVE - Bring the mixture to a boil, reduce the heat to a simmer, and cook covered for 40 minutes, or until veggies are tender.\nSLOW COOKER - Cook on low for 8 hours or high for 4 hours.\nINSTANT POT - Cook on Stew for 35 minutes.\nOPTIONAL - For a thicker stew, after cooking time, blend 1 cup cooked potatoes with 1 cup broth and then add back into the stew.\nADD frozen peas and remove bay leaves. Stir well to combine and let sit for 5 minutes before serving.\nSTORE in the fridge for up to 1 week or freeze for up to 3 months in a sealed container.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("whole30.com")
    expect(recipe.canonical_url).to eq("https://whole30.com/recipes/whole30-beef-stew/")
    expect(recipe.site_name).to eq("The Whole30® Program")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Michael Beasley")
    expect(recipe.description).to eq("This Whole30 Beef Stew is packed with mouth-watering, classic flavor. Make it on the stove, or let your Instant Pot do the work for you!")
    expect(recipe.image).to eq("https://whole30.com/wp-content/uploads/2023/12/Whole30-Beef-Stew-2.png")
    expect(recipe.category).to eq("dinner")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(35)
    expect(recipe.keywords).to eq(["instant pot", "slow cooker", "stew"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.0396825396825)
    expect(recipe.ratings_count).to eq(126)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
