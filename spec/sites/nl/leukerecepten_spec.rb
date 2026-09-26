# frozen_string_literal: true

RSpec.describe "leukerecepten.nl" do
  subject(:recipe) { scrape_cassette("nl/leukerecepten", url: "https://www.leukerecepten.nl/recepten/pasta-met-paddenstoelen/") }

  it "reads the title" do
    expect(recipe.title).to eq("Pasta met paddenstoelen en champignons")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "160 gr spaghetti",
      "250 gr paddenstoelen (en champignons)",
      "1 teen knoflook",
      "1 ui",
      "200 gr crème fraîche",
      "30 gr Parmezaanse kaas (geraspt)",
      "100 gr verse spinazie",
      "2 eetlepels pijnboompitten (geroosterd)",
      "snuf peper en zout",
      "Optioneel: truffeltapenade of truffelolie"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 160.0, unit: "gr", name: "spaghetti" },
      { amount: 250.0, unit: "gr", name: "paddenstoelen" },
      { amount: 1.0, unit: "teen", name: "knoflook" },
      { amount: 1.0, unit: nil, name: "ui" },
      { amount: 200.0, unit: "gr", name: "crème fraîche" },
      { amount: 30.0, unit: "gr", name: "Parmezaanse kaas" },
      { amount: 100.0, unit: "gr", name: "verse spinazie" },
      { amount: 2.0, unit: "eetlepels", name: "pijnboompitten" },
      { amount: 1.0, unit: "snuf", name: "peper en zout" },
      { amount: nil, unit: nil, name: "Optioneel: truffeltapenade of truffelolie" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Bereiding",
      "Kook de spaghetti gaar en vang tijdens het afgieten een deel van het kookvocht op. Snijd de paddenstoelen in plakjes. Verhit een beetje olie of boter in een pan en bak de paddenstoelen een paar minuten tot ze iets geslonken zijn. Schep ze uit de pan.",
      "Snipper de ui en knoflook en fruit aan in dezelfde pan. Doe de spinazie er bij laat slinken. Schep de creme fraiche erbij en een scheut van het kookvocht van de pasta. Breng de romige saus op smaak met peper en zout.",
      "Schep de spaghetti door de saus. Voeg als laatste de gebakken paddenstoelen toe en warm nog even mee. Serveer de pasta met wat Parmezaanse kaas en pijnboompitten.",
      "Tip: voeg een beetje truffeltapenade of truffelolie toe op het laatst.",
      "Parmezaanse kaas bevat dierlijk stremsel waardoor dit recept niet 100% vegetarisch is. Vervang de kaas door een oude of gerijpte kaas met vegetarisch stremsel of probeer eens een veganistische kaas."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Bereiding\nKook de spaghetti gaar en vang tijdens het afgieten een deel van het kookvocht op. Snijd de paddenstoelen in plakjes. Verhit een beetje olie of boter in een pan en bak de paddenstoelen een paar minuten tot ze iets geslonken zijn. Schep ze uit de pan.\nSnipper de ui en knoflook en fruit aan in dezelfde pan. Doe de spinazie er bij laat slinken. Schep de creme fraiche erbij en een scheut van het kookvocht van de pasta. Breng de romige saus op smaak met peper en zout.\nSchep de spaghetti door de saus. Voeg als laatste de gebakken paddenstoelen toe en warm nog even mee. Serveer de pasta met wat Parmezaanse kaas en pijnboompitten.\nTip: voeg een beetje truffeltapenade of truffelolie toe op het laatst.\nParmezaanse kaas bevat dierlijk stremsel waardoor dit recept niet 100% vegetarisch is. Vervang de kaas door een oude of gerijpte kaas met vegetarisch stremsel of probeer eens een veganistische kaas.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("leukerecepten.nl")
    expect(recipe.canonical_url).to eq("https://www.leukerecepten.nl/recepten/pasta-met-paddenstoelen/")
    expect(recipe.site_name).to eq("Leuke Recepten")
    expect(recipe.language).to eq("nl")
    expect(recipe.author).to eq("Sandra Waterschoot")
    expect(recipe.description).to eq("Ik ben gek op paddenstoelen in pasta, vooral omdat ze het gerecht meteen een volle en hartige smaak geven. Ook passen ze perfect bij de romige saus met crème fraîche, spinazie en een scheutje kookvocht van de pasta. In dit recept gebruik ik spaghetti, omdat de saus hier goed mee mengt. Maar je kunt natuurlijk ook een andere pastasoort gebruiken als je dat lekkerder vindt. Voor het serveren maak ik de pasta af met wat Parmezaanse kaas en pijnboompitten. Deze pasta met paddenstoelen is helemaal niet moeilijk om te maken en binnen 25 minuten staat hij al op tafel.")
    expect(recipe.image).to eq("https://www.leukerecepten.nl/app/uploads/2020/10/pasta-met-paddenstoelen-1.jpg")
    expect(recipe.category).to eq("Hoofdgerechten")
    expect(recipe.cuisine).to eq("Italiaanse recepten")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to eq(25)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Herfstrecepten", "Pasta", "Vegetarische", "Crème fraîche"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["VegetarianDiet"])
    expect(recipe.ratings).to eq(4.0)
    expect(recipe.ratings_count).to eq(328)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "670 kcal energie",
      "fatContent" => "35 g vet",
      "saturatedFatContent" => "20 g waarvan verzadigd",
      "carbohydrateContent" => "60 koolhydraten",
      "sugarContent" => "5 g suiker",
      "fiberContent" => "5 g vezels",
      "proteinContent" => "20 g eiwit",
      "sodiumContent" => "1500 mg zout"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 670.0 },
      { name: "fatContent", unit: "g", amount: 35.0 },
      { name: "saturatedFatContent", unit: "g", amount: 20.0 },
      { name: "carbohydrateContent", unit: "koolhydraten", amount: 60.0 },
      { name: "sugarContent", unit: "g", amount: 5.0 },
      { name: "fiberContent", unit: "g", amount: 5.0 },
      { name: "proteinContent", unit: "g", amount: 20.0 },
      { name: "sodiumContent", unit: "mg", amount: 1500.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
