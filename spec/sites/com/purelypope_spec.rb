# frozen_string_literal: true

RSpec.describe "purelypope.com" do
  subject(:recipe) { scrape_cassette("com/purelypope", url: "https://purelypope.com/sweet-chili-brussel-sprouts/") }

  it "reads the title" do
    expect(recipe.title).to eq("Sweet Chili Brussel Sprouts")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups brussel sprouts, stems removed & cut in half",
      "2 tbsp coconut aminos",
      "1 tbsp sriracha",
      "1/2 tbsp maple syrup",
      "1 tsp sesame oil",
      "Everything bagel seasoning or sesame seeds, to top"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "brussel sprouts, stems removed & cut in half" },
      { amount: 2.0, unit: "tbsp", name: "coconut aminos" },
      { amount: 1.0, unit: "tbsp", name: "sriracha" },
      { amount: 0.5, unit: "tbsp", name: "maple syrup" },
      { amount: 1.0, unit: "tsp", name: "sesame oil" },
      { amount: nil, unit: nil, name: "Everything bagel seasoning or sesame seeds, to top" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Instructions",
      "Brussel Sprout Time!",
      "Preheat oven to 350 degrees.",
      "Whisk the sauce (coconut aminos, sriracha, maple syrup & sesame oil) together in a large bowl.",
      "Toss in brussel sprouts and coat mixture evenly over the brussels.",
      "Roast for 30 minutes.",
      "Turn oven to broil for 2-3 minutes to crisp (watch carefully to not burn.)",
      "Top with everything or sesame seeds."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Instructions\nBrussel Sprout Time!\nPreheat oven to 350 degrees.\nWhisk the sauce (coconut aminos, sriracha, maple syrup & sesame oil) together in a large bowl.\nToss in brussel sprouts and coat mixture evenly over the brussels.\nRoast for 30 minutes.\nTurn oven to broil for 2-3 minutes to crisp (watch carefully to not burn.)\nTop with everything or sesame seeds.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("purelypope.com")
    expect(recipe.canonical_url).to eq("https://purelypope.com/sweet-chili-brussel-sprouts/")
    expect(recipe.site_name).to eq("PurelyPope")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("There is nothing better than a well cooked batch of brussel sprouts! These sweet chili brussel sprouts are packed with flavor and nutritious, too!")
    expect(recipe.image).to eq("https://i0.wp.com/purelypope.com/wp-content/uploads/2020/05/IMG_5412-1-scaled.jpg?resize=150%2C150&ssl=1")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(32)
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
    expect(recipe.links).to include("#")
  end
end
