# frozen_string_literal: true

RSpec.describe "finedininglovers.com" do
  subject(:recipe) { scrape_cassette("com/finedininglovers", url: "https://www.finedininglovers.com/recipes/main-course/zucchini-raw-vegan-lasagna") }

  it "reads the title" do
    expect(recipe.title).to eq("Zucchini Raw Vegan Lasagna")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "Zucchini: 4 each. large",
      "Basil: 20 g. fresh",
      "Pine nuts: 70 g",
      "Extra virgin olive oil: 120 ml",
      "Yeast flakes: 6 g",
      "Garlic: 1/2 clove",
      "Salt: 1 pinch",
      "Tomatoes: 200 g",
      "Sun dried tomatoes: 4 each",
      "Extra virgin olive oil: 30 ml",
      "Salt: 1 pinch",
      "Pepper: 1 pinch",
      "Brown sugar: 1 pinch",
      "Oregano: to taste",
      "Macadamia nuts: 150 g (not roasted. unsalted)",
      "Yeast flakes: 6 g",
      "Salt: 1 pinch",
      "Limes: 1 (juice only. filtered)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: "each", name: "Zucchini, large" },
      { amount: 20.0, unit: "g", name: "Basil, fresh" },
      { amount: 70.0, unit: "g", name: "Pine nuts" },
      { amount: 120.0, unit: "ml", name: "Extra virgin olive oil" },
      { amount: 6.0, unit: "g", name: "Yeast flakes" },
      { amount: 0.5, unit: "clove", name: "Garlic" },
      { amount: 1.0, unit: "pinch", name: "Salt" },
      { amount: 200.0, unit: "g", name: "Tomatoes" },
      { amount: 4.0, unit: "each", name: "Sun dried tomatoes" },
      { amount: 30.0, unit: "ml", name: "Extra virgin olive oil" },
      { amount: 1.0, unit: "pinch", name: "Salt" },
      { amount: 1.0, unit: "pinch", name: "Pepper" },
      { amount: 1.0, unit: "pinch", name: "Brown sugar" },
      { amount: nil, unit: nil, name: "Oregano: to taste" },
      { amount: 150.0, unit: "g", name: "Macadamia nuts" },
      { amount: 6.0, unit: "g", name: "Yeast flakes" },
      { amount: 1.0, unit: "pinch", name: "Salt" },
      { amount: 1.0, unit: nil, name: "Limes" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "For the macadamia cheese",
      "Pour all ingredients in a blender and mix until a thick cream.Set aside.",
      "For the tomato cream",
      "Pour all ingredients into a blender and mix until creamy.Set aside.",
      "For the basil pesto",
      "[\"Pour all ingredients into a blender and mix until creamy. Set aside.Wash zucchini and cut them into very thin slices.Make the raw vegan lasagna alternating a layer of zucchini\", \"a layer of macadamia cheese\", \"a layer of zucchini\", \"a layer of tomato sauce\", \"a layer of zucchini\", \"a layer of basil pesto.Keep the lasagna in the fridge and serve decorated with fresh basil and pine nuts.\"]"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("For the macadamia cheese\nPour all ingredients in a blender and mix until a thick cream.Set aside.\nFor the tomato cream\nPour all ingredients into a blender and mix until creamy.Set aside.\nFor the basil pesto\n[\"Pour all ingredients into a blender and mix until creamy. Set aside.Wash zucchini and cut them into very thin slices.Make the raw vegan lasagna alternating a layer of zucchini\", \"a layer of macadamia cheese\", \"a layer of zucchini\", \"a layer of tomato sauce\", \"a layer of zucchini\", \"a layer of basil pesto.Keep the lasagna in the fridge and serve decorated with fresh basil and pine nuts.\"]")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("finedininglovers.com")
    expect(recipe.canonical_url).to eq("https://www.finedininglovers.com/explore/recipes/zucchini-raw-vegan-lasagna")
    expect(recipe.site_name).to eq("Fine Dining Lovers")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Uno Cookbook")
    expect(recipe.description).to eq("An easy raw vegan lasagna recipe made with zucchini, basil pesto and macadamia cheese: a tasty dish, perfect whether you follow a vegan or a raw food diet. Yum!")
    expect(recipe.image).to eq("https://www.finedininglovers.com/sites/default/files/recipe_content_images/Original_2242_zucchini-lasagna-raw-vegan.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("1 servings")
    expect(recipe.total_time).to eq(50)
    expect(recipe.prep_time).to eq(50)
    expect(recipe.cook_time).to be_nil
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
    expect(recipe.links).to include("#main-content")
  end
end
