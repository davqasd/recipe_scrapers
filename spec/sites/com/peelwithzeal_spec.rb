# frozen_string_literal: true

RSpec.describe "peelwithzeal.com" do
  subject(:recipe) { scrape_cassette("com/peelwithzeal", url: "https://www.peelwithzeal.com/molasses-baked-beans/") }

  it "reads the title" do
    expect(recipe.title).to eq("Molasses Baked Beans with Bacon")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 pound bacon (chopped into 1/2 inch pieces)",
      "1 large sweet onion (finely chopped)",
      "1 clove garlic (minced)",
      "2 14-ounce cans pinto beans (drain 1 can only)",
      "2 14-ounce cans navy beans (drain 1 can only)",
      "1 cup beef stock",
      "½ cup molasses (not blackstrap)",
      "½ cup ketchup",
      "¼ cup brown sugar",
      "2 Tablespoons brown mustard",
      "2 Tablespoons apple cider vinegar",
      "1 Tablespoon paprika"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "pound", name: "bacon" },
      { amount: 1.0, unit: nil, name: "large sweet onion" },
      { amount: 1.0, unit: "clove", name: "garlic" },
      { amount: 2.0, unit: "cans", name: "pinto beans" },
      { amount: 2.0, unit: "cans", name: "navy beans" },
      { amount: 1.0, unit: "cup", name: "beef stock" },
      { amount: 0.5, unit: "cup", name: "molasses" },
      { amount: 0.5, unit: "cup", name: "ketchup" },
      { amount: 0.25, unit: "cup", name: "brown sugar" },
      { amount: 2.0, unit: "Tablespoons", name: "brown mustard" },
      { amount: 2.0, unit: "Tablespoons", name: "apple cider vinegar" },
      { amount: 1.0, unit: "Tablespoon", name: "paprika" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 350 degrees F.",
      "Fry the bacon in a large skillet over medium-high heat until crisp. Remove the bacon from the pan and drain it on paper towels. Do not drain the pan.",
      "Saute",
      "Add the onion to the pan with the bacon drippings and saute for 5 minutes. Add the garlic and stir for 30 seconds.",
      "Mix",
      "Stir in the beans, beef stock, molasses, ketchup, brown sugar, mustard, paprika, and cooked bacon, and mix well.",
      "Bake",
      "Pour into a large casserole and bake covered for about 20 minutes. Remove the lid and cook for an additional 25 minutes."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 350 degrees F.\nFry the bacon in a large skillet over medium-high heat until crisp. Remove the bacon from the pan and drain it on paper towels. Do not drain the pan.\nSaute\nAdd the onion to the pan with the bacon drippings and saute for 5 minutes. Add the garlic and stir for 30 seconds.\nMix\nStir in the beans, beef stock, molasses, ketchup, brown sugar, mustard, paprika, and cooked bacon, and mix well.\nBake\nPour into a large casserole and bake covered for about 20 minutes. Remove the lid and cook for an additional 25 minutes.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("peelwithzeal.com")
    expect(recipe.canonical_url).to eq("https://www.peelwithzeal.com/molasses-baked-beans/")
    expect(recipe.site_name).to eq("Peel with Zeal")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jen Wooster")
    expect(recipe.description).to eq("Sweet and smokey baked beans with molasses and bacon are your new favorite BBQ side dish. Not overly sweet with the perfect amount of tang. My old fashioned baked beans recipe is perfect for potlucks, summer cookouts and BBQs.")
    expect(recipe.image).to eq("https://www.peelwithzeal.com/wp-content/uploads/2022/06/molasses-baked-beans.jpg")
    expect(recipe.category).to eq("Side Dish")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(65)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(45)
    expect(recipe.keywords).to eq([
      "baked beans using canned beans",
      "baked beans with molasses",
      "gluten-free baked beans"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["GlutenFreeDiet"])
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(13)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "233 kcal",
      "carbohydrateContent" => "19 g",
      "proteinContent" => "5 g",
      "fatContent" => "15 g",
      "fiberContent" => "1 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 233.0 },
      { name: "carbohydrateContent", unit: "g", amount: 19.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "fatContent", unit: "g", amount: 15.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.peelwithzeal.com/")
  end
end
