# frozen_string_literal: true

RSpec.describe "sobors.hu" do
  subject(:recipe) { scrape_cassette("hu/sobors", url: "https://sobors.hu/receptek/piskotatekercs-parizsi-kremmel-recept/") }

  it "reads the title" do
    expect(recipe.title).to eq("Piskótatekercs párizsi krémmel")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "6 darab tojás",
      "6 evőkanál cukor",
      "6 evőkanál finomliszt",
      "1 dl habtejszín",
      "20 dkg cukor",
      "3 evőkanál kakaó (cukrozatlan)",
      "20 dkg vaj",
      "1 dl mascarpone",
      "1 evőkanál rum",
      "kakaó a szóráshoz"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 6.0, unit: "darab", name: "tojás" },
      { amount: 6.0, unit: "evőkanál", name: "cukor" },
      { amount: 6.0, unit: "evőkanál", name: "finomliszt" },
      { amount: 1.0, unit: "dl", name: "habtejszín" },
      { amount: 20.0, unit: "dkg", name: "cukor" },
      { amount: 3.0, unit: "evőkanál", name: "kakaó" },
      { amount: 20.0, unit: "dkg", name: "vaj" },
      { amount: 1.0, unit: "dl", name: "mascarpone" },
      { amount: 1.0, unit: "evőkanál", name: "rum" },
      { amount: nil, unit: nil, name: "kakaó a szóráshoz" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Piskóta: A tojásokat válasszuk szét, majd a sárgáját keverjük fehéredésig a cukorral. A tojásfehérjét verjük kemény habbá, majd forgassuk a sárgájához, ezután a lisztet szitáljuk hozzá, és óvatosan keverjük egybe a tojásos keverékkel. A piskótát simítsuk sütőpapírral bélelt tepsire (24x18 centiméter), majd toljuk 180 fokosra előmelegített sütőbe, és 10-15 perc alatt süssük készre. A piskótát még melegen tekerjük fel, és tegyük félre. Krém: A habtejszínt öntsük lábasba és melegítsük fel a cukorral együtt, addig, amíg a cukor elolvad. Ezután keverjük hozzá a kakaót is, majd tegyük félre, és hűtsük ki. A kihűlt főzött krémhez keverjük hozzá a vajat, mascarponét és a rumot. A piskótát terítsük ki, és kenjük meg a krémmel, majd tekerjük fel. A rolád tetejét szórjuk meg kakaóval, és tálalásig tartsuk hűtőben."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Piskóta: A tojásokat válasszuk szét, majd a sárgáját keverjük fehéredésig a cukorral. A tojásfehérjét verjük kemény habbá, majd forgassuk a sárgájához, ezután a lisztet szitáljuk hozzá, és óvatosan keverjük egybe a tojásos keverékkel. A piskótát simítsuk sütőpapírral bélelt tepsire (24x18 centiméter), majd toljuk 180 fokosra előmelegített sütőbe, és 10-15 perc alatt süssük készre. A piskótát még melegen tekerjük fel, és tegyük félre. Krém: A habtejszínt öntsük lábasba és melegítsük fel a cukorral együtt, addig, amíg a cukor elolvad. Ezután keverjük hozzá a kakaót is, majd tegyük félre, és hűtsük ki. A kihűlt főzött krémhez keverjük hozzá a vajat, mascarponét és a rumot. A piskótát terítsük ki, és kenjük meg a krémmel, majd tekerjük fel. A rolád tetejét szórjuk meg kakaóval, és tálalásig tartsuk hűtőben.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("sobors.hu")
    expect(recipe.canonical_url).to eq("https://sobors.hu/receptek/piskotatekercs-parizsi-kremmel-recept/")
    expect(recipe.site_name).to eq("Sóbors")
    expect(recipe.language).to eq("hu")
    expect(recipe.author).to eq("Botos Claudia")
    expect(recipe.description).to eq("A puha piskóta édes párizsi krémmel töltve készül, melyben a rum zamata is érződik, ettől lesz különleges.")
    expect(recipe.image).to eq("https://sobors.hu/neon/media/images/47897676_b3db296845e2.2e16d0ba.format-jpeg.fill-1024x576.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 items")
    expect(recipe.total_time).to eq(105)
    expect(recipe.prep_time).to eq(90)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq([
      "süti",
      "sütemény",
      "piskóta",
      "piskótatekercs",
      "csokoládékrém",
      "párizsi krém",
      "piskótarolád",
      "piskótatekercs párizsi krémmel"
    ])
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
    expect(recipe.links).to include("/")
  end
end
