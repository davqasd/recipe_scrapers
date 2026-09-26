# frozen_string_literal: true

RSpec.describe "recept.se" do
  subject(:recipe) { scrape_cassette("se/recept", url: "https://recept.se/recept/chokladbollar-grundrecept") }

  it "reads the title" do
    expect(recipe.title).to eq("Chokladbollar – grundrecept")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 dl havregryn",
      "100 g mjukt och rumstempererat smör",
      "1 dl strösocker",
      "2,5 msk kakao",
      "1,5 tsk vaniljsocker",
      "2 msk starkt kaffe, typ espresso",
      "2 dl pärlsocker eller kokosflingor"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "dl", name: "havregryn" },
      { amount: 100.0, unit: "g", name: "mjukt och rumstempererat smör" },
      { amount: 1.0, unit: "dl", name: "strösocker" },
      { amount: 2.5, unit: "msk", name: "kakao" },
      { amount: 1.5, unit: "tsk", name: "vaniljsocker" },
      { amount: 2.0, unit: "msk", name: "starkt kaffe, typ espresso" },
      { amount: 2.0, unit: "dl", name: "pärlsocker eller kokosflingor" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Rör smör, socker, kakao och vaniljsocker poröst. Gärna med en elvisp eller köksassistent.",
      "Tillsätt resterande ingredienser och arbeta ihop till en jämn smet med händerna.",
      "Jag kyler aldrig kaffet. Jag bereder det när jag börjar vispa smör och socker och tillsätter det ljummet.",
      "Låt smeten stå i 15 minuter så den sväller lite.",
      "Rulla bollar av smeten och rulla sedan dessa i pärlsocker eller kokosflingor.",
      "Ställ i kyl för att stelna, men låt gärna rumstempereras innan servering."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Rör smör, socker, kakao och vaniljsocker poröst. Gärna med en elvisp eller köksassistent.\nTillsätt resterande ingredienser och arbeta ihop till en jämn smet med händerna.\nJag kyler aldrig kaffet. Jag bereder det när jag börjar vispa smör och socker och tillsätter det ljummet.\nLåt smeten stå i 15 minuter så den sväller lite.\nRulla bollar av smeten och rulla sedan dessa i pärlsocker eller kokosflingor.\nStäll i kyl för att stelna, men låt gärna rumstempereras innan servering.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("recept.se")
    expect(recipe.canonical_url).to eq("https://recept.se/recept/chokladbollar-grundrecept")
    expect(recipe.site_name).to eq("RECEPT")
    expect(recipe.language).to eq("se")
    expect(recipe.author).to eq("Sandra Palmqvist")
    expect(recipe.description).to eq("Klassiska chokladbollar med havregryn, smör, socker, kakao och kaffe. Smaksätt gärna smeten med flingsalt, brynt smör eller likör.")
    expect(recipe.image).to eq("https://images.recept.se/images/recipes/chokladbollar-grundrecept_13868.jpg?fit=crop&crop=focalpoint&auto=format&fp-x=0.5&fp-y=0.50260476470344&fp-z=1&w=1200&h=1200")
    expect(recipe.category).to eq("Bak & dessert")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("25 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq([
      "vegetarian",
      "vegetariansk",
      "vegetarian",
      "vegetariansk",
      "bak & dessert",
      "bakverk",
      "dop",
      "födelsedag",
      "utan fläsk",
      "vegetarian"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["VegetarianDiet"])
    expect(recipe.ratings).to eq(4.0)
    expect(recipe.ratings_count).to eq(359)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "87424 calories",
      "carbohydrateContent" => "12.6 g",
      "fatContent" => "3.7 g",
      "proteinContent" => "0.7 g",
      "servingSize" => "1 styck"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 87_424.0 },
      { name: "carbohydrateContent", unit: "g", amount: 12.6 },
      { name: "fatContent", unit: "g", amount: 3.7 },
      { name: "proteinContent", unit: "g", amount: 0.7 },
      { name: "servingSize", unit: "styck", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://recept.se/sok")
  end
end
