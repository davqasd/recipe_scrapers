# frozen_string_literal: true

RSpec.describe "tasteline.com" do
  subject(:recipe) { scrape_cassette("com/tasteline", url: "https://www.tasteline.com/recept/algkottbullar/") }

  it "reads the title" do
    expect(recipe.title).to eq("köttbullar älg")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq(%w[
      älgfärs
      grädde
      salt
      svartpeppar
      vitlök
      lökpulver
      grillkrydda
      ströbröd
      ägg
      senap
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "älgfärs" },
      { amount: nil, unit: nil, name: "grädde" },
      { amount: nil, unit: nil, name: "salt" },
      { amount: nil, unit: nil, name: "svartpeppar" },
      { amount: nil, unit: nil, name: "vitlök" },
      { amount: nil, unit: nil, name: "lökpulver" },
      { amount: nil, unit: nil, name: "grillkrydda" },
      { amount: nil, unit: nil, name: "ströbröd" },
      { amount: nil, unit: nil, name: "ägg" },
      { amount: nil, unit: nil, name: "senap" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Sätt ugnen på 150 grader.",
      "Blanda alla ingredienser i en bunke, blanda runt allt för hand.",
      "Låt vila i kylen ca 30 min så ströbrödet hinner svälla lite.",
      "Rulla bollar i valfri storlek, blöt händerna i kallvatten för bättre resultat.",
      "Stek köttbullarna på medelhög värme så dom får stekyta.",
      "Lägg alla färdigstekta köttbullarna på en plåt.",
      "Slå på grädden och låt stå i ugnen tills köttbullarna är färdiga.",
      "När köttbullarna är klar, sila ner grädden i en kastrull och red en brunsås."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Sätt ugnen på 150 grader.\nBlanda alla ingredienser i en bunke, blanda runt allt för hand.\nLåt vila i kylen ca 30 min så ströbrödet hinner svälla lite.\nRulla bollar i valfri storlek, blöt händerna i kallvatten för bättre resultat.\nStek köttbullarna på medelhög värme så dom får stekyta.\nLägg alla färdigstekta köttbullarna på en plåt.\nSlå på grädden och låt stå i ugnen tills köttbullarna är färdiga.\nNär köttbullarna är klar, sila ner grädden i en kastrull och red en brunsås.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("tasteline.com")
    expect(recipe.canonical_url).to eq("https://www.tasteline.com/recept/algkottbullar/")
    expect(recipe.site_name).to eq("Tasteline")
    expect(recipe.language).to eq("sv-SE")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Riktigt saftiga älgköttbullar")
    expect(recipe.image).to eq("https://eu-central-1.linodeobjects.com/tasteline/2015/09/algkottbullar_2.jpg")
    expect(recipe.category).to eq("Mat")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(60)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(%w[köttbullar varmrätt])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(3.9)
    expect(recipe.ratings_count).to eq(715)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#feedback")
  end
end
