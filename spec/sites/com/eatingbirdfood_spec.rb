# frozen_string_literal: true

RSpec.describe "eatingbirdfood.com" do
  subject(:recipe) { scrape_cassette("com/eatingbirdfood", url: "https://www.eatingbirdfood.com/curried-shakshuka/") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy Shakshuka")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 Tablespoons olive oil",
      "1 large onion (chopped)",
      "1 orange bell pepper (chopped)",
      "4 cloves garlic (minced)",
      "½ teaspoon cumin",
      "½ teaspoon paprika",
      "¼ teaspoon cayenne pepper",
      "1-2 teaspoons curry powder",
      "¼ teaspoon turmeric",
      "½ teaspoon sea salt",
      "¼ teaspoon ground pepper",
      "28 ounce can diced tomatoes",
      "4-5 eggs",
      "½ cup feta cheese",
      "fresh cilantro and parsley (for serving)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "Tablespoons", name: "olive oil" },
      { amount: 1.0, unit: nil, name: "large onion" },
      { amount: 1.0, unit: nil, name: "orange bell pepper" },
      { amount: 4.0, unit: "cloves", name: "garlic" },
      { amount: 0.5, unit: "teaspoon", name: "cumin" },
      { amount: 0.5, unit: "teaspoon", name: "paprika" },
      { amount: 0.25, unit: "teaspoon", name: "cayenne pepper" },
      { amount: 1.0, unit: "teaspoons", name: "curry powder" },
      { amount: 0.25, unit: "teaspoon", name: "turmeric" },
      { amount: 0.5, unit: "teaspoon", name: "sea salt" },
      { amount: 0.25, unit: "teaspoon", name: "ground pepper" },
      { amount: 28.0, unit: "ounce", name: "can diced tomatoes" },
      { amount: 4.0, unit: nil, name: "eggs" },
      { amount: 0.5, unit: "cup", name: "feta cheese" },
      { amount: nil, unit: nil, name: "fresh cilantro and parsley" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Saute",
      "Heat oil in a large skillet over medium heat. Add onion, bell pepper and garlic to the skillet and cook until onions are soft and fragrant — about 5 to 10 minutes.",
      "Cook sauce",
      "Add cumin, paprika, cayenne, curry, turmeric, salt and pepper. Give the mixture a stir and cook for about 1 minute more. Add diced tomatoes to the skillet and bring sauce to a boil. Reduce heat to a simmer and cook until the sauce thickens up a bit, about 10 minutes. Add feta cheese to the tomato mixture and stir.",
      "Cook eggs",
      "Crack eggs into tomato sauce. You should be able to fit 4-5 eggs in a large skillet. Cover and let the eggs cook for about 5 minutes, or until the egg whites are completely cooked through. Remove skillet from heat, uncover and let sit for a 1-2 minutes before serving.",
      "Serve",
      "Spoon 1-2 eggs along with a big serving of tomato sauce on to each plate. Garnish with extra feta cheese and fresh cilantro and parsley. Serve with toast, veggies or over a whole grain like quinoa or brown rice for a complete meal."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Saute\nHeat oil in a large skillet over medium heat. Add onion, bell pepper and garlic to the skillet and cook until onions are soft and fragrant — about 5 to 10 minutes.\nCook sauce\nAdd cumin, paprika, cayenne, curry, turmeric, salt and pepper. Give the mixture a stir and cook for about 1 minute more. Add diced tomatoes to the skillet and bring sauce to a boil. Reduce heat to a simmer and cook until the sauce thickens up a bit, about 10 minutes. Add feta cheese to the tomato mixture and stir.\nCook eggs\nCrack eggs into tomato sauce. You should be able to fit 4-5 eggs in a large skillet. Cover and let the eggs cook for about 5 minutes, or until the egg whites are completely cooked through. Remove skillet from heat, uncover and let sit for a 1-2 minutes before serving.\nServe\nSpoon 1-2 eggs along with a big serving of tomato sauce on to each plate. Garnish with extra feta cheese and fresh cilantro and parsley. Serve with toast, veggies or over a whole grain like quinoa or brown rice for a complete meal.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("eatingbirdfood.com")
    expect(recipe.canonical_url).to eq("https://www.eatingbirdfood.com/curried-shakshuka/")
    expect(recipe.site_name).to eq("Eating Bird Food")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Brittany Mullins")
    expect(recipe.description).to eq("This easy shakshuka recipe features poached eggs in a flavorful tomato sauce. It comes together quickly and can be served any time of the day!")
    expect(recipe.image).to eq("https://www.eatingbirdfood.com/wp-content/uploads/2024/08/shakshuka-hero-new.jpg")
    expect(recipe.category).to eq("Lunch/Dinner")
    expect(recipe.cuisine).to eq("Middle Eastern")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["shakshuka"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["GlutenFreeDiet"])
    expect(recipe.ratings).to eq(4.47)
    expect(recipe.ratings_count).to eq(60)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 /4 of recipe",
      "calories" => "284 kcal",
      "sugarContent" => "8 g",
      "sodiumContent" => "620 mg",
      "fatContent" => "18 g",
      "saturatedFatContent" => "6 g",
      "carbohydrateContent" => "17 g",
      "fiberContent" => "3 g",
      "proteinContent" => "14 g",
      "cholesterolContent" => "224 mg",
      "unsaturatedFatContent" => "6 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: nil, amount: 0.25 },
      { name: "calories", unit: "kcal", amount: 284.0 },
      { name: "sugarContent", unit: "g", amount: 8.0 },
      { name: "sodiumContent", unit: "mg", amount: 620.0 },
      { name: "fatContent", unit: "g", amount: 18.0 },
      { name: "saturatedFatContent", unit: "g", amount: 6.0 },
      { name: "carbohydrateContent", unit: "g", amount: 17.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "proteinContent", unit: "g", amount: 14.0 },
      { name: "cholesterolContent", unit: "mg", amount: 224.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 6.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
