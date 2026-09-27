# frozen_string_literal: true

RSpec.describe "essen-und-trinken.de" do
  subject(:recipe) { scrape_cassette("de/essen_und_trinken", url: "https://www.essen-und-trinken.de/rezepte/zitronenkuchen-rezept-fuer-den-kuchenklassiker-12086296.html") }

  it "reads the title" do
    expect(recipe.title).to eq("Saftiger Zitronenkuchen: Rezept mit Zuckerguss")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 Bio-Zitrone",
      "6 Bio-Ei",
      "350 g Zucker",
      "350 g Mehl",
      "2 Tl Backpulver",
      "1 Pk. Vanillezucker",
      "350 g Margarine",
      "300 g Puderzucker"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: nil, name: "Bio-Zitrone" },
      { amount: 6.0, unit: nil, name: "Bio-Ei" },
      { amount: 350.0, unit: "g", name: "Zucker" },
      { amount: 350.0, unit: "g", name: "Mehl" },
      { amount: 2.0, unit: "Tl", name: "Backpulver" },
      { amount: 1.0, unit: "Pk", name: "Vanillezucker" },
      { amount: 350.0, unit: "g", name: "Margarine" },
      { amount: 300.0, unit: "g", name: "Puderzucker" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Backofen auf 180 Grad vorheizen und ein Backblech mit Backpapier auslegen. Zitronen heiß abwaschen, trocken tupfen und Zitronenschale fein abreiben. Anschließend Zitronen auspressen. 3–4 El Zitronensaft für den Guss beiseitestellen.",
      "In einer Schüssel Eier und Zucker schaumig schlagen. Mehl und Backpulver sieben und Vanillezucker untermischen. Abwechselnd mit der Margarine unter die Ei-Zucker-Masse rühren. Zitronenabrieb und restlichen Saft zugeben. Auf das Backblech geben und glatt streichen. Im Backofen auf der 2. Schiene von unten 20–30 Minuten backen. Stäbchenprobe machen.",
      "Für die Zitronenglasur Puderzucker erst mit 2 EL Zitronensaft verrühren. Ist der Guss noch zu fest, einen oder zwei weitere EL Zitronensaft zugeben und glatt rühren. Kuchen aus dem Backofen nehmen und noch warm mit einer Gabel einstechen. Glasur auf dem Kuchen verstreichen und abkühlen lassen."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Backofen auf 180 Grad vorheizen und ein Backblech mit Backpapier auslegen. Zitronen heiß abwaschen, trocken tupfen und Zitronenschale fein abreiben. Anschließend Zitronen auspressen. 3–4 El Zitronensaft für den Guss beiseitestellen.\nIn einer Schüssel Eier und Zucker schaumig schlagen. Mehl und Backpulver sieben und Vanillezucker untermischen. Abwechselnd mit der Margarine unter die Ei-Zucker-Masse rühren. Zitronenabrieb und restlichen Saft zugeben. Auf das Backblech geben und glatt streichen. Im Backofen auf der 2. Schiene von unten 20–30 Minuten backen. Stäbchenprobe machen.\nFür die Zitronenglasur Puderzucker erst mit 2 EL Zitronensaft verrühren. Ist der Guss noch zu fest, einen oder zwei weitere EL Zitronensaft zugeben und glatt rühren. Kuchen aus dem Backofen nehmen und noch warm mit einer Gabel einstechen. Glasur auf dem Kuchen verstreichen und abkühlen lassen.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("essen-und-trinken.de")
    expect(recipe.canonical_url).to eq("https://www.essen-und-trinken.de/rezepte/zitronenkuchen-rezept-fuer-den-kuchenklassiker-12086296.html")
    expect(recipe.site_name).to eq("essen-und-trinken.de")
    expect(recipe.language).to eq("de")
    expect(recipe.author).to eq("essen-und-trinken.de")
    expect(recipe.description).to eq("Saftiger Zitronenkuchen ist ein Rührkuchen-Klassiker! Hier finden Sie das beste Zitronenkuchen-Rezept und praktische Tipps.")
    expect(recipe.image).to eq("https://image.essen-und-trinken.de/13932976/t/52/v2/w1440/r1.7778/-/zitronenkuchen-adobestock-601116880-asife.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("20 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.8)
    expect(recipe.ratings_count).to eq(598)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "0",
      "proteinContent" => "0",
      "fatContent" => "0",
      "carbohydrateContent" => "0"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: nil, amount: 0.0 },
      { name: "proteinContent", unit: nil, amount: 0.0 },
      { name: "fatContent", unit: nil, amount: 0.0 },
      { name: "carbohydrateContent", unit: nil, amount: 0.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
