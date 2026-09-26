# frozen_string_literal: true

RSpec.describe "gloriousrecipes.com" do
  subject(:recipe) { scrape_cassette("com/gloriousrecipes", url: "https://www.gloriousrecipes.com/low-carb-tuna-crepini-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Low Carb Tuna Crepini")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "½ can tuna, drained",
      "2 tbsp avocado mayonnaise",
      "salt and black pepper, to taste",
      "1 tbsp jalapeño, finely diced",
      "1 tbsp red onion, finely diced",
      "1 tbsp pickles, finely diced",
      "1 Crepini wrap",
      "¼ cup arugula"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.5, unit: "can", name: "tuna, drained" },
      { amount: 2.0, unit: "tbsp", name: "avocado mayonnaise" },
      { amount: nil, unit: nil, name: "salt and black pepper, to taste" },
      { amount: 1.0, unit: "tbsp", name: "jalapeño, finely diced" },
      { amount: 1.0, unit: "tbsp", name: "red onion, finely diced" },
      { amount: 1.0, unit: "tbsp", name: "pickles, finely diced" },
      { amount: 1.0, unit: nil, name: "Crepini wrap" },
      { amount: 0.25, unit: "cup", name: "arugula" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Prepare ingredients",
      "Prepare all ingredients as required.",
      "Mix ingredients",
      "Add drained tuna, avocado mayonnaise, salt, and pepper to a bowl and mix well. Add diced jalapeño, onions, and pickles to the mixture and combine well.",
      "Assemble wrap",
      "Spread the mixture on a Crepini wrap and top with arugula. Serve and enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Prepare ingredients\nPrepare all ingredients as required.\nMix ingredients\nAdd drained tuna, avocado mayonnaise, salt, and pepper to a bowl and mix well. Add diced jalapeño, onions, and pickles to the mixture and combine well.\nAssemble wrap\nSpread the mixture on a Crepini wrap and top with arugula. Serve and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("gloriousrecipes.com")
    expect(recipe.canonical_url).to eq("https://www.gloriousrecipes.com/low-carb-tuna-crepini-recipe/")
    expect(recipe.site_name).to eq("Glorious Recipes")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Dorothy Williams")
    expect(recipe.description).to eq("This Low Carb Tuna Crepini makes for a perfect light brunch or snack and it's so simple to make! Try it yourself and you'll be pleasantly surprised by how good it tastes!")
    expect(recipe.image).to eq("https://www.gloriousrecipes.com/wp-content/uploads/2023/11/Low-Carb-Tuna-Crepini-480x480.jpg")
    expect(recipe.category).to eq("Lunch & Dinner")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("1 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(5)
    expect(recipe.keywords).to eq(["tuna crepini recipe", "crepini recipes"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(17)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "120 calories",
      "carbohydrateContent" => "0 grams carbohydrates",
      "cholesterolContent" => "0 milligrams cholesterol",
      "fatContent" => "1 grams fat",
      "fiberContent" => "5 grams fiber",
      "proteinContent" => "28 grams protein",
      "saturatedFatContent" => "0 grams saturated fat",
      "servingSize" => "1",
      "sodiumContent" => "25 milligrams sodium",
      "sugarContent" => "0 grams sugar",
      "transFatContent" => "0 grams trans fat",
      "unsaturatedFatContent" => "0 grams unsaturated fat"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 120.0 },
      { name: "carbohydrateContent", unit: "g", amount: 0.0 },
      { name: "cholesterolContent", unit: "mg", amount: 0.0 },
      { name: "fatContent", unit: "g", amount: 1.0 },
      { name: "fiberContent", unit: "g", amount: 5.0 },
      { name: "proteinContent", unit: "g", amount: 28.0 },
      { name: "saturatedFatContent", unit: "g", amount: 0.0 },
      { name: "servingSize", unit: nil, amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 25.0 },
      { name: "sugarContent", unit: "g", amount: 0.0 },
      { name: "transFatContent", unit: "g", amount: 0.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 0.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
