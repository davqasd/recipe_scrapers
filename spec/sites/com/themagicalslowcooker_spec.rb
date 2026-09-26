# frozen_string_literal: true

RSpec.describe "themagicalslowcooker.com" do
  subject(:recipe) { scrape_cassette("com/themagicalslowcooker", url: "https://www.themagicalslowcooker.com/slow-cooker-ground-beef/") }

  it "reads the title" do
    expect(recipe.title).to eq("How to Make Ground Beef in the Crockpot")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 lbs. ground beef (7-20 % fat)",
      "1 ½ tsp. salt",
      "½ tsp. garlic powder",
      "½ tsp. onion powder",
      "1 small white onion (diced)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "lbs", name: "ground beef" },
      { amount: 1.5, unit: "tsp", name: "salt" },
      { amount: 0.5, unit: "tsp", name: "garlic powder" },
      { amount: 0.5, unit: "tsp", name: "onion powder" },
      { amount: 1.0, unit: nil, name: "small white onion" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Crumble the beef slightly with your fingers and add to the slow cooker.",
      "Sprinkle over the salt, pepper, onion powder and garlic powder.",
      "Add the diced white onion. Stir.",
      "Cook on low for 5 hours or on high for 3 hours. Stirring occasionally, when stirring break up the meat with the spatula.",
      "Serve and enjoy."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Crumble the beef slightly with your fingers and add to the slow cooker.\nSprinkle over the salt, pepper, onion powder and garlic powder.\nAdd the diced white onion. Stir.\nCook on low for 5 hours or on high for 3 hours. Stirring occasionally, when stirring break up the meat with the spatula.\nServe and enjoy.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("themagicalslowcooker.com")
    expect(recipe.canonical_url).to eq("https://www.themagicalslowcooker.com/slow-cooker-ground-beef/")
    expect(recipe.site_name).to eq("The Magical Slow Cooker")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Sarah Olson")
    expect(recipe.description).to eq("Whip up the best-tasting ground beef using just 5 ingredients. This Crockpot Ground Beef can be used in just about every recipe!")
    expect(recipe.image).to eq("https://www.themagicalslowcooker.com/wp-content/uploads/2023/08/crockpot-ground-beef-8.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(245)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(240)
    expect(recipe.keywords).to eq(["ground beef"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "275 kcal",
      "carbohydrateContent" => "2 g",
      "proteinContent" => "31 g",
      "fatContent" => "15 g",
      "saturatedFatContent" => "6 g",
      "transFatContent" => "1 g",
      "cholesterolContent" => "98 mg",
      "sodiumContent" => "682 mg",
      "fiberContent" => "0.4 g",
      "sugarContent" => "1 g",
      "unsaturatedFatContent" => "8 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 275.0 },
      { name: "carbohydrateContent", unit: "g", amount: 2.0 },
      { name: "proteinContent", unit: "g", amount: 31.0 },
      { name: "fatContent", unit: "g", amount: 15.0 },
      { name: "saturatedFatContent", unit: "g", amount: 6.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 98.0 },
      { name: "sodiumContent", unit: "mg", amount: 682.0 },
      { name: "fiberContent", unit: "g", amount: 0.4 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 8.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
