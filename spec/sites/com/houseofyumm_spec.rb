# frozen_string_literal: true

RSpec.describe "houseofyumm.com" do
  subject(:recipe) { scrape_cassette("com/houseofyumm", url: "https://houseofyumm.com/cheesy-chicken-fritters/") }

  it "reads the title" do
    expect(recipe.title).to eq("Cheesy Chicken Fritters")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1½ pounds chicken thighs (skinless, boneless)",
      "2 large eggs",
      "⅓ cup greek yogurt (plain)",
      "⅓ cup bread crumbs (plain)",
      "1 cup Monterey Jack cheese (grated)",
      "½ bunch cilantro (chopped)",
      "1 teaspoon salt",
      "½ teaspoon chili powder",
      "½ teaspoon garlic powder",
      "½ teaspoon cumin",
      "½ lime (juiced)",
      "2 cloves garlic (minced)",
      "2 green onions (sliced)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.5, unit: "pounds", name: "chicken thighs" },
      { amount: 2.0, unit: nil, name: "large eggs" },
      { amount: 0.33, unit: "cup", name: "greek yogurt" },
      { amount: 0.33, unit: "cup", name: "bread crumbs" },
      { amount: 1.0, unit: "cup", name: "Monterey Jack cheese" },
      { amount: 0.5, unit: "bunch", name: "cilantro" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: 0.5, unit: "teaspoon", name: "chili powder" },
      { amount: 0.5, unit: "teaspoon", name: "garlic powder" },
      { amount: 0.5, unit: "teaspoon", name: "cumin" },
      { amount: 0.5, unit: nil, name: "lime" },
      { amount: 2.0, unit: "cloves", name: "garlic" },
      { amount: 2.0, unit: nil, name: "green onions" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Add the chicken thighs to a food processor and pulse until chicken is finely chopped up no large chunks.",
      "In a large bowl combine the chicken, eggs, greek yogurt, bread crumbs, grated cheese, chopped cilantro, and seasonings. Stir this all together until well combined.",
      "Using a large scoop, divide the chicken mixture into 16 equal amounts, form into a patty shape.",
      "Preheat the air fryer. Spray with avocado oil. Then place as many chicken fritters will fit in a single layer. Air Fry at 400 for 12-15 minutes. Always check internal temperature to ensure that the chicken is cooked through at 165 degrees F.",
      "Serve with a drizzle of crema or sour cream."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Add the chicken thighs to a food processor and pulse until chicken is finely chopped up no large chunks.\nIn a large bowl combine the chicken, eggs, greek yogurt, bread crumbs, grated cheese, chopped cilantro, and seasonings. Stir this all together until well combined.\nUsing a large scoop, divide the chicken mixture into 16 equal amounts, form into a patty shape.\nPreheat the air fryer. Spray with avocado oil. Then place as many chicken fritters will fit in a single layer. Air Fry at 400 for 12-15 minutes. Always check internal temperature to ensure that the chicken is cooked through at 165 degrees F.\nServe with a drizzle of crema or sour cream.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("houseofyumm.com")
    expect(recipe.canonical_url).to eq("https://houseofyumm.com/cheesy-chicken-fritters/")
    expect(recipe.site_name).to eq("House of Yumm")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Serene")
    expect(recipe.description).to eq("These easy to make Cheesy Chicken Fritters are seasoned with an easy spice blend and packed with cilantro, green onion, lime juice, and plenty of cheese. Greek yogurt and egg add extra protein to make these a protein packed lunch or dinner idea. Cook them up in the air fryer, oven, or skillet.")
    expect(recipe.image).to eq("https://houseofyumm.com/wp-content/uploads/2025/08/chicken-fritters-5.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq(["chicken fritters"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "2 fritters",
      "calories" => "282 kcal",
      "carbohydrateContent" => "5 g",
      "proteinContent" => "20 g",
      "fatContent" => "20 g",
      "saturatedFatContent" => "7 g",
      "transFatContent" => "0.1 g",
      "cholesterolContent" => "137 mg",
      "sodiumContent" => "496 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "1 g",
      "unsaturatedFatContent" => "11 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "fritters", amount: 2.0 },
      { name: "calories", unit: "kcal", amount: 282.0 },
      { name: "carbohydrateContent", unit: "g", amount: 5.0 },
      { name: "proteinContent", unit: "g", amount: 20.0 },
      { name: "fatContent", unit: "g", amount: 20.0 },
      { name: "saturatedFatContent", unit: "g", amount: 7.0 },
      { name: "transFatContent", unit: "g", amount: 0.1 },
      { name: "cholesterolContent", unit: "mg", amount: 137.0 },
      { name: "sodiumContent", unit: "mg", amount: 496.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 11.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
