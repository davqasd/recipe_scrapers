# frozen_string_literal: true

RSpec.describe "mykitchen101en.com" do
  subject(:recipe) { scrape_cassette("com/mykitchen101en", url: "https://mykitchen101en.com/peanut-pancake-apam-balik-martabak-manis-recipe-asian-street-food/") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy Peanut Pancake Recipe (Apam Balik Recipe, Martabak Manis) – Asian Street Food")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "100 g skinless raw peanut",
      "35 g sugar",
      "20 g butter",
      "90 g all-purpose flour",
      "60 g rice flour",
      "50 g sugar",
      "140 g water",
      "1 egg",
      "½ tsp instant yeast",
      "¼ tsp baking soda (optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 100.0, unit: "g", name: "skinless raw peanut" },
      { amount: 35.0, unit: "g", name: "sugar" },
      { amount: 20.0, unit: "g", name: "butter" },
      { amount: 90.0, unit: "g", name: "all-purpose flour" },
      { amount: 60.0, unit: "g", name: "rice flour" },
      { amount: 50.0, unit: "g", name: "sugar" },
      { amount: 140.0, unit: "g", name: "water" },
      { amount: 1.0, unit: nil, name: "egg" },
      { amount: 0.5, unit: "tsp", name: "instant yeast" },
      { amount: 0.25, unit: "tsp", name: "baking soda" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Mix and whisk all ingredients for batter thoroughly until smooth with no visible lumps. Set aside to proof for 1 hour and 30 minutes.",
      "Spread the peanuts evenly in single layer on a baking tray. Bake at 170°C/340°F for 16 minutes until golden brown. Set aside to cool, baking time may vary depending on individual oven.",
      "Grind the roasted peanut with food processor.",
      "Mix ground peanut with 35 g granulated sugar. You may adjust the sweetness to your personal preference.",
      "Coat pan with some oil and wipe out with paper towel, preheat pan.",
      "Pour in batter and spread out evenly.",
      "Cover and cook over medium-low heat. Cook for about 3-5 minutes until surface of the pancake is completely cooked.",
      "Spread with a dollop of butter.",
      "Sprinkle evenly with ground peanut filling.",
      "Fold the pancake in half and cut into smaller pieces while warm."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Mix and whisk all ingredients for batter thoroughly until smooth with no visible lumps. Set aside to proof for 1 hour and 30 minutes.\nSpread the peanuts evenly in single layer on a baking tray. Bake at 170°C/340°F for 16 minutes until golden brown. Set aside to cool, baking time may vary depending on individual oven.\nGrind the roasted peanut with food processor.\nMix ground peanut with 35 g granulated sugar. You may adjust the sweetness to your personal preference.\nCoat pan with some oil and wipe out with paper towel, preheat pan.\nPour in batter and spread out evenly.\nCover and cook over medium-low heat. Cook for about 3-5 minutes until surface of the pancake is completely cooked.\nSpread with a dollop of butter.\nSprinkle evenly with ground peanut filling.\nFold the pancake in half and cut into smaller pieces while warm.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("mykitchen101en.com")
    expect(recipe.canonical_url).to eq("https://mykitchen101en.com/peanut-pancake-apam-balik-martabak-manis-recipe/")
    expect(recipe.site_name).to eq("MyKitchen101en.com")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Peanut Pancake (Apam Balik, Martabak Manis) is common street food in Southeast Asia. The pancake is known by different names depending on the cultural region.")
    expect(recipe.image).to eq("https://mykitchen101en.com/wp-content/uploads/2018/11/apambalik12.jpg")
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
    expect(recipe.links).to include("#")
  end
end
