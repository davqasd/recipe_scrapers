# frozen_string_literal: true

RSpec.describe "realmomnutrition.com" do
  subject(:recipe) { scrape_cassette("com/realmomnutrition", url: "https://www.realmomnutrition.com/easy-lemonade/") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy Lemonade (Made with Fresh + Bottled Lemon Juice)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3/4 cup sugar",
      "8 1/2 cup water, divided",
      "1 cup lemon juice"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.75, unit: "cup", name: "sugar" },
      { amount: 8.5, unit: "cup", name: "water, divided" },
      { amount: 1.0, unit: "cup", name: "lemon juice" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Make the simple syrup: Combine sugar plus 1/2 cup water in a small saucepan over medium-low heat. Heat and stir until sugar is fully dissolved (you'll know it's dissolved when the liquid looks clear).",
      "Combine the simple syrup and lemon juice in a 2-quart pitcher.",
      "Add 8 cups of cold water.",
      "Chill before serving (or serve over ice)."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Make the simple syrup: Combine sugar plus 1/2 cup water in a small saucepan over medium-low heat. Heat and stir until sugar is fully dissolved (you'll know it's dissolved when the liquid looks clear).\nCombine the simple syrup and lemon juice in a 2-quart pitcher.\nAdd 8 cups of cold water.\nChill before serving (or serve over ice).")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("realmomnutrition.com")
    expect(recipe.canonical_url).to eq("https://www.realmomnutrition.com/easy-lemonade/")
    expect(recipe.site_name).to eq("Real Mom Nutrition")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Sally")
    expect(recipe.description).to eq("Want a pitcher of cold, refreshing homemade lemonade in just a few minutes? Make this lemonade recipe with lemon juice and fresh lemons.")
    expect(recipe.image).to eq("https://www.realmomnutrition.com/wp-content/uploads/Lemonade4-480x480.jpg")
    expect(recipe.category).to eq("Drinks")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(12)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(2)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.6)
    expect(recipe.ratings_count).to eq(174)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "78 calories",
      "carbohydrateContent" => "20 grams carbohydrates",
      "cholesterolContent" => "0 milligrams cholesterol",
      "fatContent" => "0 grams fat",
      "fiberContent" => "0 grams fiber",
      "proteinContent" => "0 grams protein",
      "saturatedFatContent" => "0 grams saturated fat",
      "servingSize" => "1 cup",
      "sodiumContent" => "18 milligrams sodium",
      "sugarContent" => "19 grams sugar",
      "transFatContent" => "0 grams trans fat",
      "unsaturatedFatContent" => "0 grams unsaturated fat"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 78.0 },
      { name: "carbohydrateContent", unit: "g", amount: 20.0 },
      { name: "cholesterolContent", unit: "mg", amount: 0.0 },
      { name: "fatContent", unit: "g", amount: 0.0 },
      { name: "fiberContent", unit: "g", amount: 0.0 },
      { name: "proteinContent", unit: "g", amount: 0.0 },
      { name: "saturatedFatContent", unit: "g", amount: 0.0 },
      { name: "servingSize", unit: "cup", amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 18.0 },
      { name: "sugarContent", unit: "g", amount: 19.0 },
      { name: "transFatContent", unit: "g", amount: 0.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 0.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
