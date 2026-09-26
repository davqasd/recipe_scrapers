# frozen_string_literal: true

RSpec.describe "migusto.migros.ch" do
  subject(:recipe) { scrape_cassette("ch/migusto", url: "https://migusto.migros.ch/de/rezepte/polenta") }

  it "reads the title" do
    expect(recipe.title).to eq("Polenta")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1,1 l Gemüsebouillon",
      "220 g Bramata-Polenta",
      "Salz",
      "1,2 l Gemüsebouillon",
      "250 g feiner Maisgriess (2-Minuten Polenta)",
      "Salz"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.1, unit: "l", name: "Gemüsebouillon" },
      { amount: 220.0, unit: "g", name: "Bramata-Polenta" },
      { amount: nil, unit: nil, name: "Salz" },
      { amount: 1.2, unit: "l", name: "Gemüsebouillon" },
      { amount: 250.0, unit: "g", name: "feiner Maisgriess" },
      { amount: nil, unit: nil, name: "Salz" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Bouillon aufkochen. Mais einrieseln lassen. Unter Rühren aufkochen und bei mittlerer Hitze ca. 10 Minuten kochen. Danach Polenta unter gelegentlichem Rühren bei kleiner Hitze 25–30 Minuten fertig kochen. Mit Salz abschmecken.",
      "Bouillon aufkochen. Maisgriess unter Rühren einrieseln lassen. Unter ständigem Rühren ca. 2 Minuten köcheln lassen. Pfanne vom Herd ziehen. Zugedeckt ca. 5 Minuten quellen lassen. Mit Salz abschmecken."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Bouillon aufkochen. Mais einrieseln lassen. Unter Rühren aufkochen und bei mittlerer Hitze ca. 10 Minuten kochen. Danach Polenta unter gelegentlichem Rühren bei kleiner Hitze 25–30 Minuten fertig kochen. Mit Salz abschmecken.\nBouillon aufkochen. Maisgriess unter Rühren einrieseln lassen. Unter ständigem Rühren ca. 2 Minuten köcheln lassen. Pfanne vom Herd ziehen. Zugedeckt ca. 5 Minuten quellen lassen. Mit Salz abschmecken.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("migusto.migros.ch")
    expect(recipe.canonical_url).to eq("https://migusto.migros.ch/de/rezepte/polenta")
    expect(recipe.site_name).to eq("Migusto")
    expect(recipe.language).to eq("de")
    expect(recipe.author).to eq("Migusto")
    expect(recipe.description).to eq("Zubereitet mit Bramata-Mais, schmeckt die Polenta wie im Tessin. Der grobkörnige Mais bleibt al dente. Nach Belieben Parmesan oder Bergkäse darüber reiben.")
    expect(recipe.image).to eq("https://recipeimages.migros.ch/crop/v-w-330-h-186-a-center_center/20cc1cf3a77dfdee2255d94517cb372ad936ba0b/polenta-0-16-9.jpg")
    expect(recipe.category).to eq("Beilage")
    expect(recipe.cuisine).to eq("Schweiz")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(50)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Laktosefrei"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.0)
    expect(recipe.ratings_count).to eq(103)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "210 kcal",
      "fatContent" => "2 g",
      "fiberContent" => "46 g",
      "proteinContent" => "6 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 210.0 },
      { name: "fatContent", unit: "g", amount: 2.0 },
      { name: "fiberContent", unit: "g", amount: 46.0 },
      { name: "proteinContent", unit: "g", amount: 6.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/de.html")
  end
end
