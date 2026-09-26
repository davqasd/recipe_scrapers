# frozen_string_literal: true

RSpec.describe "smalltownwoman.com" do
  subject(:recipe) { scrape_cassette("com/smalltownwoman", url: "https://www.smalltownwoman.com/deviled-egg-pasta-salad/") }

  it "reads the title" do
    expect(recipe.title).to eq("Deviled Egg Pasta Salad")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "8 ounces elbow macaroni",
      "6 large hard-boiled eggs",
      "¾ cup mayonnaise",
      "1½ tablespoons Dijon mustard",
      "2 teaspoons apple cider vinegar",
      "½ teaspoon kosher salt",
      "¼ teaspoon freshly ground black pepper",
      "½ cup chopped celery",
      "¼ cup chopped red onion",
      "4 slices crispy cooked bacon",
      "2 sliced green onions"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 8.0, unit: "ounces", name: "elbow macaroni" },
      { amount: 6.0, unit: nil, name: "large hard-boiled eggs" },
      { amount: 0.75, unit: "cup", name: "mayonnaise" },
      { amount: 1.5, unit: "tablespoons", name: "Dijon mustard" },
      { amount: 2.0, unit: "teaspoons", name: "apple cider vinegar" },
      { amount: 0.5, unit: "teaspoon", name: "kosher salt" },
      { amount: 0.25, unit: "teaspoon", name: "freshly ground black pepper" },
      { amount: 0.5, unit: "cup", name: "chopped celery" },
      { amount: 0.25, unit: "cup", name: "chopped red onion" },
      { amount: 4.0, unit: "slices", name: "crispy cooked bacon" },
      { amount: 2.0, unit: nil, name: "sliced green onions" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Bring a large pot of lightly salted water to boil. Add the elbow macaroni and cook al dente according to package instructions. Drain the pasta well in a colander in the sink.",
      "Meanwhile, peel and slice the eggs in half. Coarsely chop the whites. Add the egg yolks to a food processor with the mayo, Dijon mustard, apple cider vinegar, salt, and black pepper. Pulse the mixture several times until smooth and creamy.",
      "In a large bowl, combine the cooked elbows, chopped egg whites, celery, and red onion. Spoon the dressing into the bowl and stir to combine. Season to taste with more salt and freshly ground black pepper.",
      "Cover and refrigerate the salad for 1-2 hours. Before serving, add the bacon and stir to combine, reserving some bacon crumbles for the top, Garnish with the remaining bacon crumbles and sliced green onions."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Bring a large pot of lightly salted water to boil. Add the elbow macaroni and cook al dente according to package instructions. Drain the pasta well in a colander in the sink.\nMeanwhile, peel and slice the eggs in half. Coarsely chop the whites. Add the egg yolks to a food processor with the mayo, Dijon mustard, apple cider vinegar, salt, and black pepper. Pulse the mixture several times until smooth and creamy.\nIn a large bowl, combine the cooked elbows, chopped egg whites, celery, and red onion. Spoon the dressing into the bowl and stir to combine. Season to taste with more salt and freshly ground black pepper.\nCover and refrigerate the salad for 1-2 hours. Before serving, add the bacon and stir to combine, reserving some bacon crumbles for the top, Garnish with the remaining bacon crumbles and sliced green onions.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("smalltownwoman.com")
    expect(recipe.canonical_url).to eq("https://www.smalltownwoman.com/deviled-egg-pasta-salad/")
    expect(recipe.site_name).to eq("Small Town Woman")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Beth Pierce")
    expect(recipe.description).to eq("Looking for the perfect dish to bring to your next summer barbecue? This deviled egg pasta salad is the perfect combination of creamy, tangy, and savory flavors. Easy to make and guaranteed to be a crowd-pleaser")
    expect(recipe.image).to eq("https://www.smalltownwoman.com/wp-content/uploads/2024/03/Deviled-Egg-Pasta-Salad-Facebook-4x5-1.jpg")
    expect(recipe.category).to eq("pasta salad")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq([
      "deviled egg macaroni pasta salad",
      "deviled egg pasta salad recipe",
      "deviled eggs pasta salad",
      "how to make deviled egg pasta salad",
      "recipe for deviled egg pasta salad"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(23)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "316 kcal",
      "carbohydrateContent" => "23 g",
      "proteinContent" => "9 g",
      "fatContent" => "21 g",
      "saturatedFatContent" => "4 g",
      "transFatContent" => "0.04 g",
      "cholesterolContent" => "149 mg",
      "sodiumContent" => "359 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "2 g",
      "unsaturatedFatContent" => "15 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 316.0 },
      { name: "carbohydrateContent", unit: "g", amount: 23.0 },
      { name: "proteinContent", unit: "g", amount: 9.0 },
      { name: "fatContent", unit: "g", amount: 21.0 },
      { name: "saturatedFatContent", unit: "g", amount: 4.0 },
      { name: "transFatContent", unit: "g", amount: 0.04 },
      { name: "cholesterolContent", unit: "mg", amount: 149.0 },
      { name: "sodiumContent", unit: "mg", amount: 359.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 15.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
