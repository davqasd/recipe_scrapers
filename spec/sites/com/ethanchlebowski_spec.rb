# frozen_string_literal: true

RSpec.describe "ethanchlebowski.com" do
  subject(:recipe) { scrape_cassette("com/ethanchlebowski", url: "https://www.ethanchlebowski.com/cooking-techniques-recipes/italian-stir-fry") }

  it "reads the title" do
    expect(recipe.title).to eq("Italian Stir Fry")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "15 ml (1 tbsp) Olive oil",
      "2 links Italian chicken sausage, sliced",
      "3 cloves of garlic, crushed but kept whole",
      "250 g asparagus, cut into inch pieces",
      "1/4 green bell pepper, sliced then cut in half",
      "1/4 red onion, sliced",
      "1 Calabrian chile (optional)",
      "Salt to taste",
      "20 cranks black pepper",
      "Basil, chiffonade",
      "Parmigiano reggiano over top"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 15.0, unit: "ml", name: "Olive oil" },
      { amount: 2.0, unit: nil, name: "links Italian chicken sausage, sliced" },
      { amount: 3.0, unit: "cloves", name: "garlic, crushed but kept whole" },
      { amount: 250.0, unit: "g", name: "asparagus, cut into inch pieces" },
      { amount: 0.25, unit: nil, name: "green bell pepper, sliced then cut in half" },
      { amount: 0.25, unit: nil, name: "red onion, sliced" },
      { amount: 1.0, unit: nil, name: "Calabrian chile" },
      { amount: nil, unit: nil, name: "Salt to taste" },
      { amount: 20.0, unit: nil, name: "cranks black pepper" },
      { amount: nil, unit: nil, name: "Basil, chiffonade" },
      { amount: nil, unit: nil, name: "Parmigiano reggiano over top" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Prep the chicken sausage, garlic cloves, asparagus, bell pepper, and red onion as mentioned.",
      "Set a wok or skillet over medium-high heat with a drizzle of olive oil. Once hot, add the garlic cloves and Calabrian chile for 15-20 seconds. Add the chicken sausage and cook until just starting to brown about 2-3 minutes. Add the asparagus, bell pepper, and onion along with a sprinkle of salt and the black pepper. Stir fry for 1-2 minutes.",
      "Turn off the heat, stir in the chiffonade basil. Serve with grated parm reg over top."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Prep the chicken sausage, garlic cloves, asparagus, bell pepper, and red onion as mentioned.\nSet a wok or skillet over medium-high heat with a drizzle of olive oil. Once hot, add the garlic cloves and Calabrian chile for 15-20 seconds. Add the chicken sausage and cook until just starting to brown about 2-3 minutes. Add the asparagus, bell pepper, and onion along with a sprinkle of salt and the black pepper. Stir fry for 1-2 minutes.\nTurn off the heat, stir in the chiffonade basil. Serve with grated parm reg over top.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("ethanchlebowski.com")
    expect(recipe.canonical_url).to eq("https://www.ethanchlebowski.com/cooking-techniques-recipes/italian-stir-fry")
    expect(recipe.site_name).to eq("Ethan")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Ethan Chlebowski")
    expect(recipe.description).to eq("Stir frying is an incredible technique, that is probably most synonymous with Chinese cuisine, but is used all over the world and if stripped down to it's basic cooking components it looks like this Hot oil Stir fry 'dry' seasoning (aromatics) Stir fry longer cooking items Stir fry short")
    expect(recipe.image).to eq("http://static1.squarespace.com/static/5d96a22649af0e131e78ca1c/5da7334443c1e2402d682705/605cce155fd4bf56f87a75b1/1616892828372/StirFry.jpg?format=1500w")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to eq(12)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(7)
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
