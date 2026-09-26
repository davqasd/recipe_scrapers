# frozen_string_literal: true

RSpec.describe "girlgonegourmet.com" do
  subject(:recipe) { scrape_cassette("com/girlgonegourmet", url: "https://www.girlgonegourmet.com/super-easy-smoked-gruyere-mac-and-cheese/") }

  it "reads the title" do
    expect(recipe.title).to eq("Smoked Gruyere Macaroni and Cheese")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "12 ounces macaroni",
      "12 ounces evaporated milk",
      "1/4 teaspoon kosher salt",
      "12 ounces smoked gruyere cheese (shredded)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 12.0, unit: "ounces", name: "macaroni" },
      { amount: 12.0, unit: "ounces", name: "evaporated milk" },
      { amount: 0.25, unit: "teaspoon", name: "kosher salt" },
      { amount: 12.0, unit: "ounces", name: "smoked gruyere cheese" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Boil the pasta two minutes less than what’s listed on the box. Reserve 1/4 cup of the pasta water before draining the pasta.",
      "Adjust the burner heat to medium-low and transfer the drained pasta back to the pot, add the evaporated milk and salt.",
      "Stir the pasta and milk. Once the milk is warmed, add the cheese in a few batches at a time, stirring between each addition until melted. If the sauce is too thick, add the pasta water a little at a time to thin it."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Boil the pasta two minutes less than what’s listed on the box. Reserve 1/4 cup of the pasta water before draining the pasta.\nAdjust the burner heat to medium-low and transfer the drained pasta back to the pot, add the evaporated milk and salt.\nStir the pasta and milk. Once the milk is warmed, add the cheese in a few batches at a time, stirring between each addition until melted. If the sauce is too thick, add the pasta water a little at a time to thin it.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("girlgonegourmet.com")
    expect(recipe.canonical_url).to eq("https://www.girlgonegourmet.com/super-easy-smoked-gruyere-mac-and-cheese/")
    expect(recipe.site_name).to eq("Girl Gone Gourmet")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("April Anderson")
    expect(recipe.description).to eq("A little fancy, totally easy. This smoked gruyere mac and cheese comes together with just four ingredients and one pot in about 20 minutes. It's decadent comfort at its best.")
    expect(recipe.image).to eq("https://www.girlgonegourmet.com/wp-content/uploads/2025/10/Smoked-Gruyere-Mac-and-Cheese-3.jpg")
    expect(recipe.category).to eq("Side Dish")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq([
      "4 ingredient macaroni and cheese",
      "mac and cheese with evaporated milk",
      "one pot mac and cheese"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "782 kcal",
      "carbohydrateContent" => "72 g",
      "proteinContent" => "42 g",
      "fatContent" => "35 g",
      "saturatedFatContent" => "20 g",
      "cholesterolContent" => "118 mg",
      "sodiumContent" => "848 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "11 g",
      "unsaturatedFatContent" => "13 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 782.0 },
      { name: "carbohydrateContent", unit: "g", amount: 72.0 },
      { name: "proteinContent", unit: "g", amount: 42.0 },
      { name: "fatContent", unit: "g", amount: 35.0 },
      { name: "saturatedFatContent", unit: "g", amount: 20.0 },
      { name: "cholesterolContent", unit: "mg", amount: 118.0 },
      { name: "sodiumContent", unit: "mg", amount: 848.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 11.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 13.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
