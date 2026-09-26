# frozen_string_literal: true

RSpec.describe "motherthyme.com" do
  subject(:recipe) { scrape_cassette("com/motherthyme", url: "https://www.motherthyme.com/2014/01/cinnamon-roll-oatmeal.html") }

  it "reads the title" do
    expect(recipe.title).to eq("Cinnamon Roll Oatmeal")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 3/4 cup milk",
      "2 tablespoons brown sugar",
      "1 tablespoon sugar",
      "1/2 teaspoon vanilla extract",
      "1/4 teaspoon salt",
      "1 1/2 cups old-fashioned rolled oats",
      "Topping",
      "2 tablespoons butter (melted)",
      "3 tablespoons packed light brown sugar",
      "1 1/2 teaspoons cinnamon",
      "Glaze",
      "1 ounce cream cheese (softened)",
      "1 tablespoon milk",
      "1/8 teaspoon vanilla extract",
      "5 tablespoons confectioners’ sugar"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.75, unit: "cup", name: "milk" },
      { amount: 2.0, unit: "tablespoons", name: "brown sugar" },
      { amount: 1.0, unit: "tablespoon", name: "sugar" },
      { amount: 0.5, unit: "teaspoon", name: "vanilla extract" },
      { amount: 0.25, unit: "teaspoon", name: "salt" },
      { amount: 1.5, unit: "cups", name: "old-fashioned rolled oats" },
      { amount: nil, unit: nil, name: "Topping" },
      { amount: 2.0, unit: "tablespoons", name: "butter" },
      { amount: 3.0, unit: "tablespoons", name: "packed light brown sugar" },
      { amount: 1.5, unit: "teaspoons", name: "cinnamon" },
      { amount: nil, unit: nil, name: "Glaze" },
      { amount: 1.0, unit: "ounce", name: "cream cheese" },
      { amount: 1.0, unit: "tablespoon", name: "milk" },
      { amount: 0.13, unit: "teaspoon", name: "vanilla extract" },
      { amount: 5.0, unit: "tablespoons", name: "confectioners’ sugar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large saucepan add milk, sugars, vanilla and salt and bring to a boil over medium heat.",
      "Stir in oats, return to a boil and continue to cook, stirring occasionally for 3-5 minutes until oatmeal begins to thicken.",
      "Cover and remove from heat. Let sit for about 3 minutes.",
      "In a small bowl mix butter, brown sugar and cinnamon until combined.",
      "Microwave cream cheese in a small bowl for about 10 seconds until just melted.",
      "Stir in confectioners’ sugar until combined.",
      "Stir in milk and vanilla until creamy.",
      "Note",
      "Add in a little more confectioners’ sugar if glaze is too thin or a little more milk if glaze is too thick until desired consistency.",
      "Place desired amount of oatmeal in serving bowl. Drizzle with some of the cinnamon sugar topping and then drizzle on top of that some of the cream cheese glaze.",
      "Serve warm."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large saucepan add milk, sugars, vanilla and salt and bring to a boil over medium heat.\nStir in oats, return to a boil and continue to cook, stirring occasionally for 3-5 minutes until oatmeal begins to thicken.\nCover and remove from heat. Let sit for about 3 minutes.\nIn a small bowl mix butter, brown sugar and cinnamon until combined.\nMicrowave cream cheese in a small bowl for about 10 seconds until just melted.\nStir in confectioners’ sugar until combined.\nStir in milk and vanilla until creamy.\nNote\nAdd in a little more confectioners’ sugar if glaze is too thin or a little more milk if glaze is too thick until desired consistency.\nPlace desired amount of oatmeal in serving bowl. Drizzle with some of the cinnamon sugar topping and then drizzle on top of that some of the cream cheese glaze.\nServe warm.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("motherthyme.com")
    expect(recipe.canonical_url).to eq("https://www.motherthyme.com/2014/01/cinnamon-roll-oatmeal.html")
    expect(recipe.site_name).to eq("Mother Thyme")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jenn (Mother Thyme)")
    expect(recipe.description).to eq("Start your morning with a warm bowl of Cinnamon Roll Oatmeal that is topped with cinnamon sugar and a cream cheese glaze. Quick and Easy Blackberry Cinnamon Rolls Pumpkin Cinnamon Rolls")
    expect(recipe.image).to eq("https://www.motherthyme.com/wp-content/uploads/2014/01/cinnamonoatmeal1-225x225.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.9)
    expect(recipe.ratings_count).to eq(26)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
