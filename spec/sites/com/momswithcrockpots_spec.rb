# frozen_string_literal: true

RSpec.describe "momswithcrockpots.com" do
  subject(:recipe) { scrape_cassette("com/momswithcrockpots", url: "https://momswithcrockpots.com/slow-cooked-macaroni-cheese/") }

  it "reads the title" do
    expect(recipe.title).to eq("Crockpot Macaroni & Cheese")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "8 ounce macaroni",
      "2 teaspoons olive oil",
      "1 cup evaporated milk",
      "1/2 cup milk",
      "1/2 teaspoon salt",
      "1/4 teaspoon ground black pepper",
      "2 cups Cheddar cheese (shredded, or a Cheddar blend)",
      "4 tablespoons butter (melted)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 8.0, unit: "ounce", name: "macaroni" },
      { amount: 2.0, unit: "teaspoons", name: "olive oil" },
      { amount: 1.0, unit: "cup", name: "evaporated milk" },
      { amount: 0.5, unit: "cup", name: "milk" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 0.25, unit: "teaspoon", name: "ground black pepper" },
      { amount: 2.0, unit: "cups", name: "Cheddar cheese" },
      { amount: 4.0, unit: "tablespoons", name: "butter" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Cook the macaroni following package directions. Drain in a colander and rinse with hot water. Drain well.",
      "Generously butter the sides and bottom of a 3 1/2- to 4-quart slow cooker (I use about 2 tablespoons of butter).",
      "Combine the macaroni with the remaining ingredients in the slow cooker and blend well. Cover the slow cooker and cook on LOW for 2 1/2 to 3 1/2 hours, stirring a few times.",
      "If desired, spoon the cooked macaroni and cheese mixture into a baking dish, sprinkle with a little more cheese, and put under the broiler for a minute or 2, just until cheese is melted.",
      "When the macaroni and cheese is done, feel free to spoon into a baking dish, top with a little more cheese, and put under the broiler for a minute or two for that \"fresh from the oven\" look.",
      "Gluten Free",
      "Use a gluten free pasta"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Cook the macaroni following package directions. Drain in a colander and rinse with hot water. Drain well.\nGenerously butter the sides and bottom of a 3 1/2- to 4-quart slow cooker (I use about 2 tablespoons of butter).\nCombine the macaroni with the remaining ingredients in the slow cooker and blend well. Cover the slow cooker and cook on LOW for 2 1/2 to 3 1/2 hours, stirring a few times.\nIf desired, spoon the cooked macaroni and cheese mixture into a baking dish, sprinkle with a little more cheese, and put under the broiler for a minute or 2, just until cheese is melted.\nWhen the macaroni and cheese is done, feel free to spoon into a baking dish, top with a little more cheese, and put under the broiler for a minute or two for that \"fresh from the oven\" look.\nGluten Free\nUse a gluten free pasta")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("momswithcrockpots.com")
    expect(recipe.canonical_url).to eq("https://momswithcrockpots.com/slow-cooked-macaroni-cheese/")
    expect(recipe.site_name).to eq("Moms with Crockpots")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Karen McCormick")
    expect(recipe.description).to eq("Shared Hundreds of Thousands of times this Crockpot Macaroni & Cheese Recipe is a keeper! Try this delicious homestyle dish today!")
    expect(recipe.image).to eq("https://momswithcrockpots.com/wp-content/uploads/2012/01/Crockpot-Macaroni-and-cheese-2.jpg")
    expect(recipe.category).to eq("Side Dish")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(225)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(210)
    expect(recipe.keywords).to eq(["holiday"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "441 kcal",
      "carbohydrateContent" => "34 g",
      "proteinContent" => "18 g",
      "fatContent" => "26 g",
      "saturatedFatContent" => "15 g",
      "cholesterolContent" => "74 mg",
      "sodiumContent" => "551 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "7 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 441.0 },
      { name: "carbohydrateContent", unit: "g", amount: 34.0 },
      { name: "proteinContent", unit: "g", amount: 18.0 },
      { name: "fatContent", unit: "g", amount: 26.0 },
      { name: "saturatedFatContent", unit: "g", amount: 15.0 },
      { name: "cholesterolContent", unit: "mg", amount: 74.0 },
      { name: "sodiumContent", unit: "mg", amount: 551.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 7.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
