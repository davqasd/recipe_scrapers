# frozen_string_literal: true

RSpec.describe "101cookbooks.com" do
  subject(:recipe) { scrape_cassette("com/101cookbooks", url: "https://www.101cookbooks.com/summer-corn-salad-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Summer Corn Salad")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "6 ears of corn",
      "1 large shallot, minced",
      "1/3 cup fresh lemon juice",
      "scant 1/2 teaspoon fine grain sea salt",
      "2 tablespoons brown sugar",
      "3 tablespoons sunflower oil",
      "3/4 cup / 4 oz / 115g toasted pepitas",
      "3/4 cup / 4 oz / 115g toasted sunflower seeds",
      "1 teaspoon Mexican oregano"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 6.0, unit: "ears", name: "corn" },
      { amount: 1.0, unit: nil, name: "large shallot, minced" },
      { amount: 0.33, unit: "cup", name: "fresh lemon juice" },
      { amount: 0.5, unit: "teaspoon", name: "fine grain sea salt" },
      { amount: 2.0, unit: "tablespoons", name: "brown sugar" },
      { amount: 3.0, unit: "tablespoons", name: "sunflower oil" },
      { amount: 0.75, unit: "cup", name: "toasted pepitas" },
      { amount: 0.75, unit: "cup", name: "toasted sunflower seeds" },
      { amount: 1.0, unit: "teaspoon", name: "Mexican oregano" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Shuck the corn and use a knife to cut the kernels from the cobs. Place the kernels in a medium bowl with the shallot while you make the dressing.",
      "Combine the lemon juice, salt, and sugar in a small bowl or jar. Gradually add the oil, whisking vigorously until the dressing comes together. Taste, and adjust with more lemon juice, salt or sugar, if needed. This dressing should be on the sweet side, not overly tangy.",
      "Just before serving, add the seeds to the bowl of corn along with 2/3 of the dressing. Toss well, really get everything well coated. If you want more dressing, add more to taste. Crush the oregano between your palms and let it shower down on to the salad. Toss one more time and serve."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Shuck the corn and use a knife to cut the kernels from the cobs. Place the kernels in a medium bowl with the shallot while you make the dressing.\nCombine the lemon juice, salt, and sugar in a small bowl or jar. Gradually add the oil, whisking vigorously until the dressing comes together. Taste, and adjust with more lemon juice, salt or sugar, if needed. This dressing should be on the sweet side, not overly tangy.\nJust before serving, add the seeds to the bowl of corn along with 2/3 of the dressing. Toss well, really get everything well coated. If you want more dressing, add more to taste. Crush the oregano between your palms and let it shower down on to the salad. Toss one more time and serve.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("101cookbooks.com")
    expect(recipe.canonical_url).to eq("https://www.101cookbooks.com/summer-corn-salad-recipe/")
    expect(recipe.site_name).to eq("101 Cookbooks")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Heidi Swanson")
    expect(recipe.description).to eq("A crunchy, sweet no-cook summer corn salad. The salad is a breeze, has a ton of toasted pepitas & sunflower seeds, tossed with a brown sugar lemonade vinaigrette.")
    expect(recipe.image).to eq("https://images.101cookbooks.com/SUMMER-CORN-SALAD-RECIPE-h2.jpg?w=1200&auto=format")
    expect(recipe.category).to eq("Salad")
    expect(recipe.cuisine).to eq("California")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(14_400)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["corn salad", "Summer"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(4)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "344 kcal",
      "carbohydrateContent" => "28 g",
      "proteinContent" => "11 g",
      "fatContent" => "24 g",
      "saturatedFatContent" => "3 g",
      "transFatContent" => "1 g",
      "sodiumContent" => "20 mg",
      "fiberContent" => "5 g",
      "sugarContent" => "11 g",
      "unsaturatedFatContent" => "20 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 344.0 },
      { name: "carbohydrateContent", unit: "g", amount: 28.0 },
      { name: "proteinContent", unit: "g", amount: 11.0 },
      { name: "fatContent", unit: "g", amount: 24.0 },
      { name: "saturatedFatContent", unit: "g", amount: 3.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 20.0 },
      { name: "fiberContent", unit: "g", amount: 5.0 },
      { name: "sugarContent", unit: "g", amount: 11.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 20.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
