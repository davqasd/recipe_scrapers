# frozen_string_literal: true

RSpec.describe "thepioneerwoman.com" do
  subject(:recipe) { scrape_cassette("com/thepioneerwoman", url: "https://www.thepioneerwoman.com/food-cooking/recipes/a10720/patty-melts/") }

  it "reads the title" do
    expect(recipe.title).to eq("Patty Melts")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 stick butter",
      "1 whole large onion, halved and sliced",
      "1 1/2 lb. ground beef",
      "salt and pepper, to taste",
      "5 dashes Worcestershire sauce",
      "8 slices Swiss cheese",
      "8 slices rye bread"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "stick", name: "butter" },
      { amount: 1.0, unit: nil, name: "whole large onion, halved and sliced" },
      { amount: 1.5, unit: "lb", name: "ground beef" },
      { amount: nil, unit: nil, name: "salt and pepper, to taste" },
      { amount: 5.0, unit: "dashes", name: "Worcestershire sauce" },
      { amount: 8.0, unit: "slices", name: "Swiss cheese" },
      { amount: 8.0, unit: "slices", name: "rye bread" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a medium skillet, melt 2 tablespoons of butter over medium-low heat. Throw in the sliced onions and cook slowly for 20 to 25 minutes, stirring occasionally, until the onions are golden brown and soft.",
      "In a medium bowl, mix together the ground beef, salt & pepper, and Worcestershire. Form into 4 patties.",
      "Melt 2 tablespoons butter in a separate skillet over medium heat. Cook the patties on both sides until totally done in the middle.",
      "Assemble patty melts this way: Slice of bread, slice of cheese, hamburger patty, 1/4 of the cooked onions, another slice of cheese, and another slice of bread. On a clean griddle or in a skillet, melt 2 tablespoons butter and grill the sandwiches over medium heat until golden brown. Remove the sandwiches and add the remaining 2 tablespoons of butter to the skillet. Turn the sandwiches to the skillet, flipping them to the other side. Cook until golden brown and crisp, and until cheese is melted.",
      "Slice in half and serve immediately!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a medium skillet, melt 2 tablespoons of butter over medium-low heat. Throw in the sliced onions and cook slowly for 20 to 25 minutes, stirring occasionally, until the onions are golden brown and soft.\nIn a medium bowl, mix together the ground beef, salt & pepper, and Worcestershire. Form into 4 patties.\nMelt 2 tablespoons butter in a separate skillet over medium heat. Cook the patties on both sides until totally done in the middle.\nAssemble patty melts this way: Slice of bread, slice of cheese, hamburger patty, 1/4 of the cooked onions, another slice of cheese, and another slice of bread. On a clean griddle or in a skillet, melt 2 tablespoons butter and grill the sandwiches over medium heat until golden brown. Remove the sandwiches and add the remaining 2 tablespoons of butter to the skillet. Turn the sandwiches to the skillet, flipping them to the other side. Cook until golden brown and crisp, and until cheese is melted.\nSlice in half and serve immediately!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thepioneerwoman.com")
    expect(recipe.canonical_url).to eq("https://www.thepioneerwoman.com/food-cooking/recipes/a10720/patty-melts/")
    expect(recipe.site_name).to eq("The Pioneer Woman")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Ree Drummond")
    expect(recipe.description).to eq("Make the ultimate patty melt with ground beef, Swiss cheese, caramelized onions, and rye bread. This easy recipe by Ree Drummond is pure comfort food.")
    expect(recipe.image).to eq("https://hips.hearstapps.com/hmg-prod/images/patty-melt-1597698088.jpg?crop=0.508xw:0.450xh;0.229xw,0.200xh&resize=1200:*")
    expect(recipe.category).to eq("Father's Day")
    expect(recipe.cuisine).to eq("Sandwich Cuisine")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to eq(%w[Recipes Cooking Food])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(7)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "910 Calories",
      "fatContent" => "75 g",
      "saturatedFatContent" => "37 g",
      "transFatContent" => "3 g",
      "cholesterolContent" => "234 mg",
      "sodiumContent" => "719 mg",
      "carbohydrateContent" => "10 g",
      "fiberContent" => "2 g",
      "sugarContent" => "2 g",
      "proteinContent" => "46 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 910.0 },
      { name: "fatContent", unit: "g", amount: 75.0 },
      { name: "saturatedFatContent", unit: "g", amount: 37.0 },
      { name: "transFatContent", unit: "g", amount: 3.0 },
      { name: "cholesterolContent", unit: "mg", amount: 234.0 },
      { name: "sodiumContent", unit: "mg", amount: 719.0 },
      { name: "carbohydrateContent", unit: "g", amount: 10.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "proteinContent", unit: "g", amount: 46.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/ree-drummond-life/")
  end
end
