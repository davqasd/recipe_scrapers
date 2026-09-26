# frozen_string_literal: true

RSpec.describe "cookingwithjanica.com" do
  subject(:recipe) { scrape_cassette("com/cookingwithjanica", url: "https://cookingwithjanica.com/air-fryer-breakfast-potatoes/") }

  it "reads the title" do
    expect(recipe.title).to eq("Air Fryer Breakfast Potatoes")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 lbs gold or russet potatoes",
      "1 teaspoon paprika",
      "1 teaspoon garlic powder",
      "1 teaspoon onion powder",
      "Salt and black pepper to taste",
      "2 tablespoons oil (EVOO, avocado, canola, etc.)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "lbs", name: "gold or russet potatoes" },
      { amount: 1.0, unit: "teaspoon", name: "paprika" },
      { amount: 1.0, unit: "teaspoon", name: "garlic powder" },
      { amount: 1.0, unit: "teaspoon", name: "onion powder" },
      { amount: nil, unit: nil, name: "Salt and black pepper to taste" },
      { amount: 2.0, unit: "tablespoons", name: "oil" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat your air fryer to 385°F.",
      "Wash your potatoes thoroughly. Using a sharp knife, dice them into 1-inch cubes.",
      "Place the potatoes in a large bowl. Sprinkle paprika, garlic powder, onion powder, salt, pepper, and oil on top. Mix gently until well combined.",
      "Place the seasoned potatoes in the air fryer basket in a single layer. Air fry for a cooking time of 15-20 minutes or until they turn golden brown. (I recommend shaking the basket halfway through to ensure they cook evenly.)"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat your air fryer to 385°F.\nWash your potatoes thoroughly. Using a sharp knife, dice them into 1-inch cubes.\nPlace the potatoes in a large bowl. Sprinkle paprika, garlic powder, onion powder, salt, pepper, and oil on top. Mix gently until well combined.\nPlace the seasoned potatoes in the air fryer basket in a single layer. Air fry for a cooking time of 15-20 minutes or until they turn golden brown. (I recommend shaking the basket halfway through to ensure they cook evenly.)")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cookingwithjanica.com")
    expect(recipe.canonical_url).to eq("https://cookingwithjanica.com/air-fryer-breakfast-potatoes/")
    expect(recipe.site_name).to eq("Cooking With Janica")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jessica Pinney")
    expect(recipe.description).to eq("Crispy breakfast potatoes made in the air fryer.")
    expect(recipe.image).to eq("https://cookingwithjanica.com/wp-content/uploads/2023/04/air_fryer_breakfast_potatoes.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["breakfast in air fryer", "easy breakfast potatoes"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "247 kcal",
      "sugarContent" => "2 g",
      "sodiumContent" => "12 mg",
      "fatContent" => "7 g",
      "saturatedFatContent" => "1 g",
      "transFatContent" => "0.03 g",
      "carbohydrateContent" => "42 g",
      "fiberContent" => "3 g",
      "proteinContent" => "5 g",
      "unsaturatedFatContent" => "6 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 247.0 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "sodiumContent", unit: "mg", amount: 12.0 },
      { name: "fatContent", unit: "g", amount: 7.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "transFatContent", unit: "g", amount: 0.03 },
      { name: "carbohydrateContent", unit: "g", amount: 42.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 6.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#wp--skip-link--target")
  end
end
