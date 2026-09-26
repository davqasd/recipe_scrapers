# frozen_string_literal: true

RSpec.describe "foodbymaria.com" do
  subject(:recipe) { scrape_cassette("com/foodbymaria", url: "https://www.foodbymaria.com/stuffed-dates/") }

  it "reads the title" do
    expect(recipe.title).to eq("Stuffed Dates")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "18 pitted Medjool dates",
      "18 thin slices of prosciutto",
      "5 sheets defrosted phyllo dough",
      "125 g brie cheese, cut into 18 small pieces",
      "1/2-3/4 cup melted butter",
      "honey for garnish"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 18.0, unit: nil, name: "pitted Medjool dates" },
      { amount: 18.0, unit: nil, name: "thin slices of prosciutto" },
      { amount: 5.0, unit: "sheets", name: "defrosted phyllo dough" },
      { amount: 125.0, unit: "g", name: "brie cheese, cut into 18 small pieces" },
      { amount: 0.5, unit: "cup", name: "melted butter" },
      { amount: nil, unit: nil, name: "honey for garnish" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 375F and line a baking sheet with parchment paper.",
      "Use a knife to cut the date lengthwise and remove the pit. Repeat for all dates (try not to cut through the whole date).",
      "Stuff each pitted date with a piece of brie and add a pinch of chili flakes to each date. Close the date, making sure the brie is tucked into the date and you can’t see the cheese.",
      "Place 1 sheet of phyllo dough onto a clean surface and gently brush the entire sheet with a little melted butter.",
      "Using a small sharp knife or pizza cutter, on the long end of the phyllo dough, divide the dough into 4 long equal strips.",
      "On each strip lay a piece of prosciutto. Then, at the end of each strip add one brie-stuffed date.",
      "Roll the phyllo up over the filling, folding the sides in to seal. Continue to roll to use the entire strip of phyllo dough and roll it up like a small cylinder. Set onto a baking tray seam-side down.",
      "Repeat to make 18 stuffed date phyllo rolls, placing on the baking sheet spaced apart evenly.",
      "Generously brush the tops of each roll with the melted butter.",
      "Bake for 18-24 minutes or until golden brown and crisp.",
      "Serve drizzled with honey."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 375F and line a baking sheet with parchment paper.\nUse a knife to cut the date lengthwise and remove the pit. Repeat for all dates (try not to cut through the whole date).\nStuff each pitted date with a piece of brie and add a pinch of chili flakes to each date. Close the date, making sure the brie is tucked into the date and you can’t see the cheese.\nPlace 1 sheet of phyllo dough onto a clean surface and gently brush the entire sheet with a little melted butter.\nUsing a small sharp knife or pizza cutter, on the long end of the phyllo dough, divide the dough into 4 long equal strips.\nOn each strip lay a piece of prosciutto. Then, at the end of each strip add one brie-stuffed date.\nRoll the phyllo up over the filling, folding the sides in to seal. Continue to roll to use the entire strip of phyllo dough and roll it up like a small cylinder. Set onto a baking tray seam-side down.\nRepeat to make 18 stuffed date phyllo rolls, placing on the baking sheet spaced apart evenly.\nGenerously brush the tops of each roll with the melted butter.\nBake for 18-24 minutes or until golden brown and crisp.\nServe drizzled with honey.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("foodbymaria.com")
    expect(recipe.canonical_url).to eq("https://www.foodbymaria.com/stuffed-dates/")
    expect(recipe.site_name).to eq("Food By Maria")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Maria Koutsogiannis")
    expect(recipe.description).to eq("These Stuffed Dates are stuffed with creamy brie and wrapped with salty prosiutto and crunchy phyllo for the perfect flavor bomb.")
    expect(recipe.image).to eq("https://www.foodbymaria.com/wp-content/uploads/2024/12/Stuffed-Dates-4.jpg")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("American-Inspired")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("18 servings")
    expect(recipe.total_time).to eq(39)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(24)
    expect(recipe.keywords).to eq(["phyllo"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "220 kcal",
      "fatContent" => "9.8 g",
      "saturatedFatContent" => "5.3 g",
      "cholesterolContent" => "46.2 mg",
      "sodiumContent" => "793.4 mg",
      "carbohydrateContent" => "20.8 g",
      "proteinContent" => "13.5 g",
      "sugarContent" => "16 g",
      "fiberContent" => "1.7 g",
      "unsaturatedFatContent" => "0.6 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 220.0 },
      { name: "fatContent", unit: "g", amount: 9.8 },
      { name: "saturatedFatContent", unit: "g", amount: 5.3 },
      { name: "cholesterolContent", unit: "mg", amount: 46.2 },
      { name: "sodiumContent", unit: "mg", amount: 793.4 },
      { name: "carbohydrateContent", unit: "g", amount: 20.8 },
      { name: "proteinContent", unit: "g", amount: 13.5 },
      { name: "sugarContent", unit: "g", amount: 16.0 },
      { name: "fiberContent", unit: "g", amount: 1.7 },
      { name: "unsaturatedFatContent", unit: "g", amount: 0.6 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
