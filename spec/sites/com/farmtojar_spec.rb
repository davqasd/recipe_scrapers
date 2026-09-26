# frozen_string_literal: true

RSpec.describe "farmtojar.com" do
  subject(:recipe) { scrape_cassette("com/farmtojar", url: "https://farmtojar.com/low-carb-scallops-grapefruit-butter/") }

  it "reads the title" do
    expect(recipe.title).to eq("Low Carb Seared Scallops in Grapefruit Butter")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "12 large sea scallops (I used frozen Kirkland raw sea scallops)",
      "1/4 cup finely chopped onion (shallots work for a milder taste)",
      "1/4 cup champagne vinegar (white wine vinegar can be substituted)",
      "1/4 cup grapefruit juice (freshly squeezed (juice from about 1/2 grapefruit))",
      "10 tablespoons unsalted butter (cut into cubes)",
      "2 1/2 teaspoons kosher salt",
      "1 tablespoon unsalted butter",
      "grapefruit segments (from 1/2 of a large grapefruit)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 12.0, unit: nil, name: "large sea scallops" },
      { amount: 0.25, unit: "cup", name: "finely chopped onion" },
      { amount: 0.25, unit: "cup", name: "champagne vinegar" },
      { amount: 0.25, unit: "cup", name: "grapefruit juice" },
      { amount: 10.0, unit: "tablespoons", name: "unsalted butter" },
      { amount: 2.5, unit: "teaspoons", name: "kosher salt" },
      { amount: 1.0, unit: "tablespoon", name: "unsalted butter" },
      { amount: nil, unit: nil, name: "grapefruit segments" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Thaw frozen scallops by placing in the refrigerator for several hours. Remove the scallops from the refrigerator about 20 minutes before cooking, drain them and set them on paper towels to start drying. Keep patting them dry with clean paper towels as you're making the sauce. They need to be as dry as possible when you place them in the pan.",
      "Make the sauce. In a small saucepan combine the chopped onion, vinegar and grapefruit juice and quickly bring to a boil. Lower the heat to simmer and simmer until the mixture is half as much as when you started (i.e., reduce the mixture by half). This takes about 6-7 minutes over low heat. Remove pan from heat and whisk in the butter cubes. Keep warm.",
      "Heat a large dry skillet over medium-high heat until it is really, really hot (may take 5 -10 minutes depending on your skillet and burner). Keep dabbing the scallops dry with paper towels. Sprinkle salt and pepper on one side of scallops after they are as dry as you can get them. When skillet is hot, melt one tablespoon of butter in it (butter will brown right away), and then add the scallops, salt side down in the skillet, and sear for 1 minute. Salt and pepper the top side of scallops while they are searing, turn them over gently with tongs, and sear the other side one minute. Do not overcook or they will be rubbery.",
      "To serve, spread a spoonful of the butter sauce across the bottom of a plate, place the scallops on top of the sauce and garnish with the grapefruit segments. Serve with a side dish of greens."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Thaw frozen scallops by placing in the refrigerator for several hours. Remove the scallops from the refrigerator about 20 minutes before cooking, drain them and set them on paper towels to start drying. Keep patting them dry with clean paper towels as you're making the sauce. They need to be as dry as possible when you place them in the pan.\nMake the sauce. In a small saucepan combine the chopped onion, vinegar and grapefruit juice and quickly bring to a boil. Lower the heat to simmer and simmer until the mixture is half as much as when you started (i.e., reduce the mixture by half). This takes about 6-7 minutes over low heat. Remove pan from heat and whisk in the butter cubes. Keep warm.\nHeat a large dry skillet over medium-high heat until it is really, really hot (may take 5 -10 minutes depending on your skillet and burner). Keep dabbing the scallops dry with paper towels. Sprinkle salt and pepper on one side of scallops after they are as dry as you can get them. When skillet is hot, melt one tablespoon of butter in it (butter will brown right away), and then add the scallops, salt side down in the skillet, and sear for 1 minute. Salt and pepper the top side of scallops while they are searing, turn them over gently with tongs, and sear the other side one minute. Do not overcook or they will be rubbery.\nTo serve, spread a spoonful of the butter sauce across the bottom of a plate, place the scallops on top of the sauce and garnish with the grapefruit segments. Serve with a side dish of greens.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("farmtojar.com")
    expect(recipe.canonical_url).to eq("https://farmtojar.com/low-carb-scallops-grapefruit-butter/")
    expect(recipe.site_name).to eq("Farm to Jar")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Dorothy Stainbrook")
    expect(recipe.description).to eq("A step by step recipe on getting the perfectly seared scallop dish with a unique flavor profile of a grapefruit butter sauce. Perfect for weeknight cooking or elegant dinner parties.")
    expect(recipe.image).to eq("https://farmtojar.com/wp-content/uploads/2015/03/758180DC-9276-42CB-AA6A-76E4B65A0D06.jpeg")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("French")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq([
      "buerre blanc",
      "grapefruit butter sauce",
      "low carb dinner",
      "low carb scallops",
      "seared scallops"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.5)
    expect(recipe.ratings_count).to eq(6)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "150 kcal",
      "carbohydrateContent" => "4.5 g",
      "proteinContent" => "26 g",
      "fatContent" => "1 g",
      "cholesterolContent" => "51 mg",
      "sodiumContent" => "240 mg",
      "sugarContent" => "4.2 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 150.0 },
      { name: "carbohydrateContent", unit: "g", amount: 4.5 },
      { name: "proteinContent", unit: "g", amount: 26.0 },
      { name: "fatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 51.0 },
      { name: "sodiumContent", unit: "mg", amount: 240.0 },
      { name: "sugarContent", unit: "g", amount: 4.2 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
