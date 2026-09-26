# frozen_string_literal: true

RSpec.describe "cookwell.com" do
  subject(:recipe) { scrape_cassette("com/cookwell", url: "https://cookwell.com/recipe/crispy-oven-fries") }

  it "reads the title" do
    expect(recipe.title).to eq("Crispy oven fries")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "Russet potatoes, 3-5",
      "Salt, to taste",
      "Vinegar, ~15 g",
      "Peanut Oil, ~60 g"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: nil, name: "Russet potatoes" },
      { amount: nil, unit: nil, name: "Salt, to taste" },
      { amount: 15.0, unit: "g", name: "Vinegar" },
      { amount: 60.0, unit: "g", name: "Peanut Oil" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Prep",
      "Set a pot of water on high heat to boil. Preheat the oven to 450°F/232°C (use the convection setting if you have it). Meanwhile, peel the potatoes, slice them into roughly 1/2 inch sheets, then into roughly 1/2 inch thick fries (or to your desired fry size).",
      "Parboil the fries",
      "Once the water has boiled, add the vinegar and a large pinch of salt, stirring to dissolve the salt. Add the potatoes to the water and boil for 8 minutes. Note: The vinegar will slow down the breakdown of the potato pectin starch so the fries do not fall apart as easily. Boiling the fries will gelate their exterior, which will give you much crispier results in the next steps. When the time is up, pour the fries into a colander and let the excess steam evaporate for a couple of minutes.",
      "Coat the fries with oil",
      "Add the fries to a large baking sheet and pour over the peanut oil. Gently mix the fries around so the oil completely coats the outside of each fry. There should be a thin layer of excess oil on the pan. Make sure the fries aren't overly crowded. They need space to properly dehydrate in the oven. Use 2 baking sheets if needed.",
      "Roast",
      "Add the pan to the preheated oven and roast for 15 minutes. Pull the baking sheet out and flip each fry over with a spatula. At this point, you should be able to see some blistering on the outside but the fries won't be overly crisp. If they look a little dry, drizzle over more peanut oil. Add them back to the oven and roast for another 15-20 minutes. At this point, they should be browned and crispy, though it could take longer depending on the size of the fry, how crowded the pan is, or the amount of oil used. If they aren't crispy, let them go longer!",
      "Finish & serve",
      "Set a paper towel in a bowl. Add the fries and immediately season with salt while they are warm with oil on their surface. Toss the fries with the paper towel so it absorbs the excess oil. Taste and adjust with more salt, if needed. Feel free to add spices, fresh herbs, cheeses, or any flavorings of your choice during this stage. Serve and enjoy."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Prep\nSet a pot of water on high heat to boil. Preheat the oven to 450°F/232°C (use the convection setting if you have it). Meanwhile, peel the potatoes, slice them into roughly 1/2 inch sheets, then into roughly 1/2 inch thick fries (or to your desired fry size).\nParboil the fries\nOnce the water has boiled, add the vinegar and a large pinch of salt, stirring to dissolve the salt. Add the potatoes to the water and boil for 8 minutes. Note: The vinegar will slow down the breakdown of the potato pectin starch so the fries do not fall apart as easily. Boiling the fries will gelate their exterior, which will give you much crispier results in the next steps. When the time is up, pour the fries into a colander and let the excess steam evaporate for a couple of minutes.\nCoat the fries with oil\nAdd the fries to a large baking sheet and pour over the peanut oil. Gently mix the fries around so the oil completely coats the outside of each fry. There should be a thin layer of excess oil on the pan. Make sure the fries aren't overly crowded. They need space to properly dehydrate in the oven. Use 2 baking sheets if needed.\nRoast\nAdd the pan to the preheated oven and roast for 15 minutes. Pull the baking sheet out and flip each fry over with a spatula. At this point, you should be able to see some blistering on the outside but the fries won't be overly crisp. If they look a little dry, drizzle over more peanut oil. Add them back to the oven and roast for another 15-20 minutes. At this point, they should be browned and crispy, though it could take longer depending on the size of the fry, how crowded the pan is, or the amount of oil used. If they aren't crispy, let them go longer!\nFinish & serve\nSet a paper towel in a bowl. Add the fries and immediately season with salt while they are warm with oil on their surface. Toss the fries with the paper towel so it absorbs the excess oil. Taste and adjust with more salt, if needed. Feel free to add spices, fresh herbs, cheeses, or any flavorings of your choice during this stage. Serve and enjoy.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cookwell.com")
    expect(recipe.canonical_url).to eq("https://cookwell.com/recipe/crispy-oven-fries")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Ethan Chlebowski")
    expect(recipe.description).to eq("Better & easier than deep fried.")
    expect(recipe.image).to eq("https://cdn.sanity.io/images/g1s4qnmz/production/ba9d3d0d5ff9a0f9f17f8e11df7e93b7f3806a48-1000x1000.jpg")
    expect(recipe.category).to eq("Side")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(75)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq([
      "Best oven method for fries",
      "best alternative to deep frying",
      "how to make crispy fries at home",
      "the science of good french fries"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "calories" => "970 calories" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 970.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.cookwell.com/download")
  end
end
