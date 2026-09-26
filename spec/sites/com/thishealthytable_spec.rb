# frozen_string_literal: true

RSpec.describe "thishealthytable.com" do
  subject(:recipe) { scrape_cassette("com/thishealthytable", url: "https://thishealthytable.com/blog/swordfish-side-dishes/") }

  it "reads the title" do
    expect(recipe.title).to eq("Side Dishes for Swordfish")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 tablespoon olive oil",
      "1 tablespoon butter",
      "3 medium yellow squash, cut into 1/2 inch pieces",
      "3 cloves garlic, minced",
      "5 sprigs fresh thyme, finely chopped",
      "10 fresh basil leaves, finely chopped",
      "1 tablespoon freshly squeezed lemon juice",
      "1/2 teaspoon sea salt",
      "1/4 teaspoon ground black pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "tablespoon", name: "olive oil" },
      { amount: 1.0, unit: "tablespoon", name: "butter" },
      { amount: 3.0, unit: nil, name: "medium yellow squash, cut into 1/2 inch pieces" },
      { amount: 3.0, unit: "cloves", name: "garlic, minced" },
      { amount: 5.0, unit: "sprigs", name: "fresh thyme, finely chopped" },
      { amount: 10.0, unit: nil, name: "fresh basil leaves, finely chopped" },
      { amount: 1.0, unit: "tablespoon", name: "freshly squeezed lemon juice" },
      { amount: 0.5, unit: "teaspoon", name: "sea salt" },
      { amount: 0.25, unit: "teaspoon", name: "ground black pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Heat a large skillet over medium-high heat. Add the olive oil and butter.",
      "Once the oil is hot and the butter is bubbling, add the yellow squash. Stir the squash to coat them in the butter and oil. Sauté for 5 minutes. Stir again and flip the squash over and cook for 4 more minutes.",
      "Add the garlic and thyme to the pan. Stir to combine and cook for an additional 2 minutes.",
      "Remove the squash from the heat and add the chopped basil, lemon juice, salt, and pepper. Stir and serve immediately."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Heat a large skillet over medium-high heat. Add the olive oil and butter.\nOnce the oil is hot and the butter is bubbling, add the yellow squash. Stir the squash to coat them in the butter and oil. Sauté for 5 minutes. Stir again and flip the squash over and cook for 4 more minutes.\nAdd the garlic and thyme to the pan. Stir to combine and cook for an additional 2 minutes.\nRemove the squash from the heat and add the chopped basil, lemon juice, salt, and pepper. Stir and serve immediately.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thishealthytable.com")
    expect(recipe.canonical_url).to eq("https://thishealthytable.com/blog/swordfish-side-dishes/")
    expect(recipe.site_name).to eq("This Healthy Table")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("This Healthy Table")
    expect(recipe.description).to eq("Try one of our favorite sides for swordfish - this easy sauteed yellow squash recipe is the best! It comes together quickly and has great flavor.")
    expect(recipe.image).to eq("https://thishealthytable.com/wp-content/uploads/2022/03/sauteed-summer-squash-720x720.jpg")
    expect(recipe.category).to eq("Roundup")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(16)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(11)
    expect(recipe.keywords).to eq([
      "sides for swordfish",
      "swordfish side dishes",
      "what to serve with swordfish",
      "swordfish sides"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(3)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "112 calories",
      "carbohydrateContent" => "12 grams carbohydrates",
      "cholesterolContent" => "8 milligrams cholesterol",
      "fatContent" => "7 grams fat",
      "fiberContent" => "4 grams fiber",
      "proteinContent" => "3 grams protein",
      "saturatedFatContent" => "2 grams saturated fat",
      "servingSize" => "1",
      "sodiumContent" => "291 milligrams sodium",
      "sugarContent" => "7 grams sugar",
      "transFatContent" => "0 grams trans fat",
      "unsaturatedFatContent" => "4 grams unsaturated fat"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 112.0 },
      { name: "carbohydrateContent", unit: "g", amount: 12.0 },
      { name: "cholesterolContent", unit: "mg", amount: 8.0 },
      { name: "fatContent", unit: "g", amount: 7.0 },
      { name: "fiberContent", unit: "g", amount: 4.0 },
      { name: "proteinContent", unit: "g", amount: 3.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "servingSize", unit: nil, amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 291.0 },
      { name: "sugarContent", unit: "g", amount: 7.0 },
      { name: "transFatContent", unit: "g", amount: 0.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 4.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://thishealthytable.com/")
  end
end
