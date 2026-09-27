# frozen_string_literal: true

RSpec.describe "netacooks.com" do
  subject(:recipe) { scrape_cassette("com/netacooks", url: "https://netacooks.com/poppy-seed-orange-muffins-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Poppy Seed Orange Muffins")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 egg",
      "3 tbsp 45 ml vegetable oil",
      "1/2 cup 100 gr sugar",
      "1/2 cup 125 ml orange juice",
      "A pinch of salt",
      "75 gr ground poppy seeds",
      "1/4 cup 25 gr oats",
      "1/2 cup 70 gr white flour",
      "1/2 tsp 5 gr baking powder",
      "50 gr chopped pecans"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "egg" },
      { amount: 3.0, unit: "tbsp", name: "vegetable oil" },
      { amount: 0.5, unit: "cup", name: "sugar" },
      { amount: 0.5, unit: "cup", name: "orange juice" },
      { amount: 1.0, unit: "pinch", name: "salt" },
      { amount: 75.0, unit: "gr", name: "ground poppy seeds" },
      { amount: 0.25, unit: "cup", name: "oats" },
      { amount: 0.5, unit: "cup", name: "white flour" },
      { amount: 0.5, unit: "tsp", name: "baking powder" },
      { amount: 50.0, unit: "gr", name: "chopped pecans" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 475℉ (220°C). Line muffin pan wells with liners.",
      "In a large bowl whisk together egg, oil, sugar, orange juice, and salt.",
      "Add in ground poppy seeds, oats, flour, and baking powder. Mix together till fully incorporated.",
      "Fold in the chopped pecans.",
      "Evenly divide the batter between 10 wells. Bake at 475℉ (220°C) for about 10-15 minutes or until muffins are golden and baked through (to test, insert a cake tester in the middle of a muffin some crumbs maybe present, but no wet batter should be)."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 475℉ (220°C). Line muffin pan wells with liners.\nIn a large bowl whisk together egg, oil, sugar, orange juice, and salt.\nAdd in ground poppy seeds, oats, flour, and baking powder. Mix together till fully incorporated.\nFold in the chopped pecans.\nEvenly divide the batter between 10 wells. Bake at 475℉ (220°C) for about 10-15 minutes or until muffins are golden and baked through (to test, insert a cake tester in the middle of a muffin some crumbs maybe present, but no wet batter should be).")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("netacooks.com")
    expect(recipe.canonical_url).to eq("https://netacooks.com/poppy-seed-orange-muffins-recipe/")
    expect(recipe.site_name).to eq("Neta Cooks")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Natalie Levin")
    expect(recipe.description).to eq("Poppy Seed Orange Muffins recipe, moist and delicious breakfast pastry. Easy and very simple recipe + step by step video to how to make!")
    expect(recipe.image).to eq("https://i0.wp.com/netacooks.com/wp-content/uploads/2016/11/IMG_0247.jpg?fit=1394%2C930&ssl=1")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 items")
    expect(recipe.total_time).to eq(18)
    expect(recipe.prep_time).to eq(3)
    expect(recipe.cook_time).to eq(15)
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
    expect(recipe.links).to include("#genesis-content")
  end
end
