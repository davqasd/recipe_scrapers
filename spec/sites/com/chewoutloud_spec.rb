# frozen_string_literal: true

RSpec.describe "chewoutloud.com" do
  subject(:recipe) { scrape_cassette("com/chewoutloud", url: "https://www.chewoutloud.com/perfectly-creamy-mac-n-cheese/") }

  it "reads the title" do
    expect(recipe.title).to eq("White Cheddar Mac and Cheese")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 lb elbow macaroni (dry)",
      "6 tablespoons butter (regular )",
      "5 1/2 cups whole milk",
      "1/2 cup all purpose flour",
      "1/2 teaspoon garlic powder",
      "1/2 teaspoon onion powder",
      "1/4 teaspoon ground nutmeg",
      "1/4 teaspoon black pepper (fresh ground )",
      "1/4 teaspoon dry mustard",
      "4 1/2 cups white cheddar (sharp, freshly grated, from a good quality block)",
      "1 1/4 cups Pecorino Romano (freshly grated, from a good quality block)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "lb", name: "elbow macaroni" },
      { amount: 6.0, unit: "tablespoons", name: "butter" },
      { amount: 5.5, unit: "cups", name: "whole milk" },
      { amount: 0.5, unit: "cup", name: "all purpose flour" },
      { amount: 0.5, unit: "teaspoon", name: "garlic powder" },
      { amount: 0.5, unit: "teaspoon", name: "onion powder" },
      { amount: 0.25, unit: "teaspoon", name: "ground nutmeg" },
      { amount: 0.25, unit: "teaspoon", name: "black pepper" },
      { amount: 0.25, unit: "teaspoon", name: "dry mustard" },
      { amount: 4.5, unit: "cups", name: "white cheddar" },
      { amount: 1.25, unit: "cups", name: "Pecorino Romano" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat",
      "Heat oven to 375F with rack in middle position. Grease a 9x13 casserole dish and set aside.",
      "Boil",
      "Fill large pot with salted water. Bring to boil, add macaroni and cook 2 minutes less than the package states for al dente. You want the pasta a bit undercooked, as it will continue to cook in oven. Transfer macaroni to colander, rinse well with cool water, and set aside to drain.",
      "Cook Roux",
      "In saucepan, heat milk until hot and set aside - watch that it doesn't spill over. In a large pot, melt butter over medium heat. When butter starts bubbling, add flour and cook 1-2 minutes, constantly stirring.",
      "Whisk",
      "Add hot milk into flour-butter mixture, whisking constantly. Continue cooking/whisking on medium heat until mixture bubbles and becomes thick, about 10 min.",
      "Add",
      "Turn heat off. Stir in garlic and onion powder, nutmeg, black pepper, and dry mustard. Add 3 cups of the white cheddar and 1 cup of the Pecorino Romano. Mix thoroughly until cheeses are melted and sauce is smooth and creamy.",
      "Combine",
      "Add cooked macaroni into cheese sauce and stir to combine well. Pour mixture into greased casserole dish, distributing evenly.",
      "Bake",
      "Sprinkle top with remaining 1 1/2 cups white cheddar and 1/4 cup Pecorino Romano. Bake until top is golden brown, about 30 min. If needed, set under broiler for 1-2 minutes for more browning. Let rest 5 minutes and serve."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat\nHeat oven to 375F with rack in middle position. Grease a 9x13 casserole dish and set aside.\nBoil\nFill large pot with salted water. Bring to boil, add macaroni and cook 2 minutes less than the package states for al dente. You want the pasta a bit undercooked, as it will continue to cook in oven. Transfer macaroni to colander, rinse well with cool water, and set aside to drain.\nCook Roux\nIn saucepan, heat milk until hot and set aside - watch that it doesn't spill over. In a large pot, melt butter over medium heat. When butter starts bubbling, add flour and cook 1-2 minutes, constantly stirring.\nWhisk\nAdd hot milk into flour-butter mixture, whisking constantly. Continue cooking/whisking on medium heat until mixture bubbles and becomes thick, about 10 min.\nAdd\nTurn heat off. Stir in garlic and onion powder, nutmeg, black pepper, and dry mustard. Add 3 cups of the white cheddar and 1 cup of the Pecorino Romano. Mix thoroughly until cheeses are melted and sauce is smooth and creamy.\nCombine\nAdd cooked macaroni into cheese sauce and stir to combine well. Pour mixture into greased casserole dish, distributing evenly.\nBake\nSprinkle top with remaining 1 1/2 cups white cheddar and 1/4 cup Pecorino Romano. Bake until top is golden brown, about 30 min. If needed, set under broiler for 1-2 minutes for more browning. Let rest 5 minutes and serve.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("chewoutloud.com")
    expect(recipe.canonical_url).to eq("https://www.chewoutloud.com/perfectly-creamy-mac-n-cheese/")
    expect(recipe.site_name).to eq("Chew Out Loud")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Amy Dong")
    expect(recipe.description).to eq("This creamy white cheddar mac and cheese is cozy, warm, and comforting. Your family, both kids and grownups alike, will adore this baked and cheese recipe.")
    expect(recipe.image).to eq("https://www.chewoutloud.com/wp-content/uploads/2024/03/White-Cheddar-Mac-and-Cheese-Square.jpg")
    expect(recipe.category).to eq("Main")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(50)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["Mac and Cheese", "Macaroni and Cheese"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["VegetarianDiet"])
    expect(recipe.ratings).to eq(4.95)
    expect(recipe.ratings_count).to eq(17)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "450 kcal",
      "sugarContent" => "7 g",
      "sodiumContent" => "373.7 mg",
      "fatContent" => "23 g",
      "saturatedFatContent" => "13.1 g",
      "transFatContent" => "0.5 g",
      "carbohydrateContent" => "39.6 g",
      "fiberContent" => "1.4 g",
      "proteinContent" => "20.7 g",
      "cholesterolContent" => "66.5 mg",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 450.0 },
      { name: "sugarContent", unit: "g", amount: 7.0 },
      { name: "sodiumContent", unit: "mg", amount: 373.7 },
      { name: "fatContent", unit: "g", amount: 23.0 },
      { name: "saturatedFatContent", unit: "g", amount: 13.1 },
      { name: "transFatContent", unit: "g", amount: 0.5 },
      { name: "carbohydrateContent", unit: "g", amount: 39.6 },
      { name: "fiberContent", unit: "g", amount: 1.4 },
      { name: "proteinContent", unit: "g", amount: 20.7 },
      { name: "cholesterolContent", unit: "mg", amount: 66.5 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#body")
  end
end
