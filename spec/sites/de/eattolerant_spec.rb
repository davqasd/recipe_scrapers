# frozen_string_literal: true

RSpec.describe "eattolerant.de" do
  subject(:recipe) { scrape_cassette("de/eattolerant", url: "https://eattolerant.de/suppe/vegane-rotkohlsuppe-mit-kokosmilch-histaminarm-glutenfrei-low-carb/") }

  it "reads the title" do
    expect(recipe.title).to eq("Vegane Rotkohlsuppe mit Kokosmilch")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "500 g Rotkohl (Nettogewicht)",
      "1 kleiner Apfel (z.B. Boskopp)",
      "200 g Kartoffeln",
      "1 Zwiebel",
      "1 kleines Stück Ingwer",
      "500 ml Gemüsebrühe",
      "200 ml Kokosmilch",
      "1 TL Zucker",
      "20 ml Verjus Sauer",
      "3 EL Kokosöl"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 500.0, unit: "g", name: "Rotkohl" },
      { amount: 1.0, unit: nil, name: "kleiner Apfel" },
      { amount: 200.0, unit: "g", name: "Kartoffeln" },
      { amount: 1.0, unit: nil, name: "Zwiebel" },
      { amount: 1.0, unit: "Stück", name: "Ingwer" },
      { amount: 500.0, unit: "ml", name: "Gemüsebrühe" },
      { amount: 200.0, unit: "ml", name: "Kokosmilch" },
      { amount: 1.0, unit: "TL", name: "Zucker" },
      { amount: 20.0, unit: "ml", name: "Verjus Sauer" },
      { amount: 3.0, unit: "EL", name: "Kokosöl" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Die äußeren Blätter vom Rotkohl entfernen, anschließend halbieren, großzügig den Strunk entfernen und in kleine Stücke schneiden.",
      "Den Apfel sowie die Kartoffeln waschen und schälen, ebenfalls in kleine Stücke schneiden.",
      "Die Zwiebel in Würfel schneiden und den Ingwer fein reiben.",
      "Das Kokosöl in einem Top erhitzen, anschließend die Zwiebel und den Rotkohl kurz darin anbraten. Währenddessen mit Salz würzen.",
      "Die Apfel- und Kartoffelstücke zugeben, ebenfalls kurz anbraten.",
      "Die Gemüsebrühe, Kokosmilch und den Ingwer zugeben und die Suppe ca. 25 Minuten köcheln lassen. Kurz vor Ende der Garzeit den Verjus sowie Zucker zugeben. Anschließend fein pürieren und sofort servieren."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Die äußeren Blätter vom Rotkohl entfernen, anschließend halbieren, großzügig den Strunk entfernen und in kleine Stücke schneiden.\nDen Apfel sowie die Kartoffeln waschen und schälen, ebenfalls in kleine Stücke schneiden.\nDie Zwiebel in Würfel schneiden und den Ingwer fein reiben.\nDas Kokosöl in einem Top erhitzen, anschließend die Zwiebel und den Rotkohl kurz darin anbraten. Währenddessen mit Salz würzen.\nDie Apfel- und Kartoffelstücke zugeben, ebenfalls kurz anbraten.\nDie Gemüsebrühe, Kokosmilch und den Ingwer zugeben und die Suppe ca. 25 Minuten köcheln lassen. Kurz vor Ende der Garzeit den Verjus sowie Zucker zugeben. Anschließend fein pürieren und sofort servieren.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("eattolerant.de")
    expect(recipe.canonical_url).to eq("https://eattolerant.de/suppe/vegane-rotkohlsuppe-mit-kokosmilch-histaminarm-glutenfrei-low-carb/")
    expect(recipe.site_name).to eq("Eat Tolerant")
    expect(recipe.language).to eq("de")
    expect(recipe.author).to eq("Jessica")
    expect(recipe.description).to eq("Histaminarmes Rezept für eine einfache und cremige vegane Rotkohlsuppe mit Kokosmilch. Low Carb, Glutenfrei.")
    expect(recipe.image).to eq("https://eattolerant.de/wp-content/uploads/2022/01/Vegane-Rotkohlsuppe-13-scaled.jpg")
    expect(recipe.category).to eq("Hauptgericht")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(40)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
