# frozen_string_literal: true

RSpec.describe "littlespicejar.com" do
  subject(:recipe) { scrape_cassette("com/littlespicejar", url: "https://littlespicejar.com/crab-cake-bites/") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy Addicting Crab Cake Bites (Crab Cake Cups)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "Cooking spray (for pan)",
      "1 cup panko bread crumbs",
      "½ cup parmesan cheese (shredded or grated)",
      "6 tablespoon melted butter",
      "8 ounces lump crab meat",
      "6 ounces cream cheese (softened to room temp)",
      "1 large egg (lightly beaten)",
      "¼ cup mayonnaise",
      "½ cup sour cream",
      "½ teaspoon garlic powder",
      "½ teaspoon smoked paprika",
      "1 teaspoon old bay seasoning",
      "1 teaspoon lemon zest",
      "2 teaspoons lemon juice",
      "1 tablespoon chopped chives (plus more for topping)",
      "Salt and white pepper (or black pepper)",
      "Serve with sauce (in notes)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "Cooking spray" },
      { amount: 1.0, unit: "cup", name: "panko bread crumbs" },
      { amount: 0.5, unit: "cup", name: "parmesan cheese" },
      { amount: 6.0, unit: "tablespoon", name: "melted butter" },
      { amount: 8.0, unit: "ounces", name: "lump crab meat" },
      { amount: 6.0, unit: "ounces", name: "cream cheese" },
      { amount: 1.0, unit: nil, name: "large egg" },
      { amount: 0.25, unit: "cup", name: "mayonnaise" },
      { amount: 0.5, unit: "cup", name: "sour cream" },
      { amount: 0.5, unit: "teaspoon", name: "garlic powder" },
      { amount: 0.5, unit: "teaspoon", name: "smoked paprika" },
      { amount: 1.0, unit: "teaspoon", name: "old bay seasoning" },
      { amount: 1.0, unit: "teaspoon", name: "lemon zest" },
      { amount: 2.0, unit: "teaspoons", name: "lemon juice" },
      { amount: 1.0, unit: "tablespoon", name: "chopped chives" },
      { amount: nil, unit: nil, name: "Salt and white pepper" },
      { amount: nil, unit: nil, name: "Serve with sauce" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "PANKO: Position a rack in the center of the oven and preheat the oven to 400ºF. Grease a mini muffin pan with cooking spray. Mix together the panko, parmesan cheese, and melted butter. Place roughly 2 teaspoons of the panko mixture in the bottom of each muffin cup using your fingers or the bottom of a measuring teaspoon (or tablespoon) gently pack into a tight shape.",
      "CRAB MIXTURE: Combine the crab meat, cream cheese, mayonnaise, egg, sour cream garlic powder, smoked paprika, old bay seasoning, lemon juice + zest, chopped chives, and ¼ teaspoon kosher salt, and ¼ teaspoon pepper. Spoon roughly 1 tablespoon of the crab mixture into each mini muffin cup.",
      "BAKE: Until the edges begin to turn golden, 14-18 minutes. Allow the crab cakes to cool in the pan for several minutes before attempting to remove them. You can run an offset spatula or a pairing knife along the edges to help pop out the bites. Serve crab bites warm or allow them to cool to room temperature before serving. I like to top them with more chopped chives before serving and serve with lemon wedges and prepared sauce."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("PANKO: Position a rack in the center of the oven and preheat the oven to 400ºF. Grease a mini muffin pan with cooking spray. Mix together the panko, parmesan cheese, and melted butter. Place roughly 2 teaspoons of the panko mixture in the bottom of each muffin cup using your fingers or the bottom of a measuring teaspoon (or tablespoon) gently pack into a tight shape.\nCRAB MIXTURE: Combine the crab meat, cream cheese, mayonnaise, egg, sour cream garlic powder, smoked paprika, old bay seasoning, lemon juice + zest, chopped chives, and ¼ teaspoon kosher salt, and ¼ teaspoon pepper. Spoon roughly 1 tablespoon of the crab mixture into each mini muffin cup.\nBAKE: Until the edges begin to turn golden, 14-18 minutes. Allow the crab cakes to cool in the pan for several minutes before attempting to remove them. You can run an offset spatula or a pairing knife along the edges to help pop out the bites. Serve crab bites warm or allow them to cool to room temperature before serving. I like to top them with more chopped chives before serving and serve with lemon wedges and prepared sauce.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("littlespicejar.com")
    expect(recipe.canonical_url).to eq("https://www.littlespicejar.com/crab-cake-bites/")
    expect(recipe.site_name).to eq("Little Spice Jar")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Marzia")
    expect(recipe.description).to eq("Delicious mini crab cake bites that are quick and easy to make! These mini crab cakes taste just like the real thing but require way less work and are perfect to pass around for parties or for the holidays!")
    expect(recipe.image).to eq("https://www.littlespicejar.com/wp-content/uploads/2020/12/Addicting-Mini-Crab-Cake-Bites-1.jpg")
    expect(recipe.category).to eq("Appetizers")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("13 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.92)
    expect(recipe.ratings_count).to eq(106)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "2 cups",
      "calories" => "193 kcal",
      "carbohydrateContent" => "5 g",
      "proteinContent" => "7 g",
      "fatContent" => "16 g",
      "fiberContent" => "0.3 g",
      "sugarContent" => "1 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "cups", amount: 2.0 },
      { name: "calories", unit: "kcal", amount: 193.0 },
      { name: "carbohydrateContent", unit: "g", amount: 5.0 },
      { name: "proteinContent", unit: "g", amount: 7.0 },
      { name: "fatContent", unit: "g", amount: 16.0 },
      { name: "fiberContent", unit: "g", amount: 0.3 },
      { name: "sugarContent", unit: "g", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
