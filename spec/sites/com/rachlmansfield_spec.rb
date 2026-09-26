# frozen_string_literal: true

RSpec.describe "rachlmansfield.com" do
  subject(:recipe) { scrape_cassette("com/rachlmansfield", url: "https://rachlmansfield.com/healthy-flourless-brownies/") }

  it "reads the title" do
    expect(recipe.title).to eq("Healthy Flourless Brownies (nut-free + gluten-free)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup tahini or creamy nut butter",
      "1/4 cup maple syrup",
      "1/2 cup coconut sugar",
      "2 pasture-raised eggs*",
      "1 teaspoon vanilla extract",
      "1/3 cup + 2 tablespoons cacao powder",
      "1 teaspoon baking powder",
      "1/2 cup dark chocolate chips"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "tahini or creamy nut butter" },
      { amount: 0.25, unit: "cup", name: "maple syrup" },
      { amount: 0.5, unit: "cup", name: "coconut sugar" },
      { amount: 2.0, unit: nil, name: "pasture-raised eggs*" },
      { amount: 1.0, unit: "teaspoon", name: "vanilla extract" },
      { amount: 0.33, unit: "cup", name: "cacao powder" },
      { amount: 1.0, unit: "teaspoon", name: "baking powder" },
      { amount: 0.5, unit: "cup", name: "dark chocolate chips" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 350 degrees and line an 8×8 baking dish with parchment paper and grease well",
      "Cream together the tahini, maple syrup, coconut sugar, eggs and vanilla",
      "Mix in the cacao powder and baking powder until well combined (it will be thick!)",
      "Fold in dark chocolate gems then add batter to baking dish",
      "Bake in oven for 22-25 minutes (or until toothpick comes out clean when you poke the brownies)",
      "Allow the brownies to cool for a few minutes (this is key so they set!) then slice and enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 350 degrees and line an 8×8 baking dish with parchment paper and grease well\nCream together the tahini, maple syrup, coconut sugar, eggs and vanilla\nMix in the cacao powder and baking powder until well combined (it will be thick!)\nFold in dark chocolate gems then add batter to baking dish\nBake in oven for 22-25 minutes (or until toothpick comes out clean when you poke the brownies)\nAllow the brownies to cool for a few minutes (this is key so they set!) then slice and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("rachlmansfield.com")
    expect(recipe.canonical_url).to eq("https://rachlmansfield.com/healthy-flourless-brownies/")
    expect(recipe.site_name).to eq("rachLmansfield")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Rachel")
    expect(recipe.description).to eq("Healthy Flourless Brownies made with all gluten-free, paleo, nut-free and dairy-free ingredients. No flour needed! These are the best FUDGEY brownies ever!")
    expect(recipe.image).to eq("https://rachlmansfield.com/wp-content/uploads/2019/12/B6984237-A840-46A7-93FD-417FAA609A78-scaled-225x225.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("9 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(22)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(82)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "249 calories",
      "sugarContent" => "16.1 g",
      "sodiumContent" => "35.8 mg",
      "fatContent" => "15.6 g",
      "saturatedFatContent" => "2.6 g",
      "transFatContent" => "0 g",
      "carbohydrateContent" => "24.8 g",
      "fiberContent" => "2.2 g",
      "proteinContent" => "6.6 g",
      "cholesterolContent" => "41.3 mg"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 249.0 },
      { name: "sugarContent", unit: "g", amount: 16.1 },
      { name: "sodiumContent", unit: "mg", amount: 35.8 },
      { name: "fatContent", unit: "g", amount: 15.6 },
      { name: "saturatedFatContent", unit: "g", amount: 2.6 },
      { name: "transFatContent", unit: "g", amount: 0.0 },
      { name: "carbohydrateContent", unit: "g", amount: 24.8 },
      { name: "fiberContent", unit: "g", amount: 2.2 },
      { name: "proteinContent", unit: "g", amount: 6.6 },
      { name: "cholesterolContent", unit: "mg", amount: 41.3 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#body")
  end
end
