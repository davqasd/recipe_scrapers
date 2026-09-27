# frozen_string_literal: true

RSpec.describe "177milkstreet.com" do
  subject(:recipe) { scrape_cassette("com/177milkstreet", url: "https://www.177milkstreet.com/recipes/romanian-apple-pie-cinnamon-walnuts") }

  it "reads the title" do
    expect(recipe.title).to eq("Romanian Apple Pie with Cinnamon and Walnuts (Plăcintă cu Mere)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "60 grams (¼ cup) cold sour cream",
      "2 tablespoons ice water",
      "195 grams (1½ cups) all-purpose flour, plus more for dusting",
      "... and more. Sign up for full access to all ingredients and instructions."
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 60.0, unit: "grams", name: "cold sour cream" },
      { amount: 2.0, unit: "tablespoons", name: "ice water" },
      { amount: 195.0, unit: "grams", name: "all-purpose flour, plus more for dusting" },
      { amount: nil, unit: nil, name: "and more. Sign up for full access to all ingredients and instructions." }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "To make the dough, in a small bowl or liquid measuring cup, stir together the sour cream and ice water. In a food processor, combine the flour, sugar, baking powder and salt; pulse to combine. Scatter in the butter and pulse until the mixture resembles coarse sand with pebbly bits, 10 to 12 pulses. Drizzle in the sour cream mixture, then pulse until the mixture is curdy in appearance and clumps together, with no dry patches remaining, 20 to 30 pulses."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("To make the dough, in a small bowl or liquid measuring cup, stir together the sour cream and ice water. In a food processor, combine the flour, sugar, baking powder and salt; pulse to combine. Scatter in the butter and pulse until the mixture resembles coarse sand with pebbly bits, 10 to 12 pulses. Drizzle in the sour cream mixture, then pulse until the mixture is curdy in appearance and clumps together, with no dry patches remaining, 20 to 30 pulses.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("177milkstreet.com")
    expect(recipe.canonical_url).to eq("https://www.177milkstreet.com/recipes/romanian-apple-pie-cinnamon-walnuts")
    expect(recipe.site_name).to eq("Christopher Kimball’s Milk Street")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Rose Hattabaugh")
    expect(recipe.description).to eq("Cookbook author Irina Georgescu introduced us to Romanian plăcintă cu mere, a hybrid of slab-style apple pie bar cookie.")
    expect(recipe.image).to eq("https://images.177milkstreet.com/production/06d661c8d1f2efc6d2b9e01d8182c83b78f0f2ab-1920x1080.jpg?rect=420,0,1080,1080&w=800&h=800&q=80&auto=format")
    expect(recipe.category).to eq("Desserts, Cakes")
    expect(recipe.cuisine).to eq("Eastern European")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(135)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(135)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
