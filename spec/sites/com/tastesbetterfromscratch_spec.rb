# frozen_string_literal: true

RSpec.describe "tastesbetterfromscratch.com" do
  subject(:recipe) { scrape_cassette("com/tastesbetterfromscratch", url: "https://tastesbetterfromscratch.com/pulled-pork/") }

  it "reads the title" do
    expect(recipe.title).to eq("How to make Pulled Pork")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 lb pork shoulder (, or butt)",
      "2 Tablespoons oil (optional if searing)",
      "1 Tbsp brown sugar",
      "1 tablespoon chili powder",
      "1 teaspoon onion powder",
      "1 teaspoon garlic powder",
      "1 teaspoon cumin",
      "1 teaspoon kosher salt",
      "1 teaspoon black pepper",
      "12 ounces coke (not diet)",
      "bbq sauce for coating meat (optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: "lb", name: "pork shoulder" },
      { amount: 2.0, unit: "Tablespoons", name: "oil" },
      { amount: 1.0, unit: "Tbsp", name: "brown sugar" },
      { amount: 1.0, unit: "tablespoon", name: "chili powder" },
      { amount: 1.0, unit: "teaspoon", name: "onion powder" },
      { amount: 1.0, unit: "teaspoon", name: "garlic powder" },
      { amount: 1.0, unit: "teaspoon", name: "cumin" },
      { amount: 1.0, unit: "teaspoon", name: "kosher salt" },
      { amount: 1.0, unit: "teaspoon", name: "black pepper" },
      { amount: 12.0, unit: "ounces", name: "coke" },
      { amount: nil, unit: nil, name: "bbq sauce for coating meat" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Trim pork of excess fat and cut into 4 pieces.",
      "Combine spices in a small bowl and rub all over the pork. (This can be done the night before).",
      "Sear (optional): Heat a few tablespoons of oil in a Dutch oven pot over medium-high heat. Add the meat and sear for a few seconds on all sides.",
      "Oven Method: Preheat oven to 300 degrees F. Pour coke around the pork in the Dutch oven pot. Cover pot with lid and cook for 3 hours. Remove lid and cook for an additional 1-2 hours, until pork is tender and easily pulls apart with a fork. Remove from pot then shred meat on a cutting board. Toss in barbecue sauce, if desired.",
      "Slow Cooker Method: Place pork in slow cooker and pour coke around it. Cover and cook on LOW (recommended) 8 hours or high for 4-5 hours, until pork is tender and shreds easily with a fork.",
      "Instant Pot Method: Place pork in instant pot and pour coke around it. Cook on Manual/High pressure for 70 minutes. When timer beeps, allow the pot to naturally release pressure, about 15 minutes longer. Remove lid and shred the meat."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Trim pork of excess fat and cut into 4 pieces.\nCombine spices in a small bowl and rub all over the pork. (This can be done the night before).\nSear (optional): Heat a few tablespoons of oil in a Dutch oven pot over medium-high heat. Add the meat and sear for a few seconds on all sides.\nOven Method: Preheat oven to 300 degrees F. Pour coke around the pork in the Dutch oven pot. Cover pot with lid and cook for 3 hours. Remove lid and cook for an additional 1-2 hours, until pork is tender and easily pulls apart with a fork. Remove from pot then shred meat on a cutting board. Toss in barbecue sauce, if desired.\nSlow Cooker Method: Place pork in slow cooker and pour coke around it. Cover and cook on LOW (recommended) 8 hours or high for 4-5 hours, until pork is tender and shreds easily with a fork.\nInstant Pot Method: Place pork in instant pot and pour coke around it. Cook on Manual/High pressure for 70 minutes. When timer beeps, allow the pot to naturally release pressure, about 15 minutes longer. Remove lid and shred the meat.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("tastesbetterfromscratch.com")
    expect(recipe.canonical_url).to eq("https://tastesbetterfromscratch.com/pulled-pork/")
    expect(recipe.site_name).to eq("Tastes Better From Scratch")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Lauren Allen")
    expect(recipe.description).to eq("Tender, juicy, and perfectly cooked Pulled Pork you can make in the oven, slow cooker or instant pot.")
    expect(recipe.image).to eq("https://tastesbetterfromscratch.com/wp-content/uploads/2020/05/Pulled-Pork-5.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(320)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(300)
    expect(recipe.keywords).to eq([
      "how to make pulled pork",
      "pulled pork",
      "pulled pork recipe",
      "pulled pork recipe oven",
      "slow cooker pulled pork"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.99)
    expect(recipe.ratings_count).to eq(2399)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "310 kcal",
      "carbohydrateContent" => "9 g",
      "proteinContent" => "36 g",
      "fatContent" => "13 g",
      "saturatedFatContent" => "5 g",
      "cholesterolContent" => "124 mg",
      "sodiumContent" => "554 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "7 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 310.0 },
      { name: "carbohydrateContent", unit: "g", amount: 9.0 },
      { name: "proteinContent", unit: "g", amount: 36.0 },
      { name: "fatContent", unit: "g", amount: 13.0 },
      { name: "saturatedFatContent", unit: "g", amount: 5.0 },
      { name: "cholesterolContent", unit: "mg", amount: 124.0 },
      { name: "sodiumContent", unit: "mg", amount: 554.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 7.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
