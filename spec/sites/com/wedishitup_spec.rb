# frozen_string_literal: true

RSpec.describe "wedishitup.com" do
  subject(:recipe) { scrape_cassette("com/wedishitup", url: "https://wedishitup.com/2530/copy-cat-nacho-bell-grande/") }

  it "reads the title" do
    expect(recipe.title).to eq("Copy Cat Nacho Bell Grande")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 10-13 oz Bag Tortilla Chips",
      "1 lb Ground Beef",
      "1 13 oz Can Refried Beans",
      "1 12 oz Jar Nacho Cheese (Store-Bought )",
      "6-8 oz Sour Cream",
      "1 medium Tomato (Diced)",
      "Green Onions (Optional)",
      "Jalapenos (Optional)",
      "Salsa or Hot Sauce (Optional)",
      "Guacamole (Optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "Bag", name: "Tortilla Chips" },
      { amount: 1.0, unit: "lb", name: "Ground Beef" },
      { amount: 1.0, unit: "Can", name: "Refried Beans" },
      { amount: 1.0, unit: "Jar", name: "Nacho Cheese" },
      { amount: 6.0, unit: "oz", name: "Sour Cream" },
      { amount: 1.0, unit: nil, name: "medium Tomato" },
      { amount: nil, unit: nil, name: "Green Onions" },
      { amount: nil, unit: nil, name: "Jalapenos" },
      { amount: nil, unit: nil, name: "Salsa or Hot Sauce" },
      { amount: nil, unit: nil, name: "Guacamole" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Dump Tortilla Chips out on a Platter",
      "In a Medium Fry Pan -Cook and break up the ground Beef-add Taco Seasoning and water as directed on seasoning",
      "Heat Beans and Nacho Cheese in Microwave",
      "Scoop beans on to chips using an ice cream scoop works best but go with what you have",
      "Spread ground beef over chips and beans",
      "Pour hot nacho cheese over chips , beans, and beef",
      "Sprinkle tomatoes over nachos",
      "Top with sour cream and other optional garnishes Serve and Enjoy"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Dump Tortilla Chips out on a Platter\nIn a Medium Fry Pan -Cook and break up the ground Beef-add Taco Seasoning and water as directed on seasoning\nHeat Beans and Nacho Cheese in Microwave\nScoop beans on to chips using an ice cream scoop works best but go with what you have\nSpread ground beef over chips and beans\nPour hot nacho cheese over chips , beans, and beef\nSprinkle tomatoes over nachos\nTop with sour cream and other optional garnishes Serve and Enjoy")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("wedishitup.com")
    expect(recipe.canonical_url).to eq("https://wedishitup.com/2530/copy-cat-nacho-bell-grande/")
    expect(recipe.site_name).to eq("We Dish It Up")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Stacy Roman")
    expect(recipe.description).to eq("Chips with Beans , Ground Beef, Nacho Cheese, Sour Cream and Tomatoes")
    expect(recipe.image).to eq("https://wedishitup.com/wp-content/uploads/2019/12/Copy-Cat-Nacho-Bell-2.jpg")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("Mexican")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(5)
    expect(recipe.keywords).to eq(["Appetizer", "Bell", "Grande", "Nachos", "Taco Bell"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(3.17)
    expect(recipe.ratings_count).to eq(6)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "212 kcal",
      "carbohydrateContent" => "2 g",
      "proteinContent" => "13 g",
      "fatContent" => "17 g",
      "saturatedFatContent" => "6 g",
      "transFatContent" => "1 g",
      "cholesterolContent" => "54 mg",
      "sodiumContent" => "55 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "1 g",
      "unsaturatedFatContent" => "9 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 212.0 },
      { name: "carbohydrateContent", unit: "g", amount: 2.0 },
      { name: "proteinContent", unit: "g", amount: 13.0 },
      { name: "fatContent", unit: "g", amount: 17.0 },
      { name: "saturatedFatContent", unit: "g", amount: 6.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 54.0 },
      { name: "sodiumContent", unit: "mg", amount: 55.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 9.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
