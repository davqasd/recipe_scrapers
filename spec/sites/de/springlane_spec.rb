# frozen_string_literal: true

RSpec.describe "springlane.de" do
  subject(:recipe) { scrape_cassette("de/springlane", url: "https://www.springlane.de/blogs/rezepte/haferflocken-kekse-mit-aprikose") }

  it "reads the title" do
    expect(recipe.title).to eq("Haferflocken-Kekse mit Aprikose")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "180 g Haferflocken",
      "200 g getrocknete Aprikosen",
      "80 g Kokosraspeln",
      "2 Stück Äpfel",
      "6 Stück Datteln",
      "60 ml Kokosöl",
      "2 EL Ahornsirup",
      "1 Stück Bio-Zitrone",
      "1 Prise Salz"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 180.0, unit: "g", name: "Haferflocken" },
      { amount: 200.0, unit: "g", name: "getrocknete Aprikosen" },
      { amount: 80.0, unit: "g", name: "Kokosraspeln" },
      { amount: 2.0, unit: "Stück", name: "Äpfel" },
      { amount: 6.0, unit: "Stück", name: "Datteln" },
      { amount: 60.0, unit: "ml", name: "Kokosöl" },
      { amount: 2.0, unit: "EL", name: "Ahornsirup" },
      { amount: 1.0, unit: "Stück", name: "Bio-Zitrone" },
      { amount: 1.0, unit: "Prise", name: "Salz" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Aprikosen und Datteln grob hacken.",
      "Zitronenschale abreiben.",
      "Aprikosen, Datteln, Zitronenabrieb, Haferflocken, Kokosraspeln, Ahornsirup, Kokosöl und Salz in den Food Processor geben.",
      "Ca. 3–4 Minuten zu einem festen Brei verarbeiten.",
      "Apfel mit Schale grob reiben und unter die Masse mengen.",
      "10 Kugeln formen und plattdrücken.",
      "Kekse auf den Ebenen des Dörrautomaten verteilen.",
      "Bei ca. 45 °C 10–12 Stunden trocknen lassen."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Aprikosen und Datteln grob hacken.\nZitronenschale abreiben.\nAprikosen, Datteln, Zitronenabrieb, Haferflocken, Kokosraspeln, Ahornsirup, Kokosöl und Salz in den Food Processor geben.\nCa. 3–4 Minuten zu einem festen Brei verarbeiten.\nApfel mit Schale grob reiben und unter die Masse mengen.\n10 Kugeln formen und plattdrücken.\nKekse auf den Ebenen des Dörrautomaten verteilen.\nBei ca. 45 °C 10–12 Stunden trocknen lassen.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("springlane.de")
    expect(recipe.canonical_url).to eq("https://springlane.de/blogs/rezepte/haferflocken-kekse-mit-aprikose")
    expect(recipe.site_name).to eq("Springlane")
    expect(recipe.language).to eq("de")
    expect(recipe.author).to eq("Joachim Heidel")
    expect(recipe.description).to eq("Fruchtige Aprikosen-Kokos-Riegel mit Haferflocken, Äpfeln und Datteln – natürlich süß, leicht nussig und angenehm saftig. Kokosöl und Ahornsirup verbinden die Zutaten, während Bio-Zitrone für eine frische Note sorgt. Perfekt als Snack für unterwegs, zum Frühstück oder als kleine Energiepause.")
    expect(recipe.image).to eq("https://springlane.de/cdn/shop/files/image_4_7ea85e3d-1757-4f10-aea5-c41b2f796c3e.png?v=1783030212&width=1200")
    expect(recipe.category).to eq("Vegan")
    expect(recipe.cuisine).to eq("Deutsch")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(600)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Haferflocken-Kekse mit Aprikose"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "0 kcal",
      "proteinContent" => "0.0 g",
      "carbohydrateContent" => "0.0 g",
      "fatContent" => "0.0 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 0.0 },
      { name: "proteinContent", unit: "g", amount: 0.0 },
      { name: "carbohydrateContent", unit: "g", amount: 0.0 },
      { name: "fatContent", unit: "g", amount: 0.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
