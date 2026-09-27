# frozen_string_literal: true

RSpec.describe "hellofresh.ch" do
  subject(:recipe) { scrape_cassette("ch/hellofresh", url: "https://www.hellofresh.ch/recipes/hot-sweet-chili-tofu-bowl-mit-pak-choi-salat-6a5763762c76eddc47d0f768") }

  it "reads the title" do
    expect(recipe.title).to eq("Sweet Chili Tofu Bowl mit Pak Choi Salat und Radiesli auf Basmatireis")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "180 g süsser Chili-Grill-Tofu",
      "200 g Rüebli",
      "30 g gehackter Knoblauch & Ingwer in Öl",
      "20 ml Agavendicksaft",
      "50 ml Sojasauce",
      "10 g Sesamsamen",
      "150 g Basmatireis",
      "75 g Limette, vegan",
      "10 ml Sesamöl",
      "130 g Pak Choi",
      "150 g Radiesli",
      "1 Esslöffel Öl",
      "300 ml Wasser",
      "nach Geschmack Salz",
      "nach Geschmack Pfeffer"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 180.0, unit: "g", name: "süsser Chili-Grill-Tofu" },
      { amount: 200.0, unit: "g", name: "Rüebli" },
      { amount: 30.0, unit: "g", name: "gehackter Knoblauch & Ingwer in Öl" },
      { amount: 20.0, unit: "ml", name: "Agavendicksaft" },
      { amount: 50.0, unit: "ml", name: "Sojasauce" },
      { amount: 10.0, unit: "g", name: "Sesamsamen" },
      { amount: 150.0, unit: "g", name: "Basmatireis" },
      { amount: 75.0, unit: "g", name: "Limette, vegan" },
      { amount: 10.0, unit: "ml", name: "Sesamöl" },
      { amount: 130.0, unit: "g", name: "Pak Choi" },
      { amount: 150.0, unit: "g", name: "Radiesli" },
      { amount: 1.0, unit: nil, name: "Esslöffel Öl" },
      { amount: 300.0, unit: "ml", name: "Wasser" },
      { amount: nil, unit: nil, name: "nach Geschmack Salz" },
      { amount: nil, unit: nil, name: "nach Geschmack Pfeffer" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Erhitze 300 ml [600 ml] Wasser im Wasserkocher. In einen kleinen Topf mit Deckel 300 ml [600 ml] heisses Wasser* füllen. Wasser salzen* und aufkochen lassen. Reis zugeben und bei niedriger Hitze 10 Min. abgedeckt köcheln lassen. Anschliessend vom Herd nehmen und abgedeckt 10 Min. ziehen lassen.",
      "Rüebli nach Belieben schälen, längs halbieren und schräg in 0.5 cm Halbmonde schneiden. Radiesli vierteln. Pak Choi halbieren und in feine Streifen schneiden. Limette heiss waschen und 1 TL [2 TL] der Schale fein abraffeln. Limette vierteln.",
      "Sesam in einer grossen Bratpfanne ohne Fettzugabe 1 – 2 Min. rösten, bis er bräunt. Herausnehmen und beiseite stellen. Tofu mit Küchenpapier trocken tupfen. Wende Druck an, um einen Teil des im Tofu enthaltenen Wassers herauszudrücken. Anschliessend Tofu in 1 cm Würfel schneiden. In einer grossen Bratpfanne 1 EL [2 EL] Öl* erhitzen. Tofu darin 6 – 7 Min. rundum anbraten.",
      "Währenddessen in einem hohem Rührgefäss, Sesamöl, Agavendicksaft, Sojasauce, gehackten Knoblauch & Ingwer, Saft von 1 [2] Limettenspalte und Pfeffer* zu einem Dressing pürieren.",
      "In einer grossen Schüssel Rüebli, Radiesli und Pak Choi mit dem Dressing vermengen.",
      "Reis nach der Garzeit mit einer Gabel auflockern und Limettenabrieb unterheben. Limetten-Reis auf tiefen Teller verteilen, Pak Choi-Salat darauf anrichten und Sweet-Chili-Tofu darauf toppen. Mit Sesam garnieren. En Guete!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Erhitze 300 ml [600 ml] Wasser im Wasserkocher. In einen kleinen Topf mit Deckel 300 ml [600 ml] heisses Wasser* füllen. Wasser salzen* und aufkochen lassen. Reis zugeben und bei niedriger Hitze 10 Min. abgedeckt köcheln lassen. Anschliessend vom Herd nehmen und abgedeckt 10 Min. ziehen lassen.\nRüebli nach Belieben schälen, längs halbieren und schräg in 0.5 cm Halbmonde schneiden. Radiesli vierteln. Pak Choi halbieren und in feine Streifen schneiden. Limette heiss waschen und 1 TL [2 TL] der Schale fein abraffeln. Limette vierteln.\nSesam in einer grossen Bratpfanne ohne Fettzugabe 1 – 2 Min. rösten, bis er bräunt. Herausnehmen und beiseite stellen. Tofu mit Küchenpapier trocken tupfen. Wende Druck an, um einen Teil des im Tofu enthaltenen Wassers herauszudrücken. Anschliessend Tofu in 1 cm Würfel schneiden. In einer grossen Bratpfanne 1 EL [2 EL] Öl* erhitzen. Tofu darin 6 – 7 Min. rundum anbraten.\nWährenddessen in einem hohem Rührgefäss, Sesamöl, Agavendicksaft, Sojasauce, gehackten Knoblauch & Ingwer, Saft von 1 [2] Limettenspalte und Pfeffer* zu einem Dressing pürieren.\nIn einer grossen Schüssel Rüebli, Radiesli und Pak Choi mit dem Dressing vermengen.\nReis nach der Garzeit mit einer Gabel auflockern und Limettenabrieb unterheben. Limetten-Reis auf tiefen Teller verteilen, Pak Choi-Salat darauf anrichten und Sweet-Chili-Tofu darauf toppen. Mit Sesam garnieren. En Guete!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hellofresh.ch")
    expect(recipe.canonical_url).to eq("https://www.hellofresh.ch/recipes/sweet-chili-tofu-bowl-mit-pak-choi-salat-6669cf49c2b46cc6d553532c")
    expect(recipe.site_name).to eq("HelloFresh")
    expect(recipe.language).to eq("de-CH")
    expect(recipe.author).to eq("HelloFresh")
    expect(recipe.description).to eq("KLIMAHELD: Bei diesem Gericht wird 50% weniger CO2e durch Zutaten verursacht als bei einem durchschnittlichen HelloFresh Rezept. Löffel dich glücklich. Wir lieben farbenfrohe Bowl Rezepte, bei denen Du alle Zutaten aus einer Schüssel isst. Hier haben wir für dich ein buntes Gericht mit extra viel frischem Gemüse kreiert – was will man mehr?")
    expect(recipe.image).to eq("https://img.hellofresh.com/f_auto,fl_lossy,h_640,q_auto,w_1200/hellofresh_s3/image/HF_Y24_R09_W12_DE_R4655-3_Main__1low-ee107735.jpg")
    expect(recipe.category).to eq("Hauptgericht")
    expect(recipe.cuisine).to eq("Vietnamesisch")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.20454554124312)
    expect(recipe.ratings_count).to eq(22)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "693 kcal",
      "fatContent" => "26.9 g",
      "saturatedFatContent" => "3.5 g",
      "carbohydrateContent" => "84.5 g",
      "sugarContent" => "22.5 g",
      "proteinContent" => "23.4 g",
      "fiberContent" => "8 g",
      "sodiumContent" => "5.4 g",
      "servingSize" => "657"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 693.0 },
      { name: "fatContent", unit: "g", amount: 26.9 },
      { name: "saturatedFatContent", unit: "g", amount: 3.5 },
      { name: "carbohydrateContent", unit: "g", amount: 84.5 },
      { name: "sugarContent", unit: "g", amount: 22.5 },
      { name: "proteinContent", unit: "g", amount: 23.4 },
      { name: "fiberContent", unit: "g", amount: 8.0 },
      { name: "sodiumContent", unit: "g", amount: 5.4 },
      { name: "servingSize", unit: nil, amount: 657.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#page")
  end
end
