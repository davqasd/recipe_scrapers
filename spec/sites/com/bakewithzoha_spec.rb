# frozen_string_literal: true

RSpec.describe "bakewithzoha.com" do
  subject(:recipe) { scrape_cassette("com/bakewithzoha", url: "https://bakewithzoha.com/molten-lava-chocolate-mug-cake/") }

  it "reads the title" do
    expect(recipe.title).to eq("BEST MOLTEN LAVA MUG CAKE RECIPE")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 tbsp butter",
      "1 oz dark chocolate",
      "3 tbsp milk",
      "2 tbsp sugar",
      "4 tbsp flour",
      "1 tbsp cocoa powder",
      "1/3 tsp baking powder",
      "Pinch of salt",
      "1-2 chocolate truffles in the middle (I use Lindt dark chocolate)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "tbsp", name: "butter" },
      { amount: 1.0, unit: "oz", name: "dark chocolate" },
      { amount: 3.0, unit: "tbsp", name: "milk" },
      { amount: 2.0, unit: "tbsp", name: "sugar" },
      { amount: 4.0, unit: "tbsp", name: "flour" },
      { amount: 1.0, unit: "tbsp", name: "cocoa powder" },
      { amount: 0.33, unit: "tsp", name: "baking powder" },
      { amount: 1.0, unit: "Pinch", name: "salt" },
      { amount: 1.0, unit: nil, name: "chocolate truffles in the middle" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "To a 10-12oz microwave safe mug, add the butter and 1 oz chocolate, and microwave in 15 second increments until molten and combined",
      "Add the milk and stir to combine",
      "Add the sugar and stir in",
      "Sift in the dry ingredients (flour, cocoa powder, baking powder and salt) and stir. Scrape the edges and bottom of the cup so no flour gets stuck there",
      "Dunk the chocolate truffle(s) in the middle (no need to push all the way down)",
      "Microwave on high for 60-70 seconds",
      "Dust with powdered sugar, and enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("To a 10-12oz microwave safe mug, add the butter and 1 oz chocolate, and microwave in 15 second increments until molten and combined\nAdd the milk and stir to combine\nAdd the sugar and stir in\nSift in the dry ingredients (flour, cocoa powder, baking powder and salt) and stir. Scrape the edges and bottom of the cup so no flour gets stuck there\nDunk the chocolate truffle(s) in the middle (no need to push all the way down)\nMicrowave on high for 60-70 seconds\nDust with powdered sugar, and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("bakewithzoha.com")
    expect(recipe.canonical_url).to eq("https://bakewithzoha.com/molten-lava-chocolate-mug-cake/")
    expect(recipe.site_name).to eq("BAKE WITH ZOHA")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Zoha Malik")
    expect(recipe.description).to eq("This molten lava mug cake comes together in 5 minutes and is almost as good as the real thing!")
    expect(recipe.image).to eq("https://bakewithzoha.com/wp-content/uploads/2023/09/Molten-lava-chocolate-mug-cake-featured-225x225.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("1 servings")
    expect(recipe.total_time).to eq(5)
    expect(recipe.prep_time).to eq(4)
    expect(recipe.cook_time).to eq(1)
    expect(recipe.keywords).to eq(["Molten Lava Mug Cake"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.7)
    expect(recipe.ratings_count).to eq(20)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
