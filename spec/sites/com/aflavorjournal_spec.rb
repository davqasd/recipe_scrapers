# frozen_string_literal: true

RSpec.describe "aflavorjournal.com" do
  subject(:recipe) { scrape_cassette("com/aflavorjournal", url: "https://aflavorjournal.com/small-batch-restaurant-ranch-dressing-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Ranch Dressing Recipe (Small Batch, Easy & Ultra Creamy)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 tbsp. Buttermilk",
      "2 tbsp. Mayonnaise (best quality)",
      "2 tbsp. Sour Cream",
      "1 tsp. dried Minced Onion",
      "1 tsp. dried Parsley Flakes",
      "1/2 tsp. dried Chives",
      "1/4 tsp. Garlic Powder",
      "1/4 tsp. Onion Powder",
      "1/4 tsp. dried Dill",
      "1/4 tsp. Sea Salt",
      "1/4 tsp. freshly cracked Black Pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "tbsp", name: "Buttermilk" },
      { amount: 2.0, unit: "tbsp", name: "Mayonnaise" },
      { amount: 2.0, unit: "tbsp", name: "Sour Cream" },
      { amount: 1.0, unit: "tsp", name: "dried Minced Onion" },
      { amount: 1.0, unit: "tsp", name: "dried Parsley Flakes" },
      { amount: 0.5, unit: "tsp", name: "dried Chives" },
      { amount: 0.25, unit: "tsp", name: "Garlic Powder" },
      { amount: 0.25, unit: "tsp", name: "Onion Powder" },
      { amount: 0.25, unit: "tsp", name: "dried Dill" },
      { amount: 0.25, unit: "tsp", name: "Sea Salt" },
      { amount: 0.25, unit: "tsp", name: "freshly cracked Black Pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Whisk the 3 tbsp. buttermilk, 2 tbsp. mayonnaise, and 2 tbsp. sour cream together in a medium bowl.",
      "Stir in the dried herbs (1 tsp. dried minced onion, 1 tsp. dried parsley flakes, 1/2 tsp. dried chives, 1/4 tsp. each of onion powder, garlic powder, and dried dill).",
      "Stir in a pinch each of salt and pepper, taste, and add more of either if preferred. For a thinner dressing, stir in more buttermilk (1 tsp. at a time) until the dressing is the consistency you like.",
      "Cover and chill for an hour in the refrigerator for the best flavor, or serve immediately!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Whisk the 3 tbsp. buttermilk, 2 tbsp. mayonnaise, and 2 tbsp. sour cream together in a medium bowl.\nStir in the dried herbs (1 tsp. dried minced onion, 1 tsp. dried parsley flakes, 1/2 tsp. dried chives, 1/4 tsp. each of onion powder, garlic powder, and dried dill).\nStir in a pinch each of salt and pepper, taste, and add more of either if preferred. For a thinner dressing, stir in more buttermilk (1 tsp. at a time) until the dressing is the consistency you like.\nCover and chill for an hour in the refrigerator for the best flavor, or serve immediately!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("aflavorjournal.com")
    expect(recipe.canonical_url).to eq("https://aflavorjournal.com/small-batch-restaurant-ranch-dressing-recipe/")
    expect(recipe.site_name).to eq("A Flavor Journal")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Sara")
    expect(recipe.description).to eq("This ranch dressing recipe is creamy, tangy, and packed with fresh herbs. Inspired by restaurant-style ranch dressing, this homemade version is small batch, easy to make, and ready in just 5 minutes.")
    expect(recipe.image).to eq("https://aflavorjournal.com/wp-content/uploads/2022/06/Small-Batch-Ranch-Dressing-Featured.jpg")
    expect(recipe.category).to eq("Salad")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("5 servings")
    expect(recipe.total_time).to eq(5)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq([
      "homemade ranch dressing",
      "restaurant ranch dressing recipe",
      "restaurant style ranch"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.87)
    expect(recipe.ratings_count).to eq(526)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "64 kcal",
      "servingSize" => "1 tbsp.",
      "carbohydrateContent" => "2 g",
      "proteinContent" => "1 g",
      "fatContent" => "6 g",
      "saturatedFatContent" => "1 g",
      "transFatContent" => "0.01 g",
      "cholesterolContent" => "7 mg",
      "sodiumContent" => "150 mg",
      "fiberContent" => "0.5 g",
      "sugarContent" => "1 g",
      "unsaturatedFatContent" => "4 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 64.0 },
      { name: "servingSize", unit: "tbsp", amount: 1.0 },
      { name: "carbohydrateContent", unit: "g", amount: 2.0 },
      { name: "proteinContent", unit: "g", amount: 1.0 },
      { name: "fatContent", unit: "g", amount: 6.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "transFatContent", unit: "g", amount: 0.01 },
      { name: "cholesterolContent", unit: "mg", amount: 7.0 },
      { name: "sodiumContent", unit: "mg", amount: 150.0 },
      { name: "fiberContent", unit: "g", amount: 0.5 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 4.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
