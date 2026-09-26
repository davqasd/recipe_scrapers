# frozen_string_literal: true

RSpec.describe "itsnotaboutnutrition.com" do
  subject(:recipe) { scrape_cassette("com/itsnotaboutnutrition", url: "https://itsnotaboutnutrition.com/queso-cauliflower-bake-the-dish-that-wins-over-even-the-picky-eaters/") }

  it "reads the title" do
    expect(recipe.title).to eq("Queso Cauliflower Bake")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 heads cauliflower, roughly chopped",
      "2 cups shredded white cheddar cheese, divided",
      "1 cup mozzarella cheese",
      "1 package (8 oz) cream cheese, softened",
      "1 can (12 oz) evaporated milk",
      "2 cans (4 oz) diced green chiles",
      "3 teaspoons taco seasoning",
      "1 teaspoon salt",
      "0.5 teaspoon garlic powder",
      "fresh cilantro, for garnish"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "heads", name: "cauliflower, roughly chopped" },
      { amount: 2.0, unit: "cups", name: "shredded white cheddar cheese, divided" },
      { amount: 1.0, unit: "cup", name: "mozzarella cheese" },
      { amount: 1.0, unit: "package", name: "cream cheese, softened" },
      { amount: 1.0, unit: "can", name: "evaporated milk" },
      { amount: 2.0, unit: "cans", name: "diced green chiles" },
      { amount: 3.0, unit: "teaspoons", name: "taco seasoning" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: 0.5, unit: "teaspoon", name: "garlic powder" },
      { amount: nil, unit: nil, name: "fresh cilantro, for garnish" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 375°F and grease a 9x13-inch baking dish.",
      "Add chopped cauliflower to the baking dish in an even layer.",
      "In a bowl, mix 1 cup white cheddar, mozzarella, and cream cheese until combined.",
      "Add evaporated milk, green chiles, taco seasoning, salt, and garlic powder. Mix until smooth.",
      "Pour cheese mixture over cauliflower. Top with remaining cheddar.",
      "Bake for 30–35 minutes, until cauliflower is tender and top is golden.",
      "Garnish with cilantro and serve warm."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 375°F and grease a 9x13-inch baking dish.\nAdd chopped cauliflower to the baking dish in an even layer.\nIn a bowl, mix 1 cup white cheddar, mozzarella, and cream cheese until combined.\nAdd evaporated milk, green chiles, taco seasoning, salt, and garlic powder. Mix until smooth.\nPour cheese mixture over cauliflower. Top with remaining cheddar.\nBake for 30–35 minutes, until cauliflower is tender and top is golden.\nGarnish with cilantro and serve warm.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("itsnotaboutnutrition.com")
    expect(recipe.canonical_url).to eq("https://itsnotaboutnutrition.com/queso-cauliflower-bake-the-dish-that-wins-over-even-the-picky-eaters/")
    expect(recipe.site_name).to eq("It's Not About Nutrition")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jennifer")
    expect(recipe.description).to eq("Cauliflower bakes in a creamy queso-style sauce with white cheddar, mozzarella, cream cheese, green chiles, and taco seasoning.")
    expect(recipe.image).to eq("https://itsnotaboutnutrition.com/wp-content/uploads/2025/10/aspic7_httpss.mj_.runtb9dRN8V47U_Queso_Cauliflower_Bake_in_a_b_11eb7c64-c6a5-4d2e-9408-9dd14ce77ad7_1.jpg")
    expect(recipe.category).to eq("Side Dish")
    expect(recipe.cuisine).to eq("Tex-Mex")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "286 kcal",
      "fatContent" => "20.7 g",
      "saturatedFatContent" => "13 g",
      "transFatContent" => "0.2 g",
      "cholesterolContent" => "61 mg",
      "sodiumContent" => "895 mg",
      "carbohydrateContent" => "12 g",
      "fiberContent" => "1.4 g",
      "sugarContent" => "5.5 g",
      "proteinContent" => "14 g",
      "servingSize" => "1 servings"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 286.0 },
      { name: "fatContent", unit: "g", amount: 20.7 },
      { name: "saturatedFatContent", unit: "g", amount: 13.0 },
      { name: "transFatContent", unit: "g", amount: 0.2 },
      { name: "cholesterolContent", unit: "mg", amount: 61.0 },
      { name: "sodiumContent", unit: "mg", amount: 895.0 },
      { name: "carbohydrateContent", unit: "g", amount: 12.0 },
      { name: "fiberContent", unit: "g", amount: 1.4 },
      { name: "sugarContent", unit: "g", amount: 5.5 },
      { name: "proteinContent", unit: "g", amount: 14.0 },
      { name: "servingSize", unit: "servings", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
