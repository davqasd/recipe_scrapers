# frozen_string_literal: true

RSpec.describe "stacyling.com" do
  subject(:recipe) { scrape_cassette("com/stacyling", url: "https://stacyling.com/irish-cheddar-and-beer-fondue-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Irish Cheddar and Beer Fondue Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups Small Red Potatoes (about 1-1.5 inches)",
      "2 cups Broccoli Florets",
      "2 cups Cauliflower Florets",
      "3 Apples (Cored and Cut Into Wedges)",
      "1 loaf Italian bread (long and skinny with hard exterior)",
      "1 lb Irish Cheddar Cheese (Grated)",
      "2.5 tbsp All Purpose Flour",
      "3/4 - 1 cup Beer (Irish Stout is best)",
      "6 tbsp Frozen Apple Juice Concentrate (Thawed)",
      "1 tbsp Dijon Mustard"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "Small Red Potatoes" },
      { amount: 2.0, unit: "cups", name: "Broccoli Florets" },
      { amount: 2.0, unit: "cups", name: "Cauliflower Florets" },
      { amount: 3.0, unit: nil, name: "Apples" },
      { amount: 1.0, unit: "loaf", name: "Italian bread" },
      { amount: 1.0, unit: "lb", name: "Irish Cheddar Cheese" },
      { amount: 2.5, unit: "tbsp", name: "All Purpose Flour" },
      { amount: 0.75, unit: "cup", name: "Beer" },
      { amount: 6.0, unit: "tbsp", name: "Frozen Apple Juice Concentrate" },
      { amount: 1.0, unit: "tbsp", name: "Dijon Mustard" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Steam all veggies until tender for about 15 minutes.",
      "Arrange vegetables and apples around edge of large platter.",
      "Cut up bread into 1 - 1/5\" pieces so it's easy to dip in the fondue.",
      "Toss cheese with flour in large bowl.",
      "Bring 3/4 cup beer, juice concentrate and mustard to simmer in large saucepan over medium heat.",
      "Gradually add cheese.",
      "Stir constantly until cheese is smooth and melted. Add more stout to thin out if needed.",
      "Season to taste with salt and pepper.",
      "Transfer to fondue pot. Serve and enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Steam all veggies until tender for about 15 minutes.\nArrange vegetables and apples around edge of large platter.\nCut up bread into 1 - 1/5\" pieces so it's easy to dip in the fondue.\nToss cheese with flour in large bowl.\nBring 3/4 cup beer, juice concentrate and mustard to simmer in large saucepan over medium heat.\nGradually add cheese.\nStir constantly until cheese is smooth and melted. Add more stout to thin out if needed.\nSeason to taste with salt and pepper.\nTransfer to fondue pot. Serve and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("stacyling.com")
    expect(recipe.canonical_url).to eq("https://stacyling.com/irish-cheddar-and-beer-fondue-recipe/")
    expect(recipe.site_name).to eq("Bricks ’n Blooms with Stacy Ling")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Stacy Ling")
    expect(recipe.description).to eq("The Best Fondue Recipe You'll Ever Have")
    expect(recipe.image).to eq("https://stacyling.com/wp-content/uploads/2021/02/Irish-Cheddar-2-scaled.jpg")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("Irish")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(60)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["Fondue Recipe", "Irish Cheddar"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 grams",
      "calories" => "412 kcal",
      "carbohydrateContent" => "47 g",
      "proteinContent" => "17 g",
      "fatContent" => "17 g",
      "saturatedFatContent" => "9 g",
      "cholesterolContent" => "45 mg",
      "sodiumContent" => "610 mg",
      "fiberContent" => "5 g",
      "sugarContent" => "10 g",
      "unsaturatedFatContent" => "6 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "g", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 412.0 },
      { name: "carbohydrateContent", unit: "g", amount: 47.0 },
      { name: "proteinContent", unit: "g", amount: 17.0 },
      { name: "fatContent", unit: "g", amount: 17.0 },
      { name: "saturatedFatContent", unit: "g", amount: 9.0 },
      { name: "cholesterolContent", unit: "mg", amount: 45.0 },
      { name: "sodiumContent", unit: "mg", amount: 610.0 },
      { name: "fiberContent", unit: "g", amount: 5.0 },
      { name: "sugarContent", unit: "g", amount: 10.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 6.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
