# frozen_string_literal: true

RSpec.describe "hellofresh.be" do
  subject(:recipe) { scrape_cassette("be/hellofresh", url: "https://www.hellofresh.be/recipes/pikante-curry-met-kip-en-rijst-63f75f836d1f74727a153b90") }

  it "reads the title" do
    expect(recipe.title).to eq("Pikante curry met kip en rijst met paprika en verse koriander")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "150 gram Jasmijnrijst",
      "1 stuk(s) Paprika",
      "200 gram Kippendijreepjes",
      "180 ml Kokosmelk",
      "1 zakje(s) Afrikaanse kruidenmix",
      "10 gram Verse koriander",
      "50 gram Gesneden ui",
      "1 zakje(s) Gele currykruiden",
      "2.5 cm Verse gember",
      "2 stuk(s) Knoflookteen",
      "1 stuk(s) Rode peper",
      "1 pak(ken) Tomatenblokjes",
      "½ stuk(s) Zoutarm groentebouillonblokje",
      "1.5 el Zonnebloemolie",
      "1 tl Suiker",
      "naar smaak Peper en zout"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 150.0, unit: "gram", name: "Jasmijnrijst" },
      { amount: 1.0, unit: nil, name: "stuk Paprika" },
      { amount: 200.0, unit: "gram", name: "Kippendijreepjes" },
      { amount: 180.0, unit: "ml", name: "Kokosmelk" },
      { amount: 1.0, unit: "zakje", name: "Afrikaanse kruidenmix" },
      { amount: 10.0, unit: "gram", name: "Verse koriander" },
      { amount: 50.0, unit: "gram", name: "Gesneden ui" },
      { amount: 1.0, unit: "zakje", name: "Gele currykruiden" },
      { amount: 2.5, unit: "cm", name: "Verse gember" },
      { amount: 2.0, unit: nil, name: "stuk Knoflookteen" },
      { amount: 1.0, unit: nil, name: "stuk Rode peper" },
      { amount: 1.0, unit: nil, name: "pak Tomatenblokjes" },
      { amount: 0.5, unit: nil, name: "stuk Zoutarm groentebouillonblokje" },
      { amount: 1.5, unit: "el", name: "Zonnebloemolie" },
      { amount: 1.0, unit: "tl", name: "Suiker" },
      { amount: nil, unit: nil, name: "naar smaak Peper en zout" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Kook per persoon: 250 ml water met 1/4 bouillonblokje in een pot met deksel voor de rijst (zie Tip). Kook de rijst, afgedekt, 10 - 12 minuten in de pan met deksel. Meng in een kom de kippendijreepjes met de Afrikaanse kruiden en per persoon: 1/2 el zonnebloemolie, peper en zout. Laat marineren tot verder gebruik. Pers de knoflook of snijd fijn. Snijd de paprika in blokjes. Schil de gember en rasp of snijd fijn. Verwijder de zaadlijsten van de rode peper en snijd hem fijn. Tip: Wil je tijd besparen? Gebruik dan een waterkoker om snel kokend water te hebben. Let op: de rode peper is pikant! Houd je niet van pikant of eten er kinderen mee? Gebruik dan naar smaak minder rode peper of houd apart.",
      "Verhit 1/4 el zonnebloemolie per persoon in een grote sauteerpan op middelhoog vuur. Voeg de ui met de gele currykruiden toe en fruit 1 minuut. Voeg vervolgens de gemarineerde kippendijreepjes, paprika, rode peper, gember en knoflook toe en bak nog 4 - 6 minuten. (zie Tip) Tip: Heb je sojasaus in huis? Blus dan voor extra smaak de gebakken groenten en kip af met 1 tl sojasaus per persoon.",
      "Voeg vervolgens de tomatenblokjes, de kokosmelk en 1/2 tl suiker per persoon toe aan de groenten (zie Tip). Laat nog 3 - 4 minuten pruttelen en breng op smaak met peper en zout. Snijd ondertussen de koriander fijn. Tip: De kokosmelk kan klonterig worden. Dit betekent niet dat de melk niet meer goed is, de klontjes zijn de vetbestanddelen van de kokosmelk en zorgen voor een extra volle smaak.",
      "Verdeel de rijst over de borden. Verdeel de curry met kip over de rijst. Garneer met de koriander (zie Tip). Tip: Is niet iedereen liefhebber van koriander? Laat het dan achterwege of serveer apart zodat je de koriander zelf naar smaak kunt toevoegen. Weetje: Wist je dat tomaten uit blik bijna net zoveel vitaminen en mineralen bevatten als verse tomaten? In totaal bevat dit gerecht meer dan 300 gram groente, en dat voor een maaltijd die in 15 minuten op tafel staat."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Kook per persoon: 250 ml water met 1/4 bouillonblokje in een pot met deksel voor de rijst (zie Tip). Kook de rijst, afgedekt, 10 - 12 minuten in de pan met deksel. Meng in een kom de kippendijreepjes met de Afrikaanse kruiden en per persoon: 1/2 el zonnebloemolie, peper en zout. Laat marineren tot verder gebruik. Pers de knoflook of snijd fijn. Snijd de paprika in blokjes. Schil de gember en rasp of snijd fijn. Verwijder de zaadlijsten van de rode peper en snijd hem fijn. Tip: Wil je tijd besparen? Gebruik dan een waterkoker om snel kokend water te hebben. Let op: de rode peper is pikant! Houd je niet van pikant of eten er kinderen mee? Gebruik dan naar smaak minder rode peper of houd apart.\nVerhit 1/4 el zonnebloemolie per persoon in een grote sauteerpan op middelhoog vuur. Voeg de ui met de gele currykruiden toe en fruit 1 minuut. Voeg vervolgens de gemarineerde kippendijreepjes, paprika, rode peper, gember en knoflook toe en bak nog 4 - 6 minuten. (zie Tip) Tip: Heb je sojasaus in huis? Blus dan voor extra smaak de gebakken groenten en kip af met 1 tl sojasaus per persoon.\nVoeg vervolgens de tomatenblokjes, de kokosmelk en 1/2 tl suiker per persoon toe aan de groenten (zie Tip). Laat nog 3 - 4 minuten pruttelen en breng op smaak met peper en zout. Snijd ondertussen de koriander fijn. Tip: De kokosmelk kan klonterig worden. Dit betekent niet dat de melk niet meer goed is, de klontjes zijn de vetbestanddelen van de kokosmelk en zorgen voor een extra volle smaak.\nVerdeel de rijst over de borden. Verdeel de curry met kip over de rijst. Garneer met de koriander (zie Tip). Tip: Is niet iedereen liefhebber van koriander? Laat het dan achterwege of serveer apart zodat je de koriander zelf naar smaak kunt toevoegen. Weetje: Wist je dat tomaten uit blik bijna net zoveel vitaminen en mineralen bevatten als verse tomaten? In totaal bevat dit gerecht meer dan 300 gram groente, en dat voor een maaltijd die in 15 minuten op tafel staat.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hellofresh.be")
    expect(recipe.canonical_url).to eq("https://www.hellofresh.be/recipes/pikante-curry-met-kip-en-rijst-63f75f836d1f74727a153b90")
    expect(recipe.site_name).to eq("HelloFresh")
    expect(recipe.language).to eq("nl-BE")
    expect(recipe.author).to eq("HelloFresh")
    expect(recipe.description).to eq("Kippendij wordt gezien als het smaakvolste stukje van de kip. In dit recept is het alvast voorgesneden, waardoor je deze curry al binnen 15 minuten op tafel zet!")
    expect(recipe.image).to eq("https://img.hellofresh.com/f_auto,fl_lossy,h_640,q_auto,w_1200/hellofresh_s3/image/HF210330_R51_W16_NL_MB_Main_express_background_low-1cf76dd1.jpg")
    expect(recipe.category).to eq("Hoofdgerecht")
    expect(recipe.cuisine).to eq("Indiase")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(15)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.217141082689735)
    expect(recipe.ratings_count).to eq(1651)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "797 kcal",
      "fatContent" => "37 g",
      "saturatedFatContent" => "19.5 g",
      "carbohydrateContent" => "83.9 g",
      "sugarContent" => "16 g",
      "proteinContent" => "28.6 g",
      "fiberContent" => "7.2 g",
      "sodiumContent" => "2.6 g",
      "servingSize" => "617"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 797.0 },
      { name: "fatContent", unit: "g", amount: 37.0 },
      { name: "saturatedFatContent", unit: "g", amount: 19.5 },
      { name: "carbohydrateContent", unit: "g", amount: 83.9 },
      { name: "sugarContent", unit: "g", amount: 16.0 },
      { name: "proteinContent", unit: "g", amount: 28.6 },
      { name: "fiberContent", unit: "g", amount: 7.2 },
      { name: "sodiumContent", unit: "g", amount: 2.6 },
      { name: "servingSize", unit: nil, amount: 617.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#page")
  end
end
