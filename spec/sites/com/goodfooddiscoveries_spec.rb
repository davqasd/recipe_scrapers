# frozen_string_literal: true

RSpec.describe "goodfooddiscoveries.com" do
  subject(:recipe) { scrape_cassette("com/goodfooddiscoveries", url: "https://goodfooddiscoveries.com/lemon-risotto/") }

  it "reads the title" do
    expect(recipe.title).to eq("Lemon Risotto")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 1/2 cups (300g) Arborio rice",
      "4 cups (960ml) chicken or vegetable broth",
      "1/2 cup (120ml) dry white wine",
      "1 small onion, finely chopped",
      "2 cloves garlic, minced",
      "1/4 cup (60g) unsalted butter",
      "1/2 cup (60g) grated parmesan cheese",
      "2 tbsp (30ml) extra virgin olive oil",
      "1 lemon, zest and juice",
      "Salt and pepper, to taste",
      "Fresh parsley, for serving"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.5, unit: "cups", name: "Arborio rice" },
      { amount: 4.0, unit: "cups", name: "chicken or vegetable broth" },
      { amount: 0.5, unit: "cup", name: "dry white wine" },
      { amount: 1.0, unit: nil, name: "small onion, finely chopped" },
      { amount: 2.0, unit: "cloves", name: "garlic, minced" },
      { amount: 0.25, unit: "cup", name: "unsalted butter" },
      { amount: 0.5, unit: "cup", name: "grated parmesan cheese" },
      { amount: 2.0, unit: "tbsp", name: "extra virgin olive oil" },
      { amount: 1.0, unit: nil, name: "lemon, zest and juice" },
      { amount: nil, unit: nil, name: "Salt and pepper, to taste" },
      { amount: nil, unit: nil, name: "Fresh parsley, for serving" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a medium saucepan, heat the broth over low heat until it's warm.",
      "In a large saucepan or Dutch oven, heat the olive oil over medium heat. Add the onion and garlic, and sauté until the onion is soft and translucent, about 3-4 minutes.",
      "Add the Arborio rice to the pan and stir to coat it in the oil. Cook for 2-3 minutes, stirring occasionally, until the rice is lightly toasted.",
      "Add the white wine to the pan and stir until it's absorbed by the rice.",
      "Begin adding the warm broth to the rice mixture, one cup at a time, stirring constantly until each cup of broth is absorbed before adding the next. Continue to stir frequently to ensure that the rice doesn't stick to the pan.",
      "When the rice is tender and the mixture is creamy, after about 20-25 minutes, remove the pan from heat.",
      "Add the butter, parmesan cheese, lemon zest, and lemon juice to the pan and stir until the butter is melted and the cheese is fully incorporated.",
      "Season the risotto with salt and pepper to taste. If the risotto is too thick, add additional broth or water, one tablespoon at a time, until it reaches your desired consistency.",
      "Serve the lemon risotto hot, garnished with fresh parsley."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a medium saucepan, heat the broth over low heat until it's warm.\nIn a large saucepan or Dutch oven, heat the olive oil over medium heat. Add the onion and garlic, and sauté until the onion is soft and translucent, about 3-4 minutes.\nAdd the Arborio rice to the pan and stir to coat it in the oil. Cook for 2-3 minutes, stirring occasionally, until the rice is lightly toasted.\nAdd the white wine to the pan and stir until it's absorbed by the rice.\nBegin adding the warm broth to the rice mixture, one cup at a time, stirring constantly until each cup of broth is absorbed before adding the next. Continue to stir frequently to ensure that the rice doesn't stick to the pan.\nWhen the rice is tender and the mixture is creamy, after about 20-25 minutes, remove the pan from heat.\nAdd the butter, parmesan cheese, lemon zest, and lemon juice to the pan and stir until the butter is melted and the cheese is fully incorporated.\nSeason the risotto with salt and pepper to taste. If the risotto is too thick, add additional broth or water, one tablespoon at a time, until it reaches your desired consistency.\nServe the lemon risotto hot, garnished with fresh parsley.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("goodfooddiscoveries.com")
    expect(recipe.canonical_url).to eq("https://goodfooddiscoveries.com/lemon-risotto/")
    expect(recipe.site_name).to eq("Good Food Discoveries")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Magda Gonczaruk")
    expect(recipe.description).to eq("Lemon Parmesan risotto is a classic Italian dish that features creamy Arborio rice cooked in a flavorful broth and infused with fresh lemon zest and juice, butter, and grated Parmesan cheese.")
    expect(recipe.image).to eq("https://goodfooddiscoveries.com/wp-content/uploads/2023/03/lemon-parmesan-risotto.jpeg")
    expect(recipe.category).to eq("Sides")
    expect(recipe.cuisine).to eq("Italian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to eq(["lemon", "parmesan", "risotto", "lemon risotto"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
