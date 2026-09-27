# frozen_string_literal: true

RSpec.describe "vegansociety.com" do
  subject(:recipe) { scrape_cassette("com/vegansociety", url: "https://vegansociety.com/resources/recipes/main-meals/chef-day-radleys-spicy-one-pot-black-bean-rice") }

  it "reads the title" do
    expect(recipe.title).to eq("Chef Day Radley's spicy one pot black bean rice")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 can of black beans, drained and rinsed",
      "1/2 cup brown basmati rice",
      "1 onion, sliced",
      "3 carrots, roughly chopped",
      "1 or 2 potatoes, roughly chopped",
      "2 or 3 garlic cloves, roughly sliced",
      "1 tablespoon stock powder",
      "2 teaspoon toasted and ground cumin seed or pre-ground cumin",
      "2 teaspoon hot smoked paprika"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "can", name: "black beans, drained and rinsed" },
      { amount: 0.5, unit: "cup", name: "brown basmati rice" },
      { amount: 1.0, unit: nil, name: "onion, sliced" },
      { amount: 3.0, unit: nil, name: "carrots, roughly chopped" },
      { amount: 1.0, unit: nil, name: "potatoes, roughly chopped" },
      { amount: 2.0, unit: nil, name: "garlic cloves, roughly sliced" },
      { amount: 1.0, unit: "tablespoon", name: "stock powder" },
      { amount: 2.0, unit: "teaspoon", name: "toasted and ground cumin seed or pre-ground cumin" },
      { amount: 2.0, unit: "teaspoon", name: "hot smoked paprika" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Add all of the ingredients straight into the pan.",
      "Pour in enough water so that the ingredients are just about covered.",
      "Bring to the boil on a high heat, then reduce to a simmer - add a little hot water if the pan dries out too much.",
      "Cook for around 30-40 minutes until the rice is cooked through."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Add all of the ingredients straight into the pan.\nPour in enough water so that the ingredients are just about covered.\nBring to the boil on a high heat, then reduce to a simmer - add a little hot water if the pan dries out too much.\nCook for around 30-40 minutes until the rice is cooked through.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("vegansociety.com")
    expect(recipe.canonical_url).to eq("https://www.vegansociety.com/resources/recipes/main-meals/chef-day-radleys-spicy-one-pot-black-bean-rice")
    expect(recipe.site_name).to eq("The Vegan Society")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("This one-pot rice dish not only saves you washing up time, but can be easily adapted to use ingredients you already own.")
    expect(recipe.image).to eq("https://www.vegansociety.com/sites/default/files/onepan_thumbnail_0.jpg")
    expect(recipe.category).to eq("Dinner")
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
    expect(recipe.links).to include("#main-content")
  end
end
