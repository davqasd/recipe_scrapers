# frozen_string_literal: true

RSpec.describe "realfoodwell.com" do
  subject(:recipe) { scrape_cassette("com/realfoodwell", url: "https://realfoodwell.com/pan-seared-swordfish-with-mediterranean-salsa/") }

  it "reads the title" do
    expect(recipe.title).to eq("Pan Seared Swordfish with Mediterranean Salsa")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 6oz. swordfish steaks",
      "1 tsp. Kosher salt",
      "¼ tsp. freshly ground black pepper",
      "2 Tbsp. olive oil, extra virgin and cold pressed",
      "1/2 cup Castelvetrano olives, pitted and quartered",
      "1/2 cup Kalamata olives, pitted and quartered",
      "2 medium Roma tomatoes, diced",
      "2 Tbsp. capers, drained",
      "2 Tbsp. pine nuts, toasted",
      "2 Tbsp. basil, chopped (for garnish)",
      "2 Tbsp. olive oil, extra virgin and cold pressed",
      "1 Tbsp. red wine vinegar"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: nil, name: "6oz. swordfish steaks" },
      { amount: 1.0, unit: "tsp", name: "Kosher salt" },
      { amount: 0.25, unit: "tsp", name: "freshly ground black pepper" },
      { amount: 2.0, unit: "Tbsp", name: "olive oil, extra virgin and cold pressed" },
      { amount: 0.5, unit: "cup", name: "Castelvetrano olives, pitted and quartered" },
      { amount: 0.5, unit: "cup", name: "Kalamata olives, pitted and quartered" },
      { amount: 2.0, unit: nil, name: "medium Roma tomatoes, diced" },
      { amount: 2.0, unit: "Tbsp", name: "capers, drained" },
      { amount: 2.0, unit: "Tbsp", name: "pine nuts, toasted" },
      { amount: 2.0, unit: "Tbsp", name: "basil, chopped" },
      { amount: 2.0, unit: "Tbsp", name: "olive oil, extra virgin and cold pressed" },
      { amount: 1.0, unit: "Tbsp", name: "red wine vinegar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pat the swordfish steaks dry with a paper towel. Rub a little avocado oil on both sides of each steak and season with salt and pepper.",
      "Make the salsa so that it is ready to go, prior to cooking the steaks.",
      "Toast the pine nuts in a small skillet. Toss them frequently, so that they don’t burn. They should be lightly browned and fragrant. Let them cool and add them to the salsa before serving.",
      "Warm a skillet to medium-high heat. Place the steaks in the pan and sear them on each side for about 5 minutes. Cook time may vary depending on the thickness of the steaks.",
      "Top with the steaks with the salsa and a little fresh basil."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pat the swordfish steaks dry with a paper towel. Rub a little avocado oil on both sides of each steak and season with salt and pepper.\nMake the salsa so that it is ready to go, prior to cooking the steaks.\nToast the pine nuts in a small skillet. Toss them frequently, so that they don’t burn. They should be lightly browned and fragrant. Let them cool and add them to the salsa before serving.\nWarm a skillet to medium-high heat. Place the steaks in the pan and sear them on each side for about 5 minutes. Cook time may vary depending on the thickness of the steaks.\nTop with the steaks with the salsa and a little fresh basil.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("realfoodwell.com")
    expect(recipe.canonical_url).to eq("https://realfoodwell.com/pan-seared-swordfish-with-mediterranean-salsa/")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Cheryl Englebretson")
    expect(recipe.description).to eq("This healthy and delicious seafood dish is packed with flavor and takes less than 30 minutes to make.")
    expect(recipe.image).to eq("https://realfoodwell.com/wp-content/uploads/2024/01/Pan-Seared-Swordfish-with-Mediterranean-Salsa-FInal-rc-225x225.jpg")
    expect(recipe.category).to eq("main dish")
    expect(recipe.cuisine).to eq("Mediterranean")
    expect(recipe.cooking_method).to eq("stovetop")
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq(["gluten free", "dairy free"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["GlutenFreeDiet"])
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
