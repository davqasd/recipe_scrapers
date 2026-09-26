# frozen_string_literal: true

RSpec.describe "sandwichtribunal.com" do
  subject(:recipe) { scrape_cassette("com/sandwichtribunal", url: "https://www.sandwichtribunal.com/2023/01/barbecue-chicken-with-alabama-white-sauce/") }

  it "reads the title" do
    expect(recipe.title).to eq("Alabama White Sauce")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups mayonnaise",
      "1/2 cup apple cider vinegar",
      "4 tbsp brown sugar",
      "2 tbsp dijon mustard",
      "1.5 tbsp extra hot horseradish",
      "juice from 1/2 large lemon",
      "2 tsp Worcestershire sauce",
      "2 tsp cayenne pepper",
      "salt and pepper to taste"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "mayonnaise" },
      { amount: 0.5, unit: "cup", name: "apple cider vinegar" },
      { amount: 4.0, unit: "tbsp", name: "brown sugar" },
      { amount: 2.0, unit: "tbsp", name: "dijon mustard" },
      { amount: 1.5, unit: "tbsp", name: "extra hot horseradish" },
      { amount: nil, unit: nil, name: "juice from 1/2 large lemon" },
      { amount: 2.0, unit: "tsp", name: "Worcestershire sauce" },
      { amount: 2.0, unit: "tsp", name: "cayenne pepper" },
      { amount: nil, unit: nil, name: "salt and pepper to taste" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Mix all ingredients together and taste. Season as needed and hold in refrigerator for at least 1 hour.",
      "Serve with barbecue chicken, pork, or turkey"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Mix all ingredients together and taste. Season as needed and hold in refrigerator for at least 1 hour.\nServe with barbecue chicken, pork, or turkey")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("sandwichtribunal.com")
    expect(recipe.canonical_url).to eq("https://www.sandwichtribunal.com/2023/01/barbecue-chicken-with-alabama-white-sauce/")
    expect(recipe.site_name).to eq("Sandwich Tribunal")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jim Behymer")
    expect(recipe.description).to eq("a mayonnaise-and-vinegar based sauce for barbecue chicken")
    expect(recipe.image).to eq("https://www.sandwichtribunal.com/wp-content/uploads/2023/01/IMG_7386.jpg")
    expect(recipe.category).to eq("Sauce")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("48 servings")
    expect(recipe.total_time).to eq(70)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["alabama", "decatur", "white sauce"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "calories" => "70 kcal", "servingSize" => "1 serving" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 70.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
