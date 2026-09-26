# frozen_string_literal: true

RSpec.describe "swissmilk.ch" do
  subject(:recipe) { scrape_cassette("ch/swissmilk", url: "https://www.swissmilk.ch/de/rezepte-kochideen/rezepte/LM200910_59/tomatenrisotto/") }

  it "reads the title" do
    expect(recipe.title).to eq("Tomatenrisotto")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 Knoblauchzehe, gepresst",
      "½ Zwiebel, fein gehackt",
      "Butter zum Dünsten",
      "150 g Risottoreis, z.B. Carnaroli",
      "3 EL Tomatenpüree",
      "1 dl Weisswein oder Gemüsebouillon",
      "3,5 - 4 dl Gemüsebouillon, heiss",
      "3 EL Schweizer Mascarpone",
      "2 EL fein gehackter Oregano",
      "2 Tomaten, halbiert, entkernt, klein gewürfelt",
      "2 - 3 EL geriebener Sbrinz AOP",
      "Pfeffer aus der Mühle",
      "Oregano zum Garnieren"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "Knoblauchzehe, gepresst" },
      { amount: 0.5, unit: nil, name: "Zwiebel, fein gehackt" },
      { amount: nil, unit: nil, name: "Butter zum Dünsten" },
      { amount: 150.0, unit: "g", name: "Risottoreis, z.B. Carnaroli" },
      { amount: 3.0, unit: "EL", name: "Tomatenpüree" },
      { amount: 1.0, unit: "dl", name: "Weisswein oder Gemüsebouillon" },
      { amount: 3.5, unit: "dl", name: "Gemüsebouillon, heiss" },
      { amount: 3.0, unit: "EL", name: "Schweizer Mascarpone" },
      { amount: 2.0, unit: "EL", name: "fein gehackter Oregano" },
      { amount: 2.0, unit: nil, name: "Tomaten, halbiert, entkernt, klein gewürfelt" },
      { amount: 2.0, unit: "EL", name: "geriebener Sbrinz AOP" },
      { amount: nil, unit: nil, name: "Pfeffer aus der Mühle" },
      { amount: nil, unit: nil, name: "Oregano zum Garnieren" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Knoblauch und Zwiebel in Butter andünsten. Reis und Tomatenpüree kurz mitdünsten. Mit Wein oder Bouillon ablöschen, einkochen. Nach und nach heisse Bouillon dazugiessen, unter häufigem Rühren 15-20 Minuten al dente kochen.",
      "Mascarpone, Oregano, Tomaten und Sbrinz daruntermischen, nur heiss werden lassen, mit Pfeffer würzen, garnieren."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Knoblauch und Zwiebel in Butter andünsten. Reis und Tomatenpüree kurz mitdünsten. Mit Wein oder Bouillon ablöschen, einkochen. Nach und nach heisse Bouillon dazugiessen, unter häufigem Rühren 15-20 Minuten al dente kochen.\nMascarpone, Oregano, Tomaten und Sbrinz daruntermischen, nur heiss werden lassen, mit Pfeffer würzen, garnieren.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("swissmilk.ch")
    expect(recipe.canonical_url).to eq("https://www.swissmilk.ch/de/rezepte-kochideen/rezepte/LM200910_59/tomatenrisotto/")
    expect(recipe.site_name).to eq("Swissmilk")
    expect(recipe.language).to eq("de")
    expect(recipe.author).to eq("Swissmilk")
    expect(recipe.description).to eq("Risotto mal anders: wunderbares Aroma von Tomaten und Oregano und herrlich sämig dank Mascarpone. Jede Gabel schmeckt wie Ferien im Tessin.")
    expect(recipe.image).to eq("https://res.cloudinary.com/swissmilk/image/fetch/w_1600,c_fill,g_auto,f_auto,q_auto:eco,ar_16:9/https://api.swissmilk.ch/wp-content/uploads/2019/12/LM200910_59_Tomatenrisotto-2560x1707.jpg")
    expect(recipe.category).to eq("Hauptgänge")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Max. 30 Minuten", "Vegetarisch", "Klassiker", "Grundrezept"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.4)
    expect(recipe.ratings_count).to eq(231)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "527",
      "fatContent" => "19",
      "carbohydrateContent" => "68",
      "proteinContent" => "12"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: nil, amount: 527.0 },
      { name: "fatContent", unit: nil, amount: 19.0 },
      { name: "carbohydrateContent", unit: nil, amount: 68.0 },
      { name: "proteinContent", unit: nil, amount: 12.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
