# frozen_string_literal: true

RSpec.describe "blogghetti.com" do
  subject(:recipe) { scrape_cassette("com/blogghetti", url: "https://blogghetti.com/nutter-butter-love-bug-cookies/") }

  it "reads the title" do
    expect(recipe.title).to eq("Nutter Butter Love Bug Cookies")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "12 Nutter Butter Cookies",
      "1 cup white candy melts",
      "1 cup pink candy melts",
      "2 teaspoons red, white, and pink sprinkles",
      "6 pretzel sticks, broken in half",
      "12 edible candy eyes",
      "6 mini chocolate chips",
      "6 pink M&Ms",
      "6 jumbo red hearts sprinkles"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 12.0, unit: nil, name: "Nutter Butter Cookies" },
      { amount: 1.0, unit: "cup", name: "white candy melts" },
      { amount: 1.0, unit: "cup", name: "pink candy melts" },
      { amount: 2.0, unit: "teaspoons", name: "red, white, and pink sprinkles" },
      { amount: 6.0, unit: nil, name: "pretzel sticks, broken in half" },
      { amount: 12.0, unit: nil, name: "edible candy eyes" },
      { amount: 6.0, unit: nil, name: "mini chocolate chips" },
      { amount: 6.0, unit: nil, name: "pink M&Ms" },
      { amount: 6.0, unit: nil, name: "jumbo red hearts sprinkles" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Tip: work in small batches so the candy melts stay easy to handle.",
      "Prepare your workspace: Line a baking sheet or tray with parchment paper to keep cookies from sticking and make cleanup easier.",
      "Melt the candy melts: In separate microwave-safe bowls, melt the pink and white candy melts in 30-second intervals, stirring in between until smooth.",
      "Coat the cookies: Dip one completely in pink candy melts, tap off excess, and place on the parchment. Sprinkle the sides with red, white, and pink sprinkles, leaving the center clear for stacking.",
      "Assemble the body: Coat another cookie in white candy melts and gently place it crosswise on top of the pink-coated one to create the “love bug” body. Press lightly so it sticks without breaking.",
      "Add the finishing touches: Insert pretzel halves for antennae, place candy eyes above a mini chocolate chip nose, and add pink M&Ms or heart sprinkles near the bottom for accents."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Tip: work in small batches so the candy melts stay easy to handle.\nPrepare your workspace: Line a baking sheet or tray with parchment paper to keep cookies from sticking and make cleanup easier.\nMelt the candy melts: In separate microwave-safe bowls, melt the pink and white candy melts in 30-second intervals, stirring in between until smooth.\nCoat the cookies: Dip one completely in pink candy melts, tap off excess, and place on the parchment. Sprinkle the sides with red, white, and pink sprinkles, leaving the center clear for stacking.\nAssemble the body: Coat another cookie in white candy melts and gently place it crosswise on top of the pink-coated one to create the “love bug” body. Press lightly so it sticks without breaking.\nAdd the finishing touches: Insert pretzel halves for antennae, place candy eyes above a mini chocolate chip nose, and add pink M&Ms or heart sprinkles near the bottom for accents.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("blogghetti.com")
    expect(recipe.canonical_url).to eq("https://blogghetti.com/nutter-butter-love-bug-cookies/")
    expect(recipe.site_name).to eq("Blogghetti")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Lisa Kerhin")
    expect(recipe.description).to eq("Love Bug Cookies are a cute no-bake peanut butter treat recipe made with candy melts and simple decorations that are fun to assemble and easy to share.")
    expect(recipe.image).to eq("https://blogghetti.com/wp-content/uploads/2026/01/feature-image-for-nutter-butter-love-bug-cookies.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["love bug cookies", "nutter butter cookies"])
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
    expect(recipe.links).to include("#main")
  end
end
