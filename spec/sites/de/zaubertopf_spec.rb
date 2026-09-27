# frozen_string_literal: true

RSpec.describe "zaubertopf.de" do
  subject(:recipe) { scrape_cassette("de/zaubertopf", url: "https://www.zaubertopf.de/kuerbissuppe-mit-kokosmilch-thermomix-rezept/") }

  it "reads the title" do
    expect(recipe.title).to eq("Kürbissuppe mit Kokosmilch")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "Kürbiskerne, zum Garnieren",
      "1 Zwiebel, à ca. 50 g",
      "2 Knoblauchzehen",
      "20 g Rapsöl",
      "800 g Hokkaidokürbis",
      "700 g Gemüsebrühe zubereitet",
      "1 TL Salz",
      "0,5 TL gemahlener schwarzer Pfeffer",
      "3 Prisen Muskatnusspulver",
      "100 g Kokosmilch"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "Kürbiskerne, zum Garnieren" },
      { amount: 1.0, unit: nil, name: "Zwiebel, à ca. 50 g" },
      { amount: 2.0, unit: nil, name: "Knoblauchzehen" },
      { amount: 20.0, unit: "g", name: "Rapsöl" },
      { amount: 800.0, unit: "g", name: "Hokkaidokürbis" },
      { amount: 700.0, unit: "g", name: "Gemüsebrühe zubereitet" },
      { amount: 1.0, unit: "TL", name: "Salz" },
      { amount: 0.5, unit: "TL", name: "gemahlener schwarzer Pfeffer" },
      { amount: 3.0, unit: nil, name: "Prisen Muskatnusspulver" },
      { amount: 100.0, unit: "g", name: "Kokosmilch" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Zuerst die Kürbiskerne in den Mixtopf geben und 6 Sek. | Stufe 7 zerkleinern und umfüllen.",
      "Zwiebel halbiert und Knoblauch in den Mixtopf geben und 5 Sek. | Stufe 5 zerkleinern. Mit dem Spatel nach unten schieben. Rapsöl zugeben und 2 Min. | 120 °C | Stufe 2 dünsten.",
      "Kürbis in groben Stücken in den Mixtopf geben und 7 Sek. | Stufe 7 zerkleinern. Gemüsebrühe, Salz, Pfeffer und Muskat zugeben, 15 Min. | 100 °C | Stufe 2 kochen.",
      "Kokosmilch zugeben und stufenweise auf 4 – 5 – 8 ca. 40 Sekunden pürieren.",
      "Suppe auf Teller füllen und mit Kürbiskernen garnieren."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Zuerst die Kürbiskerne in den Mixtopf geben und 6 Sek. | Stufe 7 zerkleinern und umfüllen.\nZwiebel halbiert und Knoblauch in den Mixtopf geben und 5 Sek. | Stufe 5 zerkleinern. Mit dem Spatel nach unten schieben. Rapsöl zugeben und 2 Min. | 120 °C | Stufe 2 dünsten.\nKürbis in groben Stücken in den Mixtopf geben und 7 Sek. | Stufe 7 zerkleinern. Gemüsebrühe, Salz, Pfeffer und Muskat zugeben, 15 Min. | 100 °C | Stufe 2 kochen.\nKokosmilch zugeben und stufenweise auf 4 – 5 – 8 ca. 40 Sekunden pürieren.\nSuppe auf Teller füllen und mit Kürbiskernen garnieren.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("zaubertopf.de")
    expect(recipe.canonical_url).to eq("https://www.zaubertopf.de/kuerbissuppe-mit-kokosmilch-thermomix-rezept/")
    expect(recipe.site_name).to eq("ZauberTopf")
    expect(recipe.language).to eq("de")
    expect(recipe.author).to eq("mein ZauberTopf")
    expect(recipe.description).to eq("Kürbissuppe mit Kokosmilch ist die perfekte Wahl für alle, die Kürbissuppe lieben und sie vegan mögen. Die Kokosmilch sorgt für eine himmlische Cremigkeit und die Zubereitung mit dem Thermomix®® ist super einfach. Hier das Rezept, probiere es gleich aus!")
    expect(recipe.image).to eq("https://www.zaubertopf.de/wp-content/uploads/2024/10/Kuerbissuppe-mit-Kokosmilch_46858-640x640.jpg")
    expect(recipe.category).to eq("Suppen & Eintöpfe")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to eq(26)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Kürbis"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "284"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: nil, amount: 284.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
