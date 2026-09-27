# frozen_string_literal: true

RSpec.describe "lacucinaitaliana.it" do
  subject(:recipe) { scrape_cassette("it/lacucinaitaliana", url: "https://www.lacucinaitaliana.it/ricetta/melanzane-pomodorini-confit-ricotta-salata/") }

  it "reads the title" do
    expect(recipe.title).to eq("Melanzane, pomodorini confit e ricotta salata, antipasto vegetariano")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "800 g 2 melanzane",
      "500 g pomodorini",
      "80 g ricotta salata",
      "zucchero semolato",
      "timo",
      "aglio",
      "basilico",
      "olio extravergine di oliva",
      "olio di semi",
      "sale",
      "pepe"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 800.0, unit: "g", name: "2 melanzane" },
      { amount: 500.0, unit: "g", name: "pomodorini" },
      { amount: 80.0, unit: "g", name: "ricotta salata" },
      { amount: nil, unit: nil, name: "zucchero semolato" },
      { amount: nil, unit: nil, name: "timo" },
      { amount: nil, unit: nil, name: "aglio" },
      { amount: nil, unit: nil, name: "basilico" },
      { amount: nil, unit: nil, name: "olio extravergine di oliva" },
      { amount: nil, unit: nil, name: "olio di semi" },
      { amount: nil, unit: nil, name: "sale" },
      { amount: nil, unit: nil, name: "pepe" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Lavate i pomodorini e tagliateli a metà per il lungo. Distribuiteli su una teglia rivestita con carta da forno, conditeli con olio extravergine di oliva, sale e pepe, quindi distribuitevi sopra un paio di cucchiai di zucchero. Unite anche 2-3 rametti di timo e infornate, in modalità ventilata, a 160 °C per circa 45 minuti, finché non saranno leggermente appassiti e canditi in superficie.",
      "Mondate le melanzane e tagliatele a cubetti di circa 2 cm di lato.",
      "Scaldate abbondante olio per friggere in una casseruola, profumandolo con uno spicchio di aglio; quando l’aglio comincerà a sfrigolare, eliminatelo e friggete le melanzane, poche per volta, finché non saranno ben dorate e croccanti, scolandole via via su carta assorbente. Unitele ai pomodorini, completate con foglie di basilico fresco e una generosa grattugiata di ricotta salata e servite."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Lavate i pomodorini e tagliateli a metà per il lungo. Distribuiteli su una teglia rivestita con carta da forno, conditeli con olio extravergine di oliva, sale e pepe, quindi distribuitevi sopra un paio di cucchiai di zucchero. Unite anche 2-3 rametti di timo e infornate, in modalità ventilata, a 160 °C per circa 45 minuti, finché non saranno leggermente appassiti e canditi in superficie.\nMondate le melanzane e tagliatele a cubetti di circa 2 cm di lato.\nScaldate abbondante olio per friggere in una casseruola, profumandolo con uno spicchio di aglio; quando l’aglio comincerà a sfrigolare, eliminatelo e friggete le melanzane, poche per volta, finché non saranno ben dorate e croccanti, scolandole via via su carta assorbente. Unitele ai pomodorini, completate con foglie di basilico fresco e una generosa grattugiata di ricotta salata e servite.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("lacucinaitaliana.it")
    expect(recipe.canonical_url).to eq("https://www.lacucinaitaliana.it/ricetta/melanzane-pomodorini-confit-ricotta-salata/")
    expect(recipe.site_name).to eq("La Cucina Italiana")
    expect(recipe.language).to eq("it-IT")
    expect(recipe.author).to eq("Redazione")
    expect(recipe.description).to eq("Scoprite la ricetta delle Melanzane, pomodorini confit e ricotta salata per un antipasto vegetariano facile da realizzare")
    expect(recipe.image).to eq("https://media-assets.lacucinaitaliana.it/photos/6aad6c59a23ef74589c67487/16:9/w_1072,h_603,c_limit/Melanzane,%20pomodorini%20confit%20e%20ricotta%20salata.jpeg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(60)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["facile", "vegetariana", "senza glutine", "melanzane", "pomodori", "ricotta", "estate", "magazine"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.4)
    expect(recipe.ratings_count).to eq(5)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
