# frozen_string_literal: true

RSpec.describe "homeandplate.com" do
  subject(:recipe) { scrape_cassette("com/homeandplate", url: "https://www.homeandplate.com/blog/easy-cheesy-eggplant-and-zucchini-casserole-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy Cheesy Eggplant and Zucchini Casserole Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 large eggplant, (cut into cubes)",
      "2 zucchini, (sliced lengthwise and quartered)",
      "2 yellow squash, (sliced lengthwise and quartered)",
      "1 medium onion, (chopped)",
      "Olive oil",
      "2 large tomatoes, (chopped)",
      "2 cloves garlic, (minced)",
      "1 pound hot sausage",
      "1 cup Panko breadcrumbs",
      "1 cup feta cheese, (crumbled)",
      "1 teaspoon dried parsley",
      "1 teaspoon dried basil",
      "Salt and pepper to taste"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "large eggplant" },
      { amount: 2.0, unit: nil, name: "zucchini" },
      { amount: 2.0, unit: nil, name: "yellow squash" },
      { amount: 1.0, unit: nil, name: "medium onion" },
      { amount: nil, unit: nil, name: "Olive oil" },
      { amount: 2.0, unit: nil, name: "large tomatoes" },
      { amount: 2.0, unit: "cloves", name: "garlic" },
      { amount: 1.0, unit: "pound", name: "hot sausage" },
      { amount: 1.0, unit: "cup", name: "Panko breadcrumbs" },
      { amount: 1.0, unit: "cup", name: "feta cheese" },
      { amount: 1.0, unit: "teaspoon", name: "dried parsley" },
      { amount: 1.0, unit: "teaspoon", name: "dried basil" },
      { amount: nil, unit: nil, name: "Salt and pepper to taste" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 425° F.",
      "Chop the eggplant, onion, zucchini, and squash and toss in a medium bowl with olive oil, parsley, basil, salt, and pepper.",
      "Chop the tomatoes and set aside.",
      "Place the vegetables on a foil lined baking sheet in a single layer and bake for 20 minutes or until the vegetables have softened.",
      "In a large skillet over medium – high heat, sauté the sausage, until brown and crumbly. Remove to a bowl.",
      "Add the tomatoes to the skillet and sauté for five minutes until the juices start to release. Stir in the garlic and stir for a minute longer.",
      "In a large baking dish, spread the sausage on the bottom of the pan.",
      "Transfer the cooked vegetables from the baking sheet to the baking dish on top of the sausage.",
      "Layer the tomatoes on top.",
      "Sprinkle the breadcrumbs over the top layer of tomatoes and then add the feta cheese.",
      "Place the baking dish in the oven and bake at 425° F for 20 minutes or until the breadcrumbs and feta cheese has turned a golden brown."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 425° F.\nChop the eggplant, onion, zucchini, and squash and toss in a medium bowl with olive oil, parsley, basil, salt, and pepper.\nChop the tomatoes and set aside.\nPlace the vegetables on a foil lined baking sheet in a single layer and bake for 20 minutes or until the vegetables have softened.\nIn a large skillet over medium – high heat, sauté the sausage, until brown and crumbly. Remove to a bowl.\nAdd the tomatoes to the skillet and sauté for five minutes until the juices start to release. Stir in the garlic and stir for a minute longer.\nIn a large baking dish, spread the sausage on the bottom of the pan.\nTransfer the cooked vegetables from the baking sheet to the baking dish on top of the sausage.\nLayer the tomatoes on top.\nSprinkle the breadcrumbs over the top layer of tomatoes and then add the feta cheese.\nPlace the baking dish in the oven and bake at 425° F for 20 minutes or until the breadcrumbs and feta cheese has turned a golden brown.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("homeandplate.com")
    expect(recipe.canonical_url).to eq("https://www.homeandplate.com/blog/easy-cheesy-eggplant-and-zucchini-casserole-recipe/")
    expect(recipe.site_name).to eq("Home & Plate")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Ali Randall")
    expect(recipe.description).to eq("This cheesy eggplant and zucchini casserole recipe celebrates the flavors of summer.")
    expect(recipe.image).to eq("https://www.homeandplate.com/wp-content/uploads/2024/03/zucchini-eggplant-casserole-recipe-6.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(55)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(40)
    expect(recipe.keywords).to eq(["Zucchini eggplant casserole"])
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
    expect(recipe.links).to include("#content")
  end
end
