# frozen_string_literal: true

RSpec.describe "potatorolls.com" do
  subject(:recipe) { scrape_cassette("com/potatorolls", url: "https://potatorolls.com/recipes/caramelized-onion-and-apple-panini/") }

  it "reads the title" do
    expect(recipe.title).to eq("Caramelized Onion and Apple Panini")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 Tablespoons + 2 Tablespoons Butter, room temperature",
      "2 Large Yellow Onions, thinly sliced",
      "2 Teaspoon of Kosher Salt",
      "1 Tablespoon Fresh Sage, chopped",
      "2 Ounces Brie Cheese, cubed",
      "4 Slices Martin’s Potato Bread or Real Old-Fashioned Butter Bread",
      "4 Ounces Cheddar Cheese, finely shredded",
      "1 Granny Smith Apple, thinly sliced"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: "Tablespoons", name: "Butter, room temperature" },
      { amount: 2.0, unit: nil, name: "Large Yellow Onions, thinly sliced" },
      { amount: 2.0, unit: "Teaspoon", name: "Kosher Salt" },
      { amount: 1.0, unit: "Tablespoon", name: "Fresh Sage, chopped" },
      { amount: 2.0, unit: "Ounces", name: "Brie Cheese, cubed" },
      { amount: 4.0, unit: "Slices", name: "Martin’s Potato Bread or Real Old-Fashioned Butter Bread" },
      { amount: 4.0, unit: "Ounces", name: "Cheddar Cheese, finely shredded" },
      { amount: 1.0, unit: nil, name: "Granny Smith Apple, thinly sliced" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Heat 4 tablespoons unsalted butter in skillet over medium heat. Add onions and salt and stir occasionally. Add 3 tablespoons of water and cover for 3-5 minutes. Continue to cook, stirring every few minutes for an additional 5-10 minutes until golden.",
      "Prepare other ingredients: Combine sage with 2 tablespoons of butter and generous pinch of salt. Remove rind from brie cheese and slice into ½-inch cubes.",
      "To assemble, spread sage butter on one slice of bread. Then, buttered side down, top with brie cheese, then cheddar cheese, then apples in a single layer slightly overlapping, then ¼ cup caramelized onions. Top with another slice of bread. Spread 1 tablespoon of sage butter on the top piece of bread.",
      "Cook sandwich in a panini maker for about 3-5 minutes until golden. Serve warm & enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Heat 4 tablespoons unsalted butter in skillet over medium heat. Add onions and salt and stir occasionally. Add 3 tablespoons of water and cover for 3-5 minutes. Continue to cook, stirring every few minutes for an additional 5-10 minutes until golden.\nPrepare other ingredients: Combine sage with 2 tablespoons of butter and generous pinch of salt. Remove rind from brie cheese and slice into ½-inch cubes.\nTo assemble, spread sage butter on one slice of bread. Then, buttered side down, top with brie cheese, then cheddar cheese, then apples in a single layer slightly overlapping, then ¼ cup caramelized onions. Top with another slice of bread. Spread 1 tablespoon of sage butter on the top piece of bread.\nCook sandwich in a panini maker for about 3-5 minutes until golden. Serve warm & enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("potatorolls.com")
    expect(recipe.canonical_url).to eq("https://potatorolls.com/recipes/caramelized-onion-and-apple-panini/")
    expect(recipe.site_name).to eq("Martin's Famous Potato Rolls and Bread")
    expect(recipe.language).to be_nil
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Caramelized Onion and Apple Panini - Martin's Famous Potato Rolls and Bread")
    expect(recipe.image).to eq("https://potatorolls.com/wp-content/uploads/2026_Caramelized-Onion-and-Apple-Panini6-960x640.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to eq(41)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
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
    expect(recipe.links).to include("https://potatorolls.com/our-community/")
  end
end
