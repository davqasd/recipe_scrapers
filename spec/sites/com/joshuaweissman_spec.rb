# frozen_string_literal: true

RSpec.describe "joshuaweissman.com" do
  subject(:recipe) { scrape_cassette("com/joshuaweissman", url: "https://www.joshuaweissman.com/recipes/mcdonalds-sweet-and-sour-sauce-copycat-recipe") }

  it "reads the title" do
    expect(recipe.title).to eq("McDonald’s Sweet and Sour Sauce")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "¼ cup (60g) apricot jam",
      "¼ cup (60g) peach jam",
      "1 Tbsp (13g) light brown sugar",
      "1 tsp (5mL) fresh lemon juice",
      "2 Tbsp (30mL) sherry vinegar",
      "1 Tbsp (15mL) shirodashi",
      "2 tsp (10g) yellow mustard",
      "2 tsp (5g) cornstarch",
      "2 Tbsp (30mL) water",
      "Kosher salt, to taste"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.25, unit: "cup", name: "apricot jam" },
      { amount: 0.25, unit: "cup", name: "peach jam" },
      { amount: 1.0, unit: "Tbsp", name: "light brown sugar" },
      { amount: 1.0, unit: "tsp", name: "fresh lemon juice" },
      { amount: 2.0, unit: "Tbsp", name: "sherry vinegar" },
      { amount: 1.0, unit: "Tbsp", name: "shirodashi" },
      { amount: 2.0, unit: "tsp", name: "yellow mustard" },
      { amount: 2.0, unit: "tsp", name: "cornstarch" },
      { amount: 2.0, unit: "Tbsp", name: "water" },
      { amount: nil, unit: nil, name: "Kosher salt, to taste" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Add the apricot jam, peach jam, brown sugar, lemon juice, sherry vinegar, shirodashi, yellow mustard, and salt to taste to a small saucepan. Place over medium heat and bring to a simmer, stirring often.",
      "Meanwhile, whisk together the cornstarch and water in a small bowl until completely smooth. Once the sauce reaches a simmer, whisk in the cornstarch slurry and cook, whisking constantly, until thickened and glossy, about 20-30 seconds.",
      "Remove from the heat and let cool completely before serving. The sauce will continue to thicken as it cools."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Add the apricot jam, peach jam, brown sugar, lemon juice, sherry vinegar, shirodashi, yellow mustard, and salt to taste to a small saucepan. Place over medium heat and bring to a simmer, stirring often.\nMeanwhile, whisk together the cornstarch and water in a small bowl until completely smooth. Once the sauce reaches a simmer, whisk in the cornstarch slurry and cook, whisking constantly, until thickened and glossy, about 20-30 seconds.\nRemove from the heat and let cool completely before serving. The sauce will continue to thicken as it cools.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("joshuaweissman.com")
    expect(recipe.canonical_url).to eq("https://www.joshuaweissman.com/recipes/mcdonalds-sweet-and-sour-sauce-copycat-recipe")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Joshua Weissman")
    expect(recipe.description).to be_nil
    expect(recipe.image).to eq("https://cdn.prod.website-files.com/6744d2d124649f6ecd466f50/6aa0d612861764f5141478a9_yt-thumb-sweetnsour-1280x720-letterbox.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(5)
    expect(recipe.keywords).to eq(["McDonald’s Sweet and Sour Sauce", "Chef Joshua Weissman recipe"])
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
    expect(recipe.links).to include("#comments-ratings")
  end
end
