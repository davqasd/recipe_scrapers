# frozen_string_literal: true

RSpec.describe "hellofresh.at" do
  subject(:recipe) { scrape_cassette("at/hellofresh", url: "https://www.hellofresh.at/recipes/golf-von-mexico-cannellini-bohnen-und-mais-salad-669f7c71180815c793277451") }

  it "reads the title" do
    expect(recipe.title).to eq("Cajun Garnelen auf Cannellinibohnen-Salat dazu Mais und Buttermilch-Zitronen-Dressing")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "150 g Garnelen ohne Schale",
      "380 g Cannellinibohnen",
      "150 g Mais",
      "1 Stück Salatherz (Romana)",
      "1 Stück kleine Salatgurke",
      "1 Stück rote Zwiebel",
      "10 g Petersilie, glatt",
      "50 ml Buttermilch-Zitronen-Dressing",
      "20 ml mittelscharfer Senf",
      "2 g Gewürzmischung „Hello Cajun“",
      "3 Esslöffel Olivenöl",
      "1 Esslöffel Butter",
      "1 Esslöffel Weißweinessig",
      "nach Geschmack Salz",
      "nach Geschmack Pfeffer",
      "½ Teelöffel Honig"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 150.0, unit: "g", name: "Garnelen ohne Schale" },
      { amount: 380.0, unit: "g", name: "Cannellinibohnen" },
      { amount: 150.0, unit: "g", name: "Mais" },
      { amount: 1.0, unit: "Stück", name: "Salatherz" },
      { amount: 1.0, unit: "Stück", name: "kleine Salatgurke" },
      { amount: 1.0, unit: "Stück", name: "rote Zwiebel" },
      { amount: 10.0, unit: "g", name: "Petersilie, glatt" },
      { amount: 50.0, unit: "ml", name: "Buttermilch-Zitronen-Dressing" },
      { amount: 20.0, unit: "ml", name: "mittelscharfer Senf" },
      { amount: 2.0, unit: "g", name: "Gewürzmischung „Hello Cajun“" },
      { amount: 3.0, unit: nil, name: "Esslöffel Olivenöl" },
      { amount: 1.0, unit: nil, name: "Esslöffel Butter" },
      { amount: 1.0, unit: nil, name: "Esslöffel Weißweinessig" },
      { amount: nil, unit: nil, name: "nach Geschmack Salz" },
      { amount: nil, unit: nil, name: "nach Geschmack Pfeffer" },
      { amount: 0.5, unit: nil, name: "Teelöffel Honig" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Zwiebel in sehr feine Streifen schneiden. Gurke längs halbieren und in 0,5 cm Halbmonde schneiden. Kräuter fein hacken. Romanasalat in feine Streifen schneiden.",
      "Cannellinibohnen durch ein Sieb abgießen und mit Wasser abspülen. Mais mithilfe des Deckels abgießen.",
      "In einer großen Schüssel Buttermilch-Zitronen-Dressing, Senf, die Hälfte der Kräuter, 2 EL [3 EL | 4 EL] Olivenöl*, 1 EL [1,5 EL | 2 EL] Essig*, 0,5 TL [0,75 TL | 1 TL] Honig*, Salz* und Pfeffer* mischen.",
      "Cannellinibohnen und Gurkenhalbmonde unter das Dressing heben. Romanasalat in die Schüssel geben. Am Ende des Rezepts untermischen.",
      "In einer großen Pfanne 1 EL [1,5 EL | 2 EL] Butter* erhitzen. Mais und Zwiebelstreifen darin 3 – 4 Min. scharf anbraten. Mit Salz* und Pfeffer* würzen. Herausnehmen. In der großen Pfanne erneut 1 EL [1,5 EL | 2 EL] Olivenöl* erhitzen. Garnelen mit „Hello Cajun“ würzen und darin 2 – 3 Min. scharf anbraten, bis sie innen nicht mehr glasig sind.",
      "Salat unter das Dressing heben. Mit Salz* und Pfeffer* abschmecken. Salat auf tiefen Teller anrichten. Mit Zwiebeln, Mais und Garnelen toppen. Mit restlichen Kräutern garnieren. Guten Appetit!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Zwiebel in sehr feine Streifen schneiden. Gurke längs halbieren und in 0,5 cm Halbmonde schneiden. Kräuter fein hacken. Romanasalat in feine Streifen schneiden.\nCannellinibohnen durch ein Sieb abgießen und mit Wasser abspülen. Mais mithilfe des Deckels abgießen.\nIn einer großen Schüssel Buttermilch-Zitronen-Dressing, Senf, die Hälfte der Kräuter, 2 EL [3 EL | 4 EL] Olivenöl*, 1 EL [1,5 EL | 2 EL] Essig*, 0,5 TL [0,75 TL | 1 TL] Honig*, Salz* und Pfeffer* mischen.\nCannellinibohnen und Gurkenhalbmonde unter das Dressing heben. Romanasalat in die Schüssel geben. Am Ende des Rezepts untermischen.\nIn einer großen Pfanne 1 EL [1,5 EL | 2 EL] Butter* erhitzen. Mais und Zwiebelstreifen darin 3 – 4 Min. scharf anbraten. Mit Salz* und Pfeffer* würzen. Herausnehmen. In der großen Pfanne erneut 1 EL [1,5 EL | 2 EL] Olivenöl* erhitzen. Garnelen mit „Hello Cajun“ würzen und darin 2 – 3 Min. scharf anbraten, bis sie innen nicht mehr glasig sind.\nSalat unter das Dressing heben. Mit Salz* und Pfeffer* abschmecken. Salat auf tiefen Teller anrichten. Mit Zwiebeln, Mais und Garnelen toppen. Mit restlichen Kräutern garnieren. Guten Appetit!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hellofresh.at")
    expect(recipe.canonical_url).to eq("https://www.hellofresh.at/recipes/golf-von-mexico-cannellini-bohnen-und-mais-salad-669f7c71180815c793277451")
    expect(recipe.site_name).to eq("HelloFresh")
    expect(recipe.language).to eq("de-AT")
    expect(recipe.author).to eq("HelloFresh")
    expect(recipe.description).to eq("Weniger Kohlenhydrate, voller Geschmack. Freu dich auf dieses aromatische Low Carb Gericht mit weniger als 50 g Kohlenhydraten pro Portion.")
    expect(recipe.image).to eq("https://img.hellofresh.com/f_auto,fl_lossy,h_640,q_auto,w_1200/hellofresh_s3/image/HF_Y24_R38_W46_DE_R30315-1_Main_low-d20b544d.jpg")
    expect(recipe.category).to eq("Hauptgericht")
    expect(recipe.cuisine).to eq("0")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.255157889671696)
    expect(recipe.ratings_count).to eq(206)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "565 kcal",
      "fatContent" => "28.4 g",
      "saturatedFatContent" => "6.3 g",
      "carbohydrateContent" => "44.6 g",
      "sugarContent" => "22 g",
      "proteinContent" => "26 g",
      "fiberContent" => "18.2 g",
      "sodiumContent" => "3.7 g",
      "servingSize" => "577"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 565.0 },
      { name: "fatContent", unit: "g", amount: 28.4 },
      { name: "saturatedFatContent", unit: "g", amount: 6.3 },
      { name: "carbohydrateContent", unit: "g", amount: 44.6 },
      { name: "sugarContent", unit: "g", amount: 22.0 },
      { name: "proteinContent", unit: "g", amount: 26.0 },
      { name: "fiberContent", unit: "g", amount: 18.2 },
      { name: "sodiumContent", unit: "g", amount: 3.7 },
      { name: "servingSize", unit: nil, amount: 577.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#page")
  end
end
