# frozen_string_literal: true

RSpec.describe "ndr.de" do
  subject(:recipe) { scrape_cassette("de/ndr", url: "https://www.ndr.de/ratgeber/kochen/rezepte/kumpir-backkartoffel-mit-krautsalat-und-joghurt-creme,kumpir-100.html") }

  it "reads the title" do
    expect(recipe.title).to eq("Kumpir: Backkartoffel mit Krautsalat und Joghurt-Creme")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 Kartoffeln",
      "Olivenöl",
      "200 g Käse",
      "100 g Butter",
      "Salz",
      "Pfeffer",
      "500 g Spitzkohl",
      "1 kl. Glas Möhren",
      "1 EL Weißweinessig",
      "2 EL Pflanzenöl",
      "1 EL Zucker",
      "1 TL Salz",
      "Kreuzkümmel",
      "500 g Joghurt",
      "1 Zehe Knoblauch",
      "1 Bund Schnittlauch",
      "Olivenöl",
      "Zitronensaft",
      "Salz",
      "Pfeffer",
      "Maiskörner",
      "Gewürzgurken",
      "schwarze Oliven",
      "Frühlingszwiebeln",
      "Gemüse",
      "Kichererbsen",
      "Gurke",
      "Minze"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: nil, name: "Kartoffeln" },
      { amount: nil, unit: nil, name: "Olivenöl" },
      { amount: 200.0, unit: "g", name: "Käse" },
      { amount: 100.0, unit: "g", name: "Butter" },
      { amount: nil, unit: nil, name: "Salz" },
      { amount: nil, unit: nil, name: "Pfeffer" },
      { amount: 500.0, unit: "g", name: "Spitzkohl" },
      { amount: 1.0, unit: nil, name: "kl. Glas Möhren" },
      { amount: 1.0, unit: "EL", name: "Weißweinessig" },
      { amount: 2.0, unit: "EL", name: "Pflanzenöl" },
      { amount: 1.0, unit: "EL", name: "Zucker" },
      { amount: 1.0, unit: "TL", name: "Salz" },
      { amount: nil, unit: nil, name: "Kreuzkümmel" },
      { amount: 500.0, unit: "g", name: "Joghurt" },
      { amount: 1.0, unit: "Zehe", name: "Knoblauch" },
      { amount: 1.0, unit: "Bund", name: "Schnittlauch" },
      { amount: nil, unit: nil, name: "Olivenöl" },
      { amount: nil, unit: nil, name: "Zitronensaft" },
      { amount: nil, unit: nil, name: "Salz" },
      { amount: nil, unit: nil, name: "Pfeffer" },
      { amount: nil, unit: nil, name: "Maiskörner" },
      { amount: nil, unit: nil, name: "Gewürzgurken" },
      { amount: nil, unit: nil, name: "schwarze Oliven" },
      { amount: nil, unit: nil, name: "Frühlingszwiebeln" },
      { amount: nil, unit: nil, name: "Gemüse" },
      { amount: nil, unit: nil, name: "Kichererbsen" },
      { amount: nil, unit: nil, name: "Gurke" },
      { amount: nil, unit: nil, name: "Minze" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Backofen auf 180 Grad (Ober-/Unterhitze) vorheizen. Kartoffeln gründlich waschen, trocken tupfen und mehrfach mit einer Gabel oder Messerspitze einstechen. Die Knollen anschließend mit Öl einreiben, auf ein Backblech legen und im Ofen 75-90 Minuten backen, bis sie innen schön weich sind. Käse reiben und beiseitestellen.",
      "Den Kohlkopf in Viertel teilen und den dicken Strunk herausschneiden. Hobeln oder mit einem Messer in feine Streifen schneiden. In eine Schüssel geben, mit Salz bestreuen und mit den Händen einige Zeit kräftig kneten, damit er weich wird und etwas Wasser verliert. Wasser abgießen. Mit Essig, Öl, Zucker und etwas Kreuzkümmel würzen und vermengen. Die Möhrenstreifen hinzufügen. Mindestens 30 Minuten ziehen lassen.",
      "Knoblauch reiben oder pressen, Schnittlauch in feine Ringe schneiden. Mit dem Joghurt vermengen und mit Salz, Pfeffer, Zitronensaft und Olivenöl abschmecken.",
      "Toppings nach Wahl in mundgerechte Stücke schneiden und in Schälchen oder auf Platten legen."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Backofen auf 180 Grad (Ober-/Unterhitze) vorheizen. Kartoffeln gründlich waschen, trocken tupfen und mehrfach mit einer Gabel oder Messerspitze einstechen. Die Knollen anschließend mit Öl einreiben, auf ein Backblech legen und im Ofen 75-90 Minuten backen, bis sie innen schön weich sind. Käse reiben und beiseitestellen.\nDen Kohlkopf in Viertel teilen und den dicken Strunk herausschneiden. Hobeln oder mit einem Messer in feine Streifen schneiden. In eine Schüssel geben, mit Salz bestreuen und mit den Händen einige Zeit kräftig kneten, damit er weich wird und etwas Wasser verliert. Wasser abgießen. Mit Essig, Öl, Zucker und etwas Kreuzkümmel würzen und vermengen. Die Möhrenstreifen hinzufügen. Mindestens 30 Minuten ziehen lassen.\nKnoblauch reiben oder pressen, Schnittlauch in feine Ringe schneiden. Mit dem Joghurt vermengen und mit Salz, Pfeffer, Zitronensaft und Olivenöl abschmecken.\nToppings nach Wahl in mundgerechte Stücke schneiden und in Schälchen oder auf Platten legen.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("ndr.de")
    expect(recipe.canonical_url).to eq("https://www.ndr.de/ratgeber/kochen/rezepte/kumpir-backkartoffel-mit-krautsalat-und-joghurt-creme,kumpir-100.html")
    expect(recipe.site_name).to eq("ndr.de")
    expect(recipe.language).to eq("de")
    expect(recipe.author).to eq("Zora Klipp")
    expect(recipe.description).to eq("Die Kartoffeln nach türkischer Art sind einfach zuzubereiten. Sie lassen sich nach Belieben mit weiteren Toppings verfeinern.")
    expect(recipe.image).to eq("https://images.ndr.de/image/36f41fdb-cf27-48ad-a403-57b7438430de/AAABoI_OAqk/AAABnSSvrFg/16x9-big/kumpir-102.jpg?width=1920")
    expect(recipe.category).to eq("Hauptspeise, Kartoffeln, mediterran, vegetarisch")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(80)
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
    expect(recipe.links).to include("#anchor-mainnav")
  end
end
