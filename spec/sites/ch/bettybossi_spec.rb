# frozen_string_literal: true

RSpec.describe "bettybossi.ch" do
  subject(:recipe) { scrape_cassette("ch/bettybossi", url: "https://www.bettybossi.ch/de/rezepte/rezept/zwiebelsuppe-10010500/") }

  it "reads the title" do
    expect(recipe.title).to eq("Zwiebelsuppe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "5 Zwiebeln (ca. 600 g)",
      "2 EL Butter",
      "2 EL Mehl",
      "2.5 dl Weisswein",
      "8 dl Gemüsebouillon",
      "150 g Baguette",
      "1 Bund glattblättrige Petersilie",
      "130 g geriebener Gruyère",
      "1 Prise Muskat",
      "Salz, Pfeffer , nach Bedarf"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 5.0, unit: nil, name: "Zwiebeln" },
      { amount: 2.0, unit: "EL", name: "Butter" },
      { amount: 2.0, unit: "EL", name: "Mehl" },
      { amount: 2.5, unit: "dl", name: "Weisswein" },
      { amount: 8.0, unit: "dl", name: "Gemüsebouillon" },
      { amount: 150.0, unit: "g", name: "Baguette" },
      { amount: 1.0, unit: "Bund", name: "glattblättrige Petersilie" },
      { amount: 130.0, unit: "g", name: "geriebener Gruyère" },
      { amount: 1.0, unit: "Prise", name: "Muskat" },
      { amount: nil, unit: nil, name: "Salz, Pfeffer, nach Bedarf" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Zwiebeln schälen, halbieren, in feine Streifen schneiden. Butter in einer Pfanne warm werden lassen. Zwiebeln unter gelegentlichem Wenden zugedeckt ca. 10 Min. dämpfen, bis sie weich und goldgelb sind.",
      "Ofen auf 240 Grad vorheizen. Mehl unter die Zwiebeln mischen, kurz mitdämpfen. Wein und Bouillon dazugiessen, aufkochen. Hitze reduzieren, zugedeckt ca. 20 Min. köcheln.",
      "Brot in 12 Scheiben schneiden, auf ein Backblech legen. Petersilie fein schneiden, mit dem Käse mischen, auf den Brotscheiben verteilen.",
      "Backen: ca. 6 Min. in der oberen Hälfte des Ofens.",
      "Suppe würzen, in tiefe Teller verteilen, Brotscheiben darauf anrichten."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Zwiebeln schälen, halbieren, in feine Streifen schneiden. Butter in einer Pfanne warm werden lassen. Zwiebeln unter gelegentlichem Wenden zugedeckt ca. 10 Min. dämpfen, bis sie weich und goldgelb sind.\nOfen auf 240 Grad vorheizen. Mehl unter die Zwiebeln mischen, kurz mitdämpfen. Wein und Bouillon dazugiessen, aufkochen. Hitze reduzieren, zugedeckt ca. 20 Min. köcheln.\nBrot in 12 Scheiben schneiden, auf ein Backblech legen. Petersilie fein schneiden, mit dem Käse mischen, auf den Brotscheiben verteilen.\nBacken: ca. 6 Min. in der oberen Hälfte des Ofens.\nSuppe würzen, in tiefe Teller verteilen, Brotscheiben darauf anrichten.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("bettybossi.ch")
    expect(recipe.canonical_url).to eq("https://www.bettybossi.ch/de/rezepte/rezept/zwiebelsuppe-10010500/")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("de")
    expect(recipe.author).to eq("Betty Bossi")
    expect(recipe.description).to eq("Die traditionelle Zwiebelsuppe ist noch immer der Renner. Die mit Gruyère überbackenen Baguettescheiben obendrauf sind die perfekte Krönung.")
    expect(recipe.image).to eq("https://media.bettybossi.ch/image/992382728798/image_6cagnpj9ut18db6ccq8euci70c/-FJPG")
    expect(recipe.category).to eq("Suppe, Hauptspeise")
    expect(recipe.cuisine).to eq("Gemüse , Salat")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(46)
    expect(recipe.prep_time).to eq(40)
    expect(recipe.cook_time).to eq(40)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["VegetarianDiet"])
    expect(recipe.ratings).to eq(3.8)
    expect(recipe.ratings_count).to eq(4)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "416 kcal",
      "fatContent" => "19 g",
      "carbohydrateContent" => "35 g",
      "proteinContent" => "16 g",
      "servingSize" => "Portion (1/4)"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 416.0 },
      { name: "fatContent", unit: "g", amount: 19.0 },
      { name: "carbohydrateContent", unit: "g", amount: 35.0 },
      { name: "proteinContent", unit: "g", amount: 16.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#bb-skip-main-content")
  end
end
