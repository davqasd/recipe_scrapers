# frozen_string_literal: true

RSpec.describe "tine.no" do
  subject(:recipe) { scrape_cassette("no/tine", url: "https://www.tine.no/oppskrifter/middag-og-hovedretter/fisk-og-skalldyr/torsk-med-eggesaus") }

  it "reads the title" do
    expect(recipe.title).to eq("Torsk med eggesaus")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "600 g torskefilet",
      "1 ts sukker",
      "0.25 ts salt",
      "0.25 ts pepper",
      "2 ss TINE® Meierismør",
      "3 dl TINE® Kremfløte",
      "2 dl fiskebuljong",
      "1 ts maizena",
      "2 stykk egg",
      "revet frisk 2 ss pepperrot",
      "finhakket 0.5 dl dill"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 600.0, unit: "g", name: "torskefilet" },
      { amount: 1.0, unit: "ts", name: "sukker" },
      { amount: 0.25, unit: "ts", name: "salt" },
      { amount: 0.25, unit: "ts", name: "pepper" },
      { amount: 2.0, unit: "ss", name: "TINE® Meierismør" },
      { amount: 3.0, unit: "dl", name: "TINE® Kremfløte" },
      { amount: 2.0, unit: "dl", name: "fiskebuljong" },
      { amount: 1.0, unit: "ts", name: "maizena" },
      { amount: 2.0, unit: "stykk", name: "egg" },
      { amount: 2.0, unit: "ss", name: "pepperrot, revet frisk" },
      { amount: 0.5, unit: "dl", name: "dill, finhakket" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Step 1",
      "Sett på en kjele med vann og legg romtempererte egg oppi. Kok opp og beregn ca. 10 minutter fra du la eggene i vannet. Eggene skal være hardkokte.",
      "Step 2",
      "Strø sukker over fisken, krydre med salt og nykvernet pepper.",
      "Step 3",
      "Varm smør i en stekepanne og stek torsken på den ene siden. Legg på lokk til fisken er ferdig, ca.10 minutter.",
      "Step 4",
      "Kok opp fløte og buljong i en kjele, la koke i ca. 5 minutter. Jevn med maisenna utrørt i litt kaldt vann. Bland i hakket egg og dill, krydre med salt og pepper.",
      "Step 5",
      "Server torsken med saus, revet pepperrot og dill. Grønne bønner og poteter smaker godt til."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Step 1\nSett på en kjele med vann og legg romtempererte egg oppi. Kok opp og beregn ca. 10 minutter fra du la eggene i vannet. Eggene skal være hardkokte.\nStep 2\nStrø sukker over fisken, krydre med salt og nykvernet pepper.\nStep 3\nVarm smør i en stekepanne og stek torsken på den ene siden. Legg på lokk til fisken er ferdig, ca.10 minutter.\nStep 4\nKok opp fløte og buljong i en kjele, la koke i ca. 5 minutter. Jevn med maisenna utrørt i litt kaldt vann. Bland i hakket egg og dill, krydre med salt og pepper.\nStep 5\nServer torsken med saus, revet pepperrot og dill. Grønne bønner og poteter smaker godt til.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("tine.no")
    expect(recipe.canonical_url).to eq("https://www.tine.no/oppskrifter/middag-og-hovedretter/fisk-og-skalldyr/torsk-med-eggesaus")
    expect(recipe.site_name).to eq("TINE.no")
    expect(recipe.language).to eq("no")
    expect(recipe.author).to eq("TINE Kjøkken")
    expect(recipe.description).to eq("Deilig hvit fisk i kombinasjon med en fyldig eggesaus er en lettvint og god fiskemiddag både til travle hverdager og gode søndagsmiddager.")
    expect(recipe.image).to eq("https://www.tine.no/_/recipeimage/w_1200,h_900,c_fill,x_1500,y_1000,g_xy_center/recipeimage/353925.jpg")
    expect(recipe.category).to eq("middag")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["easy"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.1)
    expect(recipe.ratings_count).to eq(17)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/oppskrifter")
  end
end
