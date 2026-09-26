# frozen_string_literal: true

RSpec.describe "amberskitchencooks.com" do
  subject(:recipe) { scrape_cassette("com/amberskitchencooks", url: "https://amberskitchencooks.com/orange-avocado-salad/") }

  it "reads the title" do
    expect(recipe.title).to eq("Orange Avocado Salad")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1/4 cup extra virgin olive oil",
      "2 Tablespoons Balsamic vinegar (I’m using @bakerandolive peach balsamic for extra sweetness and flavor)",
      "1 teaspoon yellow mustard",
      "Salt and pepper to taste",
      "1/2 cucumber (finely diced into little cubes)",
      "1/4 of a red onion (finely diced)",
      "1 orange (diced (I love Cara Cara oranges!))",
      "1 large ripe avocado (diced)",
      "3/4 cup 4 oz. pine nuts",
      "4 oz. Goat cheese (crumbled into chunks)",
      "3 oz. Arugula (or a few big handfuls)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.25, unit: "cup", name: "extra virgin olive oil" },
      { amount: 2.0, unit: "Tablespoons", name: "Balsamic vinegar" },
      { amount: 1.0, unit: "teaspoon", name: "yellow mustard" },
      { amount: nil, unit: nil, name: "Salt and pepper to taste" },
      { amount: 0.5, unit: nil, name: "cucumber" },
      { amount: 0.25, unit: nil, name: "red onion" },
      { amount: 1.0, unit: nil, name: "orange" },
      { amount: 1.0, unit: nil, name: "large ripe avocado" },
      { amount: 0.75, unit: "cup", name: "pine nuts" },
      { amount: 4.0, unit: "oz", name: "Goat cheese" },
      { amount: 3.0, unit: "oz", name: "Arugula" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large bowl, combine the olive oil, vinegar, mustard, salt and pepper. Mix together.",
      "In a skillet, toast pine nuts.",
      "To the bowl, add the diced cucumber, red onion, avocado, orange, pine nuts, goat cheese and arugula. Toss into the dressing at the bottom of the bowl.",
      "Enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large bowl, combine the olive oil, vinegar, mustard, salt and pepper. Mix together.\nIn a skillet, toast pine nuts.\nTo the bowl, add the diced cucumber, red onion, avocado, orange, pine nuts, goat cheese and arugula. Toss into the dressing at the bottom of the bowl.\nEnjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("amberskitchencooks.com")
    expect(recipe.canonical_url).to eq("https://amberskitchencooks.com/orange-avocado-salad/")
    expect(recipe.site_name).to eq("Ambers Kitchen Cooks")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Lindsay Steele")
    expect(recipe.description).to eq("A delicious combination of oranges, avocado, and goat cheese served over arugula and tossed with a balsamic vinaigrette.")
    expect(recipe.image).to eq("https://amberskitchencooks.com/wp-content/uploads/2025/01/IMG_0771.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(4)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#x-main")
  end
end
