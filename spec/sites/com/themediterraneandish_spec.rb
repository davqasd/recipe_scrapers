# frozen_string_literal: true

RSpec.describe "themediterraneandish.com" do
  subject(:recipe) { scrape_cassette("com/themediterraneandish", url: "https://www.themediterraneandish.com/savory-yogurt-bowl/") }

  it "reads the title" do
    expect(recipe.title).to eq("Savory Yogurt Bowls")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup Greek yogurt",
      "1/2 cup cooked chickpeas ((cooked from scratch or drained and rinsed canned chickpeas), patted dry)",
      "2 hard boiled eggs, (grated)",
      "2 Persian cucumbers, (chopped)",
      "2 Roma tomatoes, (chopped)",
      "Extra virgin olive oil",
      "Kosher salt",
      "Za’atar (and/or Dukkah, for serving)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "Greek yogurt" },
      { amount: 0.5, unit: "cup", name: "cooked chickpeas" },
      { amount: 2.0, unit: nil, name: "hard boiled eggs" },
      { amount: 2.0, unit: nil, name: "Persian cucumbers" },
      { amount: 2.0, unit: nil, name: "Roma tomatoes" },
      { amount: nil, unit: nil, name: "Extra virgin olive oil" },
      { amount: nil, unit: nil, name: "Kosher salt" },
      { amount: nil, unit: nil, name: "Za’atar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Build the breakfast bowl. Divide the yogurt into the bottom of two serving bowls. Top with the chickpeas, egg, and veggies.",
      "Finish and serve. Add a drizzle of good extra virgin olive oil, pinch of salt, and a good sprinkle of za’atar or dukkah. Serve or cover and refrigerate for up to 1 night."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Build the breakfast bowl. Divide the yogurt into the bottom of two serving bowls. Top with the chickpeas, egg, and veggies.\nFinish and serve. Add a drizzle of good extra virgin olive oil, pinch of salt, and a good sprinkle of za’atar or dukkah. Serve or cover and refrigerate for up to 1 night.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("themediterraneandish.com")
    expect(recipe.canonical_url).to eq("https://www.themediterraneandish.com/savory-yogurt-bowl/")
    expect(recipe.site_name).to eq("The Mediterranean Dish")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Suzy Karadsheh")
    expect(recipe.description).to eq("This savory breakfast bowl is everything I want for busy weekdays: healthy, easy, keeps me satisfied until lunchtime, and I can prep the night before. Make on repeat all year round! Swap with seasonal vegetables and what you have on hand, and trade out the yogurt for hummus if you're looking for a dairy-free option.")
    expect(recipe.image).to eq("https://www.themediterraneandish.com/wp-content/uploads/2024/10/SAVORY-YOG-BOWL-20208.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("Mediterranean")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["breakfast recipe", "greek yogurt", "savory yogurt"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(%w[GlutenFreeDiet VegetarianDiet])
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(10)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "255.1 kcal",
      "carbohydrateContent" => "24.9 g",
      "proteinContent" => "22.7 g",
      "fatContent" => "7.4 g",
      "saturatedFatContent" => "1.9 g",
      "transFatContent" => "0.01 g",
      "cholesterolContent" => "191.5 mg",
      "sodiumContent" => "106.4 mg",
      "fiberContent" => "5.5 g",
      "sugarContent" => "9.2 g",
      "unsaturatedFatContent" => "4 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 255.1 },
      { name: "carbohydrateContent", unit: "g", amount: 24.9 },
      { name: "proteinContent", unit: "g", amount: 22.7 },
      { name: "fatContent", unit: "g", amount: 7.4 },
      { name: "saturatedFatContent", unit: "g", amount: 1.9 },
      { name: "transFatContent", unit: "g", amount: 0.01 },
      { name: "cholesterolContent", unit: "mg", amount: 191.5 },
      { name: "sodiumContent", unit: "mg", amount: 106.4 },
      { name: "fiberContent", unit: "g", amount: 5.5 },
      { name: "sugarContent", unit: "g", amount: 9.2 },
      { name: "unsaturatedFatContent", unit: "g", amount: 4.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
