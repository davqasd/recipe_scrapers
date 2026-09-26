# frozen_string_literal: true

RSpec.describe "budgetbytes.com" do
  subject(:recipe) { scrape_cassette("com/budgetbytes", url: "https://www.budgetbytes.com/smash-burger/") }

  it "reads the title" do
    expect(recipe.title).to eq("Smash Burgers")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 lb ground beef* ($6.99)",
      "4 Tbsp frozen salted butter, divided* ($0.56)",
      "3 tsp Homemade Burger Seasoning ($0.33)",
      "4 burger buns ($2.99)",
      "4 leaves iceberg lettuce ($0.37)",
      "1 tomato, sliced into thin rounds ($0.45)",
      "1/4 small red onion, sliced into thin rounds ($0.16)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "lb", name: "ground beef*" },
      { amount: 4.0, unit: "Tbsp", name: "frozen salted butter, divided*" },
      { amount: 3.0, unit: "tsp", name: "Homemade Burger Seasoning" },
      { amount: 4.0, unit: nil, name: "burger buns" },
      { amount: 4.0, unit: "leaves", name: "iceberg lettuce" },
      { amount: 1.0, unit: nil, name: "tomato, sliced into thin rounds" },
      { amount: 0.25, unit: nil, name: "small red onion, sliced into thin rounds" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Separate the ground beef into four equal portions.",
      "Grate 1/2 tablespoon of frozen butter onto each portion. Wrap the meat around the butter and shape it into a ball. Chill the beef until you are ready to cook. Place an ungreased cast iron skillet over high heat. Turn on your exhaust fan. Open a window.",
      "When the skillet is smoking hot, sprinkle a 3/4 teaspoon of burger seasoning all over the beef ball, then place it in the pan.",
      "Smash down with a spatula and keep the spatula on the burger as it cooks. When you see the top of the patty change color (about 2 minutes), carefully work the spatula under the patty. Take your time with this step, as the patty will be stuck to the pan.*",
      "When you have loosened the patty, flip it and smash it again. Cook for 2 minutes more, remove the patty from the pan, and rest it on a cooling rack. Wipe the pan down with a paper towel and cook the remaining patties.",
      "While the patties rest, place a rack in the top third of your oven and put it on broil. Melt the remaining 2 tablespoons of butter and brush it onto the inside of the buns. Place them buttered side up on a sheet pan and toast in the oven for a few minutes until golden.",
      "Assemble the burgers. Place the burger on the bottom bun and top with onion rounds, tomato slices, and lettuce. Add the top bun and enjoy the crispiest, smokiest, burger ever!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Separate the ground beef into four equal portions.\nGrate 1/2 tablespoon of frozen butter onto each portion. Wrap the meat around the butter and shape it into a ball. Chill the beef until you are ready to cook. Place an ungreased cast iron skillet over high heat. Turn on your exhaust fan. Open a window.\nWhen the skillet is smoking hot, sprinkle a 3/4 teaspoon of burger seasoning all over the beef ball, then place it in the pan.\nSmash down with a spatula and keep the spatula on the burger as it cooks. When you see the top of the patty change color (about 2 minutes), carefully work the spatula under the patty. Take your time with this step, as the patty will be stuck to the pan.*\nWhen you have loosened the patty, flip it and smash it again. Cook for 2 minutes more, remove the patty from the pan, and rest it on a cooling rack. Wipe the pan down with a paper towel and cook the remaining patties.\nWhile the patties rest, place a rack in the top third of your oven and put it on broil. Melt the remaining 2 tablespoons of butter and brush it onto the inside of the buns. Place them buttered side up on a sheet pan and toast in the oven for a few minutes until golden.\nAssemble the burgers. Place the burger on the bottom bun and top with onion rounds, tomato slices, and lettuce. Add the top bun and enjoy the crispiest, smokiest, burger ever!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("budgetbytes.com")
    expect(recipe.canonical_url).to eq("https://www.budgetbytes.com/smash-burger/")
    expect(recipe.site_name).to eq("Budget Bytes")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Monti Carlo")
    expect(recipe.description).to eq("If you love a meaty, juicy burger patty with loads of crispy edges and tons of smoky crooks and crannies for your favorite sauce or cheese to sink into, this Smash Burger recipe is for you!")
    expect(recipe.image).to eq("https://www.budgetbytes.com/wp-content/uploads/2023/05/Smash-Burger-plated.jpg")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["Burger Seasoning", "Cheese Burger", "Smash Burger"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.7)
    expect(recipe.ratings_count).to eq(23)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 burger",
      "calories" => "516 kcal",
      "carbohydrateContent" => "23 g",
      "proteinContent" => "24 g",
      "fatContent" => "36 g",
      "sodiumContent" => "453 mg",
      "fiberContent" => "1 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "burger", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 516.0 },
      { name: "carbohydrateContent", unit: "g", amount: 23.0 },
      { name: "proteinContent", unit: "g", amount: 24.0 },
      { name: "fatContent", unit: "g", amount: 36.0 },
      { name: "sodiumContent", unit: "mg", amount: 453.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/join/")
  end
end
