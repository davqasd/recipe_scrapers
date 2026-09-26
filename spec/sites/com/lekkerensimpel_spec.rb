# frozen_string_literal: true

RSpec.describe "lekkerensimpel.com" do
  subject(:recipe) { scrape_cassette("com/lekkerensimpel", url: "https://www.lekkerensimpel.com/poke-bowl-met-kip/") }

  it "reads the title" do
    expect(recipe.title).to eq("Poké bowl met kip")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "200 gr sushi rijst",
      "2 el sushi azijn (of 1,5 el rijstazijn, 1 tl suiker en een snuf zout)",
      "2 krokante kipschnitzels",
      "1 avocado",
      "100 gr peen julienne",
      "0.5 komkommer",
      "2 el gebakken uitjes",
      "Japanse mayonaise",
      "sojasaus"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 200.0, unit: "gr", name: "sushi rijst" },
      { amount: 2.0, unit: "el", name: "sushi azijn" },
      { amount: 2.0, unit: nil, name: "krokante kipschnitzels" },
      { amount: 1.0, unit: nil, name: "avocado" },
      { amount: 100.0, unit: "gr", name: "peen julienne" },
      { amount: 0.5, unit: nil, name: "komkommer" },
      { amount: 2.0, unit: "el", name: "gebakken uitjes" },
      { amount: nil, unit: nil, name: "Japanse mayonaise" },
      { amount: nil, unit: nil, name: "sojasaus" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Begin met het maken van de sushirijst. Wij houden hiervoor dit sushirijst recept aan. Tip: heb je weinig tijd? Gebruik dan pandan rijst in plaats van sushi rijst. Dit is een stuk sneller klaar.",
      "Snijd de avocado en komkommer in plakjes/reepjes.",
      "Giet een scheutje olie in een koekenpan en bak de kipschnitzels volgens de instructies op het pak. Tip: maak ook eens de kipschnitzels zelf. Snijd de kipschnitzels daarna in plakjes.",
      "Verdeel de rijst over twee kommen. Verdeel de komkommer, kip, peen julienne, avocado en gebakken uitjes hier overheen. Als laatste verdeel je wat Japanse mayonaise en sojasaus over het geheel."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Begin met het maken van de sushirijst. Wij houden hiervoor dit sushirijst recept aan. Tip: heb je weinig tijd? Gebruik dan pandan rijst in plaats van sushi rijst. Dit is een stuk sneller klaar.\nSnijd de avocado en komkommer in plakjes/reepjes.\nGiet een scheutje olie in een koekenpan en bak de kipschnitzels volgens de instructies op het pak. Tip: maak ook eens de kipschnitzels zelf. Snijd de kipschnitzels daarna in plakjes.\nVerdeel de rijst over twee kommen. Verdeel de komkommer, kip, peen julienne, avocado en gebakken uitjes hier overheen. Als laatste verdeel je wat Japanse mayonaise en sojasaus over het geheel.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("lekkerensimpel.com")
    expect(recipe.canonical_url).to eq("https://www.lekkerensimpel.com/poke-bowl-met-kip/")
    expect(recipe.site_name).to eq("Lekker en Simpel")
    expect(recipe.language).to eq("nl-NL")
    expect(recipe.author).to eq("Lekker en Simpel")
    expect(recipe.description).to eq("Een heerlijke poké bowl met kip, avocado, peen julienne en edamame bonen. Een makkelijk gerecht dat in 30 minuten op tafel staat én waarmee je heel goed kunt variëren.")
    expect(recipe.image).to eq("https://www.lekkerensimpel.com/wp-content/uploads/2022/03/588A2370-1.jpg")
    expect(recipe.category).to eq("Hoofdgerecht")
    expect(recipe.cuisine).to eq("Aziatische keuken")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(35)
    expect(recipe.keywords).to eq(%w[kip bowl])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.52)
    expect(recipe.ratings_count).to eq(95)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
