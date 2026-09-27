# frozen_string_literal: true

RSpec.describe "ohsweetbasil.com" do
  subject(:recipe) { scrape_cassette("com/ohsweetbasil", url: "https://ohsweetbasil.com/white-chocolate-blackberry-cranberry-cream-bars-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("White Chocolate Blackberry Cranberry Cream Bars")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 Egg Yolk",
      "1 Tablespoon Heavy Cream",
      "1/4 teaspoon Vanilla",
      "1 1/4 Cups Flour",
      "2/3 Cup Powdered Sugar",
      "1/4 teaspoon Salt",
      "8 Tablespoons Butter (cold, cut in cubes)",
      "1 Cup Blackberries (frozen)",
      "2 Cups Cranberries",
      "3/4 Cup Sugar",
      "1/2 Cup Orange Juice",
      "1 Tablespoon Flour (heaping)",
      "8 Ounces Creme Fraiche (Vermont Creamery)",
      "3 Large Eggs (plus 1 Egg Yolk, lightly whisked)",
      "2 Cups Sugar",
      "3/4 Cup Flour",
      "1 Tablespoon Orange Juice",
      "1/2 teaspoon Vanilla",
      "1/2 Cup Flour",
      "2 Tablespoons Sugar",
      "1 Tablespoon Brown Sugar",
      "1/4 Cup Butter (cold and cut in cubes)",
      "1 Cup White Chocolate Chips",
      "1 Cup Cranberries",
      "1/4 Cup Sugar",
      "1/4 Cup Water",
      "1/3 Cup Sugar",
      "1 Cup White Chocolate"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "Egg Yolk" },
      { amount: 1.0, unit: "Tablespoon", name: "Heavy Cream" },
      { amount: 0.25, unit: "teaspoon", name: "Vanilla" },
      { amount: 1.25, unit: "Cups", name: "Flour" },
      { amount: 0.67, unit: "Cup", name: "Powdered Sugar" },
      { amount: 0.25, unit: "teaspoon", name: "Salt" },
      { amount: 8.0, unit: "Tablespoons", name: "Butter" },
      { amount: 1.0, unit: "Cup", name: "Blackberries" },
      { amount: 2.0, unit: "Cups", name: "Cranberries" },
      { amount: 0.75, unit: "Cup", name: "Sugar" },
      { amount: 0.5, unit: "Cup", name: "Orange Juice" },
      { amount: 1.0, unit: "Tablespoon", name: "Flour" },
      { amount: 8.0, unit: "Ounces", name: "Creme Fraiche" },
      { amount: 3.0, unit: nil, name: "Large Eggs" },
      { amount: 2.0, unit: "Cups", name: "Sugar" },
      { amount: 0.75, unit: "Cup", name: "Flour" },
      { amount: 1.0, unit: "Tablespoon", name: "Orange Juice" },
      { amount: 0.5, unit: "teaspoon", name: "Vanilla" },
      { amount: 0.5, unit: "Cup", name: "Flour" },
      { amount: 2.0, unit: "Tablespoons", name: "Sugar" },
      { amount: 1.0, unit: "Tablespoon", name: "Brown Sugar" },
      { amount: 0.25, unit: "Cup", name: "Butter" },
      { amount: 1.0, unit: "Cup", name: "White Chocolate Chips" },
      { amount: 1.0, unit: "Cup", name: "Cranberries" },
      { amount: 0.25, unit: "Cup", name: "Sugar" },
      { amount: 0.25, unit: "Cup", name: "Water" },
      { amount: 0.33, unit: "Cup", name: "Sugar" },
      { amount: 1.0, unit: "Cup", name: "White Chocolate" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "For the Tart",
      "In a small bowl, whisk together the egg yolk, cream and vanilla.",
      "In a food processor, add the flour, powdered sugar, salt and butter. Pulse a few times until it resembles coarse sand.",
      "With the machine on, pour in the egg mixture and continue to run the machine until the dough begins to come together.",
      "Create a flat disc with the dough and wrap in saran wrap.",
      "Place in the fridge for 1 hour.",
      "Heat the oven to 400 degrees.",
      "Place parchment paper in an 8x9\" baking dish and press the dough across the bottom.",
      "Prick all over with a fork.",
      "Bake for 10-12 minutes.",
      "Remove from the oven to cool while you proceed with the berries.",
      "For the Berries",
      "In a medium saucepan over medium heat add the blackberries, cranberries, sugar, orange juice and flour.",
      "Stir everything together and bring to a boil.",
      "Turn down to a simmer and allow to cook for about 10 minutes or until the cranberries have burst and the mixture is beginning to thicken.",
      "Place in a strainer bowl to release any excess juice so the bars will set up, and put in the fridge to cool.",
      "Turn the oven down to 350. Proceed to make the cream filling.",
      "For the Cream Filling",
      "Begin the filling by whisking together the creme fraiche, eggs, egg yolk, sugar, flour, orange juice and vanilla.",
      "Pour onto the baked tart crust.",
      "Remove the berry mixture from the fridge and scoop large spoonfuls over the creme fraiche and then use a spatula to swirl everything together.",
      "Bake at 350 for 30 minutes. Make the streusel topping while it bakes.",
      "For the Streusel Topping",
      "Combine the flour, sugar and brown sugar in a bowl and then cut in the cold butter using a pastry cutter or fork.",
      "When the bars are done with their 30 minutes of baking, remove from the oven and cover with the streusel topping.",
      "Bake for an additional 15-20 minutes or until the top is beginning to turn golden. The center will still be a little jiggly.",
      "Remove from the oven.",
      "Allow the bars to cool for 30 minutes then place in the fridge for at least 4 hours to set up.",
      "For serving, melt the white chocolate at 15 second intervals, stirring each time.",
      "Drizzle over the bars and sprinkle with sugared berries.",
      "For the Sugared Berries",
      "In a small saucepan over medium heat, cook the water and sugar until the sugar has dissolved.",
      "Add the cranberries and toss to coat.",
      "Spread over a cooling rack for 1 hour.",
      "Place the cranberries in a bowl with the 1/3 cup sugar and toss to coat.",
      "Serve over the bars."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["For the Tart Crust", 7],
        ["For the Berries", 5],
        ["For the Filling", 6],
        ["For the Topping", 5],
        ["For the Sugared Berries (Optional Garnish)", 5]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("For the Tart\nIn a small bowl, whisk together the egg yolk, cream and vanilla.\nIn a food processor, add the flour, powdered sugar, salt and butter. Pulse a few times until it resembles coarse sand.\nWith the machine on, pour in the egg mixture and continue to run the machine until the dough begins to come together.\nCreate a flat disc with the dough and wrap in saran wrap.\nPlace in the fridge for 1 hour.\nHeat the oven to 400 degrees.\nPlace parchment paper in an 8x9\" baking dish and press the dough across the bottom.\nPrick all over with a fork.\nBake for 10-12 minutes.\nRemove from the oven to cool while you proceed with the berries.\nFor the Berries\nIn a medium saucepan over medium heat add the blackberries, cranberries, sugar, orange juice and flour.\nStir everything together and bring to a boil.\nTurn down to a simmer and allow to cook for about 10 minutes or until the cranberries have burst and the mixture is beginning to thicken.\nPlace in a strainer bowl to release any excess juice so the bars will set up, and put in the fridge to cool.\nTurn the oven down to 350. Proceed to make the cream filling.\nFor the Cream Filling\nBegin the filling by whisking together the creme fraiche, eggs, egg yolk, sugar, flour, orange juice and vanilla.\nPour onto the baked tart crust.\nRemove the berry mixture from the fridge and scoop large spoonfuls over the creme fraiche and then use a spatula to swirl everything together.\nBake at 350 for 30 minutes. Make the streusel topping while it bakes.\nFor the Streusel Topping\nCombine the flour, sugar and brown sugar in a bowl and then cut in the cold butter using a pastry cutter or fork.\nWhen the bars are done with their 30 minutes of baking, remove from the oven and cover with the streusel topping.\nBake for an additional 15-20 minutes or until the top is beginning to turn golden. The center will still be a little jiggly.\nRemove from the oven.\nAllow the bars to cool for 30 minutes then place in the fridge for at least 4 hours to set up.\nFor serving, melt the white chocolate at 15 second intervals, stirring each time.\nDrizzle over the bars and sprinkle with sugared berries.\nFor the Sugared Berries\nIn a small saucepan over medium heat, cook the water and sugar until the sugar has dissolved.\nAdd the cranberries and toss to coat.\nSpread over a cooling rack for 1 hour.\nPlace the cranberries in a bowl with the 1/3 cup sugar and toss to coat.\nServe over the bars.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("ohsweetbasil.com")
    expect(recipe.canonical_url).to eq("https://ohsweetbasil.com/white-chocolate-blackberry-cranberry-cream-bars-recipe/")
    expect(recipe.site_name).to eq("Oh Sweet Basil")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Sweet Basil")
    expect(recipe.description).to eq("These white chocolate blackberry cranberry cream bars are just begging to be at your next holiday party!")
    expect(recipe.image).to eq("https://ohsweetbasil.com/wp-content/uploads/2015/11/white-chocolate-blackberry-cranberry-cream-bars-ohsweetbasil.com-21.jpg")
    expect(recipe.category).to eq("100 Best Brownies and Bars Recipes")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(165)
    expect(recipe.prep_time).to eq(120)
    expect(recipe.cook_time).to eq(45)
    expect(recipe.keywords).to eq(["bars", "cranberry", "dessert", "tart", "white chocolate"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 g",
      "calories" => "668 kcal",
      "carbohydrateContent" => "107 g",
      "proteinContent" => "7 g",
      "cholesterolContent" => "94 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "84 g",
      "fatContent" => "25 g",
      "saturatedFatContent" => "15 g",
      "transFatContent" => "1 g",
      "sodiumContent" => "200 mg",
      "unsaturatedFatContent" => "7 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "g", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 668.0 },
      { name: "carbohydrateContent", unit: "g", amount: 107.0 },
      { name: "proteinContent", unit: "g", amount: 7.0 },
      { name: "cholesterolContent", unit: "mg", amount: 94.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 84.0 },
      { name: "fatContent", unit: "g", amount: 25.0 },
      { name: "saturatedFatContent", unit: "g", amount: 15.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 200.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 7.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
