# frozen_string_literal: true

RSpec.describe "hilahcooking.com" do
  subject(:recipe) { scrape_cassette("com/hilahcooking", url: "https://hilahcooking.com/chicken-and-waffles/") }

  it "reads the title" do
    expect(recipe.title).to eq("Chicken and Waffles")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 boneless, skinless chicken thighs",
      "2 tablespoons maple syrup",
      "1 teaspoon Tabasco sauce",
      "1 teaspoon salt",
      "1/2 teaspoon pepper",
      "1/2 teaspoon dried thyme",
      "2 eggs",
      "1/2 cup buttermilk",
      "1 cup flour",
      "1 tablespoon cornstarch",
      "1/2 cup frying oil (peanut, canola, shortening, alrd, etc)",
      "Waffles",
      "Maple syrup"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: nil, name: "boneless, skinless chicken thighs" },
      { amount: 2.0, unit: "tablespoons", name: "maple syrup" },
      { amount: 1.0, unit: "teaspoon", name: "Tabasco sauce" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: 0.5, unit: "teaspoon", name: "pepper" },
      { amount: 0.5, unit: "teaspoon", name: "dried thyme" },
      { amount: 2.0, unit: nil, name: "eggs" },
      { amount: 0.5, unit: "cup", name: "buttermilk" },
      { amount: 1.0, unit: "cup", name: "flour" },
      { amount: 1.0, unit: "tablespoon", name: "cornstarch" },
      { amount: 0.5, unit: "cup", name: "frying oil" },
      { amount: nil, unit: nil, name: "Waffles" },
      { amount: nil, unit: nil, name: "Maple syrup" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Marinate the chicken in the maple syrup, Tabasco, salt, pepper, and thyme for 30 minutes to an hour. (Make your waffle batter now and set it aside.)",
      "Whisk together egg and buttermilk in a shallow bowl.",
      "Combine flour and cornstarch in another bowl.",
      "Drain excess marinade from chicken. Dip in egg, then flour, and lay in a single layer on a plate or baking sheet. Allow to sit for 10-15 minutes.",
      "Heat oil in a skillet to 350ºF.",
      "Fry chicken for 3-4 minutes on each side until dark golden brown and cooked through. To check, pierce with a knife tip and if juices run clear, you’re good!",
      "Drain on paper. Sprinkle with a little salt. Set aside.",
      "Cook waffle batter in your waffle iron according to manufacturer’s directions.",
      "Serve chicken on top of waffles with maple syrup."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Marinate the chicken in the maple syrup, Tabasco, salt, pepper, and thyme for 30 minutes to an hour. (Make your waffle batter now and set it aside.)\nWhisk together egg and buttermilk in a shallow bowl.\nCombine flour and cornstarch in another bowl.\nDrain excess marinade from chicken. Dip in egg, then flour, and lay in a single layer on a plate or baking sheet. Allow to sit for 10-15 minutes.\nHeat oil in a skillet to 350ºF.\nFry chicken for 3-4 minutes on each side until dark golden brown and cooked through. To check, pierce with a knife tip and if juices run clear, you’re good!\nDrain on paper. Sprinkle with a little salt. Set aside.\nCook waffle batter in your waffle iron according to manufacturer’s directions.\nServe chicken on top of waffles with maple syrup.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hilahcooking.com")
    expect(recipe.canonical_url).to eq("https://hilahcooking.com/chicken-and-waffles/")
    expect(recipe.site_name).to eq("Hilah Cooking")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Hilah Johnson")
    expect(recipe.description).to eq("Chicken and waffles is a festive and heartily unhealthy breakfast or brunch recipe! Try my version with boneless chicken and maple syrup.")
    expect(recipe.image).to eq("https://hilahcooking.com/wp-content/uploads/2013/08/chicken-and-waffles-hilah-cooking.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(15)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.5)
    expect(recipe.ratings_count).to eq(2)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#fl-main-content")
  end
end
