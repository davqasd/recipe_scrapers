# frozen_string_literal: true

RSpec.describe "hellofresh.dk" do
  subject(:recipe) { scrape_cassette("dk/hellofresh", url: "https://www.hellofresh.dk/recipes/indisk-rajma-makhani-dhal-med-sorte-bonner-6a6891a297f1e0220917466c") }

  it "reads the title" do
    expect(recipe.title).to eq("Indisk rajma makhani dhal med sorte bønner med lune naanbrød og koriander")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 stk Hvidløgsfed",
      "1 stk Løg",
      "2 tsk Ingefær",
      "8 g Mild Mahal",
      "2 stk Naanbrød",
      "390 g Sorte bønner",
      "1 stk Gulerod",
      "10 g Mandelflager",
      "75 ml Madlavningsfløde",
      "200 g Passata",
      "50 g Soltørrede tomater",
      "35 g Tomatpuré",
      "2 g Røget paprika",
      "1 stk Koriander",
      "1 spsk Olie til stegning",
      "½ tsk Salt til gryderet",
      "1 tsk Sukker til gryderet",
      "2 dl Vand til gryderet"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "stk", name: "Hvidløgsfed" },
      { amount: 1.0, unit: "stk", name: "Løg" },
      { amount: 2.0, unit: "tsk", name: "Ingefær" },
      { amount: 8.0, unit: "g", name: "Mild Mahal" },
      { amount: 2.0, unit: "stk", name: "Naanbrød" },
      { amount: 390.0, unit: "g", name: "Sorte bønner" },
      { amount: 1.0, unit: "stk", name: "Gulerod" },
      { amount: 10.0, unit: "g", name: "Mandelflager" },
      { amount: 75.0, unit: "ml", name: "Madlavningsfløde" },
      { amount: 200.0, unit: "g", name: "Passata" },
      { amount: 50.0, unit: "g", name: "Soltørrede tomater" },
      { amount: 35.0, unit: "g", name: "Tomatpuré" },
      { amount: 2.0, unit: "g", name: "Røget paprika" },
      { amount: 1.0, unit: "stk", name: "Koriander" },
      { amount: 1.0, unit: "spsk", name: "Olie til stegning" },
      { amount: 0.5, unit: "tsk", name: "Salt til gryderet" },
      { amount: 1.0, unit: "tsk", name: "Sukker til gryderet" },
      { amount: 2.0, unit: "dl", name: "Vand til gryderet" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Forvarm ovnen til 220°C/200°C (varmluft). Hak løg, gulerod og soltørrede tomater groft. Riv ingefær og hvidløg fint. Skyl sorte bønner.",
      "Opvarm olivenolie i en stor gryde på middelhøj varme. Steg løg, gulerod og soltørrede tomater i 2-3 min, eller indtil let bløde. Tilsæt hvidløg, ingefær, Mild Mahal og røget paprika, og svits i 30 sek, eller indtil velduftende. VIGTIGT: I denne opskrift bruges halvdelen af mængden af visse ingredienser – dobbelttjek ingredienslisten!",
      "Tilsæt tomatpuré, passata, vand, halvdelen af bønner, sukker salt og et nip peber, og bring i kog. Sænk til middel varme, og lad simre i 4-5 min, eller indtil let tyknet.",
      "Hold naanbrød under rindende vand i 2 sek, og pak ind i sølvpapir. Varm i ovnen i 4-5 min.",
      "Overfør halvdelen af dhal til en høj kande, og blend til en jævn konsistens med en stavblender eller blender. Hæld tilbage i gryden med resterende dhal, og tilsæt madlavningsfløde. TIP: Mos groft med en kartoffelmoser, hvis du ikke har en blender.",
      "Anret dhal i dybe tallerkener. Top med mandelflager og koriander. Server med naanbrød."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Forvarm ovnen til 220°C/200°C (varmluft). Hak løg, gulerod og soltørrede tomater groft. Riv ingefær og hvidløg fint. Skyl sorte bønner.\nOpvarm olivenolie i en stor gryde på middelhøj varme. Steg løg, gulerod og soltørrede tomater i 2-3 min, eller indtil let bløde. Tilsæt hvidløg, ingefær, Mild Mahal og røget paprika, og svits i 30 sek, eller indtil velduftende. VIGTIGT: I denne opskrift bruges halvdelen af mængden af visse ingredienser – dobbelttjek ingredienslisten!\nTilsæt tomatpuré, passata, vand, halvdelen af bønner, sukker salt og et nip peber, og bring i kog. Sænk til middel varme, og lad simre i 4-5 min, eller indtil let tyknet.\nHold naanbrød under rindende vand i 2 sek, og pak ind i sølvpapir. Varm i ovnen i 4-5 min.\nOverfør halvdelen af dhal til en høj kande, og blend til en jævn konsistens med en stavblender eller blender. Hæld tilbage i gryden med resterende dhal, og tilsæt madlavningsfløde. TIP: Mos groft med en kartoffelmoser, hvis du ikke har en blender.\nAnret dhal i dybe tallerkener. Top med mandelflager og koriander. Server med naanbrød.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hellofresh.dk")
    expect(recipe.canonical_url).to eq("https://www.hellofresh.dk/recipes/indisk-rajma-makhani-dhal-med-sorte-bonner-6a3e701cf396cfc62f2b2d51")
    expect(recipe.site_name).to eq("HelloFresh")
    expect(recipe.language).to eq("da-DK")
    expect(recipe.author).to eq("HelloFresh")
    expect(recipe.description).to eq(".")
    expect(recipe.image).to eq("https://img.hellofresh.com/f_auto,fl_lossy,h_640,q_auto,w_1200/hellofresh_s3/image/HF_Y26_R18_BW27_SE_V55790-1main_high-86f17fd4.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to eq("Indisk")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(3.847891428384436)
    expect(recipe.ratings_count).to eq(83)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "807 kcal",
      "fatContent" => "26.5 g",
      "saturatedFatContent" => "6.4 g",
      "carbohydrateContent" => "109.4 g",
      "sugarContent" => "27.2 g",
      "proteinContent" => "24.2 g",
      "fiberContent" => "17.9 g",
      "sodiumContent" => "3.8 g",
      "servingSize" => "564"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 807.0 },
      { name: "fatContent", unit: "g", amount: 26.5 },
      { name: "saturatedFatContent", unit: "g", amount: 6.4 },
      { name: "carbohydrateContent", unit: "g", amount: 109.4 },
      { name: "sugarContent", unit: "g", amount: 27.2 },
      { name: "proteinContent", unit: "g", amount: 24.2 },
      { name: "fiberContent", unit: "g", amount: 17.9 },
      { name: "sodiumContent", unit: "g", amount: 3.8 },
      { name: "servingSize", unit: nil, amount: 564.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#page")
  end
end
