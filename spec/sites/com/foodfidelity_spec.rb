# frozen_string_literal: true

RSpec.describe "foodfidelity.com" do
  subject(:recipe) { scrape_cassette("com/foodfidelity", url: "https://www.foodfidelity.com/strawberry-oatmeal/") }

  it "reads the title" do
    expect(recipe.title).to eq("Strawberry Oatmeal with Orange Juice")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup Old-Fashioned Oats",
      "1/2 tbsp Clarified Butter (Ghee or regular unsalted butter)",
      "1 pinch salt",
      "1 cup Orange Juice",
      "1 cup Almond Milk",
      "1/2 cup Strawberries",
      "1 tbsp Honey",
      "1/2 tsp Orange Zest"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "Old-Fashioned Oats" },
      { amount: 0.5, unit: "tbsp", name: "Clarified Butter" },
      { amount: 1.0, unit: "pinch", name: "salt" },
      { amount: 1.0, unit: "cup", name: "Orange Juice" },
      { amount: 1.0, unit: "cup", name: "Almond Milk" },
      { amount: 0.5, unit: "cup", name: "Strawberries" },
      { amount: 1.0, unit: "tbsp", name: "Honey" },
      { amount: 0.5, unit: "tsp", name: "Orange Zest" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Heat sauce pan over medium heat. Add ghee and then toast the oats for 1-2 minutes.",
      "Add the orange juice, salt, almond milk, and oats then cook according to package directions (bring to a boil then simmer for 5 minutes).",
      "Mix in the honey then top with the strawberry. Add zest and serve."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Heat sauce pan over medium heat. Add ghee and then toast the oats for 1-2 minutes.\nAdd the orange juice, salt, almond milk, and oats then cook according to package directions (bring to a boil then simmer for 5 minutes).\nMix in the honey then top with the strawberry. Add zest and serve.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("foodfidelity.com")
    expect(recipe.canonical_url).to eq("https://www.foodfidelity.com/strawberry-oatmeal/")
    expect(recipe.site_name).to eq("Food Fidelity")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Marwin Brown")
    expect(recipe.description).to eq("Quick and easy strawberry oatmeal recipe with old-fashioned oats cooked in a fresh orange juice based broth for a refreshing and filling breakfast.")
    expect(recipe.image).to eq("https://www.foodfidelity.com/wp-content/uploads/2020/06/stovetop-Orange-juice-oatmeal-w-strawberries-tight-1.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(2)
    expect(recipe.cook_time).to eq(5)
    expect(recipe.keywords).to eq(["oatmeal", "strawberry oatmeal"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "304 kcal",
      "carbohydrateContent" => "52 g",
      "proteinContent" => "7 g",
      "fatContent" => "8 g",
      "saturatedFatContent" => "3 g",
      "cholesterolContent" => "10 mg",
      "sodiumContent" => "186 mg",
      "fiberContent" => "5 g",
      "sugarContent" => "21 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 304.0 },
      { name: "carbohydrateContent", unit: "g", amount: 52.0 },
      { name: "proteinContent", unit: "g", amount: 7.0 },
      { name: "fatContent", unit: "g", amount: 8.0 },
      { name: "saturatedFatContent", unit: "g", amount: 3.0 },
      { name: "cholesterolContent", unit: "mg", amount: 10.0 },
      { name: "sodiumContent", unit: "mg", amount: 186.0 },
      { name: "fiberContent", unit: "g", amount: 5.0 },
      { name: "sugarContent", unit: "g", amount: 21.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
