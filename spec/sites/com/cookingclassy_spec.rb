# frozen_string_literal: true

RSpec.describe "cookingclassy.com" do
  subject(:recipe) { scrape_cassette("com/cookingclassy", url: "https://www.cookingclassy.com/pumpkin-french-toast/") }

  it "reads the title" do
    expect(recipe.title).to eq("Pumpkin French Toast")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3/4 cup half and half",
      "1/2 cup pumpkin puree (canned or fresh)",
      "4 eggs",
      "2 1/2 Tbsp packed light-brown sugar",
      "1 1/2 tsp vanilla extract",
      "1 1/4 tsp ground cinnamon",
      "1/2 tsp ground nutmeg",
      "1/4 tsp ground ginger",
      "1/8 tsp cloves",
      "9 slices (1-inch) hearty white bread (such as rustic French bread, or brioche)",
      "Butter, (for griddle)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.75, unit: "cup", name: "half and half" },
      { amount: 0.5, unit: "cup", name: "pumpkin puree" },
      { amount: 4.0, unit: nil, name: "eggs" },
      { amount: 2.5, unit: "Tbsp", name: "packed light-brown sugar" },
      { amount: 1.5, unit: "tsp", name: "vanilla extract" },
      { amount: 1.25, unit: "tsp", name: "ground cinnamon" },
      { amount: 0.5, unit: "tsp", name: "ground nutmeg" },
      { amount: 0.25, unit: "tsp", name: "ground ginger" },
      { amount: 0.13, unit: "tsp", name: "cloves" },
      { amount: 9.0, unit: "slices", name: "hearty white bread" },
      { amount: nil, unit: nil, name: "Butter" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 225 degrees. Preheat an electric griddle to 350 degrees (a non-stick skillet set over medium heat also works fine).",
      "In a shallow dish whisk together pumpkin, eggs, brown sugar, vanilla, cinnamon, nutmeg and ginger, and cloves until well combined. Pour in half and half, whisk until well blended.",
      "Dip bread into egg mixture allowing it to soak in, turn and soak on opposite side. Butter griddle area where you'll place slice of French toast, then top with the soaked French toast.",
      "Cook until golden brown on bottom for several minutes, then lift, butter griddle once more and flip french toast to opposite side and cook until golden brown.",
      "Transfer slices to oven on oven rack and let keep warm up to 10 minutes (this also helps cook them through the center more fully if they haven't already).",
      "Serve warm with maple syrup if desired."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 225 degrees. Preheat an electric griddle to 350 degrees (a non-stick skillet set over medium heat also works fine).\nIn a shallow dish whisk together pumpkin, eggs, brown sugar, vanilla, cinnamon, nutmeg and ginger, and cloves until well combined. Pour in half and half, whisk until well blended.\nDip bread into egg mixture allowing it to soak in, turn and soak on opposite side. Butter griddle area where you'll place slice of French toast, then top with the soaked French toast.\nCook until golden brown on bottom for several minutes, then lift, butter griddle once more and flip french toast to opposite side and cook until golden brown.\nTransfer slices to oven on oven rack and let keep warm up to 10 minutes (this also helps cook them through the center more fully if they haven't already).\nServe warm with maple syrup if desired.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cookingclassy.com")
    expect(recipe.canonical_url).to eq("https://www.cookingclassy.com/pumpkin-french-toast/")
    expect(recipe.site_name).to eq("Cooking Classy")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jaclyn")
    expect(recipe.description).to eq("My favorite fall french toast! Bread slices are soaked in a simple pumpkin and spice egg mixture then cooked on a griddle until perfectly golden brown.")
    expect(recipe.image).to eq("https://www.cookingclassy.com/wp-content/uploads/2025/09/pumpkin-french-toast-02.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("9 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["Pumpkin French Toast"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(6)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "203 kcal",
      "carbohydrateContent" => "26 g",
      "proteinContent" => "7 g",
      "fatContent" => "8 g",
      "saturatedFatContent" => "4 g",
      "transFatContent" => "0.1 g",
      "cholesterolContent" => "87 mg",
      "sodiumContent" => "290 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "7 g",
      "unsaturatedFatContent" => "3 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 203.0 },
      { name: "carbohydrateContent", unit: "g", amount: 26.0 },
      { name: "proteinContent", unit: "g", amount: 7.0 },
      { name: "fatContent", unit: "g", amount: 8.0 },
      { name: "saturatedFatContent", unit: "g", amount: 4.0 },
      { name: "transFatContent", unit: "g", amount: 0.1 },
      { name: "cholesterolContent", unit: "mg", amount: 87.0 },
      { name: "sodiumContent", unit: "mg", amount: 290.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 7.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 3.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.cookingclassy.com")
  end
end
