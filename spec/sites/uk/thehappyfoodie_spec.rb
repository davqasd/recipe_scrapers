# frozen_string_literal: true

RSpec.describe "thehappyfoodie.co.uk" do
  subject(:recipe) { scrape_cassette("uk/thehappyfoodie", url: "https://thehappyfoodie.co.uk/recipes/slow-cooker-garlic-mac-and-cheese/") }

  it "reads the title" do
    expect(recipe.title).to eq("Slow Cooker Garlic Mac and Cheese Recipe | Bored of Lunch")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "400g dried macaroni pasta",
      "725ml semi-skimmed milk",
      "5 garlic cloves, crushed",
      "130g Cheddar cheese, grated",
      "½ tsp paprika",
      "¼ tsp grated nutmeg",
      "100g low-fat butter",
      "50g Parmesan cheese, grated",
      "handful of breadcrumbs (optional)",
      "salt and pepper, to taste",
      "chopped chives, to garnish"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 400.0, unit: "g", name: "dried macaroni pasta" },
      { amount: 725.0, unit: "ml", name: "semi-skimmed milk" },
      { amount: 5.0, unit: nil, name: "garlic cloves, crushed" },
      { amount: 130.0, unit: "g", name: "Cheddar cheese, grated" },
      { amount: 0.5, unit: "tsp", name: "paprika" },
      { amount: 0.25, unit: "tsp", name: "grated nutmeg" },
      { amount: 100.0, unit: "g", name: "low-fat butter" },
      { amount: 50.0, unit: "g", name: "Parmesan cheese, grated" },
      { amount: 1.0, unit: "handful", name: "breadcrumbs" },
      { amount: nil, unit: nil, name: "salt and pepper, to taste" },
      { amount: nil, unit: nil, name: "chopped chives, to garnish" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Place all the ingredients, except the Parmesan and breadcrumbs, in the slow cooker, stir and season to taste. Cook on low for 1 hour 20 minutes. Stir well, add the Parmesan and a little extra milk if it needs loosening up, then cook for another 20-25 minutes.",
      "If you like a crispy topping and you have an ovenproof slow cooker pot, sprinkle the breadcrumbs over the top of the pasta and cook under a preheated grill until golden. Garnish with chopped chives."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Place all the ingredients, except the Parmesan and breadcrumbs, in the slow cooker, stir and season to taste. Cook on low for 1 hour 20 minutes. Stir well, add the Parmesan and a little extra milk if it needs loosening up, then cook for another 20-25 minutes.\nIf you like a crispy topping and you have an ovenproof slow cooker pot, sprinkle the breadcrumbs over the top of the pasta and cook under a preheated grill until golden. Garnish with chopped chives.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thehappyfoodie.co.uk")
    expect(recipe.canonical_url).to eq("https://thehappyfoodie.co.uk/recipes/slow-cooker-garlic-mac-and-cheese/")
    expect(recipe.site_name).to eq("The Happy Foodie")
    expect(recipe.language).to eq("en-GB")
    expect(recipe.author).to eq("Nathan Anthony")
    expect(recipe.description).to eq("Creamy, cheesy and unbelievably easy, this garlicky macaroni and cheese from Nathan Anthony aka Bored of Lunch is comfort food at its best, perfect for a warming weeknight dinner.")
    expect(recipe.image).to eq("https://thehappyfoodie.co.uk/wp-content/uploads/2023/03/135_garlicmacandcheese-scaled.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Calorie-counted", "Healthy", "Cheese", "One Pot", "Pasta", "Slow Cooker", "Autumn", "Winter", "Dinner", "American", "Easy", "Family Friendly"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.0)
    expect(recipe.ratings_count).to eq(3)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
