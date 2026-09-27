# frozen_string_literal: true

RSpec.describe "acouplecooks.com" do
  subject(:recipe) { scrape_cassette("com/acouplecooks", url: "https://www.acouplecooks.com/cheese-sauce-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Cheese Sauce")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 tablespoon flour*",
      "1 tablespoon butter",
      "3/4 cup milk",
      "6 ounces mild to medium cheddar cheese**, grated (1 ½ cups)",
      "⅛ teaspoon onion powder",
      "⅛ teaspoon garlic powder",
      "⅛ teaspoon kosher salt",
      "½ teaspoon apple cider vinegar or white wine vinegar",
      "Optional: 1 to 2 teaspoons hot sauce",
      "Go to Nacho Cheese Sauce and omit the hot sauce"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "tablespoon", name: "flour*" },
      { amount: 1.0, unit: "tablespoon", name: "butter" },
      { amount: 0.75, unit: "cup", name: "milk" },
      { amount: 6.0, unit: "ounces", name: "mild to medium cheddar cheese**, grated" },
      { amount: 0.13, unit: "teaspoon", name: "onion powder" },
      { amount: 0.13, unit: "teaspoon", name: "garlic powder" },
      { amount: 0.13, unit: "teaspoon", name: "kosher salt" },
      { amount: 0.5, unit: "teaspoon", name: "apple cider vinegar or white wine vinegar" },
      { amount: 1.0, unit: "teaspoons", name: "hot sauce" },
      { amount: nil, unit: nil, name: "Go to Nacho Cheese Sauce and omit the hot sauce" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a small or medium saucepan over medium heat, melt the butter. Add the flour and whisk constantly for 1 minute, until bubbly and golden.",
      "Add a splash of milk and whisk it in: the sauce will instantly turn chunky. Constantly whisking, continue to add splashes of milk and whisk them in until the entire quantity is incorporated and the sauce is smooth. Cook 2 to 3 minutes, whisking frequently, until very thick and smooth.",
      "Turn off the heat and stir in the spices. Stir in the cheese 1 handful at a time, only adding more when it has melted. Once you need more temperature to melt the cheese, return heat to low to complete melting. Once fully smooth, it will be thick. Whisk in 2 more tablespoons of milk until it comes to a pourable consistency, then stir in the vinegar (and hot sauce, if using). Serve immediately. Note that leftovers don’t reheat well after refrigeration. Make the Nacho Cheese Sauce (without hot sauce) if you want a recipe that holds up well and works as leftovers."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Classic cheese sauce", 9],
        ["Cheese sauce with evaporated milk (works for leftovers)***", 1]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a small or medium saucepan over medium heat, melt the butter. Add the flour and whisk constantly for 1 minute, until bubbly and golden.\nAdd a splash of milk and whisk it in: the sauce will instantly turn chunky. Constantly whisking, continue to add splashes of milk and whisk them in until the entire quantity is incorporated and the sauce is smooth. Cook 2 to 3 minutes, whisking frequently, until very thick and smooth.\nTurn off the heat and stir in the spices. Stir in the cheese 1 handful at a time, only adding more when it has melted. Once you need more temperature to melt the cheese, return heat to low to complete melting. Once fully smooth, it will be thick. Whisk in 2 more tablespoons of milk until it comes to a pourable consistency, then stir in the vinegar (and hot sauce, if using). Serve immediately. Note that leftovers don’t reheat well after refrigeration. Make the Nacho Cheese Sauce (without hot sauce) if you want a recipe that holds up well and works as leftovers.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("acouplecooks.com")
    expect(recipe.canonical_url).to eq("https://www.acouplecooks.com/cheese-sauce-recipe/")
    expect(recipe.site_name).to eq("A Couple Cooks")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Sonja Overhiser")
    expect(recipe.description).to eq("Try this smooth, creamy cheese sauce recipe! Here's how to make a simple sauce for for broccoli, fries, chips, and more.")
    expect(recipe.image).to eq("https://www.acouplecooks.com/wp-content/uploads/2022/06/Cheese-Sauce-005-225x225.jpg")
    expect(recipe.category).to eq("Sauce")
    expect(recipe.cuisine).to eq("Cheese")
    expect(recipe.cooking_method).to eq("Stovetop")
    expect(recipe.yields).to eq("1 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Cheese sauce", "cheese sauce recipe"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["VegetarianDiet"])
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 tablespoon",
      "calories" => "56 calories",
      "sugarContent" => "0.7 g",
      "sodiumContent" => "90 mg",
      "fatContent" => "4.3 g",
      "saturatedFatContent" => "2.5 g",
      "transFatContent" => "0.1 g",
      "carbohydrateContent" => "1.4 g",
      "fiberContent" => "0 g",
      "proteinContent" => "2.9 g",
      "cholesterolContent" => "12.7 mg"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "tablespoon", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 56.0 },
      { name: "sugarContent", unit: "g", amount: 0.7 },
      { name: "sodiumContent", unit: "mg", amount: 90.0 },
      { name: "fatContent", unit: "g", amount: 4.3 },
      { name: "saturatedFatContent", unit: "g", amount: 2.5 },
      { name: "transFatContent", unit: "g", amount: 0.1 },
      { name: "carbohydrateContent", unit: "g", amount: 1.4 },
      { name: "fiberContent", unit: "g", amount: 0.0 },
      { name: "proteinContent", unit: "g", amount: 2.9 },
      { name: "cholesterolContent", unit: "mg", amount: 12.7 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
