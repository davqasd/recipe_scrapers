# frozen_string_literal: true

RSpec.describe "app.samsungfood.com" do
  subject(:recipe) { scrape_cassette("com/app", url: "https://app.samsungfood.com/recipes/107018a3052180271afa5138d3ead5f8c57") }

  it "reads the title" do
    expect(recipe.title).to eq("5 Minute lemon and blueberry cake")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "Zest from 2 fresh lemons",
      "1 cup sugar",
      "Juice from 1 tantalizing lemon",
      "2 fluffy eggs",
      "1/2 cup velvety olive oil",
      "1/2 cup creamy yoghurt",
      "1.5 cups self raising flour (magic in a cup!)",
      "1.5 cup frozen blueberries (nature’s candy)",
      "1 tbsp raw sugar for that extra sparkle ✨"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "Zest from 2 fresh lemons" },
      { amount: 1.0, unit: "cup", name: "sugar" },
      { amount: nil, unit: nil, name: "Juice from 1 tantalizing lemon" },
      { amount: 2.0, unit: nil, name: "fluffy eggs" },
      { amount: 0.5, unit: "cup", name: "velvety olive oil" },
      { amount: 0.5, unit: "cup", name: "creamy yoghurt" },
      { amount: 1.5, unit: "cups", name: "self raising flour" },
      { amount: 1.5, unit: "cup", name: "frozen blueberries" },
      { amount: 1.0, unit: "tbsp", name: "raw sugar for that extra sparkle ✨" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In your trusty bowl, combine sugar, lemon zest, lemon juice, eggs, oil, and yogurt. Give it a good mix! 💪",
      "Add in 1 cup of those yummy frozen blueberries and the self-raising flour. Stir it up!",
      "Pour that beautiful batter into a lined loaf tin.",
      "Decorate the top with the remaining blueberries and give it a sprinkle of raw sugar.",
      "Pop it in the oven at 160C and bake for a golden 50 minutes.",
      "Voilà! A blueberry-lemon dream ready in no time. Perfect for last-minute parties or a cheeky weekend snack. Enjoy, and don't forget to share your masterpiece with me! 🎂📸"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In your trusty bowl, combine sugar, lemon zest, lemon juice, eggs, oil, and yogurt. Give it a good mix! 💪\nAdd in 1 cup of those yummy frozen blueberries and the self-raising flour. Stir it up!\nPour that beautiful batter into a lined loaf tin.\nDecorate the top with the remaining blueberries and give it a sprinkle of raw sugar.\nPop it in the oven at 160C and bake for a golden 50 minutes.\nVoilà! A blueberry-lemon dream ready in no time. Perfect for last-minute parties or a cheeky weekend snack. Enjoy, and don't forget to share your masterpiece with me! 🎂📸")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("app.samsungfood.com")
    expect(recipe.canonical_url).to eq("https://app.samsungfood.com/recipes/107018a3052180271afa5138d3ead5f8c57")
    expect(recipe.site_name).to eq("Samsung Food")
    expect(recipe.language).to eq("English")
    expect(recipe.author).to eq("STEPH De Sousa")
    expect(recipe.description).to eq("Hey there, baking friends! 🍰 Frozen fruit is my go to when it comes to baking! It’s always ready to use, available, budget friendly, and doesn’t go rotten when I forget to use it🤣🤦‍♀️🍓 Are you ready for a quick treat that'll dazzle your tastebuds and impress anyone who gets a bite?")
    expect(recipe.image).to eq("https://art.whisk.com/image/upload/fl_progressive,h_600,w_800,c_fill/v1693027610/v3/user-recipes/ab85a2475db2153dcbe548fd5dfc6577.jpg")
    expect(recipe.category).to eq("Desserts")
    expect(recipe.cuisine).to eq("World Cuisine")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(55)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(50)
    expect(recipe.keywords).to eq(["5 Minute lemon and blueberry cake", "Desserts", "World Cuisine"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "2820.87 calories",
      "carbohydrateContent" => "389.06 g",
      "cholesterolContent" => "343.29 mg",
      "fatContent" => "129.8 g",
      "fiberContent" => "12.74 g",
      "proteinContent" => "35.13 g",
      "saturatedFatContent" => "21.49 g",
      "sugarContent" => "237.75 g",
      "transFatContent" => "0.04 g",
      "servingSize" => "10"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 2820.87 },
      { name: "carbohydrateContent", unit: "g", amount: 389.06 },
      { name: "cholesterolContent", unit: "mg", amount: 343.29 },
      { name: "fatContent", unit: "g", amount: 129.8 },
      { name: "fiberContent", unit: "g", amount: 12.74 },
      { name: "proteinContent", unit: "g", amount: 35.13 },
      { name: "saturatedFatContent", unit: "g", amount: 21.49 },
      { name: "sugarContent", unit: "g", amount: 237.75 },
      { name: "transFatContent", unit: "g", amount: 0.04 },
      { name: "servingSize", unit: nil, amount: 10.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://app.samsungfood.com")
  end
end
