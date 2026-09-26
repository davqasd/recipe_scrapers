# frozen_string_literal: true

RSpec.describe "spainonafork.com" do
  subject(:recipe) { scrape_cassette("com/spainonafork", url: "https://spainonafork.com/spanish-sangria-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Homemade Spanish Sangria - Authentic Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 750ML Bottle of Red Spanish Wine",
      "1 Lemon",
      "1 Orange",
      "1 Peach",
      "1 Apple",
      "1/4 Cup Spanish Brandy",
      "1 Cup Orange Juice (not from concentrate)",
      "1/3 Cup White Sugar",
      "1 Cinnamon Stick"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "Bottle", name: "Red Spanish Wine" },
      { amount: 1.0, unit: nil, name: "Lemon" },
      { amount: 1.0, unit: nil, name: "Orange" },
      { amount: 1.0, unit: nil, name: "Peach" },
      { amount: 1.0, unit: nil, name: "Apple" },
      { amount: 0.25, unit: "Cup", name: "Spanish Brandy" },
      { amount: 1.0, unit: "Cup", name: "Orange Juice" },
      { amount: 0.33, unit: "Cup", name: "White Sugar" },
      { amount: 1.0, unit: nil, name: "Cinnamon Stick" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Thinly slice 1 orange and 1 lemon, add half of the orange slices and half of the lemon slices into a pitcher and reserve the other slices, cut 1 peach and 1 apple into small cubes and add all the cubed peaches and half the cubed apples to the pitcher, reserve the other cubed apples",
      "Next add a 1/4 cup of a good quality brandy into the pitcher, 1 cup of non-concentrated orange juice and 1/3 cup of white sugar",
      "Using a large wooden spoon, push down on the fruit to release all the juices and then mix everything together",
      "Now add one 750 ml bottle of red wine into the pitcher, I recommend a young Rioja wine, then add 1 cinnamon stick, mix everything together and add the pitcher to the fridge for at least 2 hours to let all the flavors develop",
      "Drizzle a little fresh lemon juice on the reserved apples (so they don´t brown) and add all the reserved fruit to the fridge",
      "When ready to serve, stir the sangria around in the pitcher, then add some ice cubes to each serving glass, add some of the reserved cut apples into the glass, and pour in some sangria, add 1 orange and 1 lemon slice to each glass and serve",
      "Enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Thinly slice 1 orange and 1 lemon, add half of the orange slices and half of the lemon slices into a pitcher and reserve the other slices, cut 1 peach and 1 apple into small cubes and add all the cubed peaches and half the cubed apples to the pitcher, reserve the other cubed apples\nNext add a 1/4 cup of a good quality brandy into the pitcher, 1 cup of non-concentrated orange juice and 1/3 cup of white sugar\nUsing a large wooden spoon, push down on the fruit to release all the juices and then mix everything together\nNow add one 750 ml bottle of red wine into the pitcher, I recommend a young Rioja wine, then add 1 cinnamon stick, mix everything together and add the pitcher to the fridge for at least 2 hours to let all the flavors develop\nDrizzle a little fresh lemon juice on the reserved apples (so they don´t brown) and add all the reserved fruit to the fridge\nWhen ready to serve, stir the sangria around in the pitcher, then add some ice cubes to each serving glass, add some of the reserved cut apples into the glass, and pour in some sangria, add 1 orange and 1 lemon slice to each glass and serve\nEnjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("spainonafork.com")
    expect(recipe.canonical_url).to eq("https://spainonafork.com/spanish-sangria-recipe/")
    expect(recipe.site_name).to eq("Spain on a Fork")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Albert Bevia @ Spain on a Fork")
    expect(recipe.description).to eq("Watch our video on how to easily make this homemade Spanish sangria recipe. This authentic recipe has an incredible flavor and is sure to be a hit.")
    expect(recipe.image).to eq("https://i1.wp.com/spainonafork.com/wp-content/uploads/2017/09/sangria1-11.png?fit=750%2C750&ssl=1")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(135)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(120)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
