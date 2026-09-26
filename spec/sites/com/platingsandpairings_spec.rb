# frozen_string_literal: true

RSpec.describe "platingsandpairings.com" do
  subject(:recipe) { scrape_cassette("com/platingsandpairings", url: "https://www.platingsandpairings.com/how-to-cook-perfect-quinoa-in-the-instant-pot/") }

  it "reads the title" do
    expect(recipe.title).to eq("Instant Pot Quinoa Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup quinoa",
      "1 1/2 cups water",
      "Spray cooking oil",
      "1 pinch salt"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "quinoa" },
      { amount: 1.5, unit: "cups", name: "water" },
      { amount: nil, unit: nil, name: "Spray cooking oil" },
      { amount: 1.0, unit: "pinch", name: "salt" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Rinse quinoa under cold running water until the water runs clear.",
      "Spray the Instant Pot liner with cooking oil and add the rinsed quinoa (still damp), water and salt.",
      "Lock the lid and set the steam valve to its “sealing” position.",
      "Select the “MANUAL” button and cook for 1 minute on high pressure. It will take about 5 minutes for the pressure to build, then the countdown timer will start.",
      "Allow the pressure to release naturally for 10 minutes and then release any remaining pressure.",
      "Fluff quinoa with a fork and serve."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Rinse quinoa under cold running water until the water runs clear.\nSpray the Instant Pot liner with cooking oil and add the rinsed quinoa (still damp), water and salt.\nLock the lid and set the steam valve to its “sealing” position.\nSelect the “MANUAL” button and cook for 1 minute on high pressure. It will take about 5 minutes for the pressure to build, then the countdown timer will start.\nAllow the pressure to release naturally for 10 minutes and then release any remaining pressure.\nFluff quinoa with a fork and serve.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("platingsandpairings.com")
    expect(recipe.canonical_url).to eq("https://www.platingsandpairings.com/how-to-cook-perfect-quinoa-in-the-instant-pot/")
    expect(recipe.site_name).to eq("Platings + Pairings")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Erin Lynch")
    expect(recipe.description).to eq("With these easy tips, you’ll see it’s simple to cook perfect quinoa in the Instant Pot with minimal measuring. The result is fluffy and flavorful quinoa that’s super simple to prepare.")
    expect(recipe.image).to eq("https://www.platingsandpairings.com/wp-content/uploads/2022/06/instant-pot-quinoa-recipe-8-scaled.jpg")
    expect(recipe.category).to eq("Side Dish")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(1)
    expect(recipe.cook_time).to eq(1)
    expect(recipe.keywords).to eq([
      "easy quinoa",
      "fluffy quinoa",
      "instant pot quinoa",
      "pressure cooker quinoa",
      "quick quinoa"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(156)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "156 kcal",
      "carbohydrateContent" => "27 g",
      "proteinContent" => "6 g",
      "fatContent" => "2 g",
      "sodiumContent" => "16 mg",
      "fiberContent" => "2 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 156.0 },
      { name: "carbohydrateContent", unit: "g", amount: 27.0 },
      { name: "proteinContent", unit: "g", amount: 6.0 },
      { name: "fatContent", unit: "g", amount: 2.0 },
      { name: "sodiumContent", unit: "mg", amount: 16.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.facebook.com/platingsandpairings/")
  end
end
