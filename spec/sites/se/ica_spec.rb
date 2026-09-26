# frozen_string_literal: true

RSpec.describe "ica.se" do
  subject(:recipe) { scrape_cassette("se/ica", url: "https://www.ica.se/recept/lysande-gul-fiskgryta-1677/") }

  it "reads the title" do
    expect(recipe.title).to eq("Lysande gul fiskgryta")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "400 g torskfilé, sej kolja eller hoki",
      "300 g laxfilé",
      "1/2 purjolök (1/2 purjolök motsvarar ca 150 g)",
      "1/2 gul lök",
      "1 msk smör eller olivolja",
      "1 vitlöksklyfta",
      "1 1/2 tsk tomatpuré",
      "1 tsk torkad timjan",
      "1 tsk torkad basilika",
      "2 1/2 dl torrt vitt vin",
      "1 1/2 fiskbuljongtärning",
      "2 dl vispgrädde",
      "1 dl crème fraiche",
      "2 dl vatten",
      "1 pkt saffran (à 0,5 g)",
      "1 tsk salt",
      "300 g räkor med skal",
      "1 burk musslor (à 150 g)",
      "ev. bröd och vitlöksmajonnäs"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 400.0, unit: "g", name: "torskfilé, sej kolja eller hoki" },
      { amount: 300.0, unit: "g", name: "laxfilé" },
      { amount: 0.5, unit: nil, name: "purjolök" },
      { amount: 0.5, unit: nil, name: "gul lök" },
      { amount: 1.0, unit: "msk", name: "smör eller olivolja" },
      { amount: 1.0, unit: nil, name: "vitlöksklyfta" },
      { amount: 1.5, unit: "tsk", name: "tomatpuré" },
      { amount: 1.0, unit: "tsk", name: "torkad timjan" },
      { amount: 1.0, unit: "tsk", name: "torkad basilika" },
      { amount: 2.5, unit: "dl", name: "torrt vitt vin" },
      { amount: 1.5, unit: nil, name: "fiskbuljongtärning" },
      { amount: 2.0, unit: "dl", name: "vispgrädde" },
      { amount: 1.0, unit: "dl", name: "crème fraiche" },
      { amount: 2.0, unit: "dl", name: "vatten" },
      { amount: 1.0, unit: "pkt", name: "saffran" },
      { amount: 1.0, unit: "tsk", name: "salt" },
      { amount: 300.0, unit: "g", name: "räkor med skal" },
      { amount: 1.0, unit: "burk", name: "musslor" },
      { amount: nil, unit: nil, name: "ev. bröd och vitlöksmajonnäs" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Tina fisken (om fryst används). Skölj, ansa och strimla purjon. Skala och hacka löken.",
      "Smält smöret i en stor gryta eller tjockbottnad kastrull. Fräs löken och purjolöken (spara lite till servering) ett par minuter tills de blivit glansiga och genomskinliga. Pressa i vitlök. Rör ner tomatpuré, timjan och basilika. Låt detta fräsa med en kort stund.",
      "Tillsätt vin och buljongtärning. Koka ett par minuter. Rör ner vispgrädde, crème fraiche, vatten och saffran. Sjud i 15 minuter. Smaka av med salt.",
      "Skär fisken i munsbitar, lägg i grytan och sjud i ytterligare 7 minuter.",
      "Skala räkorna. Tillsätt dem och de avrunna musslorna. Toppa soppan med purjolöksstrimlor.",
      "Serveringsförslag: Hetta upp och servera genast, gärna med bröd och vitlöksmajonnäs."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Tina fisken (om fryst används). Skölj, ansa och strimla purjon. Skala och hacka löken.\nSmält smöret i en stor gryta eller tjockbottnad kastrull. Fräs löken och purjolöken (spara lite till servering) ett par minuter tills de blivit glansiga och genomskinliga. Pressa i vitlök. Rör ner tomatpuré, timjan och basilika. Låt detta fräsa med en kort stund.\nTillsätt vin och buljongtärning. Koka ett par minuter. Rör ner vispgrädde, crème fraiche, vatten och saffran. Sjud i 15 minuter. Smaka av med salt.\nSkär fisken i munsbitar, lägg i grytan och sjud i ytterligare 7 minuter.\nSkala räkorna. Tillsätt dem och de avrunna musslorna. Toppa soppan med purjolöksstrimlor.\nServeringsförslag: Hetta upp och servera genast, gärna med bröd och vitlöksmajonnäs.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("ica.se")
    expect(recipe.canonical_url).to eq("https://www.ica.se/recept/lysande-gul-fiskgryta-1677/")
    expect(recipe.site_name).to eq("ICA.se")
    expect(recipe.language).to eq("sv")
    expect(recipe.author).to eq("ICA Köket")
    expect(recipe.description).to eq("Denna fiskgryta får sin lysande solgula färg och ljuvliga smak av saffran, vitlök och tomatpuré. Grytan blir matig och mättande med lax, torsk, räkor och musslor och passar perfekt att bjuda på till en lite festligare middag med eller utan gäster.")
    expect(recipe.image).to eq("https://assets.icanet.se/t_ICAseAbsoluteUrl/imagevaultfiles/id_243155/cf_259/lysande_gul_fiskgryta.jpg")
    expect(recipe.category).to eq("Huvudrätt,Middag")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to eq("Kokt,I gryta,Crock pot")
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.6)
    expect(recipe.ratings_count).to eq(1668)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "4 Servings",
      "calories" => "662 calories",
      "fatContent" => "43 g",
      "carbohydrateContent" => "20 g",
      "proteinContent" => "47 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "Servings", amount: 4.0 },
      { name: "calories", unit: "kcal", amount: 662.0 },
      { name: "fatContent", unit: "g", amount: 43.0 },
      { name: "carbohydrateContent", unit: "g", amount: 20.0 },
      { name: "proteinContent", unit: "g", amount: 47.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
