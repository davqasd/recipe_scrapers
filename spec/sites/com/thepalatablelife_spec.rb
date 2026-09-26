# frozen_string_literal: true

RSpec.describe "thepalatablelife.com" do
  subject(:recipe) { scrape_cassette("com/thepalatablelife", url: "https://www.thepalatablelife.com/baked-harissa-chicken-meatballs/") }

  it "reads the title" do
    expect(recipe.title).to eq("baked harissa chicken meatballs")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 lb ground chicken",
      "1/2 sweet onion (chopped)",
      "1 cup panko breadcrumbs",
      "1 cup ricotta cheese",
      "1 egg",
      "2 tbsp harissa",
      "1 tsp garlic (minced)",
      "1 tsp paprika",
      "1/2 tsp cumin",
      "1/2 tsp salt"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "lb", name: "ground chicken" },
      { amount: 0.5, unit: nil, name: "sweet onion" },
      { amount: 1.0, unit: "cup", name: "panko breadcrumbs" },
      { amount: 1.0, unit: "cup", name: "ricotta cheese" },
      { amount: 1.0, unit: nil, name: "egg" },
      { amount: 2.0, unit: "tbsp", name: "harissa" },
      { amount: 1.0, unit: "tsp", name: "garlic" },
      { amount: 1.0, unit: "tsp", name: "paprika" },
      { amount: 0.5, unit: "tsp", name: "cumin" },
      { amount: 0.5, unit: "tsp", name: "salt" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 400 F. Add all the ingredients to a large bowl. Use your hands or a rubber spatula to mix until well combined (I like to use my hands and disposable kitchen gloves).",
      "Using your hands or a cookie scoop, scoop out 1 tbsp of the meat mixture (I like to use a cookie scoop that I only use for meat!) onto a greased cookie sheet. This recipe should make about 40 one tablespoon sized meatballs.",
      "Transfer to the oven and bake for 10-15 minutes, until internal temperature is at least 165 F. Add to your favorite bowl or salad and enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 400 F. Add all the ingredients to a large bowl. Use your hands or a rubber spatula to mix until well combined (I like to use my hands and disposable kitchen gloves).\nUsing your hands or a cookie scoop, scoop out 1 tbsp of the meat mixture (I like to use a cookie scoop that I only use for meat!) onto a greased cookie sheet. This recipe should make about 40 one tablespoon sized meatballs.\nTransfer to the oven and bake for 10-15 minutes, until internal temperature is at least 165 F. Add to your favorite bowl or salad and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thepalatablelife.com")
    expect(recipe.canonical_url).to eq("https://www.thepalatablelife.com/baked-harissa-chicken-meatballs/")
    expect(recipe.site_name).to eq("the palatable life")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("thepalatablelife")
    expect(recipe.description).to eq("These baked harissa chicken meatballs are so easy to make and are the perfect weeknight dinner. Plus they make the best leftovers!")
    expect(recipe.image).to eq("https://www.thepalatablelife.com/wp-content/uploads/2023/02/harissa-meatballs-scaled.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("40 servings")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to eq(10)
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
    expect(recipe.links).to include("https://www.instagram.com/reel/DdmUpUOuUsH/")
  end
end
