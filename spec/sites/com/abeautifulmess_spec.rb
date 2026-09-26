# frozen_string_literal: true

RSpec.describe "abeautifulmess.com" do
  subject(:recipe) { scrape_cassette("com/abeautifulmess", url: "https://abeautifulmess.com/banana-ice-cream/") }

  it "reads the title" do
    expect(recipe.title).to eq("Banana Ice Cream")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 bananas (sliced )",
      "1 cup milk",
      "1 tablespoon agave syrup"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "bananas" },
      { amount: 1.0, unit: "cup", name: "milk" },
      { amount: 1.0, unit: "tablespoon", name: "agave syrup" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In your pint container, combine sliced banana, milk and agave. Stir to combine (it's OK for the banana to remain in chunks). Cover the pint and freeze for 24 hours.",
      "Use your Ninja Creami machine on “Ice Cream” setting.",
      "Remove the pint and take a look at your ice cream. If you think the texture is a bit chalky (or not as creamy as you want), make a hole in the center of the ice cream and add a tablespoon of water or milk. Then, use the “re-spin” function.",
      "We recommend adding sprinkles, chocolate chips or sliced bananas to the top. Enjoy your ice cream right away!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In your pint container, combine sliced banana, milk and agave. Stir to combine (it's OK for the banana to remain in chunks). Cover the pint and freeze for 24 hours.\nUse your Ninja Creami machine on “Ice Cream” setting.\nRemove the pint and take a look at your ice cream. If you think the texture is a bit chalky (or not as creamy as you want), make a hole in the center of the ice cream and add a tablespoon of water or milk. Then, use the “re-spin” function.\nWe recommend adding sprinkles, chocolate chips or sliced bananas to the top. Enjoy your ice cream right away!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("abeautifulmess.com")
    expect(recipe.canonical_url).to eq("https://abeautifulmess.com/banana-ice-cream/")
    expect(recipe.site_name).to eq("A Beautiful Mess")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Elsie Larson")
    expect(recipe.description).to eq("Learn to make fresh, healthy banana ice cream using only three ingredients: bananas, milk and sweetener (such as agave).")
    expect(recipe.image).to eq("https://abeautifulmess.com/wp-content/uploads/2024/07/Banana-Ice-Cream.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Banana Ice Cream", "Banana Ninja Creami Ice Cream"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(4)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "211 kcal",
      "carbohydrateContent" => "41 g",
      "proteinContent" => "5 g",
      "fatContent" => "4 g",
      "saturatedFatContent" => "2 g",
      "cholesterolContent" => "15 mg",
      "sodiumContent" => "48 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "27 g",
      "unsaturatedFatContent" => "1.2 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 211.0 },
      { name: "carbohydrateContent", unit: "g", amount: 41.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "fatContent", unit: "g", amount: 4.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "cholesterolContent", unit: "mg", amount: 15.0 },
      { name: "sodiumContent", unit: "mg", amount: 48.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 27.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 1.2 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
