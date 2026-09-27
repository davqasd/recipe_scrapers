# frozen_string_literal: true

RSpec.describe "arla.se" do
  subject(:recipe) { scrape_cassette("se/arla", url: "https://www.arla.se/recept/oxfile-surprise-med-rodvinssas/") }

  it "reads the title" do
    expect(recipe.title).to eq("Oxfilé surprise med rödvinssås")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1⅕ kg oxfilé",
      "1 tsk salt",
      "1 krm svartpeppar",
      "g Svenskt Smör från Arla® att steka i",
      "3 dl grovriven Arla Ko Präst® Ost 31%",
      "1 dl grovhackade valnötter",
      "1 dl Arla Köket® Crème fraiche",
      "2 schalottenlökar",
      "4 dl rödvin",
      "1 dl vatten",
      "4 msk kalvfond",
      "1 msk tomatpuré",
      "1 krm vitpeppar",
      "1 msk majsstärkelse",
      "100 g Svenskt Smör från Arla®"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.2, unit: "kg", name: "oxfilé" },
      { amount: 1.0, unit: "tsk", name: "salt" },
      { amount: 1.0, unit: "krm", name: "svartpeppar" },
      { amount: nil, unit: nil, name: "g Svenskt Smör från Arla® att steka i" },
      { amount: 3.0, unit: "dl", name: "grovriven Arla Ko Präst® Ost 31%" },
      { amount: 1.0, unit: "dl", name: "grovhackade valnötter" },
      { amount: 1.0, unit: "dl", name: "Arla Köket® Crème fraiche" },
      { amount: 2.0, unit: nil, name: "schalottenlökar" },
      { amount: 4.0, unit: "dl", name: "rödvin" },
      { amount: 1.0, unit: "dl", name: "vatten" },
      { amount: 4.0, unit: "msk", name: "kalvfond" },
      { amount: 1.0, unit: "msk", name: "tomatpuré" },
      { amount: 1.0, unit: "krm", name: "vitpeppar" },
      { amount: 1.0, unit: "msk", name: "majsstärkelse" },
      { amount: 100.0, unit: "g", name: "Svenskt Smör från Arla®" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Första instruktionen",
      "Salta och peppra köttet och bryn det hastigt i smör i en het stekpanna. Lägg köttet på ett ugnssäkert fat, låt kallna.",
      "Rör ihop ost, nötter och crème fraiche till oströran.",
      "Skala och finhacka löken till såsen. Koka den tillsammans med vin, vatten, kalvfond, tomatpuré och peppar ca 5 min.",
      "Vispa ner maizena utrört i lite vatten. Hit kan du förbereda.",
      "Sätt ugnen på 225° eller 200° varmluft.",
      "Lägg oströran på köttet. Stek i mitten av ugnen tills innertemperaturen är 58°, ca 10 min om köttet önskas rosa.",
      "Värm såsen och vispa ner smöret i klickar.",
      "Servera köttet med såsen och klyftpotatis."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Första instruktionen\nSalta och peppra köttet och bryn det hastigt i smör i en het stekpanna. Lägg köttet på ett ugnssäkert fat, låt kallna.\nRör ihop ost, nötter och crème fraiche till oströran.\nSkala och finhacka löken till såsen. Koka den tillsammans med vin, vatten, kalvfond, tomatpuré och peppar ca 5 min.\nVispa ner maizena utrört i lite vatten. Hit kan du förbereda.\nSätt ugnen på 225° eller 200° varmluft.\nLägg oströran på köttet. Stek i mitten av ugnen tills innertemperaturen är 58°, ca 10 min om köttet önskas rosa.\nVärm såsen och vispa ner smöret i klickar.\nServera köttet med såsen och klyftpotatis.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("arla.se")
    expect(recipe.canonical_url).to eq("https://www.arla.se/recept/oxfile-surprise-med-rodvinssas/")
    expect(recipe.site_name).to eq("Arla")
    expect(recipe.language).to eq("sv")
    expect(recipe.author).to eq("Arla Mat")
    expect(recipe.description).to eq("Oxfilé, läckert gratinerad med ost och valnötter, på en spegel av rödvinssås. En tacksam bjudrätt som inte lämnar någon gäst hungrig.")
    expect(recipe.image).to eq("https://images.arla.com/recordid/07E52C0A-14E4-444B-8E21F31C39016F8D/oxfile-surprise-med-rodvinssas.jpg?width=1300&height=525&mode=crop&format=webp")
    expect(recipe.category).to eq("Huvudrätt, Lunch, Middag")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 items")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Oxfilé"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.0)
    expect(recipe.ratings_count).to eq(106)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "type" => "NutritionInformation",
      "servingSize" => "port",
      "calories" => "467 kcal",
      "carbohydrateContent" => "3,2 g",
      "fatContent" => "29,6 g",
      "fiberContent" => "0,9 g",
      "proteinContent" => "37,8 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 467.0 },
      { name: "carbohydrateContent", unit: "g", amount: 3.2 },
      { name: "fatContent", unit: "g", amount: 29.6 },
      { name: "fiberContent", unit: "g", amount: 0.9 },
      { name: "proteinContent", unit: "g", amount: 37.8 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#login")
  end
end
