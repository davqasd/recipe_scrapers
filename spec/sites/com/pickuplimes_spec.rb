# frozen_string_literal: true

RSpec.describe "pickuplimes.com" do
  subject(:recipe) { scrape_cassette("com/pickuplimes", url: "https://www.pickuplimes.com/recipe/lemony-tahini-tagliatelle-with-burst-cherry-tomatoes-2811") }

  it "reads the title" do
    expect(recipe.title).to eq("Lemony Tahini Tagliatelle with Burst Cherry Tomatoes")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "10.582 oz tagliatelle",
      "½ Tbsp vegetable oil",
      "1 garlic clove",
      "⅓ cup panko bread crumbs",
      "⅛ tsp salt",
      "1 Tbsp vegetable oil",
      "1 large shallot",
      "4 garlic clove",
      "2 cup cherry tomatoes",
      "1 cup frozen green peas",
      "½ cup fresh basil leaves",
      "½ cup tahini",
      "1 Tbsp extra-virgin olive oil",
      "1 lemon",
      "1 Tbsp nutritional yeast flakes",
      "1 tsp salt",
      "1 tsp maple syrup"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 10.58, unit: "oz", name: "tagliatelle" },
      { amount: 0.5, unit: "Tbsp", name: "vegetable oil" },
      { amount: 1.0, unit: nil, name: "garlic clove" },
      { amount: 0.33, unit: "cup", name: "panko bread crumbs" },
      { amount: 0.13, unit: "tsp", name: "salt" },
      { amount: 1.0, unit: "Tbsp", name: "vegetable oil" },
      { amount: 1.0, unit: nil, name: "large shallot" },
      { amount: 4.0, unit: nil, name: "garlic clove" },
      { amount: 2.0, unit: "cup", name: "cherry tomatoes" },
      { amount: 1.0, unit: "cup", name: "frozen green peas" },
      { amount: 0.5, unit: "cup", name: "fresh basil leaves" },
      { amount: 0.5, unit: "cup", name: "tahini" },
      { amount: 1.0, unit: "Tbsp", name: "extra-virgin olive oil" },
      { amount: 1.0, unit: nil, name: "lemon" },
      { amount: 1.0, unit: "Tbsp", name: "nutritional yeast flakes" },
      { amount: 1.0, unit: "tsp", name: "salt" },
      { amount: 1.0, unit: "tsp", name: "maple syrup" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Cook the pasta in a large pot of salted water until al dente. Before draining, reserve at least 1 cup (240ml) of pasta water (more if you’d like flexibility), then drain and set aside.",
      "In a large sauté pan over medium-high heat, combine the toasted bread crumb ingredients. Toast for about 5 minutes, stirring often, until golden. Transfer to a plate.",
      "Heat the oil in the now-empty pan over medium-high heat. Cook the shallot and garlic for about 5 minutes, until golden.",
      "Add the tomatoes and cook for another 7 to 8 minutes, until lightly burst.",
      "Meanwhile, in a medium bowl, whisk together the sauce ingredients.",
      "Slowly mix in the reserved pasta water to loosen the sauce*.",
      "Add the tahini sauce to the pan with the tomatoes, then add the cooked pasta and peas. Toss to coat.",
      "Cook for 3 minutes, or until the peas are warmed through.",
      "Stir in the basil just before serving, and top with the toasted bread crumbs. Enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Cook the pasta in a large pot of salted water until al dente. Before draining, reserve at least 1 cup (240ml) of pasta water (more if you’d like flexibility), then drain and set aside.\nIn a large sauté pan over medium-high heat, combine the toasted bread crumb ingredients. Toast for about 5 minutes, stirring often, until golden. Transfer to a plate.\nHeat the oil in the now-empty pan over medium-high heat. Cook the shallot and garlic for about 5 minutes, until golden.\nAdd the tomatoes and cook for another 7 to 8 minutes, until lightly burst.\nMeanwhile, in a medium bowl, whisk together the sauce ingredients.\nSlowly mix in the reserved pasta water to loosen the sauce*.\nAdd the tahini sauce to the pan with the tomatoes, then add the cooked pasta and peas. Toss to coat.\nCook for 3 minutes, or until the peas are warmed through.\nStir in the basil just before serving, and top with the toasted bread crumbs. Enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("pickuplimes.com")
    expect(recipe.canonical_url).to eq("https://www.pickuplimes.com/recipe/lemony-tahini-tagliatelle-with-burst-cherry-tomatoes-2811")
    expect(recipe.site_name).to eq("Pick Up Limes")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Pick Up Limes")
    expect(recipe.description).to eq("This vibrant pasta brings together bright lemon, juicy burst cherry tomatoes, and a rich, flavorful tahini sauce. It beautifully coats tender tagliatelle, while sweet green peas add pops of colour. Crispy garlic-toasted breadcrumbs bring the perfect crunch - be sure not to skip it!")
    expect(recipe.image).to eq("https://cdn.pickuplimes.com/cache/1f/79/1f79f35fa11d26c89b91d978e3385e5d.jpg")
    expect(recipe.category).to eq("Main")
    expect(recipe.cuisine).to eq("Italian-inspired")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(35)
    expect(recipe.keywords).to eq(["soy free", "peanut free", "tree nut free", "vegan", "vegetarian", "plant-based"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.9)
    expect(recipe.ratings_count).to eq(9)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "636 calories",
      "fatContent" => "27.7 g",
      "saturatedFatContent" => "3.9 g",
      "transFatContent" => "0.0 g",
      "cholesterolContent" => "0.0 mg",
      "carbohydrateContent" => "80.7 g",
      "fiberContent" => "9.3 g",
      "sugarContent" => "8.6 g",
      "proteinContent" => "19.9 g",
      "calciumContent" => "199.9 mg",
      "ironContent" => "5.30 mg",
      "zincContent" => "3.41 mg",
      "omega3Content" => "0.5 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 636.0 },
      { name: "fatContent", unit: "g", amount: 27.7 },
      { name: "saturatedFatContent", unit: "g", amount: 3.9 },
      { name: "transFatContent", unit: "g", amount: 0.0 },
      { name: "cholesterolContent", unit: "mg", amount: 0.0 },
      { name: "carbohydrateContent", unit: "g", amount: 80.7 },
      { name: "fiberContent", unit: "g", amount: 9.3 },
      { name: "sugarContent", unit: "g", amount: 8.6 },
      { name: "proteinContent", unit: "g", amount: 19.9 },
      { name: "calciumContent", unit: "mg", amount: 199.9 },
      { name: "ironContent", unit: "mg", amount: 5.3 },
      { name: "zincContent", unit: "mg", amount: 3.41 },
      { name: "omega3Content", unit: "g", amount: 0.5 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#recipe-video")
  end
end
