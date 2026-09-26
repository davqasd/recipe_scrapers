# frozen_string_literal: true

RSpec.describe "nutritionfacts.org" do
  subject(:recipe) { scrape_cassette("org/nutritionfacts", url: "https://nutritionfacts.org/recipe/sweet-potato-taquitos/") }

  it "reads the title" do
    expect(recipe.title).to eq("Sweet Potato Taquitos")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2½ -3 cups chopped sweet potatoes (about 1 large or 2 medium sweet potatoes)",
      "1 cup chopped carrots (about 3 medium carrots)",
      "3 cloves garlic, minced",
      "1 cup chopped red onion",
      "1½ cups cooked black beans",
      "1 teaspoon chili powder",
      "½ teaspoon onion powder",
      "½ teaspoon paprika or smoked paprika",
      "½ teaspoon ground turmeric",
      "¼ teaspoon black pepper",
      "12-14 small corn tortillas",
      "Cashew Cream (optional)",
      "Avocado (optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.5, unit: "cups", name: "chopped sweet potatoes" },
      { amount: 1.0, unit: "cup", name: "chopped carrots" },
      { amount: 3.0, unit: "cloves", name: "garlic, minced" },
      { amount: 1.0, unit: "cup", name: "chopped red onion" },
      { amount: 1.5, unit: "cups", name: "cooked black beans" },
      { amount: 1.0, unit: "teaspoon", name: "chili powder" },
      { amount: 0.5, unit: "teaspoon", name: "onion powder" },
      { amount: 0.5, unit: "teaspoon", name: "paprika or smoked paprika" },
      { amount: 0.5, unit: "teaspoon", name: "ground turmeric" },
      { amount: 0.25, unit: "teaspoon", name: "black pepper" },
      { amount: 12.0, unit: nil, name: "small corn tortillas" },
      { amount: nil, unit: nil, name: "Cashew Cream" },
      { amount: nil, unit: nil, name: "Avocado" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Boil the potatoes and carrots in 3-4 cups water until soft. Drain the water off. Mash the potatoes and carrots until reaches desired consistency. Feel free to add a splash of unsweetened soy milk or water for a smoother texture.",
      "In a pan, sauté the garlic and onion with 2-3 tablespoons of water. Add the spices and cook until the onions are translucent. Stir in the cooked beans.",
      "In a bowl, combine the potato and carrot mixture with the black beans mixture. Stir together.",
      "Preheat the oven 425F or feel free to use an air fryer with a bake setting.",
      "Place a small scoop of the potato and bean mixture on to a tortilla, spread it out, and then roll tightly. Place the seam-side of the tortilla down on a baking sheet lined with a silicon mat or parchment paper (or an air fryer basket). Repeat this process for the remaining tortillas.",
      "Bake the tortillas for about 10-15 minutes.",
      "Prepare the Cashew Cream, if desired. Thin it out a bit to drizzle on top of the Taquitos or use it as a dip. Optional to top with diced avocado. Enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Boil the potatoes and carrots in 3-4 cups water until soft. Drain the water off. Mash the potatoes and carrots until reaches desired consistency. Feel free to add a splash of unsweetened soy milk or water for a smoother texture.\nIn a pan, sauté the garlic and onion with 2-3 tablespoons of water. Add the spices and cook until the onions are translucent. Stir in the cooked beans.\nIn a bowl, combine the potato and carrot mixture with the black beans mixture. Stir together.\nPreheat the oven 425F or feel free to use an air fryer with a bake setting.\nPlace a small scoop of the potato and bean mixture on to a tortilla, spread it out, and then roll tightly. Place the seam-side of the tortilla down on a baking sheet lined with a silicon mat or parchment paper (or an air fryer basket). Repeat this process for the remaining tortillas.\nBake the tortillas for about 10-15 minutes.\nPrepare the Cashew Cream, if desired. Thin it out a bit to drizzle on top of the Taquitos or use it as a dip. Optional to top with diced avocado. Enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("nutritionfacts.org")
    expect(recipe.canonical_url).to eq("https://nutritionfacts.org/recipe/sweet-potato-taquitos/")
    expect(recipe.site_name).to eq("NutritionFacts.org")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Michael Greger M.D. FACLM")
    expect(recipe.description).to eq("Sweet Potato Taquitos are a delicious way to check-off a few Daily Dozen servings! This dish combines beans, whole grains, spices, and vegetables for a satisfying meal. Top with cashew cream and avocados, if desired. Pair with a green leafy salad to check even more Daily Dozen boxes off.")
    expect(recipe.image).to eq("https://assets.nutritionfacts.org/2022/05/potato-taquitos-2-scaled.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.36)
    expect(recipe.ratings_count).to eq(53)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://nutritionfacts.org/")
  end
end
