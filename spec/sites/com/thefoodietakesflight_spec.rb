# frozen_string_literal: true

RSpec.describe "thefoodietakesflight.com" do
  subject(:recipe) { scrape_cassette("com/thefoodietakesflight", url: "https://thefoodietakesflight.com/hot-pot-sauce/") }

  it "reads the title" do
    expect(recipe.title).to eq("Chinese Hot Pot Sauce")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 tbsp Chinese sesame paste",
      "2 tbsp soy sauce",
      "1-2 tbsp Chinese black vinegar or rice vinegar",
      "1 tbsp vegetarian oyster sauce",
      "1 tbsp sugar (adjust to taste)",
      "1/2 tbsp sesame oil",
      "1 tsp roasted sesame seeds",
      "1/2 to 1 tbsp chili oil (adjust to desired heat)",
      "1 tbsp doubanjiang ( or fermented chili bean paste, optional)",
      "1/2 to 1 tbsp minced garlic",
      "Chopped green onions or scallions",
      "Chopped fresh cilantro",
      "2-3 tbsp water (adjust to desired consistency)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "tbsp", name: "Chinese sesame paste" },
      { amount: 2.0, unit: "tbsp", name: "soy sauce" },
      { amount: 1.0, unit: "tbsp", name: "Chinese black vinegar or rice vinegar" },
      { amount: 1.0, unit: "tbsp", name: "vegetarian oyster sauce" },
      { amount: 1.0, unit: "tbsp", name: "sugar" },
      { amount: 0.5, unit: "tbsp", name: "sesame oil" },
      { amount: 1.0, unit: "tsp", name: "roasted sesame seeds" },
      { amount: 0.5, unit: "tbsp", name: "chili oil" },
      { amount: 1.0, unit: "tbsp", name: "doubanjiang" },
      { amount: 0.5, unit: "tbsp", name: "minced garlic" },
      { amount: nil, unit: nil, name: "Chopped green onions or scallions" },
      { amount: nil, unit: nil, name: "Chopped fresh cilantro" },
      { amount: 2.0, unit: "tbsp", name: "water" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Simply mix everything together. This sauce is customizable depending on your preference! So feel free to add more or less of everything depending on what you like.",
      "Check out how to make Chinese hot pot at home here!"
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["SAUCE INGREDIENTS", 13]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Simply mix everything together. This sauce is customizable depending on your preference! So feel free to add more or less of everything depending on what you like.\nCheck out how to make Chinese hot pot at home here!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thefoodietakesflight.com")
    expect(recipe.canonical_url).to eq("https://thefoodietakesflight.com/hot-pot-sauce/")
    expect(recipe.site_name).to eq("The Foodie Takes Flight")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jeeca")
    expect(recipe.description).to eq("This Chinese Hotpot Sauce is an integral part of the hot pot experience. A lot of Chinese hot pot or shabu-shabu places offer sauce stations where you can prepare your own dipping sauce. My hot pot sauce is a rich mix of Chinese sesame paste, Chinese black vinegar, soy sauce, veg oyster sauce, sugar, chili oil, garlic, green onions, and a few other ingredients that make this sauce incredibly fragrant and tasty. Dipping pieces of cooked vegetables or tofu into this sauce is makes it so addicting.")
    expect(recipe.image).to eq("https://thefoodietakesflight.com/wp-content/uploads/2023/12/Vegan-Hotpot-or-Shabu-Shabu-Sauce-20-of-25-scaled.jpg")
    expect(recipe.category).to eq("Condiments")
    expect(recipe.cuisine).to eq("Asian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(15)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq([
      "chinese food",
      "chinese hot pot",
      "chinese recipes",
      "fresh mushrooms",
      "fresh tofu",
      "hot pot",
      "king oyster mushrooms",
      "soup recipes"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(4)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 serving",
      "calories" => "199 kcal",
      "carbohydrateContent" => "12 g",
      "proteinContent" => "5 g",
      "fatContent" => "16 g",
      "saturatedFatContent" => "2 g",
      "sodiumContent" => "1258 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "6 g",
      "unsaturatedFatContent" => "13 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "serving", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 199.0 },
      { name: "carbohydrateContent", unit: "g", amount: 12.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "fatContent", unit: "g", amount: 16.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "sodiumContent", unit: "mg", amount: 1258.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 6.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 13.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://enable-javascript.com/")
  end
end
