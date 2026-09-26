# frozen_string_literal: true

RSpec.describe "wellplated.com" do
  subject(:recipe) { scrape_cassette("com/wellplated", url: "https://www.wellplated.com/homemade-fried-rice/") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy Egg Fried Rice")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "¼ cup oyster sauce*",
      "1 tablespoon soy sauce (I use low-sodium) (plus additional to taste)",
      "2 tablespoons unsalted butter (divided, or butter with canola oil spread)",
      "3 large eggs (lightly beaten)",
      "1 tablespoon canola oil",
      "1 large red, yellow, or orange bell pepper (cut into ¼-inch dice (about 1 ¼ cups))",
      "1 bag frozen peas and carrots (thawed (12 ounces))",
      "1 cup frozen shelled edamame (thawed (optional, but great for extra protein))",
      "2 cloves garlic (minced)",
      "2 ½ cups COLD cooked brown rice (break up large clumps with your fingers)",
      "½ cup chopped green onions (about 3 medium)",
      "Red pepper flakes (Sriracha, or hot sauce of choice (optional))"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.25, unit: "cup", name: "oyster sauce*" },
      { amount: 1.0, unit: "tablespoon", name: "soy sauce" },
      { amount: 2.0, unit: "tablespoons", name: "unsalted butter" },
      { amount: 3.0, unit: nil, name: "large eggs" },
      { amount: 1.0, unit: "tablespoon", name: "canola oil" },
      { amount: 1.0, unit: nil, name: "large red, yellow, or orange bell pepper" },
      { amount: 1.0, unit: "bag", name: "frozen peas and carrots" },
      { amount: 1.0, unit: "cup", name: "frozen shelled edamame" },
      { amount: 2.0, unit: "cloves", name: "garlic" },
      { amount: 2.5, unit: "cups", name: "COLD cooked brown rice" },
      { amount: 0.5, unit: "cup", name: "chopped green onions" },
      { amount: nil, unit: nil, name: "Red pepper flakes" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Stir",
      "In a small bowl, stir together the oyster sauce and soy sauce. Set aside. Grab a small bowl and a large, flexible rubber spatula, and keep both handy.",
      "Heat a 12-inch nonstick skillet over medium heat until hot, about 2 minutes. Add 1/2 tablespoon butter and swirl to coat the bottom of the pan. Add the eggs, and cook without stirring until they barely start to set, about 20 seconds. With your spatula, scramble and break the eggs into little, bite-sized pieces. Continue to cook, stirring constantly, until eggs are just cooked through but not yet browned, about 1 additional minute. Transfer eggs to the small bowl and set aside.",
      "Add",
      "Return the skillet to the heat, and increase the heat to high. Let the skillet warm until it is nice and hot, about 1 minute. Add the canola oil, and swirl to coat. Add the diced bell pepper, and cook until it is crisp-tender, about 4 minutes.",
      "Brown",
      "Add the remaining 1 ½ tablespoons butter, peas and carrots, and edamame. Cook, stirring constantly, for 30 seconds. Stir in the garlic and cook until fragrant, about 30 seconds (do not let the garlic burn!).",
      "Cook",
      "Add the brown rice and the oyster sauce mixture. Continue cooking, stirring constantly and breaking up any remaining rice clumps, until the mixture is heated through, about 3 minutes.",
      "Add reserved eggs and green onions. Cook and stir until the mixture is completely heated through, about 1 minute more. Enjoy immediately with a sprinkle of red pepper flakes or dash of hot sauce and additional soy sauce as desired."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Stir\nIn a small bowl, stir together the oyster sauce and soy sauce. Set aside. Grab a small bowl and a large, flexible rubber spatula, and keep both handy.\nHeat a 12-inch nonstick skillet over medium heat until hot, about 2 minutes. Add 1/2 tablespoon butter and swirl to coat the bottom of the pan. Add the eggs, and cook without stirring until they barely start to set, about 20 seconds. With your spatula, scramble and break the eggs into little, bite-sized pieces. Continue to cook, stirring constantly, until eggs are just cooked through but not yet browned, about 1 additional minute. Transfer eggs to the small bowl and set aside.\nAdd\nReturn the skillet to the heat, and increase the heat to high. Let the skillet warm until it is nice and hot, about 1 minute. Add the canola oil, and swirl to coat. Add the diced bell pepper, and cook until it is crisp-tender, about 4 minutes.\nBrown\nAdd the remaining 1 ½ tablespoons butter, peas and carrots, and edamame. Cook, stirring constantly, for 30 seconds. Stir in the garlic and cook until fragrant, about 30 seconds (do not let the garlic burn!).\nCook\nAdd the brown rice and the oyster sauce mixture. Continue cooking, stirring constantly and breaking up any remaining rice clumps, until the mixture is heated through, about 3 minutes.\nAdd reserved eggs and green onions. Cook and stir until the mixture is completely heated through, about 1 minute more. Enjoy immediately with a sprinkle of red pepper flakes or dash of hot sauce and additional soy sauce as desired.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("wellplated.com")
    expect(recipe.canonical_url).to eq("https://www.wellplated.com/homemade-fried-rice/")
    expect(recipe.site_name).to eq("Well Plated")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Erin Clarke")
    expect(recipe.description).to eq("This easy egg fried rice recipe is better than takeout and done in just 15 minutes! Serve as a side or main dish, either way it'll be a hit.")
    expect(recipe.image).to eq("https://www.wellplated.com/wp-content/uploads/2023/07/Egg-Fried-Rice-Recipe.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("Asian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq([
      "Chinese egg fried rice",
      "easy homemade fried rice recipe",
      "egg fried rice recipe",
      "homemade fried rice with egg"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.98)
    expect(recipe.ratings_count).to eq(45)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 (of 6), about 1 cup",
      "calories" => "229 kcal",
      "carbohydrateContent" => "25 g",
      "proteinContent" => "9 g",
      "fatContent" => "11 g",
      "saturatedFatContent" => "4 g",
      "transFatContent" => "0.2 g",
      "cholesterolContent" => "103 mg",
      "fiberContent" => "4 g",
      "sugarContent" => "2 g",
      "unsaturatedFatContent" => "6 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: nil, amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 229.0 },
      { name: "carbohydrateContent", unit: "g", amount: 25.0 },
      { name: "proteinContent", unit: "g", amount: 9.0 },
      { name: "fatContent", unit: "g", amount: 11.0 },
      { name: "saturatedFatContent", unit: "g", amount: 4.0 },
      { name: "transFatContent", unit: "g", amount: 0.2 },
      { name: "cholesterolContent", unit: "mg", amount: 103.0 },
      { name: "fiberContent", unit: "g", amount: 4.0 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 6.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
