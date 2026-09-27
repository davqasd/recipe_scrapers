# frozen_string_literal: true

RSpec.describe "empirecipes.com" do
  subject(:recipe) { scrape_cassette("com/empirecipes", url: "https://empirecipes.com/avocado-mayonnaise-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Avocado Mayonnaise")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 ripe avocado",
      "1/2 cup mayonnaise",
      "1 tablespoon lime juice",
      "1 teaspoon Dijon mustard",
      "1 small garlic clove",
      "Salt and black pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "ripe avocado" },
      { amount: 0.5, unit: "cup", name: "mayonnaise" },
      { amount: 1.0, unit: "tablespoon", name: "lime juice" },
      { amount: 1.0, unit: "teaspoon", name: "Dijon mustard" },
      { amount: 1.0, unit: nil, name: "small garlic clove" },
      { amount: nil, unit: nil, name: "Salt and black pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Add the mayonnaise and flavor ingredients to a small mixing bowl.",
      "Stir or blend until the sauce is smooth, creamy, and evenly seasoned.",
      "Taste and adjust with salt, pepper, citrus, mustard, or sweetness as needed.",
      "Chill for at least 20 minutes, then serve with sandwiches, fries, wraps, tacos, or grilled foods."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Add the mayonnaise and flavor ingredients to a small mixing bowl.\nStir or blend until the sauce is smooth, creamy, and evenly seasoned.\nTaste and adjust with salt, pepper, citrus, mustard, or sweetness as needed.\nChill for at least 20 minutes, then serve with sandwiches, fries, wraps, tacos, or grilled foods.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("empirecipes.com")
    expect(recipe.canonical_url).to eq("https://empirecipes.com/avocado-mayonnaise-recipe/")
    expect(recipe.site_name).to eq("empirecipes.com")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Camelea Gohier")
    expect(recipe.description).to eq("A quick homemade avocado mayonnaise with a creamy mayo base, balanced flavor, and simple pantry-friendly ingredients.")
    expect(recipe.image).to eq("https://empirecipes.com/wp-content/uploads/2026/06/avocado-mayonnaise-recipe-featured.jpg")
    expect(recipe.category).to eq("Condiment")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["avocado mayonnaise recipe", "homemade mayo", "mayonnaise recipe"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
