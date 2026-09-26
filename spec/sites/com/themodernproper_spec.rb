# frozen_string_literal: true

RSpec.describe "themodernproper.com" do
  subject(:recipe) { scrape_cassette("com/themodernproper", url: "https://themodernproper.com/parmesan-crusted-salmon") }

  it "reads the title" do
    expect(recipe.title).to eq("Parmesan Crusted Salmon")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "¼ cup panko breadcrumbs",
      "½ teaspoon garlic powder",
      "1 teaspoon dried or fresh parsley",
      "½ teaspoon sea salt",
      "¼ teaspoon freshly cracked black pepper",
      "⅓ cup freshly grated parmesan cheese",
      "3 tablespoons unsalted butter, melted (or extra virgin olive oil)",
      "1 (1-pound) salmon fillet",
      "Lemon wedges, for serving"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.25, unit: "cup", name: "panko breadcrumbs" },
      { amount: 0.5, unit: "teaspoon", name: "garlic powder" },
      { amount: 1.0, unit: "teaspoon", name: "dried or fresh parsley" },
      { amount: 0.5, unit: "teaspoon", name: "sea salt" },
      { amount: 0.25, unit: "teaspoon", name: "freshly cracked black pepper" },
      { amount: 0.33, unit: "cup", name: "freshly grated parmesan cheese" },
      { amount: 3.0, unit: "tablespoons", name: "unsalted butter, melted" },
      { amount: 1.0, unit: nil, name: "salmon fillet" },
      { amount: nil, unit: nil, name: "Lemon wedges, for serving" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 400°F with a rack in the center position. Line a rimmed sheet pan with parchment paper.",
      "In a small mixing bowl, combine the panko, garlic powder, parsley, salt, pepper, and ¼ cup of the parmesan. Add 2 tablespoons of the butter and mix until fully combined using a fork or your hands.",
      "Place the salmon, skin side down, on the prepared sheet. Pat dry with a paper towel. Brush the salmon with the remaining 1 tablespoon of the butter and sprinkle with the parmesan mixture, gently pressing to adhere to the salmon. Sprinkle with the remaining parmesan.",
      "Bake until the panko is golden brown and the salmon easily flakes with a fork, 12 to 15 minutes.",
      "Divide the salmon among 4 plates. Serve with the lemon wedges on the side."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 400°F with a rack in the center position. Line a rimmed sheet pan with parchment paper.\nIn a small mixing bowl, combine the panko, garlic powder, parsley, salt, pepper, and ¼ cup of the parmesan. Add 2 tablespoons of the butter and mix until fully combined using a fork or your hands.\nPlace the salmon, skin side down, on the prepared sheet. Pat dry with a paper towel. Brush the salmon with the remaining 1 tablespoon of the butter and sprinkle with the parmesan mixture, gently pressing to adhere to the salmon. Sprinkle with the remaining parmesan.\nBake until the panko is golden brown and the salmon easily flakes with a fork, 12 to 15 minutes.\nDivide the salmon among 4 plates. Serve with the lemon wedges on the side.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("themodernproper.com")
    expect(recipe.canonical_url).to eq("https://themodernproper.com/parmesan-crusted-salmon")
    expect(recipe.site_name).to eq("The Modern Proper")
    expect(recipe.language).to eq("en-us")
    expect(recipe.author).to eq("Holly Erickson, Natalie Mortimer")
    expect(recipe.description).to eq("Parmesan-panko crusted salmon feels fancy enough for fine dining, but is easy enough for weeknight dinner at home. Ready in under a half hour, it’s one of our favorite ways to prepare salmon.")
    expect(recipe.image).to eq("https://images.themodernproper.com/production/posts/ParmesanCrustedSalmon_5.jpg?w=960&h=540&q=82&fm=jpg&fit=crop&dm=1694016297&s=8efd053b3e6e14f206cfeb2938b1b1c5")
    expect(recipe.category).to eq("dinner")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq([
      "parmesan crusted salmon",
      "spring recipe",
      "fall recipe",
      "30-minute-meals"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(10)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "379 calories",
      "carbohydrateContent" => "4 grams carbohydrates",
      "cholesterolContent" => "133 milligrams cholesterol",
      "fatContent" => "27 grams fat",
      "fiberContent" => "0 grams fiber",
      "proteinContent" => "30 grams protein",
      "saturatedFatContent" => "9 grams saturated fat",
      "sodiumContent" => "530 milligrams sodium",
      "sugarContent" => "1 grams sugar"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 379.0 },
      { name: "carbohydrateContent", unit: "g", amount: 4.0 },
      { name: "cholesterolContent", unit: "mg", amount: 133.0 },
      { name: "fatContent", unit: "g", amount: 27.0 },
      { name: "fiberContent", unit: "g", amount: 0.0 },
      { name: "proteinContent", unit: "g", amount: 30.0 },
      { name: "saturatedFatContent", unit: "g", amount: 9.0 },
      { name: "sodiumContent", unit: "mg", amount: 530.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
