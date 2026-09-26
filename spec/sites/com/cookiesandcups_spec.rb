# frozen_string_literal: true

RSpec.describe "cookiesandcups.com" do
  subject(:recipe) { scrape_cassette("com/cookiesandcups", url: "https://cookiesandcups.com/brown-sugar-pancakes/") }

  it "reads the title" do
    expect(recipe.title).to eq("Brown Sugar Pancakes")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups all purpose flour",
      "2 tablespoons baking powder",
      "1 teaspoon kosher salt",
      "3 tablespoons dark brown sugar",
      "2 eggs",
      "1 teaspoon vanilla",
      "1 1/2 cups milk",
      "5 tablespoons butter, melted",
      "butter for frying"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "all purpose flour" },
      { amount: 2.0, unit: "tablespoons", name: "baking powder" },
      { amount: 1.0, unit: "teaspoon", name: "kosher salt" },
      { amount: 3.0, unit: "tablespoons", name: "dark brown sugar" },
      { amount: 2.0, unit: nil, name: "eggs" },
      { amount: 1.0, unit: "teaspoon", name: "vanilla" },
      { amount: 1.5, unit: "cups", name: "milk" },
      { amount: 5.0, unit: "tablespoons", name: "butter, melted" },
      { amount: nil, unit: nil, name: "butter for frying" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large bowl whisk the flour, baking powder, salt and brown sugar together.",
      "In separate bowl whisk the eggs, vanilla and milk together.",
      "Add the wet ingredients into the dry and mix until just combined. Lastly mix in the melted butter and stir until combined, the batter will be slightly lumpy. Set the batter aside while you heat your griddle to medium-low heat. Melt a small pat of butter on the griddle and then scoop out 1/2 cup of pancake batter onto the hot griddle.",
      "Cook until the edges are set and bubbles form on top of the pancake. Flip and cook until browned.",
      "Serve warm."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large bowl whisk the flour, baking powder, salt and brown sugar together.\nIn separate bowl whisk the eggs, vanilla and milk together.\nAdd the wet ingredients into the dry and mix until just combined. Lastly mix in the melted butter and stir until combined, the batter will be slightly lumpy. Set the batter aside while you heat your griddle to medium-low heat. Melt a small pat of butter on the griddle and then scoop out 1/2 cup of pancake batter onto the hot griddle.\nCook until the edges are set and bubbles form on top of the pancake. Flip and cook until browned.\nServe warm.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cookiesandcups.com")
    expect(recipe.canonical_url).to eq("https://cookiesandcups.com/brown-sugar-pancakes/")
    expect(recipe.site_name).to eq("Cookies and Cups")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Cookies & Cups")
    expect(recipe.description).to eq("These Brown Sugar Pancakes are easy, fluffy, and thick! They're the BEST!")
    expect(recipe.image).to eq("https://cookiesandcups.com/wp-content/uploads/2017/10/brownsugarpancakessyrup-266x266-225x225.jpg")
    expect(recipe.category).to eq("Pancakes")
    expect(recipe.cuisine).to eq("Breakfast")
    expect(recipe.cooking_method).to eq("Skillet")
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(13)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(8)
    expect(recipe.keywords).to eq([
      "best pancakes",
      "brown sugar pancakes",
      "fluffy pancake recipe",
      "homemade pancakes"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.4)
    expect(recipe.ratings_count).to eq(29)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "2 pancakes",
      "calories" => "377 calories",
      "sugarContent" => "9.3 g",
      "sodiumContent" => "543.6 mg",
      "fatContent" => "14 g",
      "saturatedFatContent" => "7.9 g",
      "transFatContent" => "0 g",
      "carbohydrateContent" => "55.2 g",
      "fiberContent" => "1.7 g",
      "proteinContent" => "10.3 g",
      "cholesterolContent" => "106.4 mg"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "pancakes", amount: 2.0 },
      { name: "calories", unit: "kcal", amount: 377.0 },
      { name: "sugarContent", unit: "g", amount: 9.3 },
      { name: "sodiumContent", unit: "mg", amount: 543.6 },
      { name: "fatContent", unit: "g", amount: 14.0 },
      { name: "saturatedFatContent", unit: "g", amount: 7.9 },
      { name: "transFatContent", unit: "g", amount: 0.0 },
      { name: "carbohydrateContent", unit: "g", amount: 55.2 },
      { name: "fiberContent", unit: "g", amount: 1.7 },
      { name: "proteinContent", unit: "g", amount: 10.3 },
      { name: "cholesterolContent", unit: "mg", amount: 106.4 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
