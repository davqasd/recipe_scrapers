# frozen_string_literal: true

RSpec.describe "corriecooks.com" do
  subject(:recipe) { scrape_cassette("com/corriecooks", url: "https://www.corriecooks.com/keto-instant-pot-recipes/") }

  it "reads the title" do
    expect(recipe.title).to eq("5 Best Keto Instant Pot Recipes")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "Instant Pot London Broil",
      "Instant Pot Egg Roll in a Bowl",
      "Instant Pot Chicken Tikka Masala",
      "Instant Pot Turkey Chili",
      "Instant Pot Whole Chicken",
      "Instant Pot Chicken Drumsticks",
      "Instant Pot Chicken Livers",
      "Instant Pot Egg Bites"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "Instant Pot London Broil" },
      { amount: nil, unit: nil, name: "Instant Pot Egg Roll in a Bowl" },
      { amount: nil, unit: nil, name: "Instant Pot Chicken Tikka Masala" },
      { amount: nil, unit: nil, name: "Instant Pot Turkey Chili" },
      { amount: nil, unit: nil, name: "Instant Pot Whole Chicken" },
      { amount: nil, unit: nil, name: "Instant Pot Chicken Drumsticks" },
      { amount: nil, unit: nil, name: "Instant Pot Chicken Livers" },
      { amount: nil, unit: nil, name: "Instant Pot Egg Bites" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Choose your favorite keto recipe.",
      "Get all the required ingredients.",
      "Make an easy Instant Pot ketogenic recipe."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Choose your favorite keto recipe.\nGet all the required ingredients.\nMake an easy Instant Pot ketogenic recipe.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("corriecooks.com")
    expect(recipe.canonical_url).to eq("https://www.corriecooks.com/keto-instant-pot-recipes/")
    expect(recipe.site_name).to eq("Corrie Cooks")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Corrie")
    expect(recipe.description).to eq("You can easily make keto-friendly delicious dishes in your Instant Pot.")
    expect(recipe.image).to eq("https://www.corriecooks.com/wp-content/uploads/2021/03/Keto-Instant-Pot-Recipes.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(22)
    expect(recipe.prep_time).to eq(7)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["gluten free", "keto", "ketogenic"])
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
    expect(recipe.links).to include("#recipe")
  end
end
