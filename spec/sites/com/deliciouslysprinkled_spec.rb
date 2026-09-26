# frozen_string_literal: true

RSpec.describe "deliciouslysprinkled.com" do
  subject(:recipe) { scrape_cassette("com/deliciouslysprinkled", url: "https://deliciouslysprinkled.com/crockpot-buffalo-chicken-dip/") }

  it "reads the title" do
    expect(recipe.title).to eq("Crockpot Buffalo Chicken Dip")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 12.5 oz cans chunk chicken (drained)",
      "1 cup hot sauce (I use Frank's RedHot)",
      "2 8 oz packages cream cheese (softened)",
      "3/4 cup blue cheese dressing",
      "1 ½ cups Cheddar cheese (shredded)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cans", name: "chunk chicken" },
      { amount: 1.0, unit: "cup", name: "hot sauce" },
      { amount: 2.0, unit: "packages", name: "cream cheese" },
      { amount: 0.75, unit: "cup", name: "blue cheese dressing" },
      { amount: 1.5, unit: "cups", name: "Cheddar cheese" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Add chicken, hot sauce, cream cheese, blue cheese dressing and cheddar cheese to a 6-quart crockpot.",
      "Stir to combine.",
      "Cook on LOW for 1-2 hours or until hot.",
      "Serve with celery sticks, carrots, and tortilla chips."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Add chicken, hot sauce, cream cheese, blue cheese dressing and cheddar cheese to a 6-quart crockpot.\nStir to combine.\nCook on LOW for 1-2 hours or until hot.\nServe with celery sticks, carrots, and tortilla chips.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("deliciouslysprinkled.com")
    expect(recipe.canonical_url).to eq("https://deliciouslysprinkled.com/crockpot-buffalo-chicken-dip/")
    expect(recipe.site_name).to eq("Deliciously Sprinkled")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jennifer")
    expect(recipe.description).to eq("Tasty Buffalo Chicken Dip made in a crockpot perfect for any game day. A tasty combination of cheese, hot suace, and chicken!")
    expect(recipe.image).to eq("https://deliciouslysprinkled.com/wp-content/uploads/2024/09/Crockpot-Buffalo-Chicken-Dip.jpg")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("20 servings")
    expect(recipe.total_time).to eq(125)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(120)
    expect(recipe.keywords).to eq(["Crockpot Buffalo Chicken Dip"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "46 kcal",
      "carbohydrateContent" => "1 g",
      "proteinContent" => "3 g",
      "fatContent" => "4 g",
      "saturatedFatContent" => "2 g",
      "cholesterolContent" => "9 mg",
      "sodiumContent" => "460 mg",
      "fiberContent" => "0.04 g",
      "sugarContent" => "0.4 g",
      "unsaturatedFatContent" => "1.3 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 46.0 },
      { name: "carbohydrateContent", unit: "g", amount: 1.0 },
      { name: "proteinContent", unit: "g", amount: 3.0 },
      { name: "fatContent", unit: "g", amount: 4.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "cholesterolContent", unit: "mg", amount: 9.0 },
      { name: "sodiumContent", unit: "mg", amount: 460.0 },
      { name: "fiberContent", unit: "g", amount: 0.04 },
      { name: "sugarContent", unit: "g", amount: 0.4 },
      { name: "unsaturatedFatContent", unit: "g", amount: 1.3 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
