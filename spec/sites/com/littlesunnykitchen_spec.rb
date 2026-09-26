# frozen_string_literal: true

RSpec.describe "littlesunnykitchen.com" do
  subject(:recipe) { scrape_cassette("com/littlesunnykitchen", url: "https://littlesunnykitchen.com/mexican-chicken-marinade/") }

  it "reads the title" do
    expect(recipe.title).to eq("Mexican Chicken Marinade")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 tablespoons olive oil",
      "3 cloves garlic (minced)",
      "1 tablespoon fresh lime juice",
      "2 teaspoons chili powder",
      "1 teaspoon smoked paprika",
      "1 teaspoon dried oregano",
      "1 teaspoon ground cumin",
      "¼ teaspoon ground cinnamon (optional)",
      "1 teaspoon salt",
      "1-2 pounds chicken (breasts, cutlets, thighs, or drumsticks)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "tablespoons", name: "olive oil" },
      { amount: 3.0, unit: "cloves", name: "garlic" },
      { amount: 1.0, unit: "tablespoon", name: "fresh lime juice" },
      { amount: 2.0, unit: "teaspoons", name: "chili powder" },
      { amount: 1.0, unit: "teaspoon", name: "smoked paprika" },
      { amount: 1.0, unit: "teaspoon", name: "dried oregano" },
      { amount: 1.0, unit: "teaspoon", name: "ground cumin" },
      { amount: 0.25, unit: "teaspoon", name: "ground cinnamon" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: 1.0, unit: "pounds", name: "chicken" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "To a Ziploc bag, add the chicken followed by the wet ingredients and the spices.",
      "Seal the bag, and toss the chicken so that the chicken is well coated in the marinade.",
      "Place in the fridge and allow to marinate for 2-24 hours.",
      "Remove the chicken from the bag, and grill it or bake it until the internal temperature of the chicken reaches 165°F/74°C with an Instant read thermometer."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("To a Ziploc bag, add the chicken followed by the wet ingredients and the spices.\nSeal the bag, and toss the chicken so that the chicken is well coated in the marinade.\nPlace in the fridge and allow to marinate for 2-24 hours.\nRemove the chicken from the bag, and grill it or bake it until the internal temperature of the chicken reaches 165°F/74°C with an Instant read thermometer.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("littlesunnykitchen.com")
    expect(recipe.canonical_url).to eq("https://littlesunnykitchen.com/mexican-chicken-marinade/")
    expect(recipe.site_name).to eq("Little Sunny Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Diana")
    expect(recipe.description).to eq("Make this fresh Mexican chicken marinade to season all of your favorite cuts of chicken. Made with lime, garlic, olive oil, oregano, and warm spices to give your chicken an amazing flavor!")
    expect(recipe.image).to eq("https://littlesunnykitchen.com/wp-content/uploads/2021/05/Mexican-Chicken-Marinade-1.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(130)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Mexican Chicken Marinade"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.94)
    expect(recipe.ratings_count).to eq(76)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "49 kcal",
      "carbohydrateContent" => "2 g",
      "proteinContent" => "1 g",
      "fatContent" => "5 g",
      "saturatedFatContent" => "1 g",
      "sodiumContent" => "400 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "1 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 49.0 },
      { name: "carbohydrateContent", unit: "g", amount: 2.0 },
      { name: "proteinContent", unit: "g", amount: 1.0 },
      { name: "fatContent", unit: "g", amount: 5.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 400.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
