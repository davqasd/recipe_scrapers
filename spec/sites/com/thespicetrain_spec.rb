# frozen_string_literal: true

RSpec.describe "thespicetrain.com" do
  subject(:recipe) { scrape_cassette("com/thespicetrain", url: "https://thespicetrain.com/ahi-tuna-rub/") }

  it "reads the title" do
    expect(recipe.title).to eq("Ahi Tuna Rub")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 teaspoon dry mustard*",
      "½ teaspoon ground black pepper",
      "¼ teaspoon smoked hot paprika",
      "¼ teaspoon dried thyme",
      "⅛ teaspoon dried rosemary",
      "¼ teaspoon onion powder",
      "¼ teaspoon garlic powder",
      "¼ teaspoon table salt"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "teaspoon", name: "dry mustard*" },
      { amount: 0.5, unit: "teaspoon", name: "ground black pepper" },
      { amount: 0.25, unit: "teaspoon", name: "smoked hot paprika" },
      { amount: 0.25, unit: "teaspoon", name: "dried thyme" },
      { amount: 0.13, unit: "teaspoon", name: "dried rosemary" },
      { amount: 0.25, unit: "teaspoon", name: "onion powder" },
      { amount: 0.25, unit: "teaspoon", name: "garlic powder" },
      { amount: 0.25, unit: "teaspoon", name: "table salt" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Add all ingredients to a bowl and mix well.",
      "If you're not planning on using the rub right away, transfer it into an airtight container. Keep in a dark and cool place, such as the kitchen cabinet. It will stay fresh for at least 6 months."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Add all ingredients to a bowl and mix well.\nIf you're not planning on using the rub right away, transfer it into an airtight container. Keep in a dark and cool place, such as the kitchen cabinet. It will stay fresh for at least 6 months.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thespicetrain.com")
    expect(recipe.canonical_url).to eq("https://thespicetrain.com/ahi-tuna-rub/")
    expect(recipe.site_name).to eq("The Spice Train")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Nicole B.")
    expect(recipe.description).to eq("This ahi tuna rub creates a delicious, flavorful crust on ahi (yellowfin) tuna steaks.Makes a little more than 1 tablespoon, which is enough to season 2 ahi tuna steaks (with each steak weighing about 5 ounces).")
    expect(recipe.image).to eq("https://thespicetrain.com/wp-content/uploads/2022/06/ahi-tuna-rub-252.jpg")
    expect(recipe.category).to eq("Dry Rubs and Seasonings")
    expect(recipe.cuisine).to eq("World")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(5)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["ahi tuna rub", "ahi tuna seasoning"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.9)
    expect(recipe.ratings_count).to eq(19)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "13 kcal",
      "carbohydrateContent" => "1.7 g",
      "proteinContent" => "0.6 g",
      "fatContent" => "0.5 g",
      "saturatedFatContent" => "0.1 g",
      "sodiumContent" => "291 mg",
      "fiberContent" => "0.6 g",
      "sugarContent" => "0.3 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 13.0 },
      { name: "carbohydrateContent", unit: "g", amount: 1.7 },
      { name: "proteinContent", unit: "g", amount: 0.6 },
      { name: "fatContent", unit: "g", amount: 0.5 },
      { name: "saturatedFatContent", unit: "g", amount: 0.1 },
      { name: "sodiumContent", unit: "mg", amount: 291.0 },
      { name: "fiberContent", unit: "g", amount: 0.6 },
      { name: "sugarContent", unit: "g", amount: 0.3 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://thespicetrain.com/")
  end
end
