# frozen_string_literal: true

RSpec.describe "lecker.de" do
  subject(:recipe) { scrape_cassette("de/lecker", url: "https://www.lecker.de/sandkuchen-omas-lieblingsrezept-49.html") }

  it "reads the title" do
    expect(recipe.title).to eq("Sandkuchen (Omas Lieblingsrezept) Rezept")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 Eier (Gr. M)",
      "250 g weiche Butter oder Margarine",
      "250 g Zucker",
      "1 Pck. Vanillin-Zucker",
      "abgeriebene Schale von 1 unbehandelte Zitrone",
      "1 Prise Salz",
      "3 EL Kuhmilch",
      "150 g Mehl",
      "150 g Speisestärke",
      "1 TL Backpulver",
      "Puderzucker zum Bestäuben"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: nil, name: "Eier" },
      { amount: 250.0, unit: "g", name: "weiche Butter oder Margarine" },
      { amount: 250.0, unit: "g", name: "Zucker" },
      { amount: 1.0, unit: "Pck", name: "Vanillin-Zucker" },
      { amount: nil, unit: nil, name: "abgeriebene Schale von 1 unbehandelte Zitrone" },
      { amount: 1.0, unit: "Prise", name: "Salz" },
      { amount: 3.0, unit: "EL", name: "Kuhmilch" },
      { amount: 150.0, unit: "g", name: "Mehl" },
      { amount: 150.0, unit: "g", name: "Speisestärke" },
      { amount: 1.0, unit: "TL", name: "Backpulver" },
      { amount: nil, unit: nil, name: "Puderzucker zum Bestäuben" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Eier trennen. Fett, 125 g Zucker, Vanillin-Zucker, Zitronenschale und Salz schaumig schlagen. Eigelbe und Milch nach und nach unterrühren. Eiweiß steif schlagen, dabei 125 g Zucker einrieseln lassen. Eischnee unter die Fett-Zucker-Masse heben.",
      "Mehl, Stärke und Backpulver mischen und unterheben. Teig in eine gefettete, mit Mehl bestäubte Kastenform (ca. 2 Liter Inhalt; 10 x 30 cm) füllen. Im vorgeheizten Backofen (E-Herd: 175 °C/ Umluft: 150 °C/ Gas: Stufe 2) auf der 2. Schiene von unten 45-50 Minuten backen.",
      "MehH 45 Wörter, 269 Zeichen HMehl, Stärke und Backpulver mischen und unterheben. Teig in eine gefettete, mit Mehl bestäubte Kastenform (ca. 2 Liter Inhalt; 10 x 30 cm) füllen. Im vorgeheizten Backofen (E-Herd: 175 °C/ Umluft: 150 °C/ Gas: Stufe 2) auf der 2. Schiene von unten 45-50 Minuten backen. Drag & Drop oder klicken l, Stärke und Backpulver mischen und unterheben. Teig in eine gefettete, mit Mehl bestäubte Kastenform (ca. 2 Liter Inhalt; 10 x 30 cm) füllen. Im vorgeheizten Backofen (E-Herd: 175 °C/ Umluft: 150 °C/ Gas: Stufe 2) auf der 2. Schiene von unten 45-50 Minuten backen."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Eier trennen. Fett, 125 g Zucker, Vanillin-Zucker, Zitronenschale und Salz schaumig schlagen. Eigelbe und Milch nach und nach unterrühren. Eiweiß steif schlagen, dabei 125 g Zucker einrieseln lassen. Eischnee unter die Fett-Zucker-Masse heben.\nMehl, Stärke und Backpulver mischen und unterheben. Teig in eine gefettete, mit Mehl bestäubte Kastenform (ca. 2 Liter Inhalt; 10 x 30 cm) füllen. Im vorgeheizten Backofen (E-Herd: 175 °C/ Umluft: 150 °C/ Gas: Stufe 2) auf der 2. Schiene von unten 45-50 Minuten backen.\nMehH 45 Wörter, 269 Zeichen HMehl, Stärke und Backpulver mischen und unterheben. Teig in eine gefettete, mit Mehl bestäubte Kastenform (ca. 2 Liter Inhalt; 10 x 30 cm) füllen. Im vorgeheizten Backofen (E-Herd: 175 °C/ Umluft: 150 °C/ Gas: Stufe 2) auf der 2. Schiene von unten 45-50 Minuten backen. Drag & Drop oder klicken l, Stärke und Backpulver mischen und unterheben. Teig in eine gefettete, mit Mehl bestäubte Kastenform (ca. 2 Liter Inhalt; 10 x 30 cm) füllen. Im vorgeheizten Backofen (E-Herd: 175 °C/ Umluft: 150 °C/ Gas: Stufe 2) auf der 2. Schiene von unten 45-50 Minuten backen.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("lecker.de")
    expect(recipe.canonical_url).to eq("https://www.lecker.de/sandkuchen-omas-lieblingsrezept-49.html")
    expect(recipe.site_name).to eq("LECKER")
    expect(recipe.language).to eq("de")
    expect(recipe.author).to eq("Lecker")
    expect(recipe.description).to eq("Unser beliebtes Rezept für Sandkuchen (Omas Lieblingsrezept) und mehr als 45.000 weitere kostenlose Rezepte auf LECKER.de.")
    expect(recipe.image).to eq("https://images.lecker.de/sandkuchen-omas-lieblingsrezept/1x1,id=d1e6b509,b=lecker,w=1600,h=,ca=0,10.78,100,89.22,rm=sk.jpeg")
    expect(recipe.category).to eq("Kuchen & Gebäck")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("16 items")
    expect(recipe.total_time).to eq(75)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(75)
    expect(recipe.keywords).to eq(["Rezepte", "Backen", "Kuchen", "Rührkuchen", "Torten", "Omas Rezepte"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(3.96)
    expect(recipe.ratings_count).to eq(23)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 Stück",
      "calories" => "270 kcal",
      "fatContent" => "15 g",
      "carbohydrateContent" => "31 g",
      "proteinContent" => "3 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "Stück", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 270.0 },
      { name: "fatContent", unit: "g", amount: 15.0 },
      { name: "carbohydrateContent", unit: "g", amount: 31.0 },
      { name: "proteinContent", unit: "g", amount: 3.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
