# frozen_string_literal: true

RSpec.describe "aldi.hu" do
  subject(:recipe) { scrape_cassette("hu/aldi", url: "https://www.aldi.hu/az-en-aldi-m/recipes/all/roze-kacsamell") }

  it "reads the title" do
    expect(recipe.title).to eq("Rozé kacsamell")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "KOKÁRDÁS háromnegyed zsíros vaj 60%",
      "narancs kifacsart leve",
      "DUNA-TISZA KÖZI Irsai Olivér száraz fehérbor",
      "LE GUSTO só, bors",
      "sárgarépa",
      "fehérrépa",
      "BELLASAN olívaolaj",
      "LE GUSTO só, bors",
      "KOKÁRDÁS kancsós tej 1,5%",
      "KOKÁRDÁS háromnegyed zsíros vaj 60%",
      "citrom leve",
      "HÚSMESTER friss pecsenyekacsa mellfilé bőrrel",
      "LE GUSTO só, bors",
      "BELLASAN napraforgó-étolaj",
      "sárgarépa"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "KOKÁRDÁS háromnegyed zsíros vaj 60%" },
      { amount: nil, unit: nil, name: "narancs kifacsart leve" },
      { amount: nil, unit: nil, name: "DUNA-TISZA KÖZI Irsai Olivér száraz fehérbor" },
      { amount: nil, unit: nil, name: "LE GUSTO só, bors" },
      { amount: nil, unit: nil, name: "sárgarépa" },
      { amount: nil, unit: nil, name: "fehérrépa" },
      { amount: nil, unit: nil, name: "BELLASAN olívaolaj" },
      { amount: nil, unit: nil, name: "LE GUSTO só, bors" },
      { amount: nil, unit: nil, name: "KOKÁRDÁS kancsós tej 1,5%" },
      { amount: nil, unit: nil, name: "KOKÁRDÁS háromnegyed zsíros vaj 60%" },
      { amount: nil, unit: nil, name: "citrom leve" },
      { amount: nil, unit: nil, name: "HÚSMESTER friss pecsenyekacsa mellfilé bőrrel" },
      { amount: nil, unit: nil, name: "LE GUSTO só, bors" },
      { amount: nil, unit: nil, name: "BELLASAN napraforgó-étolaj" },
      { amount: nil, unit: nil, name: "sárgarépa" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "A répapüréhez a répákat megpucoljuk, felvagdossuk, sütőpapírral bélelt tepsibe tesszük, meglocsoljuk olívaolajjal, sózzuk, borsozzuk, és 200 fokra előmelegített sütőben puhára sütjük.",
      "A narancsos répához a sárgarépákat megpucoljuk, hosszában félbevágjuk.",
      "Egy serpenyőben megolvasztjuk a vajat, és elkezdjük rajta pirítani a félbevágott répákat.",
      "Hozzáfacsarjuk a narancsok levét, és öntünk hozzá fehérbort, sózzuk és borsozzuk. Addig pároljuk, amíg szép szirupos állaga nem lesz.",
      "A megsült répákat turmixgépbe tesszük, felöntjük a tejjel, majd lezúzzuk. Sózzuk, borsozzuk, továbbá adunk hozzá kevés citromlevet és vajat is.",
      "A kacsamelleket előkészítjük: a kilógó zsíros részeket levagdossuk, a vékony kis kacsamell belső filét levágjuk róla, és a bőrét óvatosan beirdaljuk (hogy a húsba ne vágjunk bele). Sózzuk, borsozzuk mindkét oldalukat.",
      "Közepesen forró serpenyőbe kevés olajat öntünk, és a bőrös felével lefelé a melleket elkezdjük pirítani. Közepes lángon addig sütjük, amíg szépen kisül a bőréből a zsír, és ropogós nem lesz.",
      "Ezután megfordítjuk és 2-3 percig sütjük a másik oldalukat is.",
      "Majd ugorhatnak is a kb. 50 fokos sütőbe egy sütőrácsra (bőrös oldalukkal felfelé), hogy a tálalásig melegen tartsuk."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("A répapüréhez a répákat megpucoljuk, felvagdossuk, sütőpapírral bélelt tepsibe tesszük, meglocsoljuk olívaolajjal, sózzuk, borsozzuk, és 200 fokra előmelegített sütőben puhára sütjük.\nA narancsos répához a sárgarépákat megpucoljuk, hosszában félbevágjuk.\nEgy serpenyőben megolvasztjuk a vajat, és elkezdjük rajta pirítani a félbevágott répákat.\nHozzáfacsarjuk a narancsok levét, és öntünk hozzá fehérbort, sózzuk és borsozzuk. Addig pároljuk, amíg szép szirupos állaga nem lesz.\nA megsült répákat turmixgépbe tesszük, felöntjük a tejjel, majd lezúzzuk. Sózzuk, borsozzuk, továbbá adunk hozzá kevés citromlevet és vajat is.\nA kacsamelleket előkészítjük: a kilógó zsíros részeket levagdossuk, a vékony kis kacsamell belső filét levágjuk róla, és a bőrét óvatosan beirdaljuk (hogy a húsba ne vágjunk bele). Sózzuk, borsozzuk mindkét oldalukat.\nKözepesen forró serpenyőbe kevés olajat öntünk, és a bőrös felével lefelé a melleket elkezdjük pirítani. Közepes lángon addig sütjük, amíg szépen kisül a bőréből a zsír, és ropogós nem lesz.\nEzután megfordítjuk és 2-3 percig sütjük a másik oldalukat is.\nMajd ugorhatnak is a kb. 50 fokos sütőbe egy sütőrácsra (bőrös oldalukkal felfelé), hogy a tálalásig melegen tartsuk.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("aldi.hu")
    expect(recipe.canonical_url).to eq("https://www.aldi.hu/az-en-aldi-m/recipes/all/roze-kacsamell")
    expect(recipe.site_name).to eq("ALDI")
    expect(recipe.language).to eq("hu-HU")
    expect(recipe.author).to eq("HOFER")
    expect(recipe.description).to eq("Rozé kacsamell Rezept: ✓ Schnell & einfach ✓ Schritt-für-Schritt Anleitung von HOFER ➤ Jetzt zubereiten!")
    expect(recipe.image).to eq("https://www.aldi.hu/content/dam/aldi/emea/hu/editorial/recipes/migrated-assets/Article_1588161391657140.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to eq(120)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(90)
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
