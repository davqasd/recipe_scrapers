# frozen_string_literal: true

RSpec.describe "ninjatestkitchen.eu" do
  subject(:recipe) { scrape_cassette("eu/ninjatestkitchen", url: "https://ninjatestkitchen.eu/recipe/chocolate-crunch-energy-balls/") }

  it "reads the title" do
    expect(recipe.title).to eq("Chocolate Crunch Energy Balls")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1.75oz rolled oats",
      "1.4oz cacao nibs",
      "1.05oz puffed quinoa (you could also use puffed rice, just slightly break it up so the pieces are smaller)",
      "1 tbsp chopped hazelnut pieces",
      "2.8oz peanut butter",
      "3 tbsp maple syrup",
      "1 tbsp coconut oil"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.75, unit: "oz", name: "rolled oats" },
      { amount: 1.4, unit: "oz", name: "cacao nibs" },
      { amount: 1.05, unit: "oz", name: "puffed quinoa" },
      { amount: 1.0, unit: "tbsp", name: "chopped hazelnut pieces" },
      { amount: 2.8, unit: "oz", name: "peanut butter" },
      { amount: 3.0, unit: "tbsp", name: "maple syrup" },
      { amount: 1.0, unit: "tbsp", name: "coconut oil" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Place the oats and cacao nibs in your food processor and process until finely chopped then add the peanut butter, maple syrup and coconut oil and blend again.",
      "Transfer to a mixing bowl and stir in the puffed quinoa and hazelnut pieces.",
      "Using slightly wet hands (this avoids sticking) form the mixture into balls. Place in the fridge for about 4 hours to firm up."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Place the oats and cacao nibs in your food processor and process until finely chopped then add the peanut butter, maple syrup and coconut oil and blend again.\nTransfer to a mixing bowl and stir in the puffed quinoa and hazelnut pieces.\nUsing slightly wet hands (this avoids sticking) form the mixture into balls. Place in the fridge for about 4 hours to firm up.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("ninjatestkitchen.eu")
    expect(recipe.canonical_url).to eq("https://www.sharkninja.co.uk/chocolate-crunch-energy-balls/REC4039EU.html")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("A delicious sweet, healthy snack to curb those chocolate cravings and keep your energy levels up! Perfect for Sunday meal prep for the rest of the week, a mid-morning boost or evening dessert.")
    expect(recipe.image).to eq("https://assets.sharkninja.com/image/upload/f_auto/q_auto/recipes/REC4039EU.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#maincontent")
  end
end
