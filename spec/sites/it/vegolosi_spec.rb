# frozen_string_literal: true

RSpec.describe "vegolosi.it" do
  subject(:recipe) { scrape_cassette("it/vegolosi", url: "https://www.vegolosi.it/ricette/gelato-vegan-al-cioccolato-con-anacardi/") }

  it "reads the title" do
    expect(recipe.title).to eq("Gelato vegano al cioccolato con anacardi")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "200 g di cioccolato fondente",
      "300 g di anacardi",
      "420 g di latte di mandorla",
      "200 g di sciroppo d’acero",
      "5 g di vaniglia in polvere",
      "50 g di cacao amaro in polvere",
      "2 g di gomma di tara",
      "robot ad immersione o un frullatore",
      "gelatiera"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 200.0, unit: "g", name: "cioccolato fondente" },
      { amount: 300.0, unit: "g", name: "anacardi" },
      { amount: 420.0, unit: "g", name: "latte di mandorla" },
      { amount: 200.0, unit: "g", name: "sciroppo d’acero" },
      { amount: 5.0, unit: "g", name: "vaniglia in polvere" },
      { amount: 50.0, unit: "g", name: "cacao amaro in polvere" },
      { amount: 2.0, unit: "g", name: "gomma di tara" },
      { amount: nil, unit: nil, name: "robot ad immersione o un frullatore" },
      { amount: nil, unit: nil, name: "gelatiera" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "I preparativi",
      "Tritate con la lama di un coltello il cioccolato fondente in modo da ottenere piccole scaglie di cioccolato che andrete a riporre in freezer per farle ben raffreddare.",
      "Frulliamo",
      "A parte, in un robot da cucina o frullatore, amalgamate gli altri ingredienti quindi gli anacardi, il latte di mandorla, lo sciroppo d’acero, la vaniglia e la gomma di tara.",
      "Frullate sino a ottenere una crema priva di grumi e molto omogenea. A questo punto aggiungete il cacao in polvere e date un’ultima frullata alla crema in modo da amalgamare anche quest’ultimo ingrediente.",
      "Raffreddiamo e aspettiamo",
      "Fate ora raffreddare il composto per circa 1 ora in frigorifero e poi versatelo nella gelatiera e, a seconda delle istruzioni della macchina, lavorate la crema per il tempo necessario a dargli volume e la giusta consistenza. Qualche minuto prima di terminare il gelato aggiungete le scaglie di cioccolato fondente.",
      "Procedimento senza gelatiera",
      "Nel caso non abbiate la gelatiera in casa il procedimento si allunga un po’, ma nulla di complicato: fate riposare la crema nel congelatore per circa 30 minuti; il composto andrà poi ripreso, lavorato nuovamente con un cucchiaio e riposto ancora nel congelatore a riposare. Questa operazione, che vi consigliamo di ripetere almeno 3 volte, è necessaria perché durante il processo di congelamento del gelato si formano dei cristalli di ghiaccio: rompendoli il gelato risulterà più morbido quando andremo ad assaggiarlo. Nell’ultima lavorazione aggiungete le scaglie di cioccolato fondente.",
      "Serviamo",
      "Estratto dalla gelatiera o dal freezer di casa dopo le 3 lavorazioni, potete servire il gelato immediatamente decorandolo con scaglie di cocco o altri anacardi spezzettati."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("I preparativi\nTritate con la lama di un coltello il cioccolato fondente in modo da ottenere piccole scaglie di cioccolato che andrete a riporre in freezer per farle ben raffreddare.\nFrulliamo\nA parte, in un robot da cucina o frullatore, amalgamate gli altri ingredienti quindi gli anacardi, il latte di mandorla, lo sciroppo d’acero, la vaniglia e la gomma di tara.\nFrullate sino a ottenere una crema priva di grumi e molto omogenea. A questo punto aggiungete il cacao in polvere e date un’ultima frullata alla crema in modo da amalgamare anche quest’ultimo ingrediente.\nRaffreddiamo e aspettiamo\nFate ora raffreddare il composto per circa 1 ora in frigorifero e poi versatelo nella gelatiera e, a seconda delle istruzioni della macchina, lavorate la crema per il tempo necessario a dargli volume e la giusta consistenza. Qualche minuto prima di terminare il gelato aggiungete le scaglie di cioccolato fondente.\nProcedimento senza gelatiera\nNel caso non abbiate la gelatiera in casa il procedimento si allunga un po’, ma nulla di complicato: fate riposare la crema nel congelatore per circa 30 minuti; il composto andrà poi ripreso, lavorato nuovamente con un cucchiaio e riposto ancora nel congelatore a riposare. Questa operazione, che vi consigliamo di ripetere almeno 3 volte, è necessaria perché durante il processo di congelamento del gelato si formano dei cristalli di ghiaccio: rompendoli il gelato risulterà più morbido quando andremo ad assaggiarlo. Nell’ultima lavorazione aggiungete le scaglie di cioccolato fondente.\nServiamo\nEstratto dalla gelatiera o dal freezer di casa dopo le 3 lavorazioni, potete servire il gelato immediatamente decorandolo con scaglie di cocco o altri anacardi spezzettati.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("vegolosi.it")
    expect(recipe.canonical_url).to eq("https://www.vegolosi.it/ricette-vegane/dolci-vegani/gelato-vegan/gelato-vegan-al-cioccolato-con-anacardi/")
    expect(recipe.site_name).to eq("Vegolosi")
    expect(recipe.language).to eq("it-IT")
    expect(recipe.author).to eq("Cristiano Bonolo")
    expect(recipe.description).to eq("Il gelato vegano al cioccolato con anacardi è un dessert goloso e fresco, amato da tutti e davvero irrinunciabile sia per rinfrescarsi nelle giornate di caldo estivo che come semplice dolce da servire a fine pasto per i più golosi.")
    expect(recipe.image).to eq("https://www.vegolosi.it/wp-content/uploads/2015/08/gelato-vegan-cioccolato_IMG_0442_650.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(75)
    expect(recipe.prep_time).to eq(75)
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
    expect(recipe.links).to include("#top")
  end
end
