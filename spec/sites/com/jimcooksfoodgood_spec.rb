# frozen_string_literal: true

RSpec.describe "jimcooksfoodgood.com" do
  subject(:recipe) { scrape_cassette("com/jimcooksfoodgood", url: "https://jimcooksfoodgood.com/german-potato-salad/") }

  it "reads the title" do
    expect(recipe.title).to eq("German Potato Salad")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 Pounds Yukon Gold Potatoes (Or a small white potato)",
      "2/3 Cup Sherry or Apple Cider Vinegar",
      "1/2 Cup dijon mustard",
      "1/2 Cup Bread and Butter Pickles",
      "1/4 Cup olive oil",
      "4 Tablespoons capers (Plus a splash of brine)",
      "2 Teaspoons salt",
      "1/2 Cup Fresh Parsley",
      "1/4 Cup scallions",
      "1 Sprig Fresh Rosemary"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "Pounds", name: "Yukon Gold Potatoes" },
      { amount: 0.67, unit: "Cup", name: "Sherry or Apple Cider Vinegar" },
      { amount: 0.5, unit: "Cup", name: "dijon mustard" },
      { amount: 0.5, unit: "Cup", name: "Bread and Butter Pickles" },
      { amount: 0.25, unit: "Cup", name: "olive oil" },
      { amount: 4.0, unit: "Tablespoons", name: "capers" },
      { amount: 2.0, unit: "Teaspoons", name: "salt" },
      { amount: 0.5, unit: "Cup", name: "Fresh Parsley" },
      { amount: 0.25, unit: "Cup", name: "scallions" },
      { amount: 1.0, unit: "Sprig", name: "Fresh Rosemary" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 400 deg F. Cut potatoes into rough bitesize chunks, it doesn't have to be exact. Arrange on two non-stick sprayed baking sheets, season with 1/2 of the salt, and roast for 30 minutes.",
      "As potatoes cook, roughly chop the pickles, capers, rosemary, scallions, and parsley. Combine thoroughly with vinegar, mustard, oil, remaining teaspoon of salt, and some heavy grinds of black pepper.",
      "When potatoes are cooked, immediately transfer to very large mixing bowl. Add the dressing slowly as you mix; the potatoes should gently break apart, which is a good thing. Serve warm or at room temperature."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 400 deg F. Cut potatoes into rough bitesize chunks, it doesn't have to be exact. Arrange on two non-stick sprayed baking sheets, season with 1/2 of the salt, and roast for 30 minutes.\nAs potatoes cook, roughly chop the pickles, capers, rosemary, scallions, and parsley. Combine thoroughly with vinegar, mustard, oil, remaining teaspoon of salt, and some heavy grinds of black pepper.\nWhen potatoes are cooked, immediately transfer to very large mixing bowl. Add the dressing slowly as you mix; the potatoes should gently break apart, which is a good thing. Serve warm or at room temperature.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("jimcooksfoodgood.com")
    expect(recipe.canonical_url).to eq("https://jimcooksfoodgood.com/german-potato-salad/")
    expect(recipe.site_name).to eq("Jim Cooks Food Good!")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jim")
    expect(recipe.description).to eq("German Potato Salad")
    expect(recipe.image).to eq("https://jimcooksfoodgood.com/wp-content/uploads/2019/09/1282A83C-D784-4DF4-9623-C580DC9B9840.jpeg")
    expect(recipe.category).to eq("Main Dish")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["#healthyrecipe"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "servingSize" => "8 People", "calories" => "222 kcal" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "People", amount: 8.0 },
      { name: "calories", unit: "kcal", amount: 222.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
