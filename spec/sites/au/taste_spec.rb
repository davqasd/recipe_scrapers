# frozen_string_literal: true

RSpec.describe "taste.com.au" do
  subject(:recipe) { scrape_cassette("au/taste", url: "https://www.taste.com.au/recipes/potato-garlic-rosemary-pizza/fc0c5902-c32e-4e0a-a720-160d34876eae") }

  it "reads the title" do
    expect(recipe.title).to eq("Potato, garlic and rosemary pizza")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "700g Red Rascal or Carisma potatoes",
      "60ml olive oil",
      "2 garlic cloves, crushed",
      "40.00 ml rosemary, finely chopped",
      "Coles Brand Thin & Crispy Medium Pizza Bases (2 pack)",
      "120g mozzarella",
      "40g parmesan",
      "6 slices prosciutto",
      "60g rocket leaves"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 700.0, unit: "g", name: "Red Rascal or Carisma potatoes" },
      { amount: 60.0, unit: "ml", name: "olive oil" },
      { amount: 2.0, unit: nil, name: "garlic cloves, crushed" },
      { amount: 40.0, unit: "ml", name: "rosemary, finely chopped" },
      { amount: nil, unit: nil, name: "Coles Brand Thin & Crispy Medium Pizza Bases" },
      { amount: 120.0, unit: "g", name: "mozzarella" },
      { amount: 40.0, unit: "g", name: "parmesan" },
      { amount: 6.0, unit: "slices", name: "prosciutto" },
      { amount: 60.0, unit: "g", name: "rocket leaves" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Cook potatoes in a saucepan of boiling water for 12-15 mins or until just tender. Drain and set aside to cool slightly. Thinly slice.",
      "Meanwhile, place 2 large baking trays in oven and preheat to 220C.",
      "Combine the oil, garlic and rosemary in a jug. Season. Spread half the oil mixture over the pizza bases. Top with half the mozzarella. Arrange the sliced potatoes over the mozzarella and drizzle with remaining oil mixture. Top with remaining mozzarella and parmesan.",
      "Transfer to the trays and bake for 10-15 mins or until golden and bases are crisp. Serve pizzas topped with prosciutto and rocket leaves."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Cook potatoes in a saucepan of boiling water for 12-15 mins or until just tender. Drain and set aside to cool slightly. Thinly slice.\nMeanwhile, place 2 large baking trays in oven and preheat to 220C.\nCombine the oil, garlic and rosemary in a jug. Season. Spread half the oil mixture over the pizza bases. Top with half the mozzarella. Arrange the sliced potatoes over the mozzarella and drizzle with remaining oil mixture. Top with remaining mozzarella and parmesan.\nTransfer to the trays and bake for 10-15 mins or until golden and bases are crisp. Serve pizzas topped with prosciutto and rocket leaves.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("taste.com.au")
    expect(recipe.canonical_url).to eq("https://www.taste.com.au/recipes/potato-garlic-rosemary-pizza/fc0c5902-c32e-4e0a-a720-160d34876eae")
    expect(recipe.site_name).to eq("Taste")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Coles")
    expect(recipe.description).to eq("Thinly sliced potato, crispy prosciutto and fresh rocket give this pizza a gourmet touch.")
    expect(recipe.image).to eq("https://img.taste.com.au/UAFq9j4w/w1200-h675-cfill-q80/taste/2016/11/potato-garlic-and-rosemary-pizza-107532-1.jpeg")
    expect(recipe.category).to eq("main")
    expect(recipe.cuisine).to eq("italian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(50)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["prosciutto", "spring", "winter", "main", "dinner", "italian", "family friendly", "pizza", "rosemary", "garlic", "potato", "spud lite"])
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
    expect(recipe.links).to include("#")
  end
end
