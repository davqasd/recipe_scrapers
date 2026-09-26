# frozen_string_literal: true

RSpec.describe "matprat.no" do
  subject(:recipe) { scrape_cassette("no/matprat", url: "https://www.matprat.no/oppskrifter/gjester/butter-chicken---indisk-smorkylling/") }

  it "reads the title" do
    expect(recipe.title).to eq("Butter chicken - indisk smørkylling")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 stk. kylling (ca. 1300 g)",
      "4 båter hvitløk",
      "0,5 ss revet frisk ingefær",
      "2 ss sitronsaft",
      "1 dl gresk yoghurt",
      "0,5 ss chilipulver (helst indisk)",
      "1 ss garam masala",
      "1 ss rapsolje eller sennepsolje",
      "100 g cashewnøtter",
      "8 stk. tomat",
      "2 ss nøytral olje",
      "4 båter finhakket hvitløk",
      "0,5 ss revet frisk ingefær",
      "0,5 ss chilipulver (helst indisk)",
      "2 stk. hel kardemomme",
      "2 ts hel bukkehornkløver",
      "2 ss honning",
      "1 stk. grønn chili",
      "2 ss smør",
      "1 dl kremfløte eller matfløte",
      "0,5 potte frisk koriander"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "stk", name: "kylling" },
      { amount: 4.0, unit: "båter", name: "hvitløk" },
      { amount: 0.5, unit: "ss", name: "revet frisk ingefær" },
      { amount: 2.0, unit: "ss", name: "sitronsaft" },
      { amount: 1.0, unit: "dl", name: "gresk yoghurt" },
      { amount: 0.5, unit: "ss", name: "chilipulver" },
      { amount: 1.0, unit: "ss", name: "garam masala" },
      { amount: 1.0, unit: "ss", name: "rapsolje eller sennepsolje" },
      { amount: 100.0, unit: "g", name: "cashewnøtter" },
      { amount: 8.0, unit: "stk", name: "tomat" },
      { amount: 2.0, unit: "ss", name: "nøytral olje" },
      { amount: 4.0, unit: "båter", name: "finhakket hvitløk" },
      { amount: 0.5, unit: "ss", name: "revet frisk ingefær" },
      { amount: 0.5, unit: "ss", name: "chilipulver" },
      { amount: 2.0, unit: "stk", name: "hel kardemomme" },
      { amount: 2.0, unit: "ts", name: "hel bukkehornkløver" },
      { amount: 2.0, unit: "ss", name: "honning" },
      { amount: 1.0, unit: "stk", name: "grønn chili" },
      { amount: 2.0, unit: "ss", name: "smør" },
      { amount: 1.0, unit: "dl", name: "kremfløte eller matfløte" },
      { amount: 0.5, unit: "potte", name: "frisk koriander" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Fjern skinnet på kyllingen og tørk den godt. Kutt dype snitt i kjøttet på hele kyllingen. Finhakk hvitløk og bland med revet ingefær og sitronsaft, og gni kyllingen godt inn med blandingen. Dryss over litt salt. Sett kaldt i 20 minutter.",
      "Bland sammen chilipulver, garam masala, olje og yoghurt. Tørk kyllingen med litt kjøkkenpapir og gni den godt inn med yoghurtblandingen. Plasser kyllingen på et fat og sett den kaldt i minst 4-6 timer, helst over natten.",
      "Stek kyllingen midt i stekeovnen ved 200 °C, eller grill den til den er gyllenbrun og gjennomstekt, ca. 50 min. - 1 time.",
      "Avkjøl og plukk kjøttet av beina i store biter.",
      "Lag smør- og tomatcurry: Bløtlegg cashewnøtter i litt lunkent vann i minst 30 minutter. Hell av vannet og mos nøttene i hurtigmikser eller med stavmikser. Sett til side.",
      "Del tomater i biter. Varm en sauteringspanne med olje og fres tomater, hvitløk, ingefær, chilipulver, kardemomme og bukkehornkløver på middels varme til tomatene er helt myke.",
      "Tilsett cashewpuré og bruk stavmikser eller hurtigmikser til å finmose sausen. Sil gjerne sausen gjennom en grov sikt for å få ut rester av skall, hvis du vil ha den ekstra fin.",
      "Ha sausen tilbake i kjelen og la den småkoke i i noen minutter. Smak til med honning, finhakket grønn chili, salt og pepper. Visp inn fløte og romtemperert smør i den varme sausen.",
      "Legg kyllingbitene i sausen og la alt bli gjennomvarmt. Pynt med koriander."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Fjern skinnet på kyllingen og tørk den godt. Kutt dype snitt i kjøttet på hele kyllingen. Finhakk hvitløk og bland med revet ingefær og sitronsaft, og gni kyllingen godt inn med blandingen. Dryss over litt salt. Sett kaldt i 20 minutter.\nBland sammen chilipulver, garam masala, olje og yoghurt. Tørk kyllingen med litt kjøkkenpapir og gni den godt inn med yoghurtblandingen. Plasser kyllingen på et fat og sett den kaldt i minst 4-6 timer, helst over natten.\nStek kyllingen midt i stekeovnen ved 200 °C, eller grill den til den er gyllenbrun og gjennomstekt, ca. 50 min. - 1 time.\nAvkjøl og plukk kjøttet av beina i store biter.\nLag smør- og tomatcurry: Bløtlegg cashewnøtter i litt lunkent vann i minst 30 minutter. Hell av vannet og mos nøttene i hurtigmikser eller med stavmikser. Sett til side.\nDel tomater i biter. Varm en sauteringspanne med olje og fres tomater, hvitløk, ingefær, chilipulver, kardemomme og bukkehornkløver på middels varme til tomatene er helt myke.\nTilsett cashewpuré og bruk stavmikser eller hurtigmikser til å finmose sausen. Sil gjerne sausen gjennom en grov sikt for å få ut rester av skall, hvis du vil ha den ekstra fin.\nHa sausen tilbake i kjelen og la den småkoke i i noen minutter. Smak til med honning, finhakket grønn chili, salt og pepper. Visp inn fløte og romtemperert smør i den varme sausen.\nLegg kyllingbitene i sausen og la alt bli gjennomvarmt. Pynt med koriander.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("matprat.no")
    expect(recipe.canonical_url).to eq("https://www.matprat.no/oppskrifter/gjester/butter-chicken---indisk-smorkylling/")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("no")
    expect(recipe.author).to eq("Matprat")
    expect(recipe.description).to eq("Butter chicken – eller murgh makhani som retten heter på indisk – er en av de mest kjente indiske curryrettene. Hovedingrediens er er kylling marinert i yoghurt og krydder. Vi bruker kyllingfilet eller lårfilet, som er mørt og saftig. Basmatiris eller ferske nanbrød serveres til. Avansert vanskelighetsgrad")
    expect(recipe.image).to eq("https://images.matprat.no/5jm2e5m2ne__w=1200_h=1200_autocrop=true_cropMode=zoom/image.webp")
    expect(recipe.category).to eq("Kyllingfilet")
    expect(recipe.cuisine).to eq("Internasjonal")
    expect(recipe.cooking_method).to eq("Blande")
    expect(recipe.yields).to eq("6 items")
    expect(recipe.total_time).to eq(80)
    expect(recipe.prep_time).to eq(80)
    expect(recipe.cook_time).to eq(80)
    expect(recipe.keywords).to eq([
      "Butter chicken",
      "smørkylling",
      "kylling",
      "murgh makhani",
      "curry",
      "gurkemeie",
      "indisk",
      "indisk gryte",
      "basmatiris",
      "koriander"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.76253298153034)
    expect(recipe.ratings_count).to eq(379)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "657 KCAL",
      "carbohydrateContent" => "15 G",
      "proteinContent" => "46 G",
      "fatContent" => "45 G"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 657.0 },
      { name: "carbohydrateContent", unit: "g", amount: 15.0 },
      { name: "proteinContent", unit: "g", amount: 46.0 },
      { name: "fatContent", unit: "g", amount: 45.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
