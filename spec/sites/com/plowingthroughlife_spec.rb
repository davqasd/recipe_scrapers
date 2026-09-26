# frozen_string_literal: true

RSpec.describe "plowingthroughlife.com" do
  subject(:recipe) { scrape_cassette("com/plowingthroughlife", url: "https://plowingthroughlife.com/crock-pot-mac-and-cheese-farmhouse-style/") }

  it "reads the title" do
    expect(recipe.title).to eq("Crock Pot Mac and Cheese")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "8 ounces macaroni (cooked)",
      "2 tablespoons vegetable oil",
      "12 ounces evaporated milk",
      "1 1/2 cups milk",
      "1 teaspoon salt",
      "1/2 teaspoon pepper (optional)",
      "1 tablespoon dried onion flakes (use up to 2 T. for maximum flavor)",
      "1 1/2 cups Velveeta cheese",
      "1 1/2 cups shredded cheddar cheese",
      "4 tablespoons butter (melted)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 8.0, unit: "ounces", name: "macaroni" },
      { amount: 2.0, unit: "tablespoons", name: "vegetable oil" },
      { amount: 12.0, unit: "ounces", name: "evaporated milk" },
      { amount: 1.5, unit: "cups", name: "milk" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: 0.5, unit: "teaspoon", name: "pepper" },
      { amount: 1.0, unit: "tablespoon", name: "dried onion flakes" },
      { amount: 1.5, unit: "cups", name: "Velveeta cheese" },
      { amount: 1.5, unit: "cups", name: "shredded cheddar cheese" },
      { amount: 4.0, unit: "tablespoons", name: "butter" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a crock pot toss cooked macaroni with vegetable oil.",
      "Stir in remaining ingredients.",
      "Cover and cook on low for 2 - 3 hours. Stir a couple times and enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a crock pot toss cooked macaroni with vegetable oil.\nStir in remaining ingredients.\nCover and cook on low for 2 - 3 hours. Stir a couple times and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("plowingthroughlife.com")
    expect(recipe.canonical_url).to eq("https://plowingthroughlife.com/crock-pot-mac-and-cheese-farmhouse-style/")
    expect(recipe.site_name).to eq("Plowing Through Life")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jennifer Osterholt")
    expect(recipe.description).to eq("Creamy macaroni and cheese is super easy to make in a crock pot. Cooked pasta, Velveeta and cheddar cheese along with evaporated milk make a rich and delicious side dish for any occasion! Our Farmhouse Style Crock Pot Mac and Cheese is a family favorite!")
    expect(recipe.image).to eq("https://plowingthroughlife.com/wp-content/uploads/2020/05/Farmhouse-Mac-and-cheese-FI.jpg")
    expect(recipe.category).to eq("Side Dish")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(160)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(150)
    expect(recipe.keywords).to eq(["Crock Pot Mac and Cheese"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(33)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "306 kcal",
      "carbohydrateContent" => "23 g",
      "proteinContent" => "15 g",
      "fatContent" => "17 g",
      "saturatedFatContent" => "11 g",
      "cholesterolContent" => "49 mg",
      "sodiumContent" => "828 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "8 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 306.0 },
      { name: "carbohydrateContent", unit: "g", amount: 23.0 },
      { name: "proteinContent", unit: "g", amount: 15.0 },
      { name: "fatContent", unit: "g", amount: 17.0 },
      { name: "saturatedFatContent", unit: "g", amount: 11.0 },
      { name: "cholesterolContent", unit: "mg", amount: 49.0 },
      { name: "sodiumContent", unit: "mg", amount: 828.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 8.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
