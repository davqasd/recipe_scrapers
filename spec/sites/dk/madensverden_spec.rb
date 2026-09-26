# frozen_string_literal: true

RSpec.describe "madensverden.dk" do
  subject(:recipe) { scrape_cassette("dk/madensverden", url: "https://madensverden.dk/trifli-med-rabarber/") }

  it "reads the title" do
    expect(recipe.title).to eq("Rabarbertrifli")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "400 g rabarber",
      "75 g sukker",
      "10 g vaniljesukker",
      "2 pasteuriserede æggeblommer (1 bæger)",
      "40 g sukker",
      "10 g majsstivelse",
      "2,5 dl sødmælk",
      "2,5 dl piskefløde",
      "100 g makroner",
      "40 g mandelflager"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 400.0, unit: "g", name: "rabarber" },
      { amount: 75.0, unit: "g", name: "sukker" },
      { amount: 10.0, unit: "g", name: "vaniljesukker" },
      { amount: 2.0, unit: nil, name: "pasteuriserede æggeblommer" },
      { amount: 40.0, unit: "g", name: "sukker" },
      { amount: 10.0, unit: "g", name: "majsstivelse" },
      { amount: 2.5, unit: "dl", name: "sødmælk" },
      { amount: 2.5, unit: "dl", name: "piskefløde" },
      { amount: 100.0, unit: "g", name: "makroner" },
      { amount: 40.0, unit: "g", name: "mandelflager" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Start med at lave rabarberkompot. Rabarber snittes i tynde skiver, som koges i en kasserolle sammen med sukker og vaniljesukker. Kogetiden er cirka 10 minutter. Lad kompotten køle af.",
      "Cremen laves ved at piske æggeblommer sammen med sukker og majsstivelse i en kasserolle. Koges op med sødmælken indtil den har den rette konsistens, og du skal piske i den undervejs så cremen ikke brænder på. Lad den køle lidt af.",
      "Fløden piskes til en let flødeskum.",
      "Anret nu trifli med rabarber i portionsglas.",
      "Først med et lag creme nederst, så knuste makroner og ovenpå det den lækre rabarberkompot.",
      "Slut af med flødeskum og pynt med mandelflager.",
      "Stil rabarbertriflierne i køleskabet, og lad dem trække i mindst en time før servering."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Rabarberkompot laves af", 3],
        ["Creme laves af", 4],
        ["Derudover anvendes", 3]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Start med at lave rabarberkompot. Rabarber snittes i tynde skiver, som koges i en kasserolle sammen med sukker og vaniljesukker. Kogetiden er cirka 10 minutter. Lad kompotten køle af.\nCremen laves ved at piske æggeblommer sammen med sukker og majsstivelse i en kasserolle. Koges op med sødmælken indtil den har den rette konsistens, og du skal piske i den undervejs så cremen ikke brænder på. Lad den køle lidt af.\nFløden piskes til en let flødeskum.\nAnret nu trifli med rabarber i portionsglas.\nFørst med et lag creme nederst, så knuste makroner og ovenpå det den lækre rabarberkompot.\nSlut af med flødeskum og pynt med mandelflager.\nStil rabarbertriflierne i køleskabet, og lad dem trække i mindst en time før servering.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("madensverden.dk")
    expect(recipe.canonical_url).to eq("https://madensverden.dk/trifli-med-rabarber/")
    expect(recipe.site_name).to eq("Madens Verden")
    expect(recipe.language).to eq("da-DK")
    expect(recipe.author).to eq("Holger Rørby Madsen")
    expect(recipe.description).to eq("Rabarbertrifli er en populær dessert, der laves med knuste makroner og flødeskum. Den lækre trifli med rabarber kan laves god tid i forvejen.")
    expect(recipe.image).to eq("https://madensverden.dk/wp-content/uploads/2017/08/billederesultat-for-rabarbertrifli.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("Dansk")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.72)
    expect(recipe.ratings_count).to eq(38)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "405 kcal",
      "carbohydrateContent" => "38 g",
      "proteinContent" => "7 g",
      "fatContent" => "26 g",
      "saturatedFatContent" => "12 g",
      "transFatContent" => "0.002 g",
      "cholesterolContent" => "117 mg",
      "sodiumContent" => "39 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "32 g",
      "unsaturatedFatContent" => "13 g",
      "servingSize" => "1 person"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 405.0 },
      { name: "carbohydrateContent", unit: "g", amount: 38.0 },
      { name: "proteinContent", unit: "g", amount: 7.0 },
      { name: "fatContent", unit: "g", amount: 26.0 },
      { name: "saturatedFatContent", unit: "g", amount: 12.0 },
      { name: "transFatContent", unit: "g", amount: 0.002 },
      { name: "cholesterolContent", unit: "mg", amount: 117.0 },
      { name: "sodiumContent", unit: "mg", amount: 39.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 32.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 13.0 },
      { name: "servingSize", unit: "person", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://madensverden.dk/")
  end
end
