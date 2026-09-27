# frozen_string_literal: true

RSpec.describe "alisoneroman.com" do
  subject(:recipe) { scrape_cassette("com/alisoneroman", url: "https://www.alisoneroman.com/recipes/garlicky-buttered-carrots/") }

  it "reads the title" do
    expect(recipe.title).to eq("Garlicky, Buttered Carrots")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "¼ cup chicken fat, olive oil or unsalted butter",
      "¼ cup olive oil",
      "Pinch of red-pepper flakes (optional)",
      "2 bunches carrots , topped removed (about 1 pound), thinly sliced into rounds",
      "Kosher salt and freshly ground black pepper",
      "1 garlic clove, finely chopped or grated"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.25, unit: "cup", name: "chicken fat, olive oil or unsalted butter" },
      { amount: 0.25, unit: "cup", name: "olive oil" },
      { amount: 1.0, unit: "Pinch", name: "red-pepper flakes" },
      { amount: 2.0, unit: "bunches", name: "carrots, topped removed, thinly sliced into rounds" },
      { amount: nil, unit: nil, name: "Kosher salt and freshly ground black pepper" },
      { amount: 1.0, unit: nil, name: "garlic clove, finely chopped or grated" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Melt chicken fat in a large skillet over medium-high heat. (If using butter, melt until lightly foamy and starting to brown, 2 to 3 minutes.) Add olive oil and red-pepper flakes, if using, swirling to bloom a bit in the butter. Add carrots and season with salt and pepper. Cook, tossing occasionally, until carrots are just cooked through, 3 to 4 minutes. (They should be simply softened, like al dente pasta, not soft or mushy.)",
      "Remove pan from heat, and add garlic, tossing to coat, and transfer to serving bowl."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Melt chicken fat in a large skillet over medium-high heat. (If using butter, melt until lightly foamy and starting to brown, 2 to 3 minutes.) Add olive oil and red-pepper flakes, if using, swirling to bloom a bit in the butter. Add carrots and season with salt and pepper. Cook, tossing occasionally, until carrots are just cooked through, 3 to 4 minutes. (They should be simply softened, like al dente pasta, not soft or mushy.)\nRemove pan from heat, and add garlic, tossing to coat, and transfer to serving bowl.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("alisoneroman.com")
    expect(recipe.canonical_url).to eq("https://www.alisoneroman.com/recipes/garlicky-buttered-carrots/")
    expect(recipe.site_name).to eq("Alison Roman")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Alison Roman")
    expect(recipe.description).to eq("This is one of the few occasions when overcrowding the skillet is a good thing. These carrots are cooked in fat (schmaltz, olive oil, butter), with a pinch of something spicy, sort of half-steaming on top of each other until just tender (no mushy carrots here, please).")
    expect(recipe.image).to eq("https://storage.ghost.io/c/aa/c9/aac954d7-13e7-4d9e-8784-fa2d15230fb2/content/images/images-squarespace-cdn-com/content/v1/541b1515e4b0a990b33a796e/1634744056997-1VJ2LDVSEL62LK1R8RTD/carrot_coins_0050.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to be_nil
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
    expect(recipe.links).to include("#main-content")
  end
end
