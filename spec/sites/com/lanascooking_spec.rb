# frozen_string_literal: true

RSpec.describe "lanascooking.com" do
  subject(:recipe) { scrape_cassette("com/lanascooking", url: "https://www.lanascooking.com/southern-tomato-cracker-salad/") }

  it "reads the title" do
    expect(recipe.title).to eq("Southern Tomato Cracker Salad")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 very ripe medium tomatoes",
      "kosher salt to taste",
      "1/2 shallot (finely minced)",
      "2 tablespoons chives (finely chopped)",
      "ground black pepper to taste",
      "1 cup mayonnaise",
      "40 saltine crackers (1 sleeve)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: nil, name: "very ripe medium tomatoes" },
      { amount: nil, unit: nil, name: "kosher salt to taste" },
      { amount: 0.5, unit: nil, name: "shallot" },
      { amount: 2.0, unit: "tablespoons", name: "chives" },
      { amount: nil, unit: nil, name: "ground black pepper to taste" },
      { amount: 1.0, unit: "cup", name: "mayonnaise" },
      { amount: 40.0, unit: nil, name: "saltine crackers" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Start by removing the core, or stem end) of the tomatoes and then cut each in half through the middle or \"waist.\"",
      "Working over a medium bowl or into the sink, press each tomato half gently to get rid of most of the seeds and juice.",
      "Dice the tomatoes. Place the diced tomatoes in a large mixing bowl and sprinkle lightly with salt. Remove a few tablespoons of diced tomatoes for garnish and set them aside.",
      "Into the bowl with the diced tomatoes, add the minced shallot, half of the chives, black pepper, and mayonnaise. Fold together gently to combine.",
      "Crumble the crackers creating mostly large pieces for the best texture.",
      "Add the broken saltine crackers to the bowl with the tomato mixture and fold gently to combine.",
      "Taste for seasoning and adjust if necessary.",
      "Garnish with the reserved tomatoes and remaining chives.",
      "Serve immediately."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Start by removing the core, or stem end) of the tomatoes and then cut each in half through the middle or \"waist.\"\nWorking over a medium bowl or into the sink, press each tomato half gently to get rid of most of the seeds and juice.\nDice the tomatoes. Place the diced tomatoes in a large mixing bowl and sprinkle lightly with salt. Remove a few tablespoons of diced tomatoes for garnish and set them aside.\nInto the bowl with the diced tomatoes, add the minced shallot, half of the chives, black pepper, and mayonnaise. Fold together gently to combine.\nCrumble the crackers creating mostly large pieces for the best texture.\nAdd the broken saltine crackers to the bowl with the tomato mixture and fold gently to combine.\nTaste for seasoning and adjust if necessary.\nGarnish with the reserved tomatoes and remaining chives.\nServe immediately.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("lanascooking.com")
    expect(recipe.canonical_url).to eq("https://www.lanascooking.com/southern-tomato-cracker-salad/")
    expect(recipe.site_name).to eq("Lana's Cooking")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Lana Stuart")
    expect(recipe.description).to eq("If you like a southern tomato sandwich, then you'll fall head over heels for this 15-minute Southern Tomato Cracker Salad recipe!")
    expect(recipe.image).to eq("https://www.lanascooking.com/wp-content/uploads/2022/06/southern-tomato-cracker-salad-feature-1200.jpg")
    expect(recipe.category).to eq("Salads")
    expect(recipe.cuisine).to eq("Southern, Vintage")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(15)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq([
      "cracker salad",
      "southern salads",
      "southern tomato cracker salad",
      "tomato salad",
      "vintage salad recipe"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(4)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 serving",
      "calories" => "278 kcal",
      "carbohydrateContent" => "32 g",
      "proteinContent" => "4 g",
      "fatContent" => "15 g",
      "saturatedFatContent" => "2 g",
      "transFatContent" => "0.2 g",
      "cholesterolContent" => "9 mg",
      "sodiumContent" => "750 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "5 g",
      "unsaturatedFatContent" => "12 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "serving", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 278.0 },
      { name: "carbohydrateContent", unit: "g", amount: 32.0 },
      { name: "proteinContent", unit: "g", amount: 4.0 },
      { name: "fatContent", unit: "g", amount: 15.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "transFatContent", unit: "g", amount: 0.2 },
      { name: "cholesterolContent", unit: "mg", amount: 9.0 },
      { name: "sodiumContent", unit: "mg", amount: 750.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 5.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 12.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
