# frozen_string_literal: true

RSpec.describe "barefeetinthekitchen.com" do
  subject(:recipe) { scrape_cassette("com/barefeetinthekitchen", url: "https://barefeetinthekitchen.com/roasted-sweet-potato-and-spinach/") }

  it "reads the title" do
    expect(recipe.title).to eq("Sweet Potato Hash with Eggs")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 large sweet potatoes, cut into ½\"-1\" pieces, about 4 cups",
      "2 tablespoons olive oil",
      "½ teaspoon kosher salt, adjust to taste",
      "½ teaspoon freshly cracked black pepper, adjust to taste",
      "1 pound breakfast sausage of your choice",
      "1 small yellow onion, chopped into ½\" pieces, about 1 cup",
      "4 cups baby spinach leaves",
      "(optional) eggs, 1 per person"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "large sweet potatoes, cut into ½\"-1\" pieces, about 4 cups" },
      { amount: 2.0, unit: "tablespoons", name: "olive oil" },
      { amount: 0.5, unit: "teaspoon", name: "kosher salt, adjust to taste" },
      { amount: 0.5, unit: "teaspoon", name: "freshly cracked black pepper, adjust to taste" },
      { amount: 1.0, unit: "pound", name: "breakfast sausage of your choice" },
      { amount: 1.0, unit: nil, name: "small yellow onion, chopped into ½\" pieces, about 1 cup" },
      { amount: 4.0, unit: "cups", name: "baby spinach leaves" },
      { amount: nil, unit: nil, name: "eggs, 1 per person" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Roasting Instructions",
      "Preheat the oven to 400°F. Place the sweet potatoes in a large mixing bowl and drizzle with olive oil. Sprinkle generously with salt and pepper and toss to coat thoroughly.",
      "Coat a large baking sheet with oil and spread the potatoes across it. Roast the potatoes until they are fork tender, and then roast a bit longer to get a slightly crisp edge. This usually takes between 45-70 minutes depending on how many potatoes I am cooking at the time.",
      "Skillet Instructions",
      "When the potatoes are almost done, add the sausage and the onions to a large skillet over medium-high heat. Cook and crumble the sausage while browning the onions.",
      "Drain the sausage (if needed) and add the spinach. Remove from the heat and toss together to wilt the spinach. Remove to a serving dish and cover loosely to keep warm.",
      "In the same skillet used for the sausage, cook the eggs until the whites are set and the yolks are still soft and runny. When ready to eat, top the spinach mixture with the soft eggs."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Roasting Instructions\nPreheat the oven to 400°F. Place the sweet potatoes in a large mixing bowl and drizzle with olive oil. Sprinkle generously with salt and pepper and toss to coat thoroughly.\nCoat a large baking sheet with oil and spread the potatoes across it. Roast the potatoes until they are fork tender, and then roast a bit longer to get a slightly crisp edge. This usually takes between 45-70 minutes depending on how many potatoes I am cooking at the time.\nSkillet Instructions\nWhen the potatoes are almost done, add the sausage and the onions to a large skillet over medium-high heat. Cook and crumble the sausage while browning the onions.\nDrain the sausage (if needed) and add the spinach. Remove from the heat and toss together to wilt the spinach. Remove to a serving dish and cover loosely to keep warm.\nIn the same skillet used for the sausage, cook the eggs until the whites are set and the yolks are still soft and runny. When ready to eat, top the spinach mixture with the soft eggs.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("barefeetinthekitchen.com")
    expect(recipe.canonical_url).to eq("https://barefeetinthekitchen.com/roasted-sweet-potato-and-spinach/")
    expect(recipe.site_name).to eq("Barefeet in the Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Mary Younkin")
    expect(recipe.description).to eq("Roasted sweet potatoes, crisp warm baby spinach and spicy breakfast sausage are all topped with a soft egg in this Sweet Potato Hash with Eggs.")
    expect(recipe.image).to eq("https://barefeetinthekitchen.com/wp-content/uploads/2023/08/Sausage-Sweet-Potato-Hash-BFK-7-1-of-1.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(70)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(60)
    expect(recipe.keywords).to eq(["Sweet Potato Hash with Eggs"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(5)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "518 kcal",
      "carbohydrateContent" => "25 g",
      "proteinContent" => "20 g",
      "fatContent" => "37 g",
      "saturatedFatContent" => "11 g",
      "cholesterolContent" => "82 mg",
      "sodiumContent" => "808 mg",
      "fiberContent" => "4 g",
      "sugarContent" => "6 g",
      "transFatContent" => "0.2 g",
      "unsaturatedFatContent" => "24 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 518.0 },
      { name: "carbohydrateContent", unit: "g", amount: 25.0 },
      { name: "proteinContent", unit: "g", amount: 20.0 },
      { name: "fatContent", unit: "g", amount: 37.0 },
      { name: "saturatedFatContent", unit: "g", amount: 11.0 },
      { name: "cholesterolContent", unit: "mg", amount: 82.0 },
      { name: "sodiumContent", unit: "mg", amount: 808.0 },
      { name: "fiberContent", unit: "g", amount: 4.0 },
      { name: "sugarContent", unit: "g", amount: 6.0 },
      { name: "transFatContent", unit: "g", amount: 0.2 },
      { name: "unsaturatedFatContent", unit: "g", amount: 24.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
