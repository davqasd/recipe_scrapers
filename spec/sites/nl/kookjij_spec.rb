# frozen_string_literal: true

RSpec.describe "kookjij.nl" do
  subject(:recipe) { scrape_cassette("nl/kookjij", url: "https://www.kookjij.nl/recepten/fesenjan/") }

  it "reads the title" do
    expect(recipe.title).to eq("Fesenjan")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "kipfilet",
      "granaatappel juice",
      "verse granaatappels",
      "halfgedroogde pruimen",
      "uien",
      "boter",
      "olijfolie",
      "2 koffiekoppen halve walnoten",
      "suiker/oersuiker/palmsuiker",
      "kaneel",
      "nootmuskaat",
      "zwarte peper",
      "kipfond of -bouillon",
      "kurkuma",
      "naar behoefte rode pepers/piripiri/cayennepeper",
      "zeezout",
      "gedroogde citroen",
      "ben je een liefhebber van koriander dan de steeltjes eraf halen en fijnchoppen. De blaadjes apart houden."
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "kipfilet" },
      { amount: nil, unit: nil, name: "granaatappel juice" },
      { amount: nil, unit: nil, name: "verse granaatappels" },
      { amount: nil, unit: nil, name: "halfgedroogde pruimen" },
      { amount: nil, unit: nil, name: "uien" },
      { amount: nil, unit: nil, name: "boter" },
      { amount: nil, unit: nil, name: "olijfolie" },
      { amount: 2.0, unit: nil, name: "koffiekoppen halve walnoten" },
      { amount: nil, unit: nil, name: "suiker/oersuiker/palmsuiker" },
      { amount: nil, unit: nil, name: "kaneel" },
      { amount: nil, unit: nil, name: "nootmuskaat" },
      { amount: nil, unit: nil, name: "zwarte peper" },
      { amount: nil, unit: nil, name: "kipfond of -bouillon" },
      { amount: nil, unit: nil, name: "kurkuma" },
      { amount: nil, unit: nil, name: "naar behoefte rode pepers/piripiri/cayennepeper" },
      { amount: nil, unit: nil, name: "zeezout" },
      { amount: nil, unit: nil, name: "gedroogde citroen" },
      { amount: nil, unit: nil, name: "ben je een liefhebber van koriander dan de steeltjes eraf halen en fijnchoppen. De blaadjes apart houden." }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Hoeveelheden heb ik niet aangegeven behalve bij de walnoten.",
      "Op gevoel afgaan is mijn advies qua hoeveelheden. Zelf werk ik ook altijd zo.",
      "De walnoten moet je toasten in een beetje olie maar…",
      "De walnoten moet je toasten in een beetje olie maar beter nog zonder maar dan de hele tijd in beweging houden maar je kan ze ook op bakpapier roasten in de oven. Vervolgens in de blender tot gort malen.",
      "Boter en olijfolie matig verhitten en de zo dun mogelijk…",
      "Boter en olijfolie matig verhitten en de zo dun mogelijk gesneden kipfilets aanbakken. Tijdens het bakken en omkeren zeezout toevoegen.",
      "Haal de kipfilets uit de pan als ze bruin zijn…",
      "Haal de kipfilets uit de pan als ze bruin zijn aangebakken en leg op een bord.",
      "Laat het vet in de pan en voeg een klont…",
      "Laat het vet in de pan en voeg een klont boter toe om vervolgens ui en eventueel knoflook tot alles glazig is. Hou het vuur medium dus geen vlugvlugvuurhoog.",
      "Doe de kip weer terug in de pan bij de…",
      "Doe de kip weer terug in de pan bij de uien en laat 30 minuten sudderen samen met pruimen. Dan kruiden toevoegen alsook granaatappeljuice en pitten en eventueel suiker. En natuurlijk de walnoten, een scheut granaatappeljuice en -zaden.",
      "Optioneel zijn de korianderstelen.Op heel zacht vuur 1.5 uur laten…",
      "Optioneel zijn de korianderstelen.Op heel zacht vuur 1.5 uur laten sudderen. Het geheel mag niet blubbelen want dan gaat het te hard. Hoe langzamer hoe beter is hier het motto. Het is meer garen bij een temperatuur van 100 graden of minder.",
      "Het geheel indikken met Kurzu of roux van tammekastanjemeel of…",
      "Het geheel indikken met Kurzu of roux van tammekastanjemeel of ander indikmiddel. Liever geen maizena na al dit moois."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Hoeveelheden heb ik niet aangegeven behalve bij de walnoten.\nOp gevoel afgaan is mijn advies qua hoeveelheden. Zelf werk ik ook altijd zo.\nDe walnoten moet je toasten in een beetje olie maar…\nDe walnoten moet je toasten in een beetje olie maar beter nog zonder maar dan de hele tijd in beweging houden maar je kan ze ook op bakpapier roasten in de oven. Vervolgens in de blender tot gort malen.\nBoter en olijfolie matig verhitten en de zo dun mogelijk…\nBoter en olijfolie matig verhitten en de zo dun mogelijk gesneden kipfilets aanbakken. Tijdens het bakken en omkeren zeezout toevoegen.\nHaal de kipfilets uit de pan als ze bruin zijn…\nHaal de kipfilets uit de pan als ze bruin zijn aangebakken en leg op een bord.\nLaat het vet in de pan en voeg een klont…\nLaat het vet in de pan en voeg een klont boter toe om vervolgens ui en eventueel knoflook tot alles glazig is. Hou het vuur medium dus geen vlugvlugvuurhoog.\nDoe de kip weer terug in de pan bij de…\nDoe de kip weer terug in de pan bij de uien en laat 30 minuten sudderen samen met pruimen. Dan kruiden toevoegen alsook granaatappeljuice en pitten en eventueel suiker. En natuurlijk de walnoten, een scheut granaatappeljuice en -zaden.\nOptioneel zijn de korianderstelen.Op heel zacht vuur 1.5 uur laten…\nOptioneel zijn de korianderstelen.Op heel zacht vuur 1.5 uur laten sudderen. Het geheel mag niet blubbelen want dan gaat het te hard. Hoe langzamer hoe beter is hier het motto. Het is meer garen bij een temperatuur van 100 graden of minder.\nHet geheel indikken met Kurzu of roux van tammekastanjemeel of…\nHet geheel indikken met Kurzu of roux van tammekastanjemeel of ander indikmiddel. Liever geen maizena na al dit moois.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("kookjij.nl")
    expect(recipe.canonical_url).to eq("https://www.kookjij.nl/recepten/fesenjan/")
    expect(recipe.site_name).to eq("KookJij - De recepten website")
    expect(recipe.language).to eq("nl-NL")
    expect(recipe.author).to eq("henryk")
    expect(recipe.description).to eq("Fesenjan is een beproefd recept van KookJij. Je maakt het in ongeveer 30 minuten, genoeg voor 4 personen. Belangrijkste ingrediënten: kipfilet, granaatappel …")
    expect(recipe.image).to eq("https://www.kookjij.nl/wp-content/uploads/2013/12/Fesenjan-1200x1122.jpg")
    expect(recipe.category).to eq("Avondeten & hoofdgerechten, Kip & gevogelte, Stoofschotels")
    expect(recipe.cuisine).to eq("Wereldkeuken")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(%w[Iran pittig])
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
    expect(recipe.links).to include("#kj-content")
  end
end
