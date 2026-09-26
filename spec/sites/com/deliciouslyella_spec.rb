# frozen_string_literal: true

RSpec.describe "deliciouslyella.com" do
  subject(:recipe) { scrape_cassette("com/deliciouslyella", url: "https://www.deliciouslyella.com/recipes/creamy-kale-and-sweet-potato-salad/") }

  it "reads the title" do
    expect(recipe.title).to eq("Creamy Kale & Sweet Potato Salad")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 sweet potatoes",
      "8.5 oz canned chickpeas",
      "1 teaspoon ground cumin",
      "1 teaspoon paprika",
      "7 oz kale",
      "handful of parsley",
      "pinch of dried red chilli flakes",
      "drizzle of olive oil",
      "pinch of sea salt & black pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "sweet potatoes" },
      { amount: 8.5, unit: "oz", name: "canned chickpeas" },
      { amount: 1.0, unit: "teaspoon", name: "ground cumin" },
      { amount: 1.0, unit: "teaspoon", name: "paprika" },
      { amount: 7.0, unit: "oz", name: "kale" },
      { amount: 1.0, unit: "handful", name: "parsley" },
      { amount: 1.0, unit: "pinch", name: "dried red chilli flakes" },
      { amount: 1.0, unit: "drizzle", name: "olive oil" },
      { amount: 1.0, unit: "pinch", name: "sea salt & black pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 190°C fan / 375°F. Place the sweet potato chunks and drained chickpeas on a baking tray and drizzle with olive oil, cumin, paprika and a pinch of salt. Mix well and roast for 30–35 minutes until the sweet potatoes begin to soften.",
      "While they cook, make the dressing. Place all of the dressing ingredients into a powerful blender and blitz until smooth.",
      "Place the kale into a large mixing bowl; add a drizzle of olive oil and a sprinkling of salt. Massage the kale with your hands for a few minutes, really rubbing the leaves until the kale is nice and soft. When ready, pour over the dressing and gently rub it into the kale, again using your hands.",
      "Once the sweet potatoes and chickpeas are cooked, remove from the oven. Allow to cool for a few minutes and then toss through the kale. Transfer to a serving bowl and finish with fresh parsley, a crack of black pepper and a pinch of chilli flakes."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 190°C fan / 375°F. Place the sweet potato chunks and drained chickpeas on a baking tray and drizzle with olive oil, cumin, paprika and a pinch of salt. Mix well and roast for 30–35 minutes until the sweet potatoes begin to soften.\nWhile they cook, make the dressing. Place all of the dressing ingredients into a powerful blender and blitz until smooth.\nPlace the kale into a large mixing bowl; add a drizzle of olive oil and a sprinkling of salt. Massage the kale with your hands for a few minutes, really rubbing the leaves until the kale is nice and soft. When ready, pour over the dressing and gently rub it into the kale, again using your hands.\nOnce the sweet potatoes and chickpeas are cooked, remove from the oven. Allow to cool for a few minutes and then toss through the kale. Transfer to a serving bowl and finish with fresh parsley, a crack of black pepper and a pinch of chilli flakes.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("deliciouslyella.com")
    expect(recipe.canonical_url).to eq("https://www.deliciouslyella.com/recipes/creamy-kale-and-sweet-potato-salad/")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Deliciously Ella")
    expect(recipe.description).to eq("Sweet potatoes and chickpeas are roasted with paprika and cumin, then tossed through kale with a creamy cashew dressing and finished with a sprinkling of parsley, chilli flakes and black pepper — simple, creamy and delicious.")
    expect(recipe.image).to eq("https://images.ctfassets.net/8ffyq0lxv9d2/3N5caHD03AfEq8k7Me0DYF/27a5316c0466144f918e5e0fc534c93c/kale_salad.jpg")
    expect(recipe.category).to eq("Mains")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(35)
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
    expect(recipe.links).to include("/cart")
  end
end
