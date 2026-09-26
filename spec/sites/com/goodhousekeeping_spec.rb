# frozen_string_literal: true

RSpec.describe "goodhousekeeping.com" do
  subject(:recipe) { scrape_cassette("com/goodhousekeeping", url: "https://www.goodhousekeeping.com/uk/halloween/a535444/spiced-pumpkin-soup/") }

  it "reads the title" do
    expect(recipe.title).to eq("Spiced pumpkin soup recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "600 g pumpkin flesh, roughly chopped",
      "2 celery sticks, roughly chopped",
      "1 garlic clove, roughly chopped",
      "1 tsp. each ground cumin and coriander",
      "800 mL vegetable stock",
      "200 mL coconut milk",
      "1 tbsp. pumpkin seeds"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 600.0, unit: "g", name: "pumpkin flesh, roughly chopped" },
      { amount: 2.0, unit: nil, name: "celery sticks, roughly chopped" },
      { amount: 1.0, unit: nil, name: "garlic clove, roughly chopped" },
      { amount: 1.0, unit: "tsp", name: "each ground cumin and coriander" },
      { amount: 800.0, unit: "mL", name: "vegetable stock" },
      { amount: 200.0, unit: "mL", name: "coconut milk" },
      { amount: 1.0, unit: "tbsp", name: "pumpkin seeds" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Put the pumpkin flesh into a food processor and whiz for 30sec until almost smooth. Add the celery, garlic and spices and whiz again for 30 seconds. Empty into a large pan.",
      "Pour over stock and coconut milk, bring to the boil, then cover and simmer for 15 minutes.",
      "Remove from heat and blend until smooth - do this in batches, if necessary. Check the seasoning and ladle into warmed soup bowls. Sprinkle with pumpkin seeds and freshly ground black pepper. Serve with crusty bread."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Put the pumpkin flesh into a food processor and whiz for 30sec until almost smooth. Add the celery, garlic and spices and whiz again for 30 seconds. Empty into a large pan.\nPour over stock and coconut milk, bring to the boil, then cover and simmer for 15 minutes.\nRemove from heat and blend until smooth - do this in batches, if necessary. Check the seasoning and ladle into warmed soup bowls. Sprinkle with pumpkin seeds and freshly ground black pepper. Serve with crusty bread.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("goodhousekeeping.com")
    expect(recipe.canonical_url).to eq("https://www.goodhousekeeping.com/uk/halloween/a535444/spiced-pumpkin-soup/")
    expect(recipe.site_name).to eq("Good Housekeeping")
    expect(recipe.language).to eq("en-GB")
    expect(recipe.author).to eq("The GH Kitchen Team")
    expect(recipe.description).to eq("Use the flesh from your Halloween pumpkin in this speedy soup recipe...🎃")
    expect(recipe.image).to eq("https://hips.hearstapps.com/goodhousekeeping-uk/main/embedded/5444/t5-Spiced-Pumpkin-Soup-de.jpg?crop=1.00xw:1.00xh;0,0&resize=1200:*")
    expect(recipe.category).to eq("vegetarian")
    expect(recipe.cuisine).to eq("Squash Cuisine")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq([
      "pumpkin soup",
      "pumpkin soup recipe",
      "easy pumpkin soup",
      "how to make pumpkin soup",
      "pumpkin recipes"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "calories" => "222 calories" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 222.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/uk/search/")
  end
end
