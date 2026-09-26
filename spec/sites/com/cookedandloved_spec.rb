# frozen_string_literal: true

RSpec.describe "cookedandloved.com" do
  subject(:recipe) { scrape_cassette("com/cookedandloved", url: "https://www.cookedandloved.com/recipes/smoked-salmon-dip/") }

  it "reads the title" do
    expect(recipe.title).to eq("Smoked Salmon Dip")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "9 oz light cream cheese (250 grams, full-fat can be used)",
      "4 oz smoked salmon (120 grams )",
      "¼ medium red onion (finely diced)",
      "1 tablespoon baby capers (chopped (plus a few extra for garnish))",
      "1 tablespoon chopped fresh dill (plus extra fronds for garnish)",
      "1 teaspoon lemon juice",
      "¼ teaspoon salt",
      "A pinch of black pepper",
      "2 teaspoons Everything But The Bagel seasoning",
      "A drizzle of olive oil (for serving)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 9.0, unit: "oz", name: "light cream cheese" },
      { amount: 4.0, unit: "oz", name: "smoked salmon" },
      { amount: 0.25, unit: nil, name: "medium red onion" },
      { amount: 1.0, unit: "tablespoon", name: "baby capers" },
      { amount: 1.0, unit: "tablespoon", name: "chopped fresh dill" },
      { amount: 1.0, unit: "teaspoon", name: "lemon juice" },
      { amount: 0.25, unit: "teaspoon", name: "salt" },
      { amount: 1.0, unit: "pinch", name: "black pepper" },
      { amount: 2.0, unit: "teaspoons", name: "Everything But The Bagel seasoning" },
      { amount: 1.0, unit: "drizzle", name: "olive oil" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Let cream cheese come to room temp",
      "Let the cream cheese come to room temperature, then add it to a mixing bowl.",
      "Finely dice the smoked salmon and other ingredients",
      "Finely dice the smoked salmon, onion, dill, and capers.",
      "Add into a bowl and season",
      "Add everything into the bowl with the cream cheese. Season with lemon juice, salt, and pepper.",
      "Mix using a whisk or hand mixer on low until mostly smooth with some texture.",
      "Transfer to serving bowl",
      "Spoon the dip into a serving bowl and smooth the top.",
      "Garnish",
      "Just before serving, top with EBTB seasoning, some extra capers, dill, and red onion. Finish with a drizzle of olive oil.",
      "Serve with bagel chips, crackers, sourdough, or veggies."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Let cream cheese come to room temp\nLet the cream cheese come to room temperature, then add it to a mixing bowl.\nFinely dice the smoked salmon and other ingredients\nFinely dice the smoked salmon, onion, dill, and capers.\nAdd into a bowl and season\nAdd everything into the bowl with the cream cheese. Season with lemon juice, salt, and pepper.\nMix using a whisk or hand mixer on low until mostly smooth with some texture.\nTransfer to serving bowl\nSpoon the dip into a serving bowl and smooth the top.\nGarnish\nJust before serving, top with EBTB seasoning, some extra capers, dill, and red onion. Finish with a drizzle of olive oil.\nServe with bagel chips, crackers, sourdough, or veggies.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cookedandloved.com")
    expect(recipe.canonical_url).to eq("https://www.cookedandloved.com/recipes/smoked-salmon-dip/")
    expect(recipe.site_name).to eq("Cooked & Loved")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Irena Macri")
    expect(recipe.description).to eq("Smoked salmon dip with cream cheese, onions, capers, dill, and a sprinkle of Everything But The Bagel seasoning— this tastes like your favorite New York bagel in a bowl. It’s creamy, a bit salty, herby, and a total crowd-pleaser. Find step-by-step photos and more recipe tips above.")
    expect(recipe.image).to eq("https://www.cookedandloved.com/wp-content/uploads/2025/08/salmon-dip-feature.jpg")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("Healthy")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["salmon dip", "smoked salmon dip"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(3)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "82 kcal",
      "carbohydrateContent" => "3 g",
      "proteinContent" => "5 g",
      "fatContent" => "6 g",
      "saturatedFatContent" => "3 g",
      "cholesterolContent" => "20 mg",
      "sodiumContent" => "391 mg",
      "fiberContent" => "0.1 g",
      "sugarContent" => "2 g",
      "unsaturatedFatContent" => "2.4 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 82.0 },
      { name: "carbohydrateContent", unit: "g", amount: 3.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "fatContent", unit: "g", amount: 6.0 },
      { name: "saturatedFatContent", unit: "g", amount: 3.0 },
      { name: "cholesterolContent", unit: "mg", amount: 20.0 },
      { name: "sodiumContent", unit: "mg", amount: 391.0 },
      { name: "fiberContent", unit: "g", amount: 0.1 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 2.4 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.cookedandloved.com/")
  end
end
