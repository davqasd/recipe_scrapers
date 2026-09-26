# frozen_string_literal: true

RSpec.describe "shelikesfood.com" do
  subject(:recipe) { scrape_cassette("com/shelikesfood", url: "https://www.shelikesfood.com/copycat-taco-bell-bean-burrito-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Copycat Taco Bell Bean Burrito Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2/3 cup refried beans",
      "4 heaping tablespoons finely shredded cheese, I like to use a bagged fiesta or Mexican style mix",
      "2 tablespoons finely chopped yellow or white onion",
      "4 tablespoons Taco sauce, I like to use the Taco Bell mild sauce that I buy from Walmart",
      "2 burrito sized flour tortillas"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.67, unit: "cup", name: "refried beans" },
      { amount: 4.0, unit: "tablespoons", name: "finely shredded cheese, I like to use a bagged fiesta or Mexican style mix" },
      { amount: 2.0, unit: "tablespoons", name: "finely chopped yellow or white onion" },
      { amount: 4.0, unit: "tablespoons", name: "Taco sauce, I like to use the Taco Bell mild sauce that I buy from Walmart" },
      { amount: 2.0, unit: nil, name: "burrito sized flour tortillas" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Add your refried beans to a small saucepan along with a couple tablespoons of water. Canned refried beans are usually pretty thick, so I like to thin mine out with a little water to make them more spreadable. How much water you use will depend on the consistency of your refried beans.",
      "Mix the beans and water together well and place over medium heat. Cook beans until piping hot, turn the heat off and let sit with the lid on while you are preparing your flour tortillas.",
      "Heat a large pan over medium heat and add your flour tortilla. You don’t need to use any cooking spray for this, you just want to heat the tortilla. Heat tortilla on both sides until hot. Remove tortilla from the pan and place on a plate or cutting board.",
      "If you want your cheese to be more melty, it’s important to move quickly while assembling your bean and cheese burrito so there isn’t much time for the refried beans or the tortilla to cool down.",
      "Spread the middle of the tortilla with about 1/3 cup of the heated refried beans. Top with a handful of cheese, about 1 tablespoon of chopped onion and 1-2 tablespoons of the taco sauce. Fold the sides of your burrito in and carefully roll up. You can either enjoy immediately or let burrito cool for a few minutes, which will give the cheese a little more time to get melty. Enjoy with extra taco sauce, if desired!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Add your refried beans to a small saucepan along with a couple tablespoons of water. Canned refried beans are usually pretty thick, so I like to thin mine out with a little water to make them more spreadable. How much water you use will depend on the consistency of your refried beans.\nMix the beans and water together well and place over medium heat. Cook beans until piping hot, turn the heat off and let sit with the lid on while you are preparing your flour tortillas.\nHeat a large pan over medium heat and add your flour tortilla. You don’t need to use any cooking spray for this, you just want to heat the tortilla. Heat tortilla on both sides until hot. Remove tortilla from the pan and place on a plate or cutting board.\nIf you want your cheese to be more melty, it’s important to move quickly while assembling your bean and cheese burrito so there isn’t much time for the refried beans or the tortilla to cool down.\nSpread the middle of the tortilla with about 1/3 cup of the heated refried beans. Top with a handful of cheese, about 1 tablespoon of chopped onion and 1-2 tablespoons of the taco sauce. Fold the sides of your burrito in and carefully roll up. You can either enjoy immediately or let burrito cool for a few minutes, which will give the cheese a little more time to get melty. Enjoy with extra taco sauce, if desired!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("shelikesfood.com")
    expect(recipe.canonical_url).to eq("https://www.shelikesfood.com/copycat-taco-bell-bean-burrito-recipe/")
    expect(recipe.site_name).to eq("She Likes Food")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("She Likes Food")
    expect(recipe.description).to eq("These Copycat Taco Bell Bean Burritos only require 5 simple ingredients and they taste so much like the real thing! If you're craving Taco Bell, but don't want to leave the house, make these delicious bean burritos right at home.")
    expect(recipe.image).to eq("https://www.shelikesfood.com/wp-content/uploads/2023/09/copycat-taco-bell-bean-burritos-8842-225x225.jpg")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to eq("Mexican Inspired")
    expect(recipe.cooking_method).to eq("Stovetop")
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(5)
    expect(recipe.keywords).to eq(["Copycat Taco Bell Bean Burrito"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["VegetarianDiet"])
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 Burrito",
      "calories" => "619 calories",
      "sugarContent" => "3.2 g",
      "sodiumContent" => "556.4 mg",
      "fatContent" => "10.1 g",
      "saturatedFatContent" => "4.2 g",
      "transFatContent" => "0.2 g",
      "carbohydrateContent" => "109.1 g",
      "fiberContent" => "7.5 g",
      "proteinContent" => "20.2 g",
      "cholesterolContent" => "18.8 mg"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "Burrito", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 619.0 },
      { name: "sugarContent", unit: "g", amount: 3.2 },
      { name: "sodiumContent", unit: "mg", amount: 556.4 },
      { name: "fatContent", unit: "g", amount: 10.1 },
      { name: "saturatedFatContent", unit: "g", amount: 4.2 },
      { name: "transFatContent", unit: "g", amount: 0.2 },
      { name: "carbohydrateContent", unit: "g", amount: 109.1 },
      { name: "fiberContent", unit: "g", amount: 7.5 },
      { name: "proteinContent", unit: "g", amount: 20.2 },
      { name: "cholesterolContent", unit: "mg", amount: 18.8 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.shelikesfood.com/")
  end
end
