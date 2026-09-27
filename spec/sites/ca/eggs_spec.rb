# frozen_string_literal: true

RSpec.describe "eggs.ca" do
  subject(:recipe) { scrape_cassette("ca/eggs", url: "https://eggs.ca/recipes/easy-egg-bake-casserole/") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy Egg Bake Casserole")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 cups sweet potatoes (about 1 lb/450 g), peeled and cubed (1/2 in/1 cm)",
      "1 large sweet onion, sliced into 1/4 in (0.5 cm) wedges",
      "2 red peppers, cut into 1/4 in (0.5 cm) slices",
      "2 yellow peppers, cut into 1/4 in (0.5 cm) slices",
      "1 cup marinara sauce",
      "1/2 cup water",
      "2 tbsp olive oil",
      "2 cloves garlic, minced",
      "1 tsp smoked paprika",
      "1/2 tsp kosher salt",
      "1/4 tsp freshly ground black pepper",
      "3 smoked and fully cooked Spanish chorizo sausages, sliced into 1/2 in (1 cm) half moons",
      "1 cup cherry tomatoes, halved",
      "6 eggs",
      "2 oz feta cheese, crumbled",
      "1/2 tsp Aleppo pepper or chili flakes (optional)",
      "1 tbsp chopped fresh chives"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: "cups", name: "sweet potatoes, peeled and cubed" },
      { amount: 1.0, unit: nil, name: "large sweet onion, sliced into 1/4 in wedges" },
      { amount: 2.0, unit: nil, name: "red peppers, cut into 1/4 in slices" },
      { amount: 2.0, unit: nil, name: "yellow peppers, cut into 1/4 in slices" },
      { amount: 1.0, unit: "cup", name: "marinara sauce" },
      { amount: 0.5, unit: "cup", name: "water" },
      { amount: 2.0, unit: "tbsp", name: "olive oil" },
      { amount: 2.0, unit: "cloves", name: "garlic, minced" },
      { amount: 1.0, unit: "tsp", name: "smoked paprika" },
      { amount: 0.5, unit: "tsp", name: "kosher salt" },
      { amount: 0.25, unit: "tsp", name: "freshly ground black pepper" },
      { amount: 3.0, unit: nil, name: "smoked and fully cooked Spanish chorizo sausages, sliced into 1/2 in half moons" },
      { amount: 1.0, unit: "cup", name: "cherry tomatoes, halved" },
      { amount: 6.0, unit: nil, name: "eggs" },
      { amount: 2.0, unit: "oz", name: "feta cheese, crumbled" },
      { amount: 0.5, unit: "tsp", name: "Aleppo pepper or chili flakes" },
      { amount: 1.0, unit: "tbsp", name: "chopped fresh chives" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 425°F (220°C).",
      "In a large casserole dish (approximately 9 in x 13 in / 23 cm x 33 cm), toss the sweet potatoes, onion, and red and yellow peppers with the marinara sauce, water, olive oil, garlic, smoked paprika, salt and pepper. Roast for 35 minutes, stirring about halfway through.",
      "Remove the casserole dish from the oven. Stir the sausage into the mixture and sprinkle the cherry tomatoes on top. With the back of a serving spoon, make 6 evenly spaced indents in the vegetable mixture. They should be deep enough to hold the eggs. Crack an egg into each indent. Return the casserole dish to the oven and bake until the egg whites are set and the yolks are still soft, about 10 to 12 minutes.",
      "Remove the egg bake from the oven and sprinkle with feta cheese, Aleppo pepper (if using) and chives. Serve hot with crusty bread or warm pita, if desired, to mop up the juices."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 425°F (220°C).\nIn a large casserole dish (approximately 9 in x 13 in / 23 cm x 33 cm), toss the sweet potatoes, onion, and red and yellow peppers with the marinara sauce, water, olive oil, garlic, smoked paprika, salt and pepper. Roast for 35 minutes, stirring about halfway through.\nRemove the casserole dish from the oven. Stir the sausage into the mixture and sprinkle the cherry tomatoes on top. With the back of a serving spoon, make 6 evenly spaced indents in the vegetable mixture. They should be deep enough to hold the eggs. Crack an egg into each indent. Return the casserole dish to the oven and bake until the egg whites are set and the yolks are still soft, about 10 to 12 minutes.\nRemove the egg bake from the oven and sprinkle with feta cheese, Aleppo pepper (if using) and chives. Serve hot with crusty bread or warm pita, if desired, to mop up the juices.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("eggs.ca")
    expect(recipe.canonical_url).to eq("https://eggs.ca/recipes/easy-egg-bake-casserole/")
    expect(recipe.site_name).to eq("Eggs.ca")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("This colourful egg bake combines roasted sweet potatoes, peppers, and chorizo with marinara sauce for a hearty one-dish meal. The vegetables and sausage can be prepped ahead, then topped with eggs and baked until just set. Serve hot from the oven, garnished with feta and chives.")
    expect(recipe.image).to eq("https://eggs.ca/wp-content/uploads/2024/06/EFC-Easy-Egg-Bake-Casserole-1280x720-v2.jpg")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(80)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(50)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "432",
      "fatContent" => "24 g",
      "transFatContent" => "0 g",
      "saturatedFatContent" => "8 g",
      "sodiumContent" => "955 mg",
      "carbohydrateContent" => "35 g",
      "sugarContent" => "11 g",
      "proteinContent" => "19 g",
      "fiberContent" => "6 g",
      "servingSize" => "1/6"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: nil, amount: 432.0 },
      { name: "fatContent", unit: "g", amount: 24.0 },
      { name: "transFatContent", unit: "g", amount: 0.0 },
      { name: "saturatedFatContent", unit: "g", amount: 8.0 },
      { name: "sodiumContent", unit: "mg", amount: 955.0 },
      { name: "carbohydrateContent", unit: "g", amount: 35.0 },
      { name: "sugarContent", unit: "g", amount: 11.0 },
      { name: "proteinContent", unit: "g", amount: 19.0 },
      { name: "fiberContent", unit: "g", amount: 6.0 },
      { name: "servingSize", unit: nil, amount: 0.16666666666666666 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://eggs.ca/")
  end
end
