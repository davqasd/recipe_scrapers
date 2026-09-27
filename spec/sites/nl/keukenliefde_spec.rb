# frozen_string_literal: true

RSpec.describe "keukenliefde.nl" do
  subject(:recipe) { scrape_cassette("nl/keukenliefde", url: "https://www.keukenliefde.nl/recepten/mexicaanse-wraps-met-gehakt-en-groenten/") }

  it "reads the title" do
    expect(recipe.title).to eq("Mexicaanse wraps met gehakt")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 grote ui, fijngesnipperd",
      "2 tenen knoflook, uitgeperst",
      "1/2 rode peper, fijngehakt",
      "400 g rundergehakt",
      "2 rode paprika’s, in kleine blokjes",
      "150 g maïs, uitgelekt",
      "240 g kidneybonen, uitgelekt",
      "1 blik tomatenblokjes op sap",
      "2 el Mexicaanse kruidenmix, gekocht of zelfgemaakt",
      "6 grote tortillawraps",
      "125 g crème fraîche",
      "100 g geraspte belegen kaas",
      "Paar takjes peterselie of koriander, fijngehakt",
      "Olie, om in te bakken en de ovenschaal in te vetten"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "grote ui, fijngesnipperd" },
      { amount: 2.0, unit: nil, name: "tenen knoflook, uitgeperst" },
      { amount: 0.5, unit: nil, name: "rode peper, fijngehakt" },
      { amount: 400.0, unit: "g", name: "rundergehakt" },
      { amount: 2.0, unit: nil, name: "rode paprika’s, in kleine blokjes" },
      { amount: 150.0, unit: "g", name: "maïs, uitgelekt" },
      { amount: 240.0, unit: "g", name: "kidneybonen, uitgelekt" },
      { amount: 1.0, unit: "blik", name: "tomatenblokjes op sap" },
      { amount: 2.0, unit: "el", name: "Mexicaanse kruidenmix, gekocht of zelfgemaakt" },
      { amount: 6.0, unit: nil, name: "grote tortillawraps" },
      { amount: 125.0, unit: "g", name: "crème fraîche" },
      { amount: 100.0, unit: "g", name: "geraspte belegen kaas" },
      { amount: nil, unit: nil, name: "Paar takjes peterselie of koriander, fijngehakt" },
      { amount: nil, unit: nil, name: "Olie, om in te bakken en de ovenschaal in te vetten" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Oven voorverwarmen",
      "Verwarm de oven voor op 200 graden en vet een ovenschaal in. Verdeel 2 eetlepels tomatensap uit het blik over de bodem van de schaal.",
      "Ui en knoflook bakken",
      "Verhit een scheutje olie in een koekenpan en bak de ui, knoflook en rode peper 2 minuten op laag vuur, tot de ui zacht is.",
      "Gehakt rolbakken",
      "Voeg het gehakt en de kruidenmix toe en bak rul op middelhoog vuur.",
      "Groenten toevoegen",
      "Schep de paprika erdoor en bak 3 minuten mee. Voeg daarna de maïs, kidneybonen en tomatenblokjes toe. Houd 3 eetlepels van de tomatenblokjes apart voor over de wraps.",
      "Even laten pruttelen",
      "Laat het mengsel 5 tot 8 minuten zacht pruttelen, tot de paprika wat zachter is en de saus iets is ingedikt.",
      "Wraps vullen",
      "Verdeel de vulling over de wraps, rol ze stevig op en leg ze naast elkaar in de ovenschaal.",
      "Afmaken",
      "Bestrijk de wraps met crème fraîche en lepel de achtergehouden tomatenblokjes erover. Bestrooi met geraspte kaas.",
      "In de oven",
      "Bak de wraps 15 minuten in het midden van de oven, tot de kaas goudbruin is.",
      "Serveren",
      "Bestrooi voor serveren met peterselie of koriander. Serveer met guacamole, tomatensalsa en eventueel zure room."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Oven voorverwarmen\nVerwarm de oven voor op 200 graden en vet een ovenschaal in. Verdeel 2 eetlepels tomatensap uit het blik over de bodem van de schaal.\nUi en knoflook bakken\nVerhit een scheutje olie in een koekenpan en bak de ui, knoflook en rode peper 2 minuten op laag vuur, tot de ui zacht is.\nGehakt rolbakken\nVoeg het gehakt en de kruidenmix toe en bak rul op middelhoog vuur.\nGroenten toevoegen\nSchep de paprika erdoor en bak 3 minuten mee. Voeg daarna de maïs, kidneybonen en tomatenblokjes toe. Houd 3 eetlepels van de tomatenblokjes apart voor over de wraps.\nEven laten pruttelen\nLaat het mengsel 5 tot 8 minuten zacht pruttelen, tot de paprika wat zachter is en de saus iets is ingedikt.\nWraps vullen\nVerdeel de vulling over de wraps, rol ze stevig op en leg ze naast elkaar in de ovenschaal.\nAfmaken\nBestrijk de wraps met crème fraîche en lepel de achtergehouden tomatenblokjes erover. Bestrooi met geraspte kaas.\nIn de oven\nBak de wraps 15 minuten in het midden van de oven, tot de kaas goudbruin is.\nServeren\nBestrooi voor serveren met peterselie of koriander. Serveer met guacamole, tomatensalsa en eventueel zure room.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("keukenliefde.nl")
    expect(recipe.canonical_url).to eq("https://www.keukenliefde.nl/recepten/mexicaanse-wraps-met-gehakt-en-groenten/")
    expect(recipe.site_name).to eq("KeukenLiefde")
    expect(recipe.language).to eq("nl-NL")
    expect(recipe.author).to eq("Annemiek Verweij")
    expect(recipe.description).to eq("Mexicaanse wraps met gehakt, daar word ik altijd blij van: heerlijk kruidig, smeuïg en echt zo’n ovengerecht waar iedereen nog een tweede portie van wil. Je vult de wraps met kruidig gehakt, paprika, maïs, kidneybonen en tomatenblokjes, rolt ze op en gratineert ze met crème fraîche en kaas in de oven. Mexicaanse kruidenmixIk gebruik hiervoor...")
    expect(recipe.image).to eq("https://www.keukenliefde.nl/app/uploads/2021/03/Mexicaanse-wraps-met-gehakt-9838-3.jpg")
    expect(recipe.category).to eq("Hoofdgerecht")
    expect(recipe.cuisine).to eq("Mexicaans")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.0)
    expect(recipe.ratings_count).to eq(27)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#start")
  end
end
