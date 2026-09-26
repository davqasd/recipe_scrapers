# frozen_string_literal: true

RSpec.describe "number-2-pencil.com" do
  subject(:recipe) { scrape_cassette("com/number_2_pencil", url: "https://www.number-2-pencil.com/one-sheet-pan-shrimp-fajitas/") }

  it "reads the title" do
    expect(recipe.title).to eq("Sheet Pan Shrimp Fajitas")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 1/2 pounds shrimp (peeled and deveined)",
      "1 yellow bell pepper (sliced thin)",
      "1 red bell pepper (sliced thin)",
      "1 orange bell pepper (sliced thin)",
      "1 small red onion (sliced thin)",
      "1 1/2 tablespoons extra virgin olive oil",
      "1 teaspoon kosher salt",
      "several turns of freshly ground pepper",
      "2 teaspoon chili powder",
      "1/2 teaspoon garlic powder",
      "1/2 teaspoon onion powder",
      "1/2 teaspoon ground cumin",
      "1/2 teaspoon smoked paprika",
      "lime",
      "fresh cilantro for garnish",
      "tortillas (warmed)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.5, unit: "pounds", name: "shrimp" },
      { amount: 1.0, unit: nil, name: "yellow bell pepper" },
      { amount: 1.0, unit: nil, name: "red bell pepper" },
      { amount: 1.0, unit: nil, name: "orange bell pepper" },
      { amount: 1.0, unit: nil, name: "small red onion" },
      { amount: 1.5, unit: "tablespoons", name: "extra virgin olive oil" },
      { amount: 1.0, unit: "teaspoon", name: "kosher salt" },
      { amount: nil, unit: nil, name: "several turns of freshly ground pepper" },
      { amount: 2.0, unit: "teaspoon", name: "chili powder" },
      { amount: 0.5, unit: "teaspoon", name: "garlic powder" },
      { amount: 0.5, unit: "teaspoon", name: "onion powder" },
      { amount: 0.5, unit: "teaspoon", name: "ground cumin" },
      { amount: 0.5, unit: "teaspoon", name: "smoked paprika" },
      { amount: nil, unit: nil, name: "lime" },
      { amount: nil, unit: nil, name: "fresh cilantro for garnish" },
      { amount: nil, unit: nil, name: "tortillas" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 450 degrees.",
      "In a large bowl, combine onion, bell pepper, shrimp, olive oil, salt and pepper and spices.",
      "Toss to combine.",
      "Spray baking sheet with non stick cooking spray.",
      "Spread shrimp, bell peppers and onions on baking sheet.",
      "Cook at 450 degrees for about 8 minutes. Then turn oven to broil and cook for additional 2 minutes or until shrimp is cooked through.",
      "Squeeze juice from fresh lime over fajita mixture and top with fresh cilantro.",
      "Serve in warm tortillas."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 450 degrees.\nIn a large bowl, combine onion, bell pepper, shrimp, olive oil, salt and pepper and spices.\nToss to combine.\nSpray baking sheet with non stick cooking spray.\nSpread shrimp, bell peppers and onions on baking sheet.\nCook at 450 degrees for about 8 minutes. Then turn oven to broil and cook for additional 2 minutes or until shrimp is cooked through.\nSqueeze juice from fresh lime over fajita mixture and top with fresh cilantro.\nServe in warm tortillas.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("number-2-pencil.com")
    expect(recipe.canonical_url).to eq("https://www.number-2-pencil.com/one-sheet-pan-shrimp-fajitas/")
    expect(recipe.site_name).to eq("No. 2 Pencil")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Melissa")
    expect(recipe.description).to eq("This shrimp fajita recipe is so easy and delicious. With juicy shrimp, tender bell peppers and onions its the perfect easy weeknight dinner!")
    expect(recipe.image).to eq("https://www.number-2-pencil.com/wp-content/uploads/2016/09/Sheet-Pan-Shrimp-Fajitas_-6.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.94)
    expect(recipe.ratings_count).to eq(48)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "carbohydrateContent" => "9 g",
      "proteinContent" => "36 g",
      "fatContent" => "7 g",
      "saturatedFatContent" => "1 g",
      "transFatContent" => "0.01 g",
      "cholesterolContent" => "274 mg",
      "sodiumContent" => "805 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "4 g",
      "calories" => "232 kcal",
      "unsaturatedFatContent" => "5 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "carbohydrateContent", unit: "g", amount: 9.0 },
      { name: "proteinContent", unit: "g", amount: 36.0 },
      { name: "fatContent", unit: "g", amount: 7.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "transFatContent", unit: "g", amount: 0.01 },
      { name: "cholesterolContent", unit: "mg", amount: 274.0 },
      { name: "sodiumContent", unit: "mg", amount: 805.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 4.0 },
      { name: "calories", unit: "kcal", amount: 232.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 5.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
