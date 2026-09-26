# frozen_string_literal: true

RSpec.describe "theguardian.com" do
  subject(:recipe) { scrape_cassette("com/theguardian", url: "https://www.theguardian.com/food/2023/dec/30/vegan-ram-don-noodles-recipe-black-garlic-leek-tenderstem-meera-sodha") }

  it "reads the title" do
    expect(recipe.title).to eq("Ram-don with black garlic, leek and Tenderstem")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "225.0g smoked tofu drained",
      "4.0tbsp cornflour",
      "15.0 dried shiitake mushrooms (15g)",
      "4.0tsp dark brown sugar",
      "4.0tbsp light soy sauce",
      "1.5tbsp black garlic paste",
      "3.0tbsp gochujang",
      "2.0tsp rice vinegar",
      "Rapeseed oil",
      "1.0 large leek (200g), finely sliced into coins",
      "0.25tsp fine salt",
      "250.0g ramen noodles",
      "300.0g Tenderstem trimmed and halved on an angle"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 225.0, unit: "g", name: "smoked tofu drained" },
      { amount: 4.0, unit: "tbsp", name: "cornflour" },
      { amount: 15.0, unit: nil, name: "dried shiitake mushrooms" },
      { amount: 4.0, unit: "tsp", name: "dark brown sugar" },
      { amount: 4.0, unit: "tbsp", name: "light soy sauce" },
      { amount: 1.5, unit: "tbsp", name: "black garlic paste" },
      { amount: 3.0, unit: "tbsp", name: "gochujang" },
      { amount: 2.0, unit: "tsp", name: "rice vinegar" },
      { amount: nil, unit: nil, name: "Rapeseed oil" },
      { amount: 1.0, unit: nil, name: "large leek, finely sliced into coins" },
      { amount: 0.25, unit: "tsp", name: "fine salt" },
      { amount: 250.0, unit: "g", name: "ramen noodles" },
      { amount: 300.0, unit: "g", name: "Tenderstem trimmed and halved on an angle" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Press the tofu with kitchen paper to remove any excess water, then cut into 2½cm cubes and put in a bowl.",
      "Add the cornflour, stir to coat, then set aside.",
      "Put the mushrooms in a heatproof bowl, pour over 400ml just-boiled water and leave to soak.",
      "To make the sauce, put the sugar, soy sauce, black garlic paste, gochujang and rice vinegar in a medium bowl, stir to combine and set aside.",
      "Put two tablespoons of oil in a wide, nonstick frying pan on a medium heat.",
      "When the oil is really hot, add the sliced leek and cook without stirring for five minutes, so that some strands blacken and caramelise.",
      "Turn down the heat to medium-low, add a quarter-teaspoon of fine salt, cook for another five minutes, stirring occasionally, then transfer to a plate.",
      "While the leeks are cooking, get on with the mushrooms and noodles.",
      "Scoop out the soaked mushrooms, squeezing them to get rid of any excess water, then pour the soaking liquid into the sauce bowl.",
      "Finely slice the rehydrated mushrooms and add them to the bowl, too.",
      "Cook the noodles according to the packet instructions, moving them around with a fork or tongs to stop them sticking together.",
      "Drain, rinse under cold water until cooled, drizzle over a couple of tablespoons of oil and stir to coat.",
      "Heat another tablespoon of oil in the leek pan, add the broccoli and a couple of tablespoons of water, pop on the lid and cook, stirring once halfway, for four minutes. Transfer to a second plate.",
      "Put the pan on a high heat and add three more tablespoons of oil.",
      "Shake any excess cornflour off the tofu, put the cubes in the pan in a single layer (you might need to fry them in two batches), fry for about six minutes, turning every other minute, until golden, then transfer to a third plate (keep the pan on the heat).",
      "Add the noodles to the hot pan, followed by the sauce, broccoli, tofu and half the leeks, toss (use a spaghetti fork or similar) until well mixed, then leave to heat through for a couple of minutes.",
      "Distribute between four plates or bowls, spoon some of the remaining leeks over each portion and serve."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Press the tofu with kitchen paper to remove any excess water, then cut into 2½cm cubes and put in a bowl.\nAdd the cornflour, stir to coat, then set aside.\nPut the mushrooms in a heatproof bowl, pour over 400ml just-boiled water and leave to soak.\nTo make the sauce, put the sugar, soy sauce, black garlic paste, gochujang and rice vinegar in a medium bowl, stir to combine and set aside.\nPut two tablespoons of oil in a wide, nonstick frying pan on a medium heat.\nWhen the oil is really hot, add the sliced leek and cook without stirring for five minutes, so that some strands blacken and caramelise.\nTurn down the heat to medium-low, add a quarter-teaspoon of fine salt, cook for another five minutes, stirring occasionally, then transfer to a plate.\nWhile the leeks are cooking, get on with the mushrooms and noodles.\nScoop out the soaked mushrooms, squeezing them to get rid of any excess water, then pour the soaking liquid into the sauce bowl.\nFinely slice the rehydrated mushrooms and add them to the bowl, too.\nCook the noodles according to the packet instructions, moving them around with a fork or tongs to stop them sticking together.\nDrain, rinse under cold water until cooled, drizzle over a couple of tablespoons of oil and stir to coat.\nHeat another tablespoon of oil in the leek pan, add the broccoli and a couple of tablespoons of water, pop on the lid and cook, stirring once halfway, for four minutes. Transfer to a second plate.\nPut the pan on a high heat and add three more tablespoons of oil.\nShake any excess cornflour off the tofu, put the cubes in the pan in a single layer (you might need to fry them in two batches), fry for about six minutes, turning every other minute, until golden, then transfer to a third plate (keep the pan on the heat).\nAdd the noodles to the hot pan, followed by the sauce, broccoli, tofu and half the leeks, toss (use a spaghetti fork or similar) until well mixed, then leave to heat through for a couple of minutes.\nDistribute between four plates or bowls, spoon some of the remaining leeks over each portion and serve.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("theguardian.com")
    expect(recipe.canonical_url).to eq("https://www.theguardian.com/food/2023/dec/30/vegan-ram-don-noodles-recipe-black-garlic-leek-tenderstem-meera-sodha")
    expect(recipe.site_name).to eq("the Guardian")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Meera Sodha")
    expect(recipe.description).to eq("Dinner and film night is my jam. It’s how we as a family end the working week on a Friday night - and this dish is a great match. You’ll need some black garlic paste, which is widely available in larger supermarkets. If you like, prep all the elements in advance – noodles, tofu, sauce, broccoli – and cook them together in the pan just before serving")
    expect(recipe.image).to eq("https://media.guim.co.uk/a32245aec6fcf66e5155a25014280e56331cf528/104_0_3463_4328/1600.jpg")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(50)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(40)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(%w[VegetarianDiet VeganDiet])
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#maincontent")
  end
end
