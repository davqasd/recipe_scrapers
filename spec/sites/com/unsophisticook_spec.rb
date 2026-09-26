# frozen_string_literal: true

RSpec.describe "unsophisticook.com" do
  subject(:recipe) { scrape_cassette("com/unsophisticook", url: "https://unsophisticook.com/grilled-cheese-in-the-oven/") }

  it "reads the title" do
    expect(recipe.title).to eq("Grilled Cheese In The Oven")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "12 pieces sliced sandwich bread",
      "6 pieces sliced American cheese (double as desired)",
      "8 tablespoons salted butter (softened)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 12.0, unit: "pieces", name: "sliced sandwich bread" },
      { amount: 6.0, unit: "pieces", name: "sliced American cheese" },
      { amount: 8.0, unit: "tablespoons", name: "salted butter" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Adjust oven rack to middle position and heat oven to 450℉.",
      "Butter one side of 6 slices of bread and place each butter-side down on a sheet pan. Layer 1-2 slices of cheese on each slice of bread. Spread butter on 6 remaining slices of bread and place them buttered-side up on top of the cheese.",
      "Bake for 5-6 minutes. Flip the sandwiches over and bake for an additional 5-6 minutes, until golden brown. Baking time may vary slightly depending on whether white or wheat bread is used."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Adjust oven rack to middle position and heat oven to 450℉.\nButter one side of 6 slices of bread and place each butter-side down on a sheet pan. Layer 1-2 slices of cheese on each slice of bread. Spread butter on 6 remaining slices of bread and place them buttered-side up on top of the cheese.\nBake for 5-6 minutes. Flip the sandwiches over and bake for an additional 5-6 minutes, until golden brown. Baking time may vary slightly depending on whether white or wheat bread is used.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("unsophisticook.com")
    expect(recipe.canonical_url).to eq("https://unsophisticook.com/grilled-cheese-in-the-oven/")
    expect(recipe.site_name).to eq("Unsophisticook")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Tara Kuczykowski")
    expect(recipe.description).to eq("This simple grilled cheese in the oven method makes six classic grilled cheese sandwiches per half sheet pan! BAKED grilled cheese? YES — hot and fresh, in just about 10 minutes... SO EASY!!!")
    expect(recipe.image).to eq("https://unsophisticook.com/wp-content/uploads/2016/10/Grilled-Cheese-In-The-Oven-1.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq([
      "baked",
      "cheesy",
      "classic",
      "comfort food",
      "easy",
      "grilled",
      "homemade",
      "kid-friendly",
      "oven-baked",
      "party food",
      "quick",
      "sandwich",
      "simple",
      "versatile"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.53)
    expect(recipe.ratings_count).to eq(409)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 sandwich",
      "calories" => "396 kcal",
      "carbohydrateContent" => "28 g",
      "proteinContent" => "13.6 g",
      "fatContent" => "26.3 g",
      "saturatedFatContent" => "15.7 g",
      "cholesterolContent" => "71.3 mg",
      "sodiumContent" => "519.1 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "4 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "sandwich", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 396.0 },
      { name: "carbohydrateContent", unit: "g", amount: 28.0 },
      { name: "proteinContent", unit: "g", amount: 13.6 },
      { name: "fatContent", unit: "g", amount: 26.3 },
      { name: "saturatedFatContent", unit: "g", amount: 15.7 },
      { name: "cholesterolContent", unit: "mg", amount: 71.3 },
      { name: "sodiumContent", unit: "mg", amount: 519.1 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 4.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://unsophisticook.com/")
  end
end
