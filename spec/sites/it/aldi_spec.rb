# frozen_string_literal: true

RSpec.describe "aldi.it" do
  subject(:recipe) { scrape_cassette("it/aldi", url: "https://www.aldi.it/il-mondo-aldi/ricette/primi/tagliatelle-al-ragu-d-anatra") }

  it "reads the title" do
    expect(recipe.title).to eq("Tagliatelle al ragu d'anatra")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "320 gr Tagliatelle all'uovo",
      "250 gr Macinato d'anatra",
      "Soffritto già pronto",
      "1 litro Brodo",
      "Ragù d'anatra Gourmet",
      "100 ml Vino rosso",
      "q.b. Erbe aromatiche",
      "q.b. Olio extra vergine d'oliva",
      "q.b. Sale e pepe nero",
      "Cipolla",
      "q.b. Parmigiano a piacere"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 320.0, unit: "gr", name: "Tagliatelle all'uovo" },
      { amount: 250.0, unit: "gr", name: "Macinato d'anatra" },
      { amount: nil, unit: nil, name: "Soffritto già pronto" },
      { amount: 1.0, unit: "litro", name: "Brodo" },
      { amount: nil, unit: nil, name: "Ragù d'anatra Gourmet" },
      { amount: 100.0, unit: "ml", name: "Vino rosso" },
      { amount: nil, unit: nil, name: "q.b. Erbe aromatiche" },
      { amount: nil, unit: nil, name: "q.b. Olio extra vergine d'oliva" },
      { amount: nil, unit: nil, name: "q.b. Sale e pepe nero" },
      { amount: nil, unit: nil, name: "Cipolla" },
      { amount: nil, unit: nil, name: "q.b. Parmigiano a piacere" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Prepara in padella un soffritto e aggiungi il macinato d'anatra, facendola rosolare fino alla cottura; sfuma il tutto col vino e aggiungi le erbe e il brodo, lasciando cuocere per circa un'ora a fiamma bassa. Una volta pronto, lascia riposare il ragù coperto, in modo da mantenerne intatto il sapore.",
      "Porta a ebollizione l’acqua e cuoci le tagliatelle; uniscile poi al condimento in padella a fuoco basso, aggiungendo un pizzico di pepe per rendere più deciso il tuo ragù.",
      "Servi il tuo primo con un po’ di Parmigiano e non dimenticare di portare il pane in tavola per l’intramontabile “scarpetta col sugo”."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Prepara in padella un soffritto e aggiungi il macinato d'anatra, facendola rosolare fino alla cottura; sfuma il tutto col vino e aggiungi le erbe e il brodo, lasciando cuocere per circa un'ora a fiamma bassa. Una volta pronto, lascia riposare il ragù coperto, in modo da mantenerne intatto il sapore.\nPorta a ebollizione l’acqua e cuoci le tagliatelle; uniscile poi al condimento in padella a fuoco basso, aggiungendo un pizzico di pepe per rendere più deciso il tuo ragù.\nServi il tuo primo con un po’ di Parmigiano e non dimenticare di portare il pane in tavola per l’intramontabile “scarpetta col sugo”.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("aldi.it")
    expect(recipe.canonical_url).to eq("https://www.aldi.it/il-mondo-aldi/ricette/primi/tagliatelle-al-ragu-d-anatra")
    expect(recipe.site_name).to eq("ALDI IT")
    expect(recipe.language).to eq("it-IT")
    expect(recipe.author).to be_nil
    expect(recipe.description).to be_nil
    expect(recipe.image).to be_nil
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
    expect(recipe.links).to include("#main")
  end
end
