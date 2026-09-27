# frozen_string_literal: true

RSpec.describe "juliegoodwin.com.au" do
  subject(:recipe) { scrape_cassette("au/juliegoodwin", url: "https://juliegoodwin.com.au/recipe/roast-honey-and-sesame-carrots/") }

  it "reads the title" do
    expect(recipe.title).to eq("Roast Honey and Sesame Carrots")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "6 large, thick carrots (around 1kg) peeled and cut into thirds",
      "30g butter",
      "2 tablespoons honey",
      "2 teaspoons sesame seeds, toasted"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 6.0, unit: nil, name: "large, thick carrots peeled and cut into thirds" },
      { amount: 30.0, unit: "g", name: "butter" },
      { amount: 2.0, unit: "tablespoons", name: "honey" },
      { amount: 2.0, unit: "teaspoons", name: "sesame seeds, toasted" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 180*C.",
      "Place carrots into a small baking dish with butter. Bake for 30 minutes, turning regularly, until browning and soft.",
      "Add honey and toss well. Return to the oven for a further 10 minutes or until the honey turns golden brown and glazes the carrots.",
      "Place in a serving dish and scatter with sesame seeds to serve."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 180*C.\nPlace carrots into a small baking dish with butter. Bake for 30 minutes, turning regularly, until browning and soft.\nAdd honey and toss well. Return to the oven for a further 10 minutes or until the honey turns golden brown and glazes the carrots.\nPlace in a serving dish and scatter with sesame seeds to serve.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("juliegoodwin.com.au")
    expect(recipe.canonical_url).to eq("https://juliegoodwin.com.au/recipe/roast-honey-and-sesame-carrots/")
    expect(recipe.site_name).to eq("Julie Goodwin")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Tender roast carrots in a golden honey glaze with toasted sesame seeds. An easy side dish ready in 50 minutes. Serves 6 as a side.")
    expect(recipe.image).to eq("https://juliegoodwin.com.au/wp-content/uploads/2026/06/honey-carrots-scaled.webp")
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
