# frozen_string_literal: true

RSpec.describe "panlasangpinoy.com" do
  subject(:recipe) { scrape_cassette("com/panlasangpinoy", url: "https://panlasangpinoy.com/bicol-express/") }

  it "reads the title" do
    expect(recipe.title).to eq("Bicol Express Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 lbs. pork belly (sliced into strips)",
      "2 cups coconut milk",
      "2 cups coconut cream",
      "1/4 cup shrimp paste (or salted Krill)",
      "5 cloves garlic (crushed)",
      "5 pieces Thai chili pepper (chopped)",
      "2 thumbs ginger (minced)",
      "1 piece onion (chopped)",
      "2 pieces Serrano pepper (sliced)",
      "1 cup water (optional)",
      "8 grams Maggi Magic Sarap"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "lbs", name: "pork belly" },
      { amount: 2.0, unit: "cups", name: "coconut milk" },
      { amount: 2.0, unit: "cups", name: "coconut cream" },
      { amount: 0.25, unit: "cup", name: "shrimp paste" },
      { amount: 5.0, unit: "cloves", name: "garlic" },
      { amount: 5.0, unit: "pieces", name: "Thai chili pepper" },
      { amount: 2.0, unit: "thumbs", name: "ginger" },
      { amount: 1.0, unit: "piece", name: "onion" },
      { amount: 2.0, unit: "pieces", name: "Serrano pepper" },
      { amount: 1.0, unit: "cup", name: "water" },
      { amount: 8.0, unit: "grams", name: "Maggi Magic Sarap" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Combine pork, ginger, garlic, onion, Thai chili pepper, long green pepper, and bagoong alamang, coconut milk in a pan. Mix well. Cover the pan and turn the heat to on. Let the mixture boil.",
      "Stir and adjust the heat to low. Cover and simmer for 50 minutes. Note: add water as necessary",
      "Add the remaining coconut cream and bagoong alamang (as needed). Season with Maggi Magic Sarap. Continue cooking in low heat until the sauce thickens (around",
      "Transfer to a serving plate and serve with warm rice."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Combine pork, ginger, garlic, onion, Thai chili pepper, long green pepper, and bagoong alamang, coconut milk in a pan. Mix well. Cover the pan and turn the heat to on. Let the mixture boil.\nStir and adjust the heat to low. Cover and simmer for 50 minutes. Note: add water as necessary\nAdd the remaining coconut cream and bagoong alamang (as needed). Season with Maggi Magic Sarap. Continue cooking in low heat until the sauce thickens (around\nTransfer to a serving plate and serve with warm rice.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("panlasangpinoy.com")
    expect(recipe.canonical_url).to eq("https://panlasangpinoy.com/bicol-express/")
    expect(recipe.site_name).to eq("Panlasang Pinoy")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Vanjo Merano")
    expect(recipe.description).to eq("This is a recipe for Bicol Express")
    expect(recipe.image).to eq("https://panlasangpinoy.com/wp-content/uploads/2021/04/Bicol-Express-1.jpg")
    expect(recipe.category).to eq("Main Dish")
    expect(recipe.cuisine).to eq("Filipino Recipe")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(60)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(55)
    expect(recipe.keywords).to eq([
      "bicol express",
      "bicol express recipe",
      "ginataang baboy",
      "how to cook bicol express"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(4)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "6 g",
      "calories" => "1224 kcal",
      "carbohydrateContent" => "10 g",
      "proteinContent" => "23 g",
      "fatContent" => "124 g",
      "saturatedFatContent" => "68 g",
      "cholesterolContent" => "168 mg",
      "sodiumContent" => "248 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "1 g",
      "unsaturatedFatContent" => "48 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "g", amount: 6.0 },
      { name: "calories", unit: "kcal", amount: 1224.0 },
      { name: "carbohydrateContent", unit: "g", amount: 10.0 },
      { name: "proteinContent", unit: "g", amount: 23.0 },
      { name: "fatContent", unit: "g", amount: 124.0 },
      { name: "saturatedFatContent", unit: "g", amount: 68.0 },
      { name: "cholesterolContent", unit: "mg", amount: 168.0 },
      { name: "sodiumContent", unit: "mg", amount: 248.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 48.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
