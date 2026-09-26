# frozen_string_literal: true

RSpec.describe "cookinglsl.com" do
  subject(:recipe) { scrape_cassette("com/cookinglsl", url: "https://cookinglsl.com/easy-baked-halibut-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Baked halibut recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 lb Halibut fillet",
      "1/4 cup olive oil",
      "1/2 tsp Salt",
      "1/4 tsp Black pepper",
      "1/4 tsp Paprika",
      "1/4 tsp Smoked paprika",
      "1/4 tsp Garlic powder",
      "Juice from one medium lemon"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "lb", name: "Halibut fillet" },
      { amount: 0.25, unit: "cup", name: "olive oil" },
      { amount: 0.5, unit: "tsp", name: "Salt" },
      { amount: 0.25, unit: "tsp", name: "Black pepper" },
      { amount: 0.25, unit: "tsp", name: "Paprika" },
      { amount: 0.25, unit: "tsp", name: "Smoked paprika" },
      { amount: 0.25, unit: "tsp", name: "Garlic powder" },
      { amount: nil, unit: nil, name: "Juice from one medium lemon" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 425°F (220°C).",
      "Place the halibut fillets in a baking dish or on a sheet pan lined with parchment paper.",
      "In a small bowl, whisk together the olive oil, lemon juice, salt, black pepper, paprika, smoked paprika, and garlic powder.",
      "Brush or spoon the mixture evenly over the fish.",
      "Bake for 12–14 minutes, or until the halibut is opaque and flakes easily with a fork.",
      "Serve warm with salad, quinoa, pasta, couscous, or your favorite sides."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 425°F (220°C).\nPlace the halibut fillets in a baking dish or on a sheet pan lined with parchment paper.\nIn a small bowl, whisk together the olive oil, lemon juice, salt, black pepper, paprika, smoked paprika, and garlic powder.\nBrush or spoon the mixture evenly over the fish.\nBake for 12–14 minutes, or until the halibut is opaque and flakes easily with a fork.\nServe warm with salad, quinoa, pasta, couscous, or your favorite sides.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cookinglsl.com")
    expect(recipe.canonical_url).to eq("https://cookinglsl.com/easy-baked-halibut-recipe/")
    expect(recipe.site_name).to eq("Cooking LSL")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Mira Lyubenova")
    expect(recipe.description).to eq("Baked halibut fillets brushed with lemon, garlic, and olive oil, then baked at high heat until flaky and tender. Ready in 12 minutes — the method that keeps it juicy every time.")
    expect(recipe.image).to eq("https://cookinglsl.com/wp-content/uploads/2020/02/baked-halibut-recipe-03.jpg")
    expect(recipe.category).to eq("dinner")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(12)
    expect(recipe.keywords).to eq(["baked Haibut"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(10)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "327 kcal",
      "carbohydrateContent" => "0.4 g",
      "proteinContent" => "42 g",
      "fatContent" => "17 g",
      "saturatedFatContent" => "3 g",
      "cholesterolContent" => "111 mg",
      "sodiumContent" => "445 mg",
      "fiberContent" => "0.1 g",
      "sugarContent" => "0.03 g",
      "unsaturatedFatContent" => "13 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 327.0 },
      { name: "carbohydrateContent", unit: "g", amount: 0.4 },
      { name: "proteinContent", unit: "g", amount: 42.0 },
      { name: "fatContent", unit: "g", amount: 17.0 },
      { name: "saturatedFatContent", unit: "g", amount: 3.0 },
      { name: "cholesterolContent", unit: "mg", amount: 111.0 },
      { name: "sodiumContent", unit: "mg", amount: 445.0 },
      { name: "fiberContent", unit: "g", amount: 0.1 },
      { name: "sugarContent", unit: "g", amount: 0.03 },
      { name: "unsaturatedFatContent", unit: "g", amount: 13.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
