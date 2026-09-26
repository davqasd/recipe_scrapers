# frozen_string_literal: true

RSpec.describe "howtocook.recipes" do
  subject(:recipe) { scrape_cassette("recipes/howtocook", url: "https://www.howtocook.recipes/homemade-hot-chocolate-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("The BEST Homemade Hot Chocolate Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups whole milk",
      "2 cups half and half",
      "1/4 cup Ghiradelli unsweetened cocoa powder",
      "1/3 cup granulated sugar",
      "1/2 cup bittersweet chocolate chips",
      "1 tsp vanilla extract"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "whole milk" },
      { amount: 2.0, unit: "cups", name: "half and half" },
      { amount: 0.25, unit: "cup", name: "Ghiradelli unsweetened cocoa powder" },
      { amount: 0.33, unit: "cup", name: "granulated sugar" },
      { amount: 0.5, unit: "cup", name: "bittersweet chocolate chips" },
      { amount: 1.0, unit: "tsp", name: "vanilla extract" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a medium saucepan on medium heat, add in the milk, cocoa powder, and sugar. Whisk the mixture frequently until warm. Once warm, add in the chocolate chips and whisk until they are fully melted. Whisk in the vanilla extract, serve immediately with optional toppings such as: whipped cream, chocolate sauce, peppermint pieces, sprinkles, mini marshmallows, or chopped chocolate bar."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a medium saucepan on medium heat, add in the milk, cocoa powder, and sugar. Whisk the mixture frequently until warm. Once warm, add in the chocolate chips and whisk until they are fully melted. Whisk in the vanilla extract, serve immediately with optional toppings such as: whipped cream, chocolate sauce, peppermint pieces, sprinkles, mini marshmallows, or chopped chocolate bar.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("howtocook.recipes")
    expect(recipe.canonical_url).to eq("https://www.howtocook.recipes/homemade-hot-chocolate-recipe/")
    expect(recipe.site_name).to eq("How To Cook.Recipes")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Megan Miller")
    expect(recipe.description).to eq("Hands down the BEST homemade hot chocolate recipe! This easy recipe takes only 5 simple ingredients and comes out rich and creamy every time!")
    expect(recipe.image).to eq("https://www.howtocook.recipes/wp-content/uploads/2021/10/Hot-chocolate-recipe.webp")
    expect(recipe.category).to eq("Drinks")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(12)
    expect(recipe.prep_time).to eq(7)
    expect(recipe.cook_time).to eq(5)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "433 kcal",
      "carbohydrateContent" => "44 g",
      "proteinContent" => "10 g",
      "fatContent" => "26 g",
      "saturatedFatContent" => "18 g",
      "cholesterolContent" => "57 mg",
      "sodiumContent" => "128 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "31 g",
      "unsaturatedFatContent" => "6 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 433.0 },
      { name: "carbohydrateContent", unit: "g", amount: 44.0 },
      { name: "proteinContent", unit: "g", amount: 10.0 },
      { name: "fatContent", unit: "g", amount: 26.0 },
      { name: "saturatedFatContent", unit: "g", amount: 18.0 },
      { name: "cholesterolContent", unit: "mg", amount: 57.0 },
      { name: "sodiumContent", unit: "mg", amount: 128.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 31.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 6.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
