# frozen_string_literal: true

RSpec.describe "brewersfriend.com" do
  subject(:recipe) { scrape_cassette("com/brewersfriend", url: "https://www.brewersfriend.com/homebrew/recipe/view/1649779/northy-12-belgian-quad-northern-brewer-/544280") }

  it "reads the title" do
    expect(recipe.title).to eq("NORTHY 12 BELGIAN QUAD (Northern Brewer)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "6 lb Liquid Malt Extract - Pilsen",
      "1 lb DME Pilsen Light",
      "3.5 lb Liquid Malt Extract - Light",
      "1 lb DME Golden Light",
      "2 lb Belgian Candi Syrup - D-180",
      "1 oz Brewers Gold Hops",
      "1 oz Hallertau Tradition (Germany) Hops",
      "1 oz Styrian Goldings Hops"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 6.0, unit: "lb", name: "Liquid Malt Extract - Pilsen" },
      { amount: 1.0, unit: "lb", name: "DME Pilsen Light" },
      { amount: 3.5, unit: "lb", name: "Liquid Malt Extract - Light" },
      { amount: 1.0, unit: "lb", name: "DME Golden Light" },
      { amount: 2.0, unit: "lb", name: "Belgian Candi Syrup - D-180" },
      { amount: 1.0, unit: "oz", name: "Brewers Gold Hops" },
      { amount: 1.0, unit: "oz", name: "Hallertau Tradition Hops" },
      { amount: 1.0, unit: "oz", name: "Styrian Goldings Hops" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Boil",
      "Bring wort to a boil and boil for 60 minutes. Add hops: Brewers Gold (Boil 60 min); Hallertau Tradition (Germany) (Boil 30 min); Styrian Goldings (Boil 15 min).",
      "Ferment with Imperial Yeast B48 Triple Double at 65°F."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Boil\nBring wort to a boil and boil for 60 minutes. Add hops: Brewers Gold (Boil 60 min); Hallertau Tradition (Germany) (Boil 30 min); Styrian Goldings (Boil 15 min).\nFerment with Imperial Yeast B48 Triple Double at 65°F.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("brewersfriend.com")
    expect(recipe.canonical_url).to eq("https://www.brewersfriend.com/homebrew/recipe/view/1649779/northy-12-belgian-quad-northern-brewer-")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("DJC")
    expect(recipe.description).to eq("Secondary Fermentation - 3 Months Bottle Fermentation - 2 Weeks - Better at 1 Year")
    expect(recipe.image).to eq("https://www.brewersfriend.com/homebrew/images/bglogo_large.png")
    expect(recipe.category).to eq("Belgian Dark Strong Ale")
    expect(recipe.cuisine).to eq("Homebrewing")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("5 items")
    expect(recipe.total_time).to eq(60)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(60)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "12 oz",
      "calories" => "292 calories",
      "carbohydrateContent" => "28.5 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "oz", amount: 12.0 },
      { name: "calories", unit: "kcal", amount: 292.0 },
      { name: "carbohydrateContent", unit: "g", amount: 28.5 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#top")
  end
end
