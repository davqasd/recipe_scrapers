# frozen_string_literal: true

RSpec.describe "greatbritishchefs.com" do
  subject(:recipe) { scrape_cassette("com/greatbritishchefs", url: "https://www.greatbritishchefs.com/recipes/picadillo-recipe") }

  it "reads the title" do
    expect(recipe.title).to eq("Picadillo")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "500g of beef mince",
      "1 onion, diced",
      "2 garlic cloves, sliced",
      "1 carrot, finely diced",
      "1 potato, finely diced",
      "1 bay leaf",
      "1 tsp ground cumin",
      "1 tsp ground coriander",
      "1 tsp smoked paprika",
      "2 tbsp of tomato purée",
      "100g of raisins",
      "300ml of chicken stock",
      "300g of tomatillo salsa",
      "1 tsp honey",
      "lime juice, to taste",
      "1 handful of coriander, chopped",
      "salt, to taste",
      "olive oil"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 500.0, unit: "g", name: "beef mince" },
      { amount: 1.0, unit: nil, name: "onion, diced" },
      { amount: 2.0, unit: nil, name: "garlic cloves, sliced" },
      { amount: 1.0, unit: nil, name: "carrot, finely diced" },
      { amount: 1.0, unit: nil, name: "potato, finely diced" },
      { amount: 1.0, unit: nil, name: "bay leaf" },
      { amount: 1.0, unit: "tsp", name: "ground cumin" },
      { amount: 1.0, unit: "tsp", name: "ground coriander" },
      { amount: 1.0, unit: "tsp", name: "smoked paprika" },
      { amount: 2.0, unit: "tbsp", name: "tomato purée" },
      { amount: 100.0, unit: "g", name: "raisins" },
      { amount: 300.0, unit: "ml", name: "chicken stock" },
      { amount: 300.0, unit: "g", name: "tomatillo salsa" },
      { amount: 1.0, unit: "tsp", name: "honey" },
      { amount: nil, unit: nil, name: "lime juice, to taste" },
      { amount: 1.0, unit: "handful", name: "coriander, chopped" },
      { amount: nil, unit: nil, name: "salt, to taste" },
      { amount: nil, unit: nil, name: "olive oil" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "To begin, heat a splash of olive oil in a large pan and add the mince. Cook until nicely browned – you may need to do this in batches to avoid overcrowding the mince",
      "Decant the mince into a bowl and sweat the onions, garlic, carrot and potato in the same pan you used to brown the mince. Add the bay leaf and spices",
      "Once the onions are translucent, return the mince to the pan and add the tomato purée, raisins, chicken stock and tomatillo salsa. Turn down the heat and simmer for 30 minutes",
      "Season with the honey, lime juice and salt. Stir through the coriander and serve with rice or as a taco filling"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("To begin, heat a splash of olive oil in a large pan and add the mince. Cook until nicely browned – you may need to do this in batches to avoid overcrowding the mince\nDecant the mince into a bowl and sweat the onions, garlic, carrot and potato in the same pan you used to brown the mince. Add the bay leaf and spices\nOnce the onions are translucent, return the mince to the pan and add the tomato purée, raisins, chicken stock and tomatillo salsa. Turn down the heat and simmer for 30 minutes\nSeason with the honey, lime juice and salt. Stir through the coriander and serve with rice or as a taco filling")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("greatbritishchefs.com")
    expect(recipe.canonical_url).to eq("https://www.greatbritishchefs.com/recipes/picadillo-recipe")
    expect(recipe.site_name).to eq("Great British Chefs")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("GBC Kitchen")
    expect(recipe.description).to eq("This simple picadillo recipe has the perfect balance of sweetness and spice. A pleasing tanginess comes from the addition of vibrant tomatillo salsa for a great depth of flavour.")
    expect(recipe.image).to eq("https://media-cdn2.greatbritishchefs.com/media/mwtkdmv3/img73858.whqc_1426x713q80.jpg")
    expect(recipe.category).to eq("Main")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["easy"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
