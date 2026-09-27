# frozen_string_literal: true

RSpec.describe "loveandlemons.com" do
  subject(:recipe) { scrape_cassette("com/loveandlemons", url: "https://www.loveandlemons.com/best-green-smoothie-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Best Green Smoothie")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 frozen banana",
      "big handfuls fresh baby spinach, about 2 cups",
      "¼ cup fresh mint, about 10 leaves",
      "2 tablespoons almond butter",
      "2 ice cubes",
      "¼ teaspoon good vanilla extract",
      "¾ cup Almond Breeze Almondmilk Cashewmilk, more as needed"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "frozen banana" },
      { amount: 1.0, unit: "handfuls", name: "fresh baby spinach, about 2 cups" },
      { amount: 0.25, unit: "cup", name: "fresh mint, about 10 leaves" },
      { amount: 2.0, unit: "tablespoons", name: "almond butter" },
      { amount: 2.0, unit: nil, name: "ice cubes" },
      { amount: 0.25, unit: "teaspoon", name: "good vanilla extract" },
      { amount: 0.75, unit: "cup", name: "Almond Breeze Almondmilk Cashewmilk, more as needed" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a blender, combine the banana, spinach, mint leaves, almond butter, ice, vanilla and cashew milk. Blend until smooth. Add more cashew milk as needed for desired consistency.",
      "Pour into glasses and serve."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a blender, combine the banana, spinach, mint leaves, almond butter, ice, vanilla and cashew milk. Blend until smooth. Add more cashew milk as needed for desired consistency.\nPour into glasses and serve.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("loveandlemons.com")
    expect(recipe.canonical_url).to eq("https://www.loveandlemons.com/best-green-smoothie-recipe/")
    expect(recipe.site_name).to eq("Love and Lemons")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jeanine Donofrio")
    expect(recipe.description).to eq("This green smoothie recipe isn't just healthy - it's delicious, too! It's a great vegan and gluten-free breakfast or afternoon snack.")
    expect(recipe.image).to eq("https://cdn.loveandlemons.com/wp-content/uploads/2016/03/IMG_2093-cropped-3-1.jpg")
    expect(recipe.category).to eq("Smoothie")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(5)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["green smoothie", "spring", "summer", "winter"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(5)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#comment-583299")
  end
end
