# frozen_string_literal: true

RSpec.describe "thecookingguy.com" do
  subject(:recipe) { scrape_cassette("com/thecookingguy", url: "https://www.thecookingguy.com/recipes/summer-lasagna---in-a-pizza-oven") }

  it "reads the title" do
    expect(recipe.title).to eq("Summer Lasagna - in a PIZZA OVEN!")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 pound Italian suasage",
      "1 medium onion, thinly sliced",
      "2 ears corn, shucked",
      "1 pint cherry tomatoes",
      "8 Barilla Oven-Ready lasagna noodles",
      "15 ounces whole milk ricotta",
      "1/4 cup prepared pesto, recipe here",
      "1/3 cup grated Parmesan, plus more for finishing",
      "1 large egg",
      "Zest of 1 lemon",
      "3 cups vodka sauce, recipe here recipe here",
      "8 ounces smoked mozzarella, shredded",
      "Olive oil",
      "Kosher salt",
      "Freshly cracked black pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "pound", name: "Italian suasage" },
      { amount: 1.0, unit: nil, name: "medium onion, thinly sliced" },
      { amount: 2.0, unit: "ears", name: "corn, shucked" },
      { amount: 1.0, unit: "pint", name: "cherry tomatoes" },
      { amount: 8.0, unit: nil, name: "Barilla Oven-Ready lasagna noodles" },
      { amount: 15.0, unit: "ounces", name: "whole milk ricotta" },
      { amount: 0.25, unit: "cup", name: "prepared pesto, recipe here" },
      { amount: 0.33, unit: "cup", name: "grated Parmesan, plus more for finishing" },
      { amount: 1.0, unit: nil, name: "large egg" },
      { amount: nil, unit: nil, name: "Zest of 1 lemon" },
      { amount: 3.0, unit: "cups", name: "vodka sauce, recipe here recipe here" },
      { amount: 8.0, unit: "ounces", name: "smoked mozzarella, shredded" },
      { amount: nil, unit: nil, name: "Olive oil" },
      { amount: nil, unit: nil, name: "Kosher salt" },
      { amount: nil, unit: nil, name: "Freshly cracked black pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Heat your pizza oven to 675-700°F",
      "Cook the Italian sausage until browned and crumbly, set aside",
      "Slowly caramelize the onion until deeply golden, set aside",
      "Roast or grill the cherry tomatoes until blistered, set aside",
      "Char the corn, then cut the kernels from the cob",
      "In a medium bowl, combine the ricotta, egg, Parmesan, pesto,lemon zest, a generous pinch of salt, and several grinds of black pepper until well mixed",
      "Using a small-ish casserole dish that'll fit comfortably inside of your pizza oven, build: lightly oil the pan, spread a thin layer of vodka sauce across the bottom, leaving about an inch around the outside, lay down 2 oven-ready lasagna noodles, top with the ricotta mixture, the sausage, the charred corn, the caramelized onions, the roasted tomatoes, the mozzarella, some parmesan and repeat until done",
      "Don't worry about making it perfectly even, let the edges stay a little rustic, and don't fill the pan completely. Those exposed edges are where the magic happens.",
      "Cover with non-stick foil, slide into the pizza oven (see reg oven directions below) , and bake bake 10-14 minutes, rotating the pan every minute or so to ensure even browning",
      "Remove the foil for the last couple minutes to brown the top",
      "The lasagna is done when the cheese is deeply blistered, the sauce is bubbling, and the noodles are tender when pierced with a knife",
      "Preheat the oven to 425°F.",
      "Cover the pan loosely with foil and bake for 20 to 25 minutes. Remove the foil and continue baking for 15 to 20 minutes, until the sauce is bubbling, the cheese is deeply golden, and a knife slides easily through the noodles",
      "If the top begins to brown too quickly after uncovering, loosely tent it with foil for the remaining baking time",
      "Let the lasagna rest for 10 to 15 minutes before serving"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Heat your pizza oven to 675-700°F\nCook the Italian sausage until browned and crumbly, set aside\nSlowly caramelize the onion until deeply golden, set aside\nRoast or grill the cherry tomatoes until blistered, set aside\nChar the corn, then cut the kernels from the cob\nIn a medium bowl, combine the ricotta, egg, Parmesan, pesto,lemon zest, a generous pinch of salt, and several grinds of black pepper until well mixed\nUsing a small-ish casserole dish that'll fit comfortably inside of your pizza oven, build: lightly oil the pan, spread a thin layer of vodka sauce across the bottom, leaving about an inch around the outside, lay down 2 oven-ready lasagna noodles, top with the ricotta mixture, the sausage, the charred corn, the caramelized onions, the roasted tomatoes, the mozzarella, some parmesan and repeat until done\nDon't worry about making it perfectly even, let the edges stay a little rustic, and don't fill the pan completely. Those exposed edges are where the magic happens.\nCover with non-stick foil, slide into the pizza oven (see reg oven directions below) , and bake bake 10-14 minutes, rotating the pan every minute or so to ensure even browning\nRemove the foil for the last couple minutes to brown the top\nThe lasagna is done when the cheese is deeply blistered, the sauce is bubbling, and the noodles are tender when pierced with a knife\nPreheat the oven to 425°F.\nCover the pan loosely with foil and bake for 20 to 25 minutes. Remove the foil and continue baking for 15 to 20 minutes, until the sauce is bubbling, the cheese is deeply golden, and a knife slides easily through the noodles\nIf the top begins to brown too quickly after uncovering, loosely tent it with foil for the remaining baking time\nLet the lasagna rest for 10 to 15 minutes before serving")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thecookingguy.com")
    expect(recipe.canonical_url).to eq("https://www.thecookingguy.com/recipes/summer-lasagna---in-a-pizza-oven")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Sam The Cooking Guy")
    expect(recipe.description).to be_nil
    expect(recipe.image).to eq("https://cdn.prod.website-files.com/657a7aac36df076237527e36/6a76526555bd4462cb2fb99e_summersagna_youtube_recipe_1.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
