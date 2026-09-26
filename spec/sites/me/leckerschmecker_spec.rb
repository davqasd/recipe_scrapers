# frozen_string_literal: true

RSpec.describe "leckerschmecker.me" do
  subject(:recipe) { scrape_cassette("me/leckerschmecker", url: "https://www.leckerschmecker.me/gebrannte-mandeln-airfryer-a-j-gehoeren/63743511448142") }

  it "reads the title" do
    expect(recipe.title).to eq("Gebrannte Mandeln aus dem Airfryer")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "200 g Mandeln",
      "70 g Zucker",
      "1 Pck. Vanillezucker",
      "1 TL Zimt (gemahlen)",
      "2-3 EL Wasser"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 200.0, unit: "g", name: "Mandeln" },
      { amount: 70.0, unit: "g", name: "Zucker" },
      { amount: 1.0, unit: "Pck", name: "Vanillezucker" },
      { amount: 1.0, unit: "TL", name: "Zimt" },
      { amount: 2.0, unit: "EL", name: "Wasser" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Fülle die Mandeln in eine Schüssel und gib den Zucker, Vanillezucker und Zimt dazu.",
      "Gib das Wasser dazu und verrühre alles gut miteinander.",
      "Lege den Korb der Heißluftfritteuse mit Backpapier aus und verteile die Mandeln darin.",
      "Backe die Mandeln bei 200 °C 12-15 Minuten. Rühre sie dabei alle 2-3 Minuten durch, damit sie nicht anbrennen."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Fülle die Mandeln in eine Schüssel und gib den Zucker, Vanillezucker und Zimt dazu.\nGib das Wasser dazu und verrühre alles gut miteinander.\nLege den Korb der Heißluftfritteuse mit Backpapier aus und verteile die Mandeln darin.\nBacke die Mandeln bei 200 °C 12-15 Minuten. Rühre sie dabei alle 2-3 Minuten durch, damit sie nicht anbrennen.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("leckerschmecker.me")
    expect(recipe.canonical_url).to eq("https://www.leckerschmecker.me/gebrannte-mandeln-airfryer-a-l-leider/63743511448142")
    expect(recipe.site_name).to eq("Leckerschmecker")
    expect(recipe.language).to eq("de")
    expect(recipe.author).to eq("Franziska")
    expect(recipe.description).to eq("Wir zeigen dir, wie du süße und knusprige gebrannte Mandeln mit dem Airfryer machen kannst. Die schmecken genauso gut wie vom Weihnachtsmarkt!")
    expect(recipe.image).to eq("https://www.leckerschmecker.me/wp-content/uploads/sites/6/2024/11/gebrannte-mandeln-airfryer.png")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.03)
    expect(recipe.ratings_count).to eq(2254)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.leckerschmecker.me/rezepte")
  end
end
