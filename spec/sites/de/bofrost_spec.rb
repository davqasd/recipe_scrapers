# frozen_string_literal: true

RSpec.describe "bofrost.de" do
  subject(:recipe) { scrape_cassette("de/bofrost", url: "https://www.bofrost.de/rezeptwelt/rezepte/festliches_37982/melonen-carpaccio-mit-brotchips_120005.html?recipeCode=91a280c6-4011-4512-a5bd-d43d8131383c") }

  it "reads the title" do
    expect(recipe.title).to eq("Melonen-Carpaccio mit Brotchips")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 Msp. Salz",
      "1 Prise(n) Pfeffer aus der Mühe",
      "0.5 Stück Cantaloupe-Melone",
      "0.5 Stück Wassermelone",
      "100 g Parmaschinken",
      "1 Prise(n) Salz",
      "1 Prise(n) Pfeffer aus der Mühe",
      "1 EL Orangenschalenstreifen",
      "100 ml Orangensaft",
      "1 Spritzer weißer Balsamico",
      "1 Msp. Zucker"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "Msp", name: "Salz" },
      { amount: 1.0, unit: "Prise", name: "Pfeffer aus der Mühe" },
      { amount: 0.5, unit: "Stück", name: "Cantaloupe-Melone" },
      { amount: 0.5, unit: "Stück", name: "Wassermelone" },
      { amount: 100.0, unit: "g", name: "Parmaschinken" },
      { amount: 1.0, unit: "Prise", name: "Salz" },
      { amount: 1.0, unit: "Prise", name: "Pfeffer aus der Mühe" },
      { amount: 1.0, unit: "EL", name: "Orangenschalenstreifen" },
      { amount: 100.0, unit: "ml", name: "Orangensaft" },
      { amount: 1.0, unit: "Spritzer", name: "weißer Balsamico" },
      { amount: 1.0, unit: "Msp", name: "Zucker" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Den Backofen auf 200°C (Ober-/Unterhitze 220°C) vorheizen. Die tiefgefrorenen Brötchen mit Backpapier auf dem Backblech in der mittleren Schiene ca. 8 min (Ober-/Unterhitze ca. 8 min) backen.",
      "Zwiebeln, Knoblauch und Olivenöl für die Brotchips verrühren und mit Salz und Pfeffer abschmecken.",
      "Die Melonen in Stücke schneiden und das Fruchtfleisch in dünne Scheiben schneiden. Anschließend mit dem Schinken auf Tellern anrichten. Burrata auseinanderzupfen und darüber verteilen.",
      "Das Olivenöl mit den Kräutern pürieren. Alles einmal durchsieben und mit Salz, Pfeffer, Orangeschalenstreifen, Orangensaft, Balsamicoessig und Zucker abschmecken.",
      "Die Brötchen in sehr dünne Scheiben schneiden. Die Brotchips mit dem Zwiebel-Knoblauch-Oliven-Mix beträufeln und auf einem Backblech unter dem Backofengrill goldbraun rösten. Zum Carpaccio servieren."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Den Backofen auf 200°C (Ober-/Unterhitze 220°C) vorheizen. Die tiefgefrorenen Brötchen mit Backpapier auf dem Backblech in der mittleren Schiene ca. 8 min (Ober-/Unterhitze ca. 8 min) backen.\nZwiebeln, Knoblauch und Olivenöl für die Brotchips verrühren und mit Salz und Pfeffer abschmecken.\nDie Melonen in Stücke schneiden und das Fruchtfleisch in dünne Scheiben schneiden. Anschließend mit dem Schinken auf Tellern anrichten. Burrata auseinanderzupfen und darüber verteilen.\nDas Olivenöl mit den Kräutern pürieren. Alles einmal durchsieben und mit Salz, Pfeffer, Orangeschalenstreifen, Orangensaft, Balsamicoessig und Zucker abschmecken.\nDie Brötchen in sehr dünne Scheiben schneiden. Die Brotchips mit dem Zwiebel-Knoblauch-Oliven-Mix beträufeln und auf einem Backblech unter dem Backofengrill goldbraun rösten. Zum Carpaccio servieren.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("bofrost.de")
    expect(recipe.canonical_url).to eq("https://www.bofrost.de/rezeptwelt/rezepte/festliches_37982/melonen-carpaccio-mit-brotchips_120005.html?recipeCode=91a280c6-4011-4512-a5bd-d43d8131383c")
    expect(recipe.site_name).to eq("bofrost*Deutschland")
    expect(recipe.language).to eq("de")
    expect(recipe.author).to eq("bofrost*")
    expect(recipe.description).to be_nil
    expect(recipe.image).to eq("https://www.bofrost.de/medias/W920xH575R1.6-47990dd3-798c-41fb-8ec6-ad06727c3c67-281aaed5-2008-47aa-8d52-d9193dbb713b?context=bWFzdGVyfHJvb3R8MTc2NTY4fGltYWdlL2pwZWd8YURWaUwyaGxZeTh4TURnNU56WXpOVEkwTmpFeE1DOVhPVEl3ZUVnMU56VlNNUzQyWHpRM09Ua3daR1F6TFRjNU9HTXROREZtWWkwNFpXTTJMV0ZrTURZM01qZGpNMk0yTjE4eU9ERmhZV1ZrTlMweU1EQTRMVFEzWVdFdE9HUTFNaTFrT1RFNU0yUmlZamN4TTJJfDkyODNlMDI1ODUzZGNiYzY5ODRjYWZlMDEyMGEyMmEyMDRkNWY1ZTJkZDU0ODhiNGVlMzUyMDMzNmRkNTI3ZTg")
    expect(recipe.category).to eq("Festliches")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Ostern"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "servingSize" => "schema.org.recipe.portions 1" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: nil, amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/saisondeal.html")
  end
end
