# frozen_string_literal: true

RSpec.describe "eatsmarter.de" do
  subject(:recipe) { scrape_cassette("de/eatsmarter", url: "https://www.eatsmarter.de/rezepte/panierter-feta-mit-rotkohl-und-salsa-verde") }

  it "reads the title" do
    expect(recipe.title).to eq("Panierter Feta mit Rotkohl und Salsa verde")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 EL eingelegte Kapern",
      "1 Knoblauchzehe",
      "0.5 Bund Petersilie",
      "0.5 Bund Basilikum",
      "1 Handvoll Dill",
      "1 EL Orangensaft",
      "3 EL Olivenöl",
      "Salz",
      "Pfeffer",
      "400 g Rotkohl",
      "0.5 TL Kümmel",
      "1 TL Honig",
      "2 Msp. Zimtpulver",
      "400 g Feta",
      "1 EL Dinkel-Vollkornmehl",
      "1 Ei",
      "6 EL geschälte, helle Sesamsamen",
      "1 EL helles Sesamöl",
      "1 Apfel"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "EL", name: "eingelegte Kapern" },
      { amount: 1.0, unit: nil, name: "Knoblauchzehe" },
      { amount: 0.5, unit: "Bund", name: "Petersilie" },
      { amount: 0.5, unit: "Bund", name: "Basilikum" },
      { amount: 1.0, unit: nil, name: "Handvoll Dill" },
      { amount: 1.0, unit: "EL", name: "Orangensaft" },
      { amount: 3.0, unit: "EL", name: "Olivenöl" },
      { amount: nil, unit: nil, name: "Salz" },
      { amount: nil, unit: nil, name: "Pfeffer" },
      { amount: 400.0, unit: "g", name: "Rotkohl" },
      { amount: 0.5, unit: "TL", name: "Kümmel" },
      { amount: 1.0, unit: "TL", name: "Honig" },
      { amount: 2.0, unit: "Msp", name: "Zimtpulver" },
      { amount: 400.0, unit: "g", name: "Feta" },
      { amount: 1.0, unit: "EL", name: "Dinkel-Vollkornmehl" },
      { amount: 1.0, unit: nil, name: "Ei" },
      { amount: 6.0, unit: "EL", name: "geschälte, helle Sesamsamen" },
      { amount: 1.0, unit: "EL", name: "helles Sesamöl" },
      { amount: 1.0, unit: nil, name: "Apfel" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Kapern abtropfen lassen und fein hacken. Knoblauch schälen und ebenfalls fein hacken. Petersilie, Basilikum und Dill waschen, trocken schütteln und fein hacken. Kapern, Knoblauch und Kräuter mit Orangensaft und 2 EL Olivenöl vermengen und mit Salz und Pfeffer würzen. Beiseitestellen.",
      "Rotkohl putzen, in feine Streifen schneiden und salzen. Kümmel in einer heißen Pfanne ohne Fett kurz anrösten, bis er anfängt zu duften. Im Mörser grob zerstoßen und zum Rotkohl geben. Honig, Zimt und restliches Olivenöl zugeben und alles einmassieren, bis der Rotkohl geschmeidig wird, anschließend beiseitestellen.",
      "Feta gut abtropfen lassen und Würfel oder Dreiecke schneiden. Mehl in einen tiefen Teller geben, Ei ebenfalls in einen tiefen Teller schlagen, mit Salz und Pfeffer würzen und verrühren. In einen dritten Teller die Sesamsamen geben. Fetawürfel zuerst im Mehl, dann im verrührten Ei und anschließend in den Sesamsamen rundherum wenden.",
      "Sesamöl in einer Pfanne erhitzen und die Fetawürfel in ca. 5 Minuten rundherum anbraten. Inzwischen Apfel waschen, vierteln, entkernen und in feine Spalten scheiden. Rotkohl auf Tellern verteilen, Apfelspalten und Fetawürfel darauf anrichten und Salsa darüberträufeln."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Kapern abtropfen lassen und fein hacken. Knoblauch schälen und ebenfalls fein hacken. Petersilie, Basilikum und Dill waschen, trocken schütteln und fein hacken. Kapern, Knoblauch und Kräuter mit Orangensaft und 2 EL Olivenöl vermengen und mit Salz und Pfeffer würzen. Beiseitestellen.\nRotkohl putzen, in feine Streifen schneiden und salzen. Kümmel in einer heißen Pfanne ohne Fett kurz anrösten, bis er anfängt zu duften. Im Mörser grob zerstoßen und zum Rotkohl geben. Honig, Zimt und restliches Olivenöl zugeben und alles einmassieren, bis der Rotkohl geschmeidig wird, anschließend beiseitestellen.\nFeta gut abtropfen lassen und Würfel oder Dreiecke schneiden. Mehl in einen tiefen Teller geben, Ei ebenfalls in einen tiefen Teller schlagen, mit Salz und Pfeffer würzen und verrühren. In einen dritten Teller die Sesamsamen geben. Fetawürfel zuerst im Mehl, dann im verrührten Ei und anschließend in den Sesamsamen rundherum wenden.\nSesamöl in einer Pfanne erhitzen und die Fetawürfel in ca. 5 Minuten rundherum anbraten. Inzwischen Apfel waschen, vierteln, entkernen und in feine Spalten scheiden. Rotkohl auf Tellern verteilen, Apfelspalten und Fetawürfel darauf anrichten und Salsa darüberträufeln.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("eatsmarter.de")
    expect(recipe.canonical_url).to eq("https://eatsmarter.de/rezepte/panierter-feta-mit-rotkohl-und-salsa-verde")
    expect(recipe.site_name).to eq("EAT SMARTER")
    expect(recipe.language).to eq("de")
    expect(recipe.author).to eq("EAT SMARTER")
    expect(recipe.description).to eq("Der Panierte Feta mit Rotkohl und Salsa verde von EAT SMARTER lässt Veggie-Herzen höher schlagen!")
    expect(recipe.image).to eq("https://images.eatsmarter.de/sites/default/files/styles/max_size/public/panierter-feta-mit-rotkohl-und-salsa-verde-656855.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to eq("Griechisch")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["Diabetiker, Eisenmangel, Erhöhter Cholesterinspiegel, Gicht, Kinderwunsch, Osteoporose, Arthrose, Schwangerschaft, Stillzeit, Stress, Eiweißreich, Low Carb, Mineralstoffreich, Ohne Alkohol, Vitaminreich, Vegetarisch, Vollwert, Gesunde Ernährung, Clean Eating, Rheuma, Hashimoto, Divertikulose, Laktoseintoleranz, Gesundes Herz, Schilddrüsenunterfunktion, Muskelaufbau, besser schlafen, mehr Energie, schöne Haut, Zunehmen, Lust auf Sex, Gesunder Darm, Rezepte fürs Immunsystem"])
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(19)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "599 kcal",
      "fatContent" => "47 g",
      "saturatedFatContent" => "19.7 g",
      "proteinContent" => "25 g",
      "carbohydrateContent" => "19 g",
      "sugarContent" => "1 g",
      "cholesterolContent" => "124 mg"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 599.0 },
      { name: "fatContent", unit: "g", amount: 47.0 },
      { name: "saturatedFatContent", unit: "g", amount: 19.7 },
      { name: "proteinContent", unit: "g", amount: 25.0 },
      { name: "carbohydrateContent", unit: "g", amount: 19.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 124.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
