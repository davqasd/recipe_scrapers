# frozen_string_literal: true

RSpec.describe "edeka.de" do
  subject(:recipe) { scrape_cassette("de/edeka", url: "https://www.edeka.de/rezeptwelt/rezepte/raw-cake-mit-avocado/") }

  it "reads the title" do
    expect(recipe.title).to eq("Raw Cake mit Avocado")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 Tassen Cashewkerne",
      "6 EL Kokosöl",
      "150 g Kokosflocken",
      "2 Limetten",
      "15 EL Ahornsirup",
      "375 g Kokoscreme",
      "2 Avocados, z.B. EDEKA mit Apeel-Schutzhülle",
      "1 Handvoll Erdbeere, frisch",
      "einige Pistazie, gehackt",
      "150 g Datteln, ohne Stein",
      "35 g Kokosflocken",
      "100 g Mandeln, geschält",
      "100 g Pistazien",
      "3 EL Kokosöl",
      "0,5 TL Zimt",
      "1 Prise Salz"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "Tassen", name: "Cashewkerne" },
      { amount: 6.0, unit: "EL", name: "Kokosöl" },
      { amount: 150.0, unit: "g", name: "Kokosflocken" },
      { amount: 2.0, unit: nil, name: "Limetten" },
      { amount: 15.0, unit: "EL", name: "Ahornsirup" },
      { amount: 375.0, unit: "g", name: "Kokoscreme" },
      { amount: 2.0, unit: nil, name: "Avocados, z.B. EDEKA mit Apeel-Schutzhülle" },
      { amount: 1.0, unit: nil, name: "Handvoll Erdbeere, frisch" },
      { amount: nil, unit: nil, name: "einige Pistazie, gehackt" },
      { amount: 150.0, unit: "g", name: "Datteln, ohne Stein" },
      { amount: 35.0, unit: "g", name: "Kokosflocken" },
      { amount: 100.0, unit: "g", name: "Mandeln, geschält" },
      { amount: 100.0, unit: "g", name: "Pistazien" },
      { amount: 3.0, unit: "EL", name: "Kokosöl" },
      { amount: 0.5, unit: "TL", name: "Zimt" },
      { amount: 1.0, unit: "Prise", name: "Salz" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Ein mit Backpapier ausgelegtes Backblech vorbereiten.",
      "Alle Zutaten für den Boden in ein hohes Rührgefäß füllen und mit dem Stabmixer zerhacken. Bei Bedarf etwas Wasser hinzufügen. Den Teig flach auf dem Backpapier verteilen, sodass ein gleichmäßiger Boden entsteht. Den Boden für ca. 4 Stunden in das Gefrierfach stellen.",
      "Die Cashew-Kerne (über Nacht in Wasser eingeweicht!), das Kokosöl, die Kokosflocken, den Saft von den 2 Limetten und den Ahornsirup mit dem Stabmixer zu einer glatten Creme vermengen. Nun die Creme in zwei Hälften teilen. Die eine Hälfte mit der Kokoscreme verrühren. Alternativ kann anstelle der Kokoscreme auch Quark verwendet werden, in dem Fall ist der Kuchen allerdings nicht roh und vegan. Zu der anderen Hälfte die zwei Avocados hinzufügen und nochmals mit dem Mixer glatt rühren. Zunächst die weiße Füllung, danach die grüne Füllung auf dem gefrorenen Boden verteilen und das Ganze noch einmal für mind. 1 Stunde in das Gefrierfach stellen.",
      "Den Kuchen aus dem Gefrierfach nehmen, mit geschnittenen Erdbeerscheiben und gehackten Pistazien dekorieren, kurz antauen lassen und anschließend servieren."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Ein mit Backpapier ausgelegtes Backblech vorbereiten.\nAlle Zutaten für den Boden in ein hohes Rührgefäß füllen und mit dem Stabmixer zerhacken. Bei Bedarf etwas Wasser hinzufügen. Den Teig flach auf dem Backpapier verteilen, sodass ein gleichmäßiger Boden entsteht. Den Boden für ca. 4 Stunden in das Gefrierfach stellen.\nDie Cashew-Kerne (über Nacht in Wasser eingeweicht!), das Kokosöl, die Kokosflocken, den Saft von den 2 Limetten und den Ahornsirup mit dem Stabmixer zu einer glatten Creme vermengen. Nun die Creme in zwei Hälften teilen. Die eine Hälfte mit der Kokoscreme verrühren. Alternativ kann anstelle der Kokoscreme auch Quark verwendet werden, in dem Fall ist der Kuchen allerdings nicht roh und vegan. Zu der anderen Hälfte die zwei Avocados hinzufügen und nochmals mit dem Mixer glatt rühren. Zunächst die weiße Füllung, danach die grüne Füllung auf dem gefrorenen Boden verteilen und das Ganze noch einmal für mind. 1 Stunde in das Gefrierfach stellen.\nDen Kuchen aus dem Gefrierfach nehmen, mit geschnittenen Erdbeerscheiben und gehackten Pistazien dekorieren, kurz antauen lassen und anschließend servieren.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("edeka.de")
    expect(recipe.canonical_url).to eq("https://www.edeka.de/rezeptwelt/rezepte/raw-cake-mit-avocado/")
    expect(recipe.site_name).to eq("EDEKA")
    expect(recipe.language).to eq("de")
    expect(recipe.author).to eq("EDEKA")
    expect(recipe.description).to eq("Unser Raw Cake mit einem Boden aus Pistazien, Kokosflocken sowie Datteln und einer Füllung aus Avocados, Kokoscreme und Cashewkernen wird nicht gebacken, sondern eiskalt serviert. Bereite mit unserem Rezept eine vegane Torte zu!")
    expect(recipe.image).to eq("https://www.edeka.de/uploads/rezepte/rez-edeka-raw-cake-mit-avocado-rezept-a-d-1-1.jpg")
    expect(recipe.category).to eq("Pflanzliche Ernährung")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(360)
    expect(recipe.prep_time).to eq(60)
    expect(recipe.cook_time).to eq(300)
    expect(recipe.keywords).to eq(%w[Vegan Sommer Glutenfrei Dessert Mandeln Limetten Beeren Kokosflocken Rezeptvideo Kaffeetafel Vegetarisch Kokosöl Datteln Früchte Pistazien Erdbeeren])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.4)
    expect(recipe.ratings_count).to eq(30)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "689 kcal",
      "carbohydrateContent" => "42 g",
      "fatContent" => "59 g",
      "proteinContent" => "10 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 689.0 },
      { name: "carbohydrateContent", unit: "g", amount: 42.0 },
      { name: "fatContent", unit: "g", amount: 59.0 },
      { name: "proteinContent", unit: "g", amount: 10.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
