# frozen_string_literal: true

RSpec.describe "kitchenstories.com" do
  subject(:recipe) { scrape_cassette("com/kitchenstories", url: "https://www.kitchenstories.com/kurbis-gnudi-zitronen-butter/308450") }

  it "reads the title" do
    expect(recipe.title).to eq("Kürbis-Gnudi mit Zitronen-Butter-Soße")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "700 g Hokkaidokürbis",
      "200 g Ricottakäse",
      "110 g Parmesan",
      "1 Eier",
      "300 g Spinat",
      "200 g Hartweizengrieß",
      "1 Zitrone",
      "4 EL Wasser",
      "100 g Butter",
      "Salz",
      "Pfeffer"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 700.0, unit: "g", name: "Hokkaidokürbis" },
      { amount: 200.0, unit: "g", name: "Ricottakäse" },
      { amount: 110.0, unit: "g", name: "Parmesan" },
      { amount: 1.0, unit: nil, name: "Eier" },
      { amount: 300.0, unit: "g", name: "Spinat" },
      { amount: 200.0, unit: "g", name: "Hartweizengrieß" },
      { amount: 1.0, unit: nil, name: "Zitrone" },
      { amount: 4.0, unit: "EL", name: "Wasser" },
      { amount: 100.0, unit: "g", name: "Butter" },
      { amount: nil, unit: nil, name: "Salz" },
      { amount: nil, unit: nil, name: "Pfeffer" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Kürbis in grobe Stücke schneiden. Zitrone abreiben und den Saft auspressen. Parmesan fein reiben. Eigelb vom Eiweiß trennen und das Eiweiß für einen anderen Zweck beiseitestellen. Kürbis auf einem Backblech bei 200°C Ober/Unterhitze für ca. 25 Min. garen, bis er weich ist. Anschließend mit dem Stabmixer zu einem Püree verarbeiten",
      "In der Zwischenzeit Spinat in kochendem Wasser ca. 1 Min. blanchieren, abschrecken und überschüssiges Wasser gründlich ausdrücken. Anschließend fein hacken und geriebenen Parmesan unterheben. Den Spinat-Mix in einer großen Schüssel mit Ricotta, Eigelb, Hartweizengrieß und dem Kürbispüree vermengen und mit Salz und Pfeffer würzen. Zu einem gleichmäßigen Teig verarbeiten.",
      "Etwas mehr Hartweizengrieß auf der Arbeitsfläche verteilen. Die Gnudi mit einem Teelöffel portionieren und im Hartweizengrieß zu Kugeln formen. Die geformten Gnudi ca. 30 Min. ruhen lassen.",
      "Gnudi in siedendem, gesalzenem Wasser ca. 5–8 Min. kochen. Währenddessen Zitronensaft und Wasser in einer Pfanne aufkochen. Die Hitze auf niedrige Stufe reduzieren und die kalte Butter in Stücken kräftig einrühren. Mit etwas Zitronenzeste, Salz und Pfeffer würzen. Gnudi direkt in die Soße geben und darin schwenken. Auf Teller verteilen, mit Parmesan und schwarzem Pfeffer toppen und sofort servieren."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Kürbis in grobe Stücke schneiden. Zitrone abreiben und den Saft auspressen. Parmesan fein reiben. Eigelb vom Eiweiß trennen und das Eiweiß für einen anderen Zweck beiseitestellen. Kürbis auf einem Backblech bei 200°C Ober/Unterhitze für ca. 25 Min. garen, bis er weich ist. Anschließend mit dem Stabmixer zu einem Püree verarbeiten\nIn der Zwischenzeit Spinat in kochendem Wasser ca. 1 Min. blanchieren, abschrecken und überschüssiges Wasser gründlich ausdrücken. Anschließend fein hacken und geriebenen Parmesan unterheben. Den Spinat-Mix in einer großen Schüssel mit Ricotta, Eigelb, Hartweizengrieß und dem Kürbispüree vermengen und mit Salz und Pfeffer würzen. Zu einem gleichmäßigen Teig verarbeiten.\nEtwas mehr Hartweizengrieß auf der Arbeitsfläche verteilen. Die Gnudi mit einem Teelöffel portionieren und im Hartweizengrieß zu Kugeln formen. Die geformten Gnudi ca. 30 Min. ruhen lassen.\nGnudi in siedendem, gesalzenem Wasser ca. 5–8 Min. kochen. Währenddessen Zitronensaft und Wasser in einer Pfanne aufkochen. Die Hitze auf niedrige Stufe reduzieren und die kalte Butter in Stücken kräftig einrühren. Mit etwas Zitronenzeste, Salz und Pfeffer würzen. Gnudi direkt in die Soße geben und darin schwenken. Auf Teller verteilen, mit Parmesan und schwarzem Pfeffer toppen und sofort servieren.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("kitchenstories.com")
    expect(recipe.canonical_url).to eq("https://www.kitchenstories.com/kurbis-gnudi-zitronen-butter/308450")
    expect(recipe.site_name).to eq("Kitchen Stories")
    expect(recipe.language).to eq("de")
    expect(recipe.author).to eq("Marlene")
    expect(recipe.description).to eq("Falls du dich schon einmal gefragt hast, ob Gnocchi nun Pasta oder Teigklöße sind, könnten diese kleinen Dinger noch etwas verwirrender sein. Gnudi aus")
    expect(recipe.image).to eq("https://www.kitchenstories.com/wp-content/uploads/sites/13/2026/09/r3543-final.jpg")
    expect(recipe.category).to eq("Hauptgericht")
    expect(recipe.cuisine).to eq("Italienisch")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(85)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to eq(%w[cremig einfach])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "630 kcal",
      "fatContent" => "34 g",
      "proteinContent" => "26 g",
      "carbohydrateContent" => "58 g",
      "servingSize" => "1 Portion"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 630.0 },
      { name: "fatContent", unit: "g", amount: 34.0 },
      { name: "proteinContent", unit: "g", amount: 26.0 },
      { name: "carbohydrateContent", unit: "g", amount: 58.0 },
      { name: "servingSize", unit: "Portion", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.kitchenstories.com/rezepte")
  end
end
