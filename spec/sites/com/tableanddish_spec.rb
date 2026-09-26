# frozen_string_literal: true

RSpec.describe "tableanddish.com" do
  subject(:recipe) { scrape_cassette("com/tableanddish", url: "https://www.tableanddish.com/swordfish-piccata/") }

  it "reads the title" do
    expect(recipe.title).to eq("Swordfish Piccata")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1/2 cup all-purpose flour for dredging",
      "1 teaspoon sea salt",
      "1 teaspoon fresh black pepper",
      "3 fresh swordfish steaks",
      "1 tablespoon extra virgin olive oil",
      "2 tablespoon unsalted butter",
      "4 cloves garlic, thinly sliced",
      "1/3 cup fresh lemon juice",
      "1/2 cup dry white wine",
      "2 tablespoons capers, drained",
      "1/3 cup minced fresh parsley",
      "Lemon garnish"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.5, unit: "cup", name: "all-purpose flour for dredging" },
      { amount: 1.0, unit: "teaspoon", name: "sea salt" },
      { amount: 1.0, unit: "teaspoon", name: "fresh black pepper" },
      { amount: 3.0, unit: nil, name: "fresh swordfish steaks" },
      { amount: 1.0, unit: "tablespoon", name: "extra virgin olive oil" },
      { amount: 2.0, unit: "tablespoon", name: "unsalted butter" },
      { amount: 4.0, unit: "cloves", name: "garlic, thinly sliced" },
      { amount: 0.33, unit: "cup", name: "fresh lemon juice" },
      { amount: 0.5, unit: "cup", name: "dry white wine" },
      { amount: 2.0, unit: "tablespoons", name: "capers, drained" },
      { amount: 0.33, unit: "cup", name: "minced fresh parsley" },
      { amount: nil, unit: nil, name: "Lemon garnish" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Combine the flour, pepper, and salt in a shallow dish such as a pie plate. Dredge the swordfish steaks in the flour mixture and shake off any excess.",
      "In a large skillet, over medium-high heat, heat the olive oil with the butter. When hot, add the fish and cook until browned on the underside, 2 to 3 minutes. Turn fish over and cook until well browned on the other side. Transfer to a platter and keep warm.",
      "To make the sauce:",
      "Add the garlic to the skillet and cook until fragrant, 30 seconds to 1 minute.",
      "Add the lemon juice and wine to the pan and deglaze, scraping up any browned bits. Bring to a boil, turn heat to low and add the capers. Adjust the salt seasoning to taste.",
      "Return the swordfish to the skillet and let the fish cook for a few minutes so that it can absorb the flavors of the sauce. Sprinkle with the parsley and serve at once, garnished with parsley and lemon."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Combine the flour, pepper, and salt in a shallow dish such as a pie plate. Dredge the swordfish steaks in the flour mixture and shake off any excess.\nIn a large skillet, over medium-high heat, heat the olive oil with the butter. When hot, add the fish and cook until browned on the underside, 2 to 3 minutes. Turn fish over and cook until well browned on the other side. Transfer to a platter and keep warm.\nTo make the sauce:\nAdd the garlic to the skillet and cook until fragrant, 30 seconds to 1 minute.\nAdd the lemon juice and wine to the pan and deglaze, scraping up any browned bits. Bring to a boil, turn heat to low and add the capers. Adjust the salt seasoning to taste.\nReturn the swordfish to the skillet and let the fish cook for a few minutes so that it can absorb the flavors of the sauce. Sprinkle with the parsley and serve at once, garnished with parsley and lemon.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("tableanddish.com")
    expect(recipe.canonical_url).to eq("https://www.tableanddish.com/swordfish-piccata/")
    expect(recipe.site_name).to eq("TableandDish")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Sally Roeckell for Table and Dish")
    expect(recipe.description).to eq("Swordfish piccata is one of the most delicious and easiest dishes we make, from prep to completion in 25 minutes or less. It pairs well with a glass of your favorite dry white wine (you’ll use a 1/2 cup in the sauce). If you have been wondering which of my recipes to try or simply contemplating what to make for dinner tonight, MAKE THIS!")
    expect(recipe.image).to eq("https://www.tableanddish.com/wp-content/uploads/2019/07/08-3934-post/Heinens_swordfish_piccata_tableanddish-3575-225x225.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
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
    expect(recipe.links).to include("https://www.tableanddish.com/")
  end
end
