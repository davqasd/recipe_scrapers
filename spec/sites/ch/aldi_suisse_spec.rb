# frozen_string_literal: true

RSpec.describe "aldi-suisse.ch" do
  subject(:recipe) { scrape_cassette("ch/aldi_suisse", url: "https://www.aldi-suisse.ch/de/rezepte/aldi-rezeptwelt/spaghetti-mediterran") }

  it "reads the title" do
    expect(recipe.title).to eq("Spaghetti Mediterran")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "Pfeffer",
      "Olivenöl",
      "Oliven mit Kern (entspricht ½ Glas abgetropft)",
      "Getrocknete Tomaten (entspricht ½ Glas abgetropft)",
      "Salz",
      "Kugeln Büffelmozzarella",
      "Basilikum, frisch",
      "Öl, zum Braten",
      "Spaghetti",
      "Knoblauchzehen",
      "Zwiebel",
      "kleine Zucchetti",
      "Gegrillte Artischocken (entspricht 1 Glas abgetropft)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "Pfeffer" },
      { amount: nil, unit: nil, name: "Olivenöl" },
      { amount: nil, unit: nil, name: "Oliven mit Kern" },
      { amount: nil, unit: nil, name: "Getrocknete Tomaten" },
      { amount: nil, unit: nil, name: "Salz" },
      { amount: nil, unit: nil, name: "Kugeln Büffelmozzarella" },
      { amount: nil, unit: nil, name: "Basilikum, frisch" },
      { amount: nil, unit: nil, name: "Öl, zum Braten" },
      { amount: nil, unit: nil, name: "Spaghetti" },
      { amount: nil, unit: nil, name: "Knoblauchzehen" },
      { amount: nil, unit: nil, name: "Zwiebel" },
      { amount: nil, unit: nil, name: "kleine Zucchetti" },
      { amount: nil, unit: nil, name: "Gegrillte Artischocken" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Oliven abtropfen, entsteinen und in Ringe schneiden. Getrocknete Tomaten und Artischocken abtropfen und in Streifen schneiden. Zucchetti waschen, längs vierteln und in gleichmässige Stücke schneiden. Zwiebel und Knoblauch schälen und fein hacken.",
      "Die Spaghetti in einem grossen Topf mit Salzwasser etwa 7 – 8 Minuten kochen, bis sie al dente sind.",
      "Zeitgleich etwas Öl in einer Pfanne bei mittlerer Hitze erhitzen. Zwiebeln und Knoblauch beigeben und andünsten. Zucchetti beigeben und mitdünsten. Mit Salz und Pfeffer würzen. Hitze reduzieren. Oliven, getrocknete Tomaten und Artischocken beigeben. Ein paar schöne Basilikumblätter als Garnitur beiseitelegen. Den Rest in feine Streifen schneiden. Kurz bevor die Spaghetti fertig sind, etwas Kochwasser zum Gemüse geben. Die Sauce aufkochen, Basilikumstreifen beigeben und abschmecken.",
      "Spaghetti abgiessen, mit der Sauce und dem Olivenöl mischen.",
      "Anrichten und Büffelmozzarella darüber zupfen, mit Basilikumblättern ausgarnieren."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Oliven abtropfen, entsteinen und in Ringe schneiden. Getrocknete Tomaten und Artischocken abtropfen und in Streifen schneiden. Zucchetti waschen, längs vierteln und in gleichmässige Stücke schneiden. Zwiebel und Knoblauch schälen und fein hacken.\nDie Spaghetti in einem grossen Topf mit Salzwasser etwa 7 – 8 Minuten kochen, bis sie al dente sind.\nZeitgleich etwas Öl in einer Pfanne bei mittlerer Hitze erhitzen. Zwiebeln und Knoblauch beigeben und andünsten. Zucchetti beigeben und mitdünsten. Mit Salz und Pfeffer würzen. Hitze reduzieren. Oliven, getrocknete Tomaten und Artischocken beigeben. Ein paar schöne Basilikumblätter als Garnitur beiseitelegen. Den Rest in feine Streifen schneiden. Kurz bevor die Spaghetti fertig sind, etwas Kochwasser zum Gemüse geben. Die Sauce aufkochen, Basilikumstreifen beigeben und abschmecken.\nSpaghetti abgiessen, mit der Sauce und dem Olivenöl mischen.\nAnrichten und Büffelmozzarella darüber zupfen, mit Basilikumblättern ausgarnieren.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("aldi-suisse.ch")
    expect(recipe.canonical_url).to eq("https://www.aldi-suisse.ch/de/rezepte/aldi-rezeptwelt/spaghetti-mediterran")
    expect(recipe.site_name).to eq("ALDI SUISSE")
    expect(recipe.language).to eq("de-CH")
    expect(recipe.author).to eq("ALDI SUISSE")
    expect(recipe.description).to eq("Mit Antipasti Gemüse, frischem Basilikum und Büffelmozzarella")
    expect(recipe.image).to eq("https://www.aldi-suisse.ch/content/dam/aldi/emea/ch/editorial/recipes/migrated-assets/Article_1588161400508241.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(15)
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
