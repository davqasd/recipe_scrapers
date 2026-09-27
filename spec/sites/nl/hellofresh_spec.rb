# frozen_string_literal: true

RSpec.describe "hellofresh.nl" do
  subject(:recipe) { scrape_cassette("nl/hellofresh", url: "https://www.hellofresh.nl/recipes/pasta-met-geroosterde-paprikasaus-en-geitenkaas-6229e608e697d4651c2103c4") }

  it "reads the title" do
    expect(recipe.title).to eq("Pasta met geroosterde-paprikasaus en geitenkaas met courgette en vers basilicum")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 stuk(s) Paprika",
      "1 stuk(s) Courgette",
      "1 zakje(s) Italiaanse kruiden",
      "1 stuk(s) Knoflookteen",
      "1 stuk(s) Rode ui",
      "5 gram Vers basilicum",
      "100 gram Verse geitenkaas",
      "180 gram Spaghetti",
      "200 gram Passata",
      "2 el Olijfolie",
      "naar smaak Peper en zout",
      "2 tl Zwarte balsamicoazijn"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "stuk Paprika" },
      { amount: 1.0, unit: nil, name: "stuk Courgette" },
      { amount: 1.0, unit: "zakje", name: "Italiaanse kruiden" },
      { amount: 1.0, unit: nil, name: "stuk Knoflookteen" },
      { amount: 1.0, unit: nil, name: "stuk Rode ui" },
      { amount: 5.0, unit: "gram", name: "Vers basilicum" },
      { amount: 100.0, unit: "gram", name: "Verse geitenkaas" },
      { amount: 180.0, unit: "gram", name: "Spaghetti" },
      { amount: 200.0, unit: "gram", name: "Passata" },
      { amount: 2.0, unit: "el", name: "Olijfolie" },
      { amount: nil, unit: nil, name: "naar smaak Peper en zout" },
      { amount: 2.0, unit: "tl", name: "Zwarte balsamicoazijn" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Verwarm de oven voor op 220 graden. Snijd de paprika in kwarten en verwijder de zaadlijsten. Snijd de courgette in de lengte in kwarten en daarna in blokjes. Meng op een bakplaat met bakpapier de paprika en courgette met per persoon: 1/2 el olijfolie en 1/2 tl Italiaanse kruiden. Dek losjes af met aluminiumfolie en rooster de groenten 25 - 30 minuten in de oven. Verwijder de aluminiumfolie de laatste 10 minuten.",
      "Breng ruim water aan de kook in een pan met deksel voor de spaghetti. Pers ondertussen de knoflook of snijd fijn en snipper de kleine rode ui. Hak het basilicum grof. Verkruimel de geitenkaas.",
      "Kook de spaghetti, afgedekt, in 10 – 12 minuten gaar. Giet af en laat uitstomen zonder deksel. Verhit 1/2 el olijfolie per persoon in een hapjespan op middelhoog vuur. Fruit de knoflook, rode ui en 1 tl Italiaanse kruiden per persoon 2 minuten. Blus af met per persoon: 1 tl zwarte balsamicoazijn, 2 el water en de passata. Verlaag het vuur en laat 6 – 8 minuten zachtjes pruttelen.",
      "Voeg alleen de geroosterde paprika toe aan een hoge kom en pureer met een staafmixer tot een gladde saus. Voeg de geroosterde courgette en de gepureerde paprika toe aan de hapjespan met passata. Breng op smaak met peper en zout en laat nog 4 - 6 minuten pruttelen op middelmatig vuur.Tip: Paprika is rijk aan vitamine E. Deze antioxidant beschermt tegen schadelijke invloeden van buitenaf, zoals vrije radicalen afkomstig van bijvoorbeeld UV-straling of luchtvervuiling.",
      "Meng de spaghetti door de paprikasaus.",
      "Verdeel de spaghetti over de borden. Verdeel de geitenkaas erover en garneer het geheel met het basilicum."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Verwarm de oven voor op 220 graden. Snijd de paprika in kwarten en verwijder de zaadlijsten. Snijd de courgette in de lengte in kwarten en daarna in blokjes. Meng op een bakplaat met bakpapier de paprika en courgette met per persoon: 1/2 el olijfolie en 1/2 tl Italiaanse kruiden. Dek losjes af met aluminiumfolie en rooster de groenten 25 - 30 minuten in de oven. Verwijder de aluminiumfolie de laatste 10 minuten.\nBreng ruim water aan de kook in een pan met deksel voor de spaghetti. Pers ondertussen de knoflook of snijd fijn en snipper de kleine rode ui. Hak het basilicum grof. Verkruimel de geitenkaas.\nKook de spaghetti, afgedekt, in 10 – 12 minuten gaar. Giet af en laat uitstomen zonder deksel. Verhit 1/2 el olijfolie per persoon in een hapjespan op middelhoog vuur. Fruit de knoflook, rode ui en 1 tl Italiaanse kruiden per persoon 2 minuten. Blus af met per persoon: 1 tl zwarte balsamicoazijn, 2 el water en de passata. Verlaag het vuur en laat 6 – 8 minuten zachtjes pruttelen.\nVoeg alleen de geroosterde paprika toe aan een hoge kom en pureer met een staafmixer tot een gladde saus. Voeg de geroosterde courgette en de gepureerde paprika toe aan de hapjespan met passata. Breng op smaak met peper en zout en laat nog 4 - 6 minuten pruttelen op middelmatig vuur.Tip: Paprika is rijk aan vitamine E. Deze antioxidant beschermt tegen schadelijke invloeden van buitenaf, zoals vrije radicalen afkomstig van bijvoorbeeld UV-straling of luchtvervuiling.\nMeng de spaghetti door de paprikasaus.\nVerdeel de spaghetti over de borden. Verdeel de geitenkaas erover en garneer het geheel met het basilicum.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hellofresh.nl")
    expect(recipe.canonical_url).to eq("https://www.hellofresh.nl/recipes/pasta-met-geroosterde-paprikasaus-en-geitenkaas-6229e608e697d4651c2103c4")
    expect(recipe.site_name).to eq("HelloFresh")
    expect(recipe.language).to eq("nl-NL")
    expect(recipe.author).to eq("HelloFresh")
    expect(recipe.description).to eq("De paprika in dit recept zorgt voor een enorme boost aan vitamine C!")
    expect(recipe.image).to eq("https://img.hellofresh.com/f_auto,fl_lossy,h_640,q_auto,w_1200/hellofresh_s3/image/pates-en-sauce-aux-poivrons-rotis-et-fromage-de-chevre-7a0aec60-7a6032de.jpg")
    expect(recipe.category).to eq("Hoofdgerecht")
    expect(recipe.cuisine).to eq("Mediterranean")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(50)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.250090321518698)
    expect(recipe.ratings_count).to eq(11_073)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "683 kcal",
      "fatContent" => "25 g",
      "saturatedFatContent" => "11 g",
      "carbohydrateContent" => "86 g",
      "sugarContent" => "19 g",
      "proteinContent" => "25 g",
      "fiberContent" => "11.5 g",
      "sodiumContent" => "1 g",
      "servingSize" => "555"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 683.0 },
      { name: "fatContent", unit: "g", amount: 25.0 },
      { name: "saturatedFatContent", unit: "g", amount: 11.0 },
      { name: "carbohydrateContent", unit: "g", amount: 86.0 },
      { name: "sugarContent", unit: "g", amount: 19.0 },
      { name: "proteinContent", unit: "g", amount: 25.0 },
      { name: "fiberContent", unit: "g", amount: 11.5 },
      { name: "sodiumContent", unit: "g", amount: 1.0 },
      { name: "servingSize", unit: nil, amount: 555.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#page")
  end
end
