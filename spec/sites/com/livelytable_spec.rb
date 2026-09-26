# frozen_string_literal: true

RSpec.describe "livelytable.com" do
  subject(:recipe) { scrape_cassette("com/livelytable", url: "https://livelytable.com/parmesan-zucchini-casserole/") }

  it "reads the title" do
    expect(recipe.title).to eq("Parmesan Zucchini Casserole")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 small zucchini",
      "2 eggs",
      "1 cup grated parmesan cheese + ½ cup parmesan cut in thin strips",
      "½ cup grated breadcrumbs with garlic powder and dried parsley",
      "1 white onion",
      "1 garlic clove",
      "2 tablespoons olive oil",
      "1 ½ teaspoons salt",
      "1 teaspoon dried rosemary",
      "½ teaspoon black pepper",
      "1 bunch of fresh thyme"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "small zucchini" },
      { amount: 2.0, unit: nil, name: "eggs" },
      { amount: 1.0, unit: "cup", name: "grated parmesan cheese + ½ cup parmesan cut in thin strips" },
      { amount: 0.5, unit: "cup", name: "grated breadcrumbs with garlic powder and dried parsley" },
      { amount: 1.0, unit: nil, name: "white onion" },
      { amount: 1.0, unit: nil, name: "garlic clove" },
      { amount: 2.0, unit: "tablespoons", name: "olive oil" },
      { amount: 1.5, unit: "teaspoons", name: "salt" },
      { amount: 1.0, unit: "teaspoon", name: "dried rosemary" },
      { amount: 0.5, unit: "teaspoon", name: "black pepper" },
      { amount: 1.0, unit: "bunch", name: "fresh thyme" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 395F.",
      "Wash the zucchinis (alternatively you can also peel them) and chop the ends.",
      "In a big bowl place the box grater and grate the zucchini in the biggest hole setting.",
      "Dice thinly the onion and mince the garlic clove.",
      "Add a bit of salt to the bowl with the grated zucchini, this will help them to lose their water. Let rest while you cook the rest of the ingredients.",
      "In a pan add the olive oil and minced garlic and chopped onion. Season with a bit of salt, pepper, rosemary, and thyme. Cook until soft and fragrant.",
      "Drain the zucchinis squeezing them with your hands.",
      "Transfer the cooked onion and garlic into the bowl with the drained zucchini.",
      "Add the eggs and beat them, once beaten ad the grated parmesan cheese to the mixture, rest of the seasonings, and mix well.",
      "Transfer the mixture to a baking dish and spread evenly.",
      "Cover with the breadcrumbs and add a final layer of parmesan strips. Add a bit more thyme on top.",
      "Cook in the oven for 20 minutes."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 395F.\nWash the zucchinis (alternatively you can also peel them) and chop the ends.\nIn a big bowl place the box grater and grate the zucchini in the biggest hole setting.\nDice thinly the onion and mince the garlic clove.\nAdd a bit of salt to the bowl with the grated zucchini, this will help them to lose their water. Let rest while you cook the rest of the ingredients.\nIn a pan add the olive oil and minced garlic and chopped onion. Season with a bit of salt, pepper, rosemary, and thyme. Cook until soft and fragrant.\nDrain the zucchinis squeezing them with your hands.\nTransfer the cooked onion and garlic into the bowl with the drained zucchini.\nAdd the eggs and beat them, once beaten ad the grated parmesan cheese to the mixture, rest of the seasonings, and mix well.\nTransfer the mixture to a baking dish and spread evenly.\nCover with the breadcrumbs and add a final layer of parmesan strips. Add a bit more thyme on top.\nCook in the oven for 20 minutes.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("livelytable.com")
    expect(recipe.canonical_url).to eq("https://livelytable.com/parmesan-zucchini-casserole/")
    expect(recipe.site_name).to eq("Lively Table")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("LINDSAY DELK")
    expect(recipe.description).to eq("Easy and healthy casserole made with zucchini and lots of parmesan. A super quick dinner or lunch idea that everyone will love.")
    expect(recipe.image).to eq("https://livelytable.com/wp-content/uploads/2023/01/Parmesan-zucchini-casserole-1-225x225.jpg")
    expect(recipe.category).to eq("Main meals")
    expect(recipe.cuisine).to eq("International")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(30)
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
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
