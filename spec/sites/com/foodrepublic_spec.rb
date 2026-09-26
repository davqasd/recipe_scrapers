# frozen_string_literal: true

RSpec.describe "foodrepublic.com" do
  subject(:recipe) { scrape_cassette("com/foodrepublic", url: "https://www.foodrepublic.com/recipes/dutch-white-asparagus-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Dutch White Asparagus Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "12 spears Dutch white asparagus",
      "1/2 each Meyer lemon",
      "2 cups water",
      "1 cup grated Parmesan cheese",
      "1/2 cup Chardonnay",
      "1/2 cup white wine vinegar",
      "2 sprigs fresh thyme",
      "1/2 cup shallots",
      "small chunk of Parmesan rind",
      "4 tablespoons unsalted butter",
      "4 fresh eggs",
      "4 slices prosciutto"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 12.0, unit: "spears", name: "Dutch white asparagus" },
      { amount: 0.5, unit: "each", name: "Meyer lemon" },
      { amount: 2.0, unit: "cups", name: "water" },
      { amount: 1.0, unit: "cup", name: "grated Parmesan cheese" },
      { amount: 0.5, unit: "cup", name: "Chardonnay" },
      { amount: 0.5, unit: "cup", name: "white wine vinegar" },
      { amount: 2.0, unit: "sprigs", name: "fresh thyme" },
      { amount: 0.5, unit: "cup", name: "shallots" },
      { amount: nil, unit: nil, name: "small chunk of Parmesan rind" },
      { amount: 4.0, unit: "tablespoons", name: "unsalted butter" },
      { amount: 4.0, unit: nil, name: "fresh eggs" },
      { amount: 4.0, unit: "slices", name: "prosciutto" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "After peeling and trimming the asparagus, steam it in citrus water — water with Meyer lemon, orange and grapefruit slices — until fork tender.",
      "In a pot add the Chardonnay, white wine vinegar, thyme, shallots and chunk of Parmesan rind; reduce about a quarter.",
      "Remove from heat and slowly whisk in cubes of butter until sauce is thick and glossy.",
      "Pour 2 tablespoons of beurre blanc on a plate, top it with a poached egg, steamed white asparagus, prosciutto and grated Parmesan.",
      "Spring Asparagus Soup Recipe",
      "Goat Cheese And Asparagus Macaroni Salad Recipe",
      "Roasted Asparagus & Scrambled Eggs Recipe"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("After peeling and trimming the asparagus, steam it in citrus water — water with Meyer lemon, orange and grapefruit slices — until fork tender.\nIn a pot add the Chardonnay, white wine vinegar, thyme, shallots and chunk of Parmesan rind; reduce about a quarter.\nRemove from heat and slowly whisk in cubes of butter until sauce is thick and glossy.\nPour 2 tablespoons of beurre blanc on a plate, top it with a poached egg, steamed white asparagus, prosciutto and grated Parmesan.\nSpring Asparagus Soup Recipe\nGoat Cheese And Asparagus Macaroni Salad Recipe\nRoasted Asparagus & Scrambled Eggs Recipe")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("foodrepublic.com")
    expect(recipe.canonical_url).to eq("https://www.foodrepublic.com/recipes/dutch-white-asparagus-recipe/")
    expect(recipe.site_name).to eq("Food Republic")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Michael's Restaurant")
    expect(recipe.description).to eq("false")
    expect(recipe.image).to eq("https://www.foodrepublic.com/img/gallery/dutch-white-asparagus-recipe/intro-import.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to eq("Dutch")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to eq(60)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(40)
    expect(recipe.keywords).to be_nil
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
    expect(recipe.links).to include("/")
  end
end
