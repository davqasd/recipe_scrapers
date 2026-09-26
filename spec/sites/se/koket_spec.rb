# frozen_string_literal: true

RSpec.describe "koket.se" do
  subject(:recipe) { scrape_cassette("se/koket", url: "https://www.koket.se/mitt-kok/tommy-myllymaki/myllymakis-toast-skagen") }

  it "reads the title" do
    expect(recipe.title).to eq("Myllymäkis toast skagen")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 kg räkor med skal (gärna färska av fin kvalitet)",
      "2 äggulor",
      "2 tsk senap",
      "1 msk vitvinsvinäger",
      "6 dl matolja",
      "1 kruka dill",
      "10 cm färsk pepparrot, skalad",
      "4 skivor vitt bröd (ej levain)",
      "smör, till stekning",
      "50 g löjrom",
      "1 citron"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "kg", name: "räkor med skal" },
      { amount: 2.0, unit: nil, name: "äggulor" },
      { amount: 2.0, unit: "tsk", name: "senap" },
      { amount: 1.0, unit: "msk", name: "vitvinsvinäger" },
      { amount: 6.0, unit: "dl", name: "matolja" },
      { amount: 1.0, unit: "kruka", name: "dill" },
      { amount: 10.0, unit: "cm", name: "färsk pepparrot, skalad" },
      { amount: 4.0, unit: "skivor", name: "vitt bröd" },
      { amount: nil, unit: nil, name: "smör, till stekning" },
      { amount: 50.0, unit: "g", name: "löjrom" },
      { amount: 1.0, unit: nil, name: "citron" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Skala alla räkor och ställ åt sidan.",
      "Gör en majonnäs genom att lägga ner äggulor, senapen och vinägern i en bunke. Tillsätt matoljan i en tunn stråle medan du vispar hela tiden. Använd elvisp eller handvisp. När majonnäsen är tjock och du ser dragen/spåren av vispen i majonnäsen är den klar.",
      "Lägg alla räkor i en bunke, tillsätt fint plockad dill och blanda ner lite majonnäs i taget.",
      "Tillsätt lite riven pepparrot och smaka av. Slå på mer majonnäs för en rinnigare röra eller mer pepparrot för mer sting.",
      "Ta fram brödet och skär ut önskad form utan att ta med kanterna, använd en skål eller ett glas som mall om ni vill ha runda bröd. Stek sedan gyllene i smör.",
      "Lägg upp bröden på tallrik, toppa med skagenröra och en rejäl klick löjrom. Avsluta med en dillkvist och en citronskiva."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Skala alla räkor och ställ åt sidan.\nGör en majonnäs genom att lägga ner äggulor, senapen och vinägern i en bunke. Tillsätt matoljan i en tunn stråle medan du vispar hela tiden. Använd elvisp eller handvisp. När majonnäsen är tjock och du ser dragen/spåren av vispen i majonnäsen är den klar.\nLägg alla räkor i en bunke, tillsätt fint plockad dill och blanda ner lite majonnäs i taget.\nTillsätt lite riven pepparrot och smaka av. Slå på mer majonnäs för en rinnigare röra eller mer pepparrot för mer sting.\nTa fram brödet och skär ut önskad form utan att ta med kanterna, använd en skål eller ett glas som mall om ni vill ha runda bröd. Stek sedan gyllene i smör.\nLägg upp bröden på tallrik, toppa med skagenröra och en rejäl klick löjrom. Avsluta med en dillkvist och en citronskiva.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("koket.se")
    expect(recipe.canonical_url).to eq("https://www.koket.se/mitt-kok/tommy-myllymaki/myllymakis-toast-skagen")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("sv")
    expect(recipe.author).to eq("Tommy Myllymäki")
    expect(recipe.description).to eq("Toast skagen är en klassisk förrätt på årets festdag - nyårsafton. Tommys variant görs med hemslagen majonnäs, pepparrot och löjrom.")
    expect(recipe.image).to eq("https://img.koket.se/standard-mega/myllymakis-toast-skagen-2.jpg")
    expect(recipe.category).to eq("Fest")
    expect(recipe.cuisine).to eq("Sverige/Norden")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(%w[Skaldjur Räkor Nyår])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(3.7)
    expect(recipe.ratings_count).to eq(407)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
