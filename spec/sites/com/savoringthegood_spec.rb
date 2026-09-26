# frozen_string_literal: true

RSpec.describe "savoringthegood.com" do
  subject(:recipe) { scrape_cassette("com/savoringthegood", url: "https://www.savoringthegood.com/air-fryer-chickpeas/") }

  it "reads the title" do
    expect(recipe.title).to eq("Crunchy Chickpeas (Air Fryer and Oven Instructions) Ranch Season")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 can chickpeas (16 ounce (drained, rinsed, patted dry))",
      "Cooking spray or olive oil",
      "1 ½ Tablespoon Ranch Seasoning",
      "2 Tablespoon Grated Parmesan Cheese"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "can", name: "chickpeas" },
      { amount: nil, unit: nil, name: "Cooking spray or olive oil" },
      { amount: 1.5, unit: "Tablespoon", name: "Ranch Seasoning" },
      { amount: 2.0, unit: "Tablespoon", name: "Grated Parmesan Cheese" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Oven Instructions",
      "preheat oven",
      "Preheat the oven to 400°F.",
      "rinse, drain and pat dry the chickpeas",
      "Using a strainer, rinse and drain the chickpeas. Pat them gently with paper towels and air-dry until completely dry.",
      "remove skins",
      "Discard any of the outer skins that may fall off.",
      "spread on sheet, oil and bake.",
      "Spread the chickpeas on a baking sheet and drizzle with olive oil. Bake in the oven for 30 minutes, shaking them up halfway through.",
      "season and toss",
      "Sprinkle the ranch seasoning and grated parmesan cheese. Toss until everything is coated.",
      "second bake",
      "Bake for another 5-10 minutes until the chickpeas are crisp. Serve and enjoy!",
      "Air Fryer Instructions",
      "Preheat the air fryer to 375°F.",
      "Using a strainer, rinse and drain the chickpeas. Pat them gently with paper towels and air-dry until completely dry.",
      "Spread the chickpeas in an air fryer basket lined with a parchment liner and drizzle with olive oil. Bake in the oven for 20 minutes, shaking them up halfway through.",
      "Sprinkle the ranch seasoning and grated parmesan cheese. Toss until everything is coated.",
      "Bake for another 5-10 minutes until the chickpeas are crisp. Serve and enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Oven Instructions\npreheat oven\nPreheat the oven to 400°F.\nrinse, drain and pat dry the chickpeas\nUsing a strainer, rinse and drain the chickpeas. Pat them gently with paper towels and air-dry until completely dry.\nremove skins\nDiscard any of the outer skins that may fall off.\nspread on sheet, oil and bake.\nSpread the chickpeas on a baking sheet and drizzle with olive oil. Bake in the oven for 30 minutes, shaking them up halfway through.\nseason and toss\nSprinkle the ranch seasoning and grated parmesan cheese. Toss until everything is coated.\nsecond bake\nBake for another 5-10 minutes until the chickpeas are crisp. Serve and enjoy!\nAir Fryer Instructions\nPreheat the air fryer to 375°F.\nUsing a strainer, rinse and drain the chickpeas. Pat them gently with paper towels and air-dry until completely dry.\nSpread the chickpeas in an air fryer basket lined with a parchment liner and drizzle with olive oil. Bake in the oven for 20 minutes, shaking them up halfway through.\nSprinkle the ranch seasoning and grated parmesan cheese. Toss until everything is coated.\nBake for another 5-10 minutes until the chickpeas are crisp. Serve and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("savoringthegood.com")
    expect(recipe.canonical_url).to eq("https://www.savoringthegood.com/air-fryer-chickpeas/")
    expect(recipe.site_name).to eq("Savoring The Good®")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Sarah Mock")
    expect(recipe.description).to eq("Make these crunchy ranch roasted chickpeas for a savory snack that’s packed with flavor and super easy to prep with pantry staples.")
    expect(recipe.image).to eq("https://www.savoringthegood.com/wp-content/uploads/2025/08/1200-x-1200-with-crops-copy.jpg")
    expect(recipe.category).to eq("Air Fryer")
    expect(recipe.cuisine).to eq("Mediterranean")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq(["Crunchy Chickpeas"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1",
      "calories" => "27 kcal",
      "carbohydrateContent" => "4 g",
      "proteinContent" => "1 g",
      "fatContent" => "1 g",
      "saturatedFatContent" => "0.4 g",
      "cholesterolContent" => "2 mg",
      "sodiumContent" => "466 mg",
      "fiberContent" => "0.02 g",
      "sugarContent" => "0.02 g",
      "unsaturatedFatContent" => "0.23 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: nil, amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 27.0 },
      { name: "carbohydrateContent", unit: "g", amount: 4.0 },
      { name: "proteinContent", unit: "g", amount: 1.0 },
      { name: "fatContent", unit: "g", amount: 1.0 },
      { name: "saturatedFatContent", unit: "g", amount: 0.4 },
      { name: "cholesterolContent", unit: "mg", amount: 2.0 },
      { name: "sodiumContent", unit: "mg", amount: 466.0 },
      { name: "fiberContent", unit: "g", amount: 0.02 },
      { name: "sugarContent", unit: "g", amount: 0.02 },
      { name: "unsaturatedFatContent", unit: "g", amount: 0.23 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.savoringthegood.com/")
  end
end
