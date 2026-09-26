# frozen_string_literal: true

RSpec.describe "mykidslickthebowl.com" do
  subject(:recipe) { scrape_cassette("com/mykidslickthebowl", url: "https://mykidslickthebowl.com/one-pan-pasta-tomato-sausage-lentils/") }

  it "reads the title" do
    expect(recipe.title).to eq("One Pan Pasta - Sausage Tomato & Lentils")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 Tablespoons olive oil",
      "1 large onion (diced)",
      "1 cup celery (diced)",
      "1 cup carrots (diced)",
      "3 sausages (225 grams)",
      "3 cloves garlic (crushed)",
      "1 Tablespoon thyme (dried)",
      "400 grams crushed tomatoes (canned)",
      "400 grams whole peeled tomatoes (canned)",
      "400 grams lentils (canned, 250 grams drained and rinsed. )",
      "2 cups stock (500 millilitres)",
      "350 grams pasta (penne, 3 and a half cups)",
      "3 handfuls baby spinach leaves (optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "Tablespoons", name: "olive oil" },
      { amount: 1.0, unit: nil, name: "large onion" },
      { amount: 1.0, unit: "cup", name: "celery" },
      { amount: 1.0, unit: "cup", name: "carrots" },
      { amount: 3.0, unit: nil, name: "sausages" },
      { amount: 3.0, unit: "cloves", name: "garlic" },
      { amount: 1.0, unit: "Tablespoon", name: "thyme" },
      { amount: 400.0, unit: "grams", name: "crushed tomatoes" },
      { amount: 400.0, unit: "grams", name: "whole peeled tomatoes" },
      { amount: 400.0, unit: "grams", name: "lentils" },
      { amount: 2.0, unit: "cups", name: "stock" },
      { amount: 350.0, unit: "grams", name: "pasta" },
      { amount: 3.0, unit: "handfuls", name: "baby spinach leaves" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Heat oil in the pan over a medium heat",
      "Add the onion, celery, and carrot and sauté until beginning to soften (around 5 mins).",
      "Cut up the sausage meat into bite-sized pieces, add this to the pan and brown.",
      "Add the garlic cloves and thyme. Sauté everything for a further 1-2 minutes until you can smell the garlic.",
      "Add both tins of tomatoes, the lentils and the stock, give everything a good stir.",
      "Add the dry pasta, stir, let the mix come to the boil, then cover with a lid and reduce the heat to low. It should take around 25 mins for the pasta to become tender, but this will vary a little depending on the pasta shape you have chosen.",
      "Optional: Add 2 to3 handfuls of baby spinach leaves to the pan, cover with the lid for 1-2 minutes until wilted, then stir through the pasta.",
      "If the pasta is not quite tender when you remove the lid, pop the lid back on and cook for a further couple of minutes. If the pasta sauce is thinner than you would prefer, cook the pasta for a few more minutes with the lid off so that extra moisture can escape.",
      "Enjoy"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Heat oil in the pan over a medium heat\nAdd the onion, celery, and carrot and sauté until beginning to soften (around 5 mins).\nCut up the sausage meat into bite-sized pieces, add this to the pan and brown.\nAdd the garlic cloves and thyme. Sauté everything for a further 1-2 minutes until you can smell the garlic.\nAdd both tins of tomatoes, the lentils and the stock, give everything a good stir.\nAdd the dry pasta, stir, let the mix come to the boil, then cover with a lid and reduce the heat to low. It should take around 25 mins for the pasta to become tender, but this will vary a little depending on the pasta shape you have chosen.\nOptional: Add 2 to3 handfuls of baby spinach leaves to the pan, cover with the lid for 1-2 minutes until wilted, then stir through the pasta.\nIf the pasta is not quite tender when you remove the lid, pop the lid back on and cook for a further couple of minutes. If the pasta sauce is thinner than you would prefer, cook the pasta for a few more minutes with the lid off so that extra moisture can escape.\nEnjoy")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("mykidslickthebowl.com")
    expect(recipe.canonical_url).to eq("https://mykidslickthebowl.com/one-pan-pasta-tomato-sausage-lentils/")
    expect(recipe.site_name).to eq("My Kids Lick The Bowl")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Stacey")
    expect(recipe.description).to eq("An easy one pan pasta recipe flavoured with sausage tomato and lentils a quick no fuss family dinner")
    expect(recipe.image).to eq("https://mykidslickthebowl.com/wp-content/uploads/2024/09/sausage-pasta-3.jpg")
    expect(recipe.category).to eq("Family Dinner Ideas")
    expect(recipe.cuisine).to eq("Italian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(35)
    expect(recipe.keywords).to eq([
      "one pan pasta",
      "pasta with lentils",
      "sausage pasta",
      "sausage pasta recipes",
      "sausage tomato pasta"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.52)
    expect(recipe.ratings_count).to eq(39)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 g",
      "calories" => "687 kcal",
      "carbohydrateContent" => "98 g",
      "proteinContent" => "34 g",
      "fatContent" => "18 g",
      "saturatedFatContent" => "5 g",
      "cholesterolContent" => "31 mg",
      "sodiumContent" => "816 mg",
      "fiberContent" => "26 g",
      "sugarContent" => "10 g",
      "transFatContent" => "0.1 g",
      "unsaturatedFatContent" => "12 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "g", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 687.0 },
      { name: "carbohydrateContent", unit: "g", amount: 98.0 },
      { name: "proteinContent", unit: "g", amount: 34.0 },
      { name: "fatContent", unit: "g", amount: 18.0 },
      { name: "saturatedFatContent", unit: "g", amount: 5.0 },
      { name: "cholesterolContent", unit: "mg", amount: 31.0 },
      { name: "sodiumContent", unit: "mg", amount: 816.0 },
      { name: "fiberContent", unit: "g", amount: 26.0 },
      { name: "sugarContent", unit: "g", amount: 10.0 },
      { name: "transFatContent", unit: "g", amount: 0.1 },
      { name: "unsaturatedFatContent", unit: "g", amount: 12.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
