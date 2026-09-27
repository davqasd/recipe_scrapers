# frozen_string_literal: true

RSpec.describe "uitpaulineskeuken.nl" do
  subject(:recipe) { scrape_cassette("nl/uitpaulineskeuken", url: "https://uitpaulineskeuken.nl/recept/aardbeien-met-chocola") }

  it "reads the title" do
    expect(recipe.title).to eq("Aardbeien met chocola")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "300 gr aardbeien",
      "250 gr pure of witte chocolade",
      "1 tl kokosolie",
      "Evt sprinkles"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 300.0, unit: "gr", name: "aardbeien" },
      { amount: 250.0, unit: "gr", name: "pure of witte chocolade" },
      { amount: 1.0, unit: "tl", name: "kokosolie" },
      { amount: nil, unit: nil, name: "Evt sprinkles" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Zo maak je aardbeien met chocola",
      "Was de aardbeien een uur van tevoren want ze moeten namelijk helemaal droog zijn voordat je ze in de chocolade dipt. Laat de aardbeien op kamertemperatuur komen.",
      "Hak de chocolade in stukken. Smelt dit samen met de kokosolie au bain-marie.",
      "Houdt het kroontje vast en dip de aardbei in de chocolade. Laat hem uitlekken en leg hem dan op bakpapier.",
      "Drizzle er naar wens nog wat chocolade overheen of bestrooi ze met geraspte kokos of sprinkles. Laat de aardbeien uitharden in de koelkast."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Ingrediënten voor 2 personen", 4]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Zo maak je aardbeien met chocola\nWas de aardbeien een uur van tevoren want ze moeten namelijk helemaal droog zijn voordat je ze in de chocolade dipt. Laat de aardbeien op kamertemperatuur komen.\nHak de chocolade in stukken. Smelt dit samen met de kokosolie au bain-marie.\nHoudt het kroontje vast en dip de aardbei in de chocolade. Laat hem uitlekken en leg hem dan op bakpapier.\nDrizzle er naar wens nog wat chocolade overheen of bestrooi ze met geraspte kokos of sprinkles. Laat de aardbeien uitharden in de koelkast.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("uitpaulineskeuken.nl")
    expect(recipe.canonical_url).to eq("https://uitpaulineskeuken.nl/recept/aardbeien-met-chocola")
    expect(recipe.site_name).to eq("Uit Pauline's Keuken")
    expect(recipe.language).to eq("nl-NL")
    expect(recipe.author).to eq("Pauline")
    expect(recipe.description).to eq("Aardbeien met chocolade: de luxe traktatie voor elke gelegenheid. Perfect voor een romantisch avondje, een feest of gewoon zomaar op de bank.")
    expect(recipe.image).to eq("https://uitpaulineskeuken.nl/wp-content/uploads/2026/04/Aardbeien-met-chocola-1.jpg")
    expect(recipe.category).to eq("Nagerecht")
    expect(recipe.cuisine).to eq("Hollandse recepten")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(15)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["aardbeien met chocola"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.34)
    expect(recipe.ratings_count).to eq(6)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "726 kcal",
      "carbohydrateContent" => "86 g",
      "sugarContent" => "81 g",
      "proteinContent" => "8 g",
      "fatContent" => "41 g",
      "saturatedFatContent" => "25 g",
      "fiberContent" => "3 g",
      "servingSize" => "1 portie"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 726.0 },
      { name: "carbohydrateContent", unit: "g", amount: 86.0 },
      { name: "sugarContent", unit: "g", amount: 81.0 },
      { name: "proteinContent", unit: "g", amount: 8.0 },
      { name: "fatContent", unit: "g", amount: 41.0 },
      { name: "saturatedFatContent", unit: "g", amount: 25.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "servingSize", unit: "portie", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
