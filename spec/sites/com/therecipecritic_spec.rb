# frozen_string_literal: true

RSpec.describe "therecipecritic.com" do
  subject(:recipe) { scrape_cassette("com/therecipecritic", url: "https://therecipecritic.com/burrata-appetizer/") }

  it "reads the title" do
    expect(recipe.title).to eq("Burrata Appetizer")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 tablespoons olive oil",
      "1 shallot, (minced)",
      "2 cloves garlic, (minced)",
      "2 teaspoons fresh thyme",
      "2 cups cherry tomatoes, (halved)",
      "½ cup dried figs, (quartered)",
      "½ teaspoon kosher salt",
      "½ teaspoon pepper",
      "¼ cup balsamic vinegar",
      "16 ounces burrata cheese",
      "fresh basil, (coarsely chopped)",
      "additional kosher salt, to taste",
      "1 baguette, (sliced and toasted for serving)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "tablespoons", name: "olive oil" },
      { amount: 1.0, unit: nil, name: "shallot" },
      { amount: 2.0, unit: "cloves", name: "garlic" },
      { amount: 2.0, unit: "teaspoons", name: "fresh thyme" },
      { amount: 2.0, unit: "cups", name: "cherry tomatoes" },
      { amount: 0.5, unit: "cup", name: "dried figs" },
      { amount: 0.5, unit: "teaspoon", name: "kosher salt" },
      { amount: 0.5, unit: "teaspoon", name: "pepper" },
      { amount: 0.25, unit: "cup", name: "balsamic vinegar" },
      { amount: 16.0, unit: "ounces", name: "burrata cheese" },
      { amount: nil, unit: nil, name: "fresh basil" },
      { amount: nil, unit: nil, name: "additional kosher salt, to taste" },
      { amount: 1.0, unit: nil, name: "baguette" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large skillet, heat the olive oil over medium-high heat.",
      "Add the shallot and saute for 4-5 minutes. Add the garlic and thyme, and saute for an additional minute.",
      "Add the tomatoes, figs, salt, and pepper. Cover and saute for about 10-12 minutes undisturbed.",
      "Remove the lid, add the balsamic vinegar, then stir. Reduce heat to medium and continue to saute until any excess liquid has cooked off, stirring occasionally.",
      "Remove the skillet from heat and let the tomatoes and figs rest for about 8-10 minutes to cool the skillet slightly.",
      "Place the burrata on top of the tomatoes and figs. Garnish with fresh basil and kosher salt.",
      "Serve with toasted baguette, sourdough, or your favorite dipping bread!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large skillet, heat the olive oil over medium-high heat.\nAdd the shallot and saute for 4-5 minutes. Add the garlic and thyme, and saute for an additional minute.\nAdd the tomatoes, figs, salt, and pepper. Cover and saute for about 10-12 minutes undisturbed.\nRemove the lid, add the balsamic vinegar, then stir. Reduce heat to medium and continue to saute until any excess liquid has cooked off, stirring occasionally.\nRemove the skillet from heat and let the tomatoes and figs rest for about 8-10 minutes to cool the skillet slightly.\nPlace the burrata on top of the tomatoes and figs. Garnish with fresh basil and kosher salt.\nServe with toasted baguette, sourdough, or your favorite dipping bread!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("therecipecritic.com")
    expect(recipe.canonical_url).to eq("https://therecipecritic.com/burrata-appetizer/")
    expect(recipe.site_name).to eq("The Recipe Critic")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Alyssa Rivers")
    expect(recipe.description).to eq("This burrata appetizer is a flavor bomb made with juicy cherry tomatoes, sweet dried figs, and a tangy balsamic kick. Topped with creamy burrata cheese, it's pure indulgence. Perfect for parties or whenever you want to treat yourself to something special!")
    expect(recipe.image).to eq("https://therecipecritic.com/wp-content/uploads/2023/07/burrata-appetizer.jpg")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("Italian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq(["burrata appetizer", "tomato and burrata appetizer"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "282 kcal",
      "carbohydrateContent" => "22 g",
      "proteinContent" => "13 g",
      "fatContent" => "19 g",
      "saturatedFatContent" => "9 g",
      "cholesterolContent" => "40 mg",
      "sodiumContent" => "345 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "6 g",
      "unsaturatedFatContent" => "4 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 282.0 },
      { name: "carbohydrateContent", unit: "g", amount: 22.0 },
      { name: "proteinContent", unit: "g", amount: 13.0 },
      { name: "fatContent", unit: "g", amount: 19.0 },
      { name: "saturatedFatContent", unit: "g", amount: 9.0 },
      { name: "cholesterolContent", unit: "mg", amount: 40.0 },
      { name: "sodiumContent", unit: "mg", amount: 345.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 6.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 4.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
