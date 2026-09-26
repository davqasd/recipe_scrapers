# frozen_string_literal: true

RSpec.describe "wearenotmartha.com" do
  subject(:recipe) { scrape_cassette("com/wearenotmartha", url: "https://wearenotmartha.com/starbucks-grilled-cheese-copycat-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Starbucks Grilled Cheese {Copycat Recipe}")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 1/2 Tbsp salted or unsalted butter, (softened)",
      "1 Tbsp finely grated parmesan cheese",
      "1/8 tsp garlic powder",
      "Pinch salt, (if butter is unsalted)",
      "4 slices sourdough bread",
      "2 oz sliced white cheddar cheese",
      "2 oz sliced mozzarella cheese"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.5, unit: "Tbsp", name: "salted or unsalted butter" },
      { amount: 1.0, unit: "Tbsp", name: "finely grated parmesan cheese" },
      { amount: 0.13, unit: "tsp", name: "garlic powder" },
      { amount: 1.0, unit: "Pinch", name: "salt" },
      { amount: 4.0, unit: "slices", name: "sourdough bread" },
      { amount: 2.0, unit: "oz", name: "sliced white cheddar cheese" },
      { amount: 2.0, unit: "oz", name: "sliced mozzarella cheese" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a small bowl, mix together softened butter, parmesan, garlic powder, and salt (if using unsalted butter) until combined.",
      "Preheat a griddle or large skillet over medium-low heat.",
      "Spread butter mixture onto one side of all four slices of bread. Top the non-buttered sides of two of the bread slices with cheese. Press remaining bread slices, butter-side up, on top.",
      "Transfer sandwiches to griddle or skillet and cook until golden on bottom, about 5 minutes. Flip and cook until sandwiches are golden on second side and cheese is melted.",
      "Slice and serve."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a small bowl, mix together softened butter, parmesan, garlic powder, and salt (if using unsalted butter) until combined.\nPreheat a griddle or large skillet over medium-low heat.\nSpread butter mixture onto one side of all four slices of bread. Top the non-buttered sides of two of the bread slices with cheese. Press remaining bread slices, butter-side up, on top.\nTransfer sandwiches to griddle or skillet and cook until golden on bottom, about 5 minutes. Flip and cook until sandwiches are golden on second side and cheese is melted.\nSlice and serve.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("wearenotmartha.com")
    expect(recipe.canonical_url).to eq("https://wearenotmartha.com/starbucks-grilled-cheese-copycat-recipe/")
    expect(recipe.site_name).to eq("We are not Martha")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Sues")
    expect(recipe.description).to eq("Are you obsessed with the grilled cheese sandwich at Starbucks? It's made with a blend of white cheddar, mozzarella, and garlic parmesan butter and is so easy to recreate at home with this Starbucks Grilled Cheese copycat recipe!")
    expect(recipe.image).to eq("https://wearenotmartha.com/wp-content/uploads/starbucks-grilled-cheese-featured.jpg")
    expect(recipe.category).to eq("lunch")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq(["Grilled Cheese Recipes", "Starbucks Copycat"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(3)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://wearenotmartha.com/")
  end
end
