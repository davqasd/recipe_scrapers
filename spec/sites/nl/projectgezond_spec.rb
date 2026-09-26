# frozen_string_literal: true

RSpec.describe "projectgezond.nl" do
  subject(:recipe) { scrape_cassette("nl/projectgezond", url: "https://www.projectgezond.nl/recepten/boeuf-bourguignon") }

  it "reads the title" do
    expect(recipe.title).to eq("Boeuf bourguignon")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "40 gr ontbijtspek",
      "250 gr runderriblappen",
      "10 gr bloem",
      "1 ui",
      "150 gr winterpeen",
      "1 teentje knoflook",
      "35 gr tomatenpuree",
      "100 ml rode wijn",
      "200 ml runderbouillon",
      "1 laurierblaadje",
      "1 takje tijm",
      "1 kruidnagel",
      "150 gr champignons",
      "50 gr zilveruitjes"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 40.0, unit: "gr", name: "ontbijtspek" },
      { amount: 250.0, unit: "gr", name: "runderriblappen" },
      { amount: 10.0, unit: "gr", name: "bloem" },
      { amount: 1.0, unit: nil, name: "ui" },
      { amount: 150.0, unit: "gr", name: "winterpeen" },
      { amount: 1.0, unit: "teentje", name: "knoflook" },
      { amount: 35.0, unit: "gr", name: "tomatenpuree" },
      { amount: 100.0, unit: "ml", name: "rode wijn" },
      { amount: 200.0, unit: "ml", name: "runderbouillon" },
      { amount: 1.0, unit: nil, name: "laurierblaadje" },
      { amount: 1.0, unit: "takje", name: "tijm" },
      { amount: 1.0, unit: nil, name: "kruidnagel" },
      { amount: 150.0, unit: "gr", name: "champignons" },
      { amount: 50.0, unit: "gr", name: "zilveruitjes" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Bak de plakken ontbijtspek bruin en licht krokant in een droge (stoof)pan. Haal uit de pan en zorg dat het bakvet achterblijft.",
      "Snijd de runderriblappen in blokjes van 2 bij 2 centimeter. Bestrooi met peper, zout en de bloem. Schep om tot alles goed verdeeld is.",
      "Snijd de ui in halve ringen en de winterpeen in plakken.",
      "Hak de knoflook fijn.",
      "Verwarm de pan waar het ontbijtspek in gebakken is opnieuw. Bak de riblappen op hoog vuur rondom bruin.",
      "Gebruik indien nodig een klein beetje boter of olijfolie.",
      "Voeg de ui en winterpeen toe en bak enkele minuten mee met de blokjes vlees.",
      "Zet het vuur lager en voeg de knoflook toe. Bak 1 à 2 minuten mee. Voeg de tomatenpuree toe. Roer los en bak 2 à 3 minuten mee.",
      "Blus af met de rode wijn. Roer eventuele aanbaksels los van de bodem. Laat de wijn grotendeels verdampen.",
      "Voeg de runderbouillon, het laurierblaadje, het takje tijm en de kruidnagel toe.",
      "Snijd de plakken ontbijtspek in stukjes en voeg toe.",
      "Laat het gerecht ongeveer 2 uur stoven met de deksel op de pan.",
      "Boen de champignons schoon en snijd ze in kwarten.",
      "Snijd de zilveruitjes doormidden.",
      "Voeg de champignons en de zilveruitjes toe.",
      "Laat alles nog minimaal 30 minuten stoven. Doe dit eventueel zonder deksel op de pan, zodat de boeuf bourguignon wat verder inkookt.",
      "Haal het laurierblaadje, het takje tijm en de kruidnagel uit de pan."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Bak de plakken ontbijtspek bruin en licht krokant in een droge (stoof)pan. Haal uit de pan en zorg dat het bakvet achterblijft.\nSnijd de runderriblappen in blokjes van 2 bij 2 centimeter. Bestrooi met peper, zout en de bloem. Schep om tot alles goed verdeeld is.\nSnijd de ui in halve ringen en de winterpeen in plakken.\nHak de knoflook fijn.\nVerwarm de pan waar het ontbijtspek in gebakken is opnieuw. Bak de riblappen op hoog vuur rondom bruin.\nGebruik indien nodig een klein beetje boter of olijfolie.\nVoeg de ui en winterpeen toe en bak enkele minuten mee met de blokjes vlees.\nZet het vuur lager en voeg de knoflook toe. Bak 1 à 2 minuten mee. Voeg de tomatenpuree toe. Roer los en bak 2 à 3 minuten mee.\nBlus af met de rode wijn. Roer eventuele aanbaksels los van de bodem. Laat de wijn grotendeels verdampen.\nVoeg de runderbouillon, het laurierblaadje, het takje tijm en de kruidnagel toe.\nSnijd de plakken ontbijtspek in stukjes en voeg toe.\nLaat het gerecht ongeveer 2 uur stoven met de deksel op de pan.\nBoen de champignons schoon en snijd ze in kwarten.\nSnijd de zilveruitjes doormidden.\nVoeg de champignons en de zilveruitjes toe.\nLaat alles nog minimaal 30 minuten stoven. Doe dit eventueel zonder deksel op de pan, zodat de boeuf bourguignon wat verder inkookt.\nHaal het laurierblaadje, het takje tijm en de kruidnagel uit de pan.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("projectgezond.nl")
    expect(recipe.canonical_url).to eq("https://www.projectgezond.nl/recepten/boeuf-bourguignon")
    expect(recipe.site_name).to eq("Project Gezond")
    expect(recipe.language).to eq("nl-NL")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Wist je dat dit recept ook te vinden is in ons bestseller kookboek ‘Altijd lekker’? In dit boek vind je een selectie van 100 populaire recepten uit ons online afslankprogramma. Benieuwd naar alle recepten uit dit boek? Bekijk dan deze pagina. Deze klassieker vindt zijn oorsprong in de Franse keuken. ‘Rund op bourgondische wijze’ is een vertaling van ‘Boeuf bourguignon’ die niets aan de verbeelding overlaat. Dit recept is dan ook het perfecte antwoord als het weer tijd is voor een potje stoof! Want het is verre van moeilijk om deze ultieme stoofpot te bereiden. Je hebt enkel wat (wacht)tijd en dus geduld nodig. Het is helemaal geen gek idee dat je dit recept al de dag van tevoren klaarmaakt trouwens. De smaken kunnen dan zelfs nog beter intrekken. Als dat geen ‘Boeuf bourguignon’ wordt…")
    expect(recipe.image).to eq("https://www.projectgezond.nl/content/uploads/2021/11/BoeufBourguignon-scaled-1.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(150)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "428 Kcal",
      "proteinContent" => "33 gram Eiwitten",
      "carbohydrateContent" => "21 gram Koolhydraten",
      "fatContent" => "19 gram Vet",
      "fiberContent" => "8 gram Vezels"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 428.0 },
      { name: "proteinContent", unit: "g", amount: 33.0 },
      { name: "carbohydrateContent", unit: "g", amount: 21.0 },
      { name: "fatContent", unit: "g", amount: 19.0 },
      { name: "fiberContent", unit: "g", amount: 8.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.projectgezond.nl/wereld")
  end
end
