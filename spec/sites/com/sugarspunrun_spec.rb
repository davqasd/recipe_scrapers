# frozen_string_literal: true

RSpec.describe "sugarspunrun.com" do
  subject(:recipe) { scrape_cassette("com/sugarspunrun", url: "https://sugarspunrun.com/hot-cocoa-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Hot Cocoa")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 Tablespoons light brown sugar (firmly packed)",
      "1 Tablespoon natural cocoa powder",
      "Pinch of table salt (about 1/16th teaspoon)",
      "¾ cup milk (divided)",
      "¼ cup heavy cream (may substitute with more milk)",
      "¼ teaspoon vanilla extract"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "Tablespoons", name: "light brown sugar" },
      { amount: 1.0, unit: "Tablespoon", name: "natural cocoa powder" },
      { amount: 1.0, unit: "Pinch", name: "table salt" },
      { amount: 0.75, unit: "cup", name: "milk" },
      { amount: 0.25, unit: "cup", name: "heavy cream" },
      { amount: 0.25, unit: "teaspoon", name: "vanilla extract" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a small saucepan, combine brown sugar, cocoa powder, and salt and whisk together.",
      "Add approximately 2-3 Tablespoons of your milk and whisk until smooth.",
      "Place saucepan over low heat and whisk until sugar begins to melt and mixture darkens in color.",
      "Add the remaining milk and the heavy cream and whisk until mixture is steaming.",
      "Remove from heat and add vanilla extract. Stir well then pour into heatproof mug. Enjoy warm, this cocoa is excellent enjoyed plain/as-is or topped with whipped cream, marshmallows, chocolate shavings, etc.!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a small saucepan, combine brown sugar, cocoa powder, and salt and whisk together.\nAdd approximately 2-3 Tablespoons of your milk and whisk until smooth.\nPlace saucepan over low heat and whisk until sugar begins to melt and mixture darkens in color.\nAdd the remaining milk and the heavy cream and whisk until mixture is steaming.\nRemove from heat and add vanilla extract. Stir well then pour into heatproof mug. Enjoy warm, this cocoa is excellent enjoyed plain/as-is or topped with whipped cream, marshmallows, chocolate shavings, etc.!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("sugarspunrun.com")
    expect(recipe.canonical_url).to eq("https://sugarspunrun.com/hot-cocoa-recipe/")
    expect(recipe.site_name).to eq("Sugar Spun Run")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Sam Merritt")
    expect(recipe.description).to eq("Skip the store-bought packets and make this 5-minute hot cocoa recipe! It tastes SO much better and uses just 6 pantry staples. Perfect for a snow day! Recipe includes a how-to video!")
    expect(recipe.image).to eq("https://sugarspunrun.com/wp-content/uploads/2024/01/Hot-cocoa-recipe-1-of-1-2.jpg")
    expect(recipe.category).to eq("Drinks")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("1 servings")
    expect(recipe.total_time).to eq(5)
    expect(recipe.prep_time).to eq(2)
    expect(recipe.cook_time).to eq(3)
    expect(recipe.keywords).to eq(["hot cocoa recipe"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(23)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 cup",
      "calories" => "418 kcal",
      "carbohydrateContent" => "37 g",
      "proteinContent" => "9 g",
      "fatContent" => "28 g",
      "saturatedFatContent" => "17 g",
      "cholesterolContent" => "89 mg",
      "sodiumContent" => "93 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "34 g",
      "unsaturatedFatContent" => "8 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "cup", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 418.0 },
      { name: "carbohydrateContent", unit: "g", amount: 37.0 },
      { name: "proteinContent", unit: "g", amount: 9.0 },
      { name: "fatContent", unit: "g", amount: 28.0 },
      { name: "saturatedFatContent", unit: "g", amount: 17.0 },
      { name: "cholesterolContent", unit: "mg", amount: 89.0 },
      { name: "sodiumContent", unit: "mg", amount: 93.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 34.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 8.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
