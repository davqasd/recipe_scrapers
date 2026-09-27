# frozen_string_literal: true

RSpec.describe "24kitchen.nl" do
  subject(:recipe) { scrape_cassette("nl/24kitchen", url: "https://www.24kitchen.nl/recepten/aardappelpreisoep-met-gerookte-zalm") }

  it "reads the title" do
    expect(recipe.title).to eq("Aardappel-preisoep met gerookte zalm")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 sjalotten",
      "4 tenen knoflook",
      "3 preien",
      "20 g boter",
      "1 l water",
      "2 groentebouillonblokjes",
      "700 g kruimige aardappels",
      "300 g gerookte zalm",
      "4 takjes bladpeterselie",
      "1 kleine bloemkool",
      "2 el extra vierge olijfolie",
      "1 el azijn",
      "1 el mosterd",
      "staafmixer"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: nil, name: "sjalotten" },
      { amount: 4.0, unit: nil, name: "tenen knoflook" },
      { amount: 3.0, unit: nil, name: "preien" },
      { amount: 20.0, unit: "g", name: "boter" },
      { amount: 1.0, unit: "l", name: "water" },
      { amount: 2.0, unit: nil, name: "groentebouillonblokjes" },
      { amount: 700.0, unit: "g", name: "kruimige aardappels" },
      { amount: 300.0, unit: "g", name: "gerookte zalm" },
      { amount: 4.0, unit: "takjes", name: "bladpeterselie" },
      { amount: 1.0, unit: nil, name: "kleine bloemkool" },
      { amount: 2.0, unit: "el", name: "extra vierge olijfolie" },
      { amount: 1.0, unit: "el", name: "azijn" },
      { amount: 1.0, unit: "el", name: "mosterd" },
      { amount: nil, unit: nil, name: "staafmixer" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Bereidingsstappen",
      "SoepVerwarm de oven voor op 180 °C.Leg de sjalotjes en de knoflook met schil in een ovenschaal en bak circa 20 minuten in de oven.Halveer de preien in de lengte en snijd in halve ringen.Verhit de boter in een ruime (braad)pan en bak de preien circa 4 minuten.Schenk het water erbij en voeg de bouillonblokjes toe.Schil en snijd de aardappels in kleine blokjes. Voeg de aardappels toe aan de pan en kook in circa 8 minuten gaar.Haal de knoflook en sjalotjes uit de oven verwijder de schil en voeg de knoflook en sjalotjes toe aan de pan.Pureer het geheel met een staafmixer tot een gladde soep. Breng op smaak met een beetje peperSnijd de zalm in stukken en voeg twee derde toe aan de soep. (bewaar de rest voor de bloemkool)Pluk de peterselie. Garneer de soep met peterselie.BloemkoolBreng een pan met water en een beetje zout aan de kook.Snijd de bloemkool in roosjes. Kook de bloemkoolroosjes in circa 4 minuten beetgaar.Giet de bloemkool af.Meng in een kom de olijfolie extra vergine azijn mosterd en een beetje zout en peper.Voeg de bloemkool en de resterende zalm toe en roer goed door."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Bereidingsstappen\nSoepVerwarm de oven voor op 180 °C.Leg de sjalotjes en de knoflook met schil in een ovenschaal en bak circa 20 minuten in de oven.Halveer de preien in de lengte en snijd in halve ringen.Verhit de boter in een ruime (braad)pan en bak de preien circa 4 minuten.Schenk het water erbij en voeg de bouillonblokjes toe.Schil en snijd de aardappels in kleine blokjes. Voeg de aardappels toe aan de pan en kook in circa 8 minuten gaar.Haal de knoflook en sjalotjes uit de oven verwijder de schil en voeg de knoflook en sjalotjes toe aan de pan.Pureer het geheel met een staafmixer tot een gladde soep. Breng op smaak met een beetje peperSnijd de zalm in stukken en voeg twee derde toe aan de soep. (bewaar de rest voor de bloemkool)Pluk de peterselie. Garneer de soep met peterselie.BloemkoolBreng een pan met water en een beetje zout aan de kook.Snijd de bloemkool in roosjes. Kook de bloemkoolroosjes in circa 4 minuten beetgaar.Giet de bloemkool af.Meng in een kom de olijfolie extra vergine azijn mosterd en een beetje zout en peper.Voeg de bloemkool en de resterende zalm toe en roer goed door.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("24kitchen.nl")
    expect(recipe.canonical_url).to eq("https://www.24kitchen.nl/recepten/aardappelpreisoep-met-gerookte-zalm")
    expect(recipe.site_name).to eq("24Kitchen")
    expect(recipe.language).to eq("nl")
    expect(recipe.author).to eq("Evert te Pas")
    expect(recipe.description).to be_nil
    expect(recipe.image).to eq("https://www.24kitchen.nl/files/styles/social_media_share/public/2013-02/138980.original.jpg.webp?itok=tvEizwjn")
    expect(recipe.category).to eq("Hoofdgerecht")
    expect(recipe.cuisine).to eq("Nederlands")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(2.79157)
    expect(recipe.ratings_count).to eq(134)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
