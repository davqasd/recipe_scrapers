# frozen_string_literal: true

RSpec.describe "organicallyaddison.com" do
  subject(:recipe) { scrape_cassette("com/organicallyaddison", url: "https://organicallyaddison.com/baked-halibut-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Baked Halibut Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 pound halibut fillet",
      "2 tbsp melted butter",
      "1 tsp minced garlic",
      "¼ tsp paprika",
      "½ tsp sea salt",
      "½ tsp black pepper",
      "sliced lemon",
      "chopped parsley"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "pound", name: "halibut fillet" },
      { amount: 2.0, unit: "tbsp", name: "melted butter" },
      { amount: 1.0, unit: "tsp", name: "minced garlic" },
      { amount: 0.25, unit: "tsp", name: "paprika" },
      { amount: 0.5, unit: "tsp", name: "sea salt" },
      { amount: 0.5, unit: "tsp", name: "black pepper" },
      { amount: nil, unit: nil, name: "sliced lemon" },
      { amount: nil, unit: nil, name: "chopped parsley" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "First, preheat oven to 400 degrees Fahrenheit.",
      "Place halibut in baking dish.",
      "In a small bowl, combine melted butter, minced garlic, paprika, sea salt and black pepper. Pour this mixture over halibut.",
      "Bake for 12 to 13 minutes or until fish is opaque and no longer transparent.",
      "Finally, remove from oven. Garnish with sliced lemon and chopped parsley if desired."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("First, preheat oven to 400 degrees Fahrenheit.\nPlace halibut in baking dish.\nIn a small bowl, combine melted butter, minced garlic, paprika, sea salt and black pepper. Pour this mixture over halibut.\nBake for 12 to 13 minutes or until fish is opaque and no longer transparent.\nFinally, remove from oven. Garnish with sliced lemon and chopped parsley if desired.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("organicallyaddison.com")
    expect(recipe.canonical_url).to eq("https://organicallyaddison.com/baked-halibut-recipe/")
    expect(recipe.site_name).to eq("Organically Addison")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Addison LaBonte")
    expect(recipe.description).to eq("This baked halibut recipe is quick, easy and so flavorful! The garlic butter sauce adds so much flavor to the flaky fish. This halibut is great for holidays, birthdays, and more!")
    expect(recipe.image).to eq("https://organicallyaddison.com/wp-content/uploads/2022/05/2022-05-07_19-11-48_910-2022-05-08T17_48_13.449.jpeg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(17)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(12)
    expect(recipe.keywords).to eq([
      "baked halibut",
      "fish",
      "gluten free",
      "halibut",
      "keto",
      "low carb",
      "low sugar",
      "paleo",
      "whole30"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["GlutenFreeDiet"])
    expect(recipe.ratings).to eq(4.98)
    expect(recipe.ratings_count).to eq(231)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "310 kcal",
      "carbohydrateContent" => "1 g",
      "proteinContent" => "42 g",
      "fatContent" => "14 g",
      "saturatedFatContent" => "8 g",
      "transFatContent" => "1 g",
      "cholesterolContent" => "141 mg",
      "sodiumContent" => "826 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "1 g",
      "unsaturatedFatContent" => "5 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 310.0 },
      { name: "carbohydrateContent", unit: "g", amount: 1.0 },
      { name: "proteinContent", unit: "g", amount: 42.0 },
      { name: "fatContent", unit: "g", amount: 14.0 },
      { name: "saturatedFatContent", unit: "g", amount: 8.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 141.0 },
      { name: "sodiumContent", unit: "mg", amount: 826.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 5.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
