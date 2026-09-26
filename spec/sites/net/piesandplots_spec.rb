# frozen_string_literal: true

RSpec.describe "piesandplots.net" do
  subject(:recipe) { scrape_cassette("net/piesandplots", url: "https://piesandplots.net/sticky-toffee-banana-bread/") }

  it "reads the title" do
    expect(recipe.title).to eq("Sticky Toffee Banana Bread")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 cups paleo flour blend (2 cups almond flour, 1 ¼ cups tapioca starch, ¾ cup coconut flour)",
      "2 teaspoons baking soda",
      "1 tablespoon ground cinnamon",
      "½ teaspoon ground cardamom",
      "2 teaspoons espresso powder",
      "2 teaspoons vanilla bean powder",
      "¼ cup maple sugar",
      "¼ cup pure maple syrup, plus 1/3 cup pure maple syrup",
      "2/3 cup coconut sugar",
      "1 cup olive oil",
      "4 large eggs",
      "7 overripe bananas, mashed",
      "1 cup dates, pitted and chopped"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "cups", name: "paleo flour blend" },
      { amount: 2.0, unit: "teaspoons", name: "baking soda" },
      { amount: 1.0, unit: "tablespoon", name: "ground cinnamon" },
      { amount: 0.5, unit: "teaspoon", name: "ground cardamom" },
      { amount: 2.0, unit: "teaspoons", name: "espresso powder" },
      { amount: 2.0, unit: "teaspoons", name: "vanilla bean powder" },
      { amount: 0.25, unit: "cup", name: "maple sugar" },
      { amount: 0.25, unit: "cup", name: "pure maple syrup, plus 1/3 cup pure maple syrup" },
      { amount: 0.67, unit: "cup", name: "coconut sugar" },
      { amount: 1.0, unit: "cup", name: "olive oil" },
      { amount: 4.0, unit: nil, name: "large eggs" },
      { amount: 7.0, unit: nil, name: "overripe bananas, mashed" },
      { amount: 1.0, unit: "cup", name: "dates, pitted and chopped" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 350 degrees F/ 325 degrees F convection. Oil 2 loaf pans or use oven safe bowls or ramekins.",
      "In a large bowl, stir together sugars, ¼ cup syrup, and olive oil until combined. Stir in the eggs one at a time, followed by the vanilla, espresso, cinnamon, cardamom, baking soda, and flour. Finish the batter with the bananas and dates, stirring until combined.",
      "Divide among the baking vessels and bake 50-60 minutes until a toothpick comes out clean or with a few crumbs. Immediately drizzle with the remaining 1/3 cup maple syrup and allow to cool in the pan before slicing and serving. Bread may be stored in an airtight container at room temperature for up to 4 days or frozen, wrapped in parchment and foil and placed in a zipper bag, for up to 3 months. Thaw in the microwave about 30 seconds."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 350 degrees F/ 325 degrees F convection. Oil 2 loaf pans or use oven safe bowls or ramekins.\nIn a large bowl, stir together sugars, ¼ cup syrup, and olive oil until combined. Stir in the eggs one at a time, followed by the vanilla, espresso, cinnamon, cardamom, baking soda, and flour. Finish the batter with the bananas and dates, stirring until combined.\nDivide among the baking vessels and bake 50-60 minutes until a toothpick comes out clean or with a few crumbs. Immediately drizzle with the remaining 1/3 cup maple syrup and allow to cool in the pan before slicing and serving. Bread may be stored in an airtight container at room temperature for up to 4 days or frozen, wrapped in parchment and foil and placed in a zipper bag, for up to 3 months. Thaw in the microwave about 30 seconds.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("piesandplots.net")
    expect(recipe.canonical_url).to eq("https://piesandplots.net/sticky-toffee-banana-bread/")
    expect(recipe.site_name).to eq("Pies and Plots")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Laura")
    expect(recipe.description).to eq("Sticky toffee pudding and banana bread combined into one irresistible breakfast, snack, or dessert.")
    expect(recipe.image).to eq("https://piesandplots.net/wp-content/uploads/2024/05/sticky-hand-225x225.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("16 servings")
    expect(recipe.total_time).to eq(75)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(60)
    expect(recipe.keywords).to be_nil
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
    expect(recipe.links).to include("https://piesandplots.net/")
  end
end
