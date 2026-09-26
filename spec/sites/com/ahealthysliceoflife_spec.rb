# frozen_string_literal: true

RSpec.describe "ahealthysliceoflife.com" do
  subject(:recipe) { scrape_cassette("com/ahealthysliceoflife", url: "https://www.ahealthysliceoflife.com/red-lentil-carrot-curry-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Red Lentil and Carrot Curry Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 Tbsp olive oil",
      "3 garlic cloves, minced",
      "1.5 tsp grated ginger",
      "1 small onion, small diced (about 1 c)",
      "2 large carrots, small diced (about 1 c)",
      "1.5 Tbsp curry powder",
      "1 tsp turmeric",
      "1.5 c red lentils",
      "1.5 tsp salt",
      "1 c vegetable broth",
      "1 can full fat coconut milk",
      "3 oz chopped baby spinach",
      "Juice of half a lime"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "Tbsp", name: "olive oil" },
      { amount: 3.0, unit: nil, name: "garlic cloves, minced" },
      { amount: 1.5, unit: "tsp", name: "grated ginger" },
      { amount: 1.0, unit: nil, name: "small onion, small diced" },
      { amount: 2.0, unit: nil, name: "large carrots, small diced" },
      { amount: 1.5, unit: "Tbsp", name: "curry powder" },
      { amount: 1.0, unit: "tsp", name: "turmeric" },
      { amount: 1.5, unit: "c", name: "red lentils" },
      { amount: 1.5, unit: "tsp", name: "salt" },
      { amount: 1.0, unit: "c", name: "vegetable broth" },
      { amount: 1.0, unit: "can", name: "full fat coconut milk" },
      { amount: 3.0, unit: "oz", name: "chopped baby spinach" },
      { amount: nil, unit: nil, name: "Juice of half a lime" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large pan, heat oil over medium heat.",
      "Add onion and carrots. Sauté 4 minutes until onions are beginning to soften. Add garlic, ginger, curry powder, and turmeric to the pan and sauté for 1-2 minutes more, until fragrant.",
      "Add lentils, salt, broth, and coconut milk to the pan. Bring to a boil while mixing well, then cover and reduce heat to a gentle simmer. Let simmer for 20 minutes, then remove from heat.",
      "Take off the lid, add spinach and lime juice and stir to combine. Serve over hot buttered rice."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large pan, heat oil over medium heat.\nAdd onion and carrots. Sauté 4 minutes until onions are beginning to soften. Add garlic, ginger, curry powder, and turmeric to the pan and sauté for 1-2 minutes more, until fragrant.\nAdd lentils, salt, broth, and coconut milk to the pan. Bring to a boil while mixing well, then cover and reduce heat to a gentle simmer. Let simmer for 20 minutes, then remove from heat.\nTake off the lid, add spinach and lime juice and stir to combine. Serve over hot buttered rice.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("ahealthysliceoflife.com")
    expect(recipe.canonical_url).to eq("https://www.ahealthysliceoflife.com/red-lentil-carrot-curry-recipe/")
    expect(recipe.site_name).to eq("A Healthy Slice of Life")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Brittany Dixon")
    expect(recipe.description).to eq("This nourishing curry recipe is perfect for when you need something comforting and delicious on the dinner table quickly!")
    expect(recipe.image).to eq("https://www.ahealthysliceoflife.com/wp-content/uploads/2021/08/A-Healthy-Slice_Lentil-Curry-9-scaled-225x225.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(4)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
