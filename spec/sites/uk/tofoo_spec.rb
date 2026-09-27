# frozen_string_literal: true

RSpec.describe "tofoo.co.uk" do
  subject(:recipe) { scrape_cassette("uk/tofoo", url: "https://tofoo.co.uk/recipes/smoked-tofoo-burnt-ends-with-coffee-ancho-glaze/") }

  it "reads the title" do
    expect(recipe.title).to eq("Smoked Tofoo Burnt Ends with Coffee & Ancho Glaze")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "100g Smoked Tofoo, torn into rustic chunks",
      "Cornflour, plenty of salt & pepper",
      "50g Mushrooms (wild), chopped and lightly tumbled in cornflour",
      "Pickled radish & lychee",
      "Chicory or endive, dressed in a light vinaigrette",
      "1 shot of espresso",
      "Dark Soy sauce & Maple syrup (to taste)",
      "1 tsp Ancho chilli flakes",
      "½ diced onion & 2 cloves minced garlic",
      "Splash of habanero hot sauce",
      "Juice of 1 lime"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 100.0, unit: "g", name: "Smoked Tofoo, torn into rustic chunks" },
      { amount: nil, unit: nil, name: "Cornflour, plenty of salt & pepper" },
      { amount: 50.0, unit: "g", name: "Mushrooms, chopped and lightly tumbled in cornflour" },
      { amount: nil, unit: nil, name: "Pickled radish & lychee" },
      { amount: nil, unit: nil, name: "Chicory or endive, dressed in a light vinaigrette" },
      { amount: 1.0, unit: "shot", name: "espresso" },
      { amount: nil, unit: nil, name: "Dark Soy sauce & Maple syrup" },
      { amount: 1.0, unit: "tsp", name: "Ancho chilli flakes" },
      { amount: 0.5, unit: nil, name: "diced onion & 2 cloves minced garlic" },
      { amount: 1.0, unit: "Splash", name: "habanero hot sauce" },
      { amount: nil, unit: nil, name: "Juice of 1 lime" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Coat: Tear your Smoked Tofoo and wild mushrooms into chunks. Tumble them both in seasoned cornflour and let them sit for 10 minutes to get nice and tacky.",
      "Crisp: Fry or bake until exceptionally crispy, then keep them warm.",
      "Glaze: Sauté the onion and garlic until fragrant. Pour in the rest of your glaze ingredients and simmer until reduced to a sticky, glossy syrup.",
      "Assemble: Lightly pickle your radish and lychee, dress your salad leaves, coat the hot burnt ends in the glaze, and serve warm with good intentions."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Coat: Tear your Smoked Tofoo and wild mushrooms into chunks. Tumble them both in seasoned cornflour and let them sit for 10 minutes to get nice and tacky.\nCrisp: Fry or bake until exceptionally crispy, then keep them warm.\nGlaze: Sauté the onion and garlic until fragrant. Pour in the rest of your glaze ingredients and simmer until reduced to a sticky, glossy syrup.\nAssemble: Lightly pickle your radish and lychee, dress your salad leaves, coat the hot burnt ends in the glaze, and serve warm with good intentions.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("tofoo.co.uk")
    expect(recipe.canonical_url).to eq("https://tofoo.co.uk/recipes/smoked-tofoo-burnt-ends-with-coffee-ancho-glaze/")
    expect(recipe.site_name).to eq("Tofoo")
    expect(recipe.language).to eq("en-GB")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Smoked Tofoo already has a massive, smoky flavour profile, so we’re building an absolute powerhouse around it. We’re tearing it up, crisping it, and smothering it in a dark, syrupy coffee and ancho chilli glaze. Burnt Ends")
    expect(recipe.image).to eq("https://tofoo.co.uk/wp-content/uploads/2026/06/Smoked-Tofoo-Burnt-Ends-copy.jpg")
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
    expect(recipe.links).to include("#recipe")
  end
end
