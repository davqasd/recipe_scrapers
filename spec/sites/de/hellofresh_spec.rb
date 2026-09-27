# frozen_string_literal: true

RSpec.describe "hellofresh.de" do
  subject(:recipe) { scrape_cassette("de/hellofresh", url: "https://www.hellofresh.de/recipes/chicken-harissa-chicken-burger-mit-zatar-dip-avocado-64f5b640c09936aa866c823a") }

  it "reads the title" do
    expect(recipe.title).to eq("Harissa Chicken Burger! mit Zatar-Dip, Avocado roten Zwiebeln und würzigen Kartoffelspalten")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "160 g vegane Brioche Burger Buns",
      "1 Stück Avocado",
      "4 g Gewürzmischung „Hello Harissa“",
      "75 g Naturjoghurt",
      "2 Stück Ofenkartoffel",
      "1 Stück rote Zwiebel",
      "4 g Gewürzmischung „Hello Paprika“",
      "4 g Zaatar",
      "250 g Hähnchenbrustfilet in Lake",
      "25 g Mayonnaise",
      "nach Geschmack Salz",
      "nach Geschmack Pfeffer",
      "nach Geschmack Butter",
      "2 Esslöffel Öl"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 160.0, unit: "g", name: "vegane Brioche Burger Buns" },
      { amount: 1.0, unit: "Stück", name: "Avocado" },
      { amount: 4.0, unit: "g", name: "Gewürzmischung „Hello Harissa“" },
      { amount: 75.0, unit: "g", name: "Naturjoghurt" },
      { amount: 2.0, unit: "Stück", name: "Ofenkartoffel" },
      { amount: 1.0, unit: "Stück", name: "rote Zwiebel" },
      { amount: 4.0, unit: "g", name: "Gewürzmischung „Hello Paprika“" },
      { amount: 4.0, unit: "g", name: "Zaatar" },
      { amount: 250.0, unit: "g", name: "Hähnchenbrustfilet in Lake" },
      { amount: 25.0, unit: "g", name: "Mayonnaise" },
      { amount: nil, unit: nil, name: "nach Geschmack Salz" },
      { amount: nil, unit: nil, name: "nach Geschmack Pfeffer" },
      { amount: nil, unit: nil, name: "nach Geschmack Butter" },
      { amount: 2.0, unit: nil, name: "Esslöffel Öl" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Heize den Backofen auf 220 °C Ober-/Unterhitze (200 °C Umluft) vor. Kartoffeln in 4 oder 6 Spalten schneiden. Kartoffeln auf ein mit Backpapier belegtes Backblech geben, mit 1 EL [1,5 EL | 2 EL] Öl*, „Hello Paprika“, Salz* und Pfeffer* vermengen und im Ofen 25 – 30 Min. goldbraun backen.",
      "Hähnchenbrust waagerecht aufschneiden, aber nicht durchschneiden und wie ein Buch aufklappen. Hähnchenbrust in eine große Schüssel geben und mit „Hello Harissa\", 1 EL [1,5 EL | 2 EL] Öl*, Salz* und Pfeffer* vermengen. Marinieren lassen und mit dem Rezept fortfahren.",
      "Burger Buns waagerecht aufschneiden Zwiebel abziehen und in 1 cm Ringen schneiden. Avocado halbieren, entkernen und in feine Streifen schneiden. Mit Salz* und Pfeffer* würzen.",
      "In einer kleinen Schüssel Joghurt, Mayonnaise und Zatar vermengen. Mit Salz* und Pfeffer* abschmecken.",
      "Zwiebeln und marinierte Hähnchenbrust neben den Kartoffeln geben und 12 – 14 Min. garen, bis das Fleisch von innen nicht mehr rosa ist. In den letzten 5 Min. der Garzeit das Burger-Brötchen offen in den Ofen geben. Tipp: Bestreiche nach Belieben das Burger-Brötchen mit etwas Butter* oder Öl*, damit es eine goldbraune Farbe bekommt.",
      "Oberseite des Brötchens mit etwas Zatar-Dip bestreichen. Untere Hälfte mit etwas Dip, Avocadoscheiben und der Hähnchenbrust belegen. Kartoffelspalten daneben anrichten und mit dem restlichen Dip genießen. Guten Appetit!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Heize den Backofen auf 220 °C Ober-/Unterhitze (200 °C Umluft) vor. Kartoffeln in 4 oder 6 Spalten schneiden. Kartoffeln auf ein mit Backpapier belegtes Backblech geben, mit 1 EL [1,5 EL | 2 EL] Öl*, „Hello Paprika“, Salz* und Pfeffer* vermengen und im Ofen 25 – 30 Min. goldbraun backen.\nHähnchenbrust waagerecht aufschneiden, aber nicht durchschneiden und wie ein Buch aufklappen. Hähnchenbrust in eine große Schüssel geben und mit „Hello Harissa\", 1 EL [1,5 EL | 2 EL] Öl*, Salz* und Pfeffer* vermengen. Marinieren lassen und mit dem Rezept fortfahren.\nBurger Buns waagerecht aufschneiden Zwiebel abziehen und in 1 cm Ringen schneiden. Avocado halbieren, entkernen und in feine Streifen schneiden. Mit Salz* und Pfeffer* würzen.\nIn einer kleinen Schüssel Joghurt, Mayonnaise und Zatar vermengen. Mit Salz* und Pfeffer* abschmecken.\nZwiebeln und marinierte Hähnchenbrust neben den Kartoffeln geben und 12 – 14 Min. garen, bis das Fleisch von innen nicht mehr rosa ist. In den letzten 5 Min. der Garzeit das Burger-Brötchen offen in den Ofen geben. Tipp: Bestreiche nach Belieben das Burger-Brötchen mit etwas Butter* oder Öl*, damit es eine goldbraune Farbe bekommt.\nOberseite des Brötchens mit etwas Zatar-Dip bestreichen. Untere Hälfte mit etwas Dip, Avocadoscheiben und der Hähnchenbrust belegen. Kartoffelspalten daneben anrichten und mit dem restlichen Dip genießen. Guten Appetit!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hellofresh.de")
    expect(recipe.canonical_url).to eq("https://www.hellofresh.de/recipes/chicken-harissa-chicken-burger-mit-zatar-dip-avocado-64f5b640c09936aa866c823a")
    expect(recipe.site_name).to eq("HelloFresh")
    expect(recipe.language).to eq("de-DE")
    expect(recipe.author).to eq("HelloFresh")
    expect(recipe.description).to eq("Wir lieben Burger! Dieses Gericht hat in unserer Ideenküche für leuchtende Augen gesorgt. Mit saftigem Fleisch und luftigen Brötchen steht Deinem Burgerglück nichts mehr im Weg. Lass es Dir schmecken!")
    expect(recipe.image).to eq("https://img.hellofresh.com/f_auto,fl_lossy,h_640,q_auto,w_1200/hellofresh_s3/image/HF_Y24_R30_W06_DE_EXP18708-1_Main__2low-13b76ba6.jpg")
    expect(recipe.category).to eq("Hauptgericht")
    expect(recipe.cuisine).to eq("Orientalisch")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.396976349760145)
    expect(recipe.ratings_count).to eq(5304)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "850 kcal",
      "fatContent" => "38.5 g",
      "saturatedFatContent" => "7 g",
      "carbohydrateContent" => "80.9 g",
      "sugarContent" => "16.8 g",
      "proteinContent" => "43.2 g",
      "sodiumContent" => "2.8 g",
      "servingSize" => "570"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 850.0 },
      { name: "fatContent", unit: "g", amount: 38.5 },
      { name: "saturatedFatContent", unit: "g", amount: 7.0 },
      { name: "carbohydrateContent", unit: "g", amount: 80.9 },
      { name: "sugarContent", unit: "g", amount: 16.8 },
      { name: "proteinContent", unit: "g", amount: 43.2 },
      { name: "sodiumContent", unit: "g", amount: 2.8 },
      { name: "servingSize", unit: nil, amount: 570.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#page")
  end
end
