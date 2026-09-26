# frozen_string_literal: true

RSpec.describe "scrummylane.com" do
  subject(:recipe) { scrape_cassette("com/scrummylane", url: "https://scrummylane.com/sauteed-frozen-broccoli/") }

  it "reads the title" do
    expect(recipe.title).to eq("10-minute Sautéed Frozen Broccoli")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 tablespoons extra virgin olive oil (plus extra for drizzling over at the end)",
      "14 ounces frozen broccoli (or roughly 3.5 ounces per person)",
      "½ teaspoon garlic powder",
      "½ teaspoon salt",
      "1 teaspoon dried basil",
      "½ teaspoon lemon pepper seasoning (optional)",
      "¼ cup parmesan cheese (grated)",
      "½ a lemon (Juice only, but grate and keep aside a little lemon zest before juicing to sprinkle over to serve.)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "tablespoons", name: "extra virgin olive oil" },
      { amount: 14.0, unit: "ounces", name: "frozen broccoli" },
      { amount: 0.5, unit: "teaspoon", name: "garlic powder" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 1.0, unit: "teaspoon", name: "dried basil" },
      { amount: 0.5, unit: "teaspoon", name: "lemon pepper seasoning" },
      { amount: 0.25, unit: "cup", name: "parmesan cheese" },
      { amount: 0.5, unit: nil, name: "lemon" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pre-heat oil in pan.",
      "Pre-heat the oil in a large skillet or sauté pan on a medium-high heat.",
      "Add broccoli and stir until coated in oil.",
      "Add the frozen broccoli florets to the pan. Stir briefly with a wooden spoon just until the broccoli is coated in the oil.",
      "Add seasonings and saute for 6 to 8 minutes.",
      "Sprinkle the dried basil, salt, garlic powder and lemon pepper seasoning (if using) all over the broccoli. Then sauté on a medium-high heat for 5 to 8 minutes or until the broccoli is perfectly tender and lightly browned.",
      "Add parmesan and lemon juice and stir-fry.",
      "Scatter over the parmesan and stir-fry for another minute or so. Then squeeze over the lemon juice.",
      "Serve with lemon zest and extra olive oil.",
      "Serve hot, warm or at room temperature scattered with a little lemon zest and a little extra olive oil, if you like."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pre-heat oil in pan.\nPre-heat the oil in a large skillet or sauté pan on a medium-high heat.\nAdd broccoli and stir until coated in oil.\nAdd the frozen broccoli florets to the pan. Stir briefly with a wooden spoon just until the broccoli is coated in the oil.\nAdd seasonings and saute for 6 to 8 minutes.\nSprinkle the dried basil, salt, garlic powder and lemon pepper seasoning (if using) all over the broccoli. Then sauté on a medium-high heat for 5 to 8 minutes or until the broccoli is perfectly tender and lightly browned.\nAdd parmesan and lemon juice and stir-fry.\nScatter over the parmesan and stir-fry for another minute or so. Then squeeze over the lemon juice.\nServe with lemon zest and extra olive oil.\nServe hot, warm or at room temperature scattered with a little lemon zest and a little extra olive oil, if you like.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("scrummylane.com")
    expect(recipe.canonical_url).to eq("https://scrummylane.com/sauteed-frozen-broccoli/")
    expect(recipe.site_name).to eq("Scrummy Lane")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Helen Schofield")
    expect(recipe.description).to eq("Welcome to your new favorite last minute vegetable side dish! You can cook this sautéed frozen broccoli straight from frozen (yep, no defrosting necessary!). Season with dried basil and garlic, lemon and parmesan for the kind of perfectly tender and browned seasoned broccoli that can convert even the most ardent of broccoli haters. The best part? It's on your dinner table in only 10 minutes!")
    expect(recipe.image).to eq("https://scrummylane.com/wp-content/uploads/2023/07/sauteed-broccoli-4.jpg")
    expect(recipe.category).to eq("Side Dish")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to eq(2)
    expect(recipe.cook_time).to eq(8)
    expect(recipe.keywords).to eq(["frozen broccoli", "sauteed broccoli", "seasoned broccoli"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(%w[DiabeticDiet LowCalorieDiet LowFatDiet])
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(10)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "92 kcal",
      "carbohydrateContent" => "7 g",
      "proteinContent" => "5 g",
      "fatContent" => "6 g",
      "saturatedFatContent" => "2 g",
      "sodiumContent" => "424 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "2 g",
      "cholesterolContent" => "4 mg",
      "unsaturatedFatContent" => "4 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 92.0 },
      { name: "carbohydrateContent", unit: "g", amount: 7.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "fatContent", unit: "g", amount: 6.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "sodiumContent", unit: "mg", amount: 424.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "cholesterolContent", unit: "mg", amount: 4.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 4.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
