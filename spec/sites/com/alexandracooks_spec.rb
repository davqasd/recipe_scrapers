# frozen_string_literal: true

RSpec.describe "alexandracooks.com" do
  subject(:recipe) { scrape_cassette("com/alexandracooks", url: "https://alexandracooks.com/2024/01/14/vegan-ranch-dressing-cashew-no-soak/") }

  it "reads the title" do
    expect(recipe.title).to eq("Vegan Ranch Dressing (Cashew, No-Soak)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup (135 g) raw cashews",
      "3/4 cup (176 g) ice water, plus more as needed",
      "1½ (5 g) teaspoons Diamond Crystal kosher salt, see notes above",
      "1/4 cup (65 g) fresh lemon juice",
      "1 garlic clove",
      "2 tablespoons (28 g) extra-virgin olive oil",
      "1 teaspoon maple syrup",
      "1/2 cup (20 g) chives",
      "Flaky sea salt, optional, to taste"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "raw cashews" },
      { amount: 0.75, unit: "cup", name: "ice water, plus more as needed" },
      { amount: 1.5, unit: "teaspoons", name: "Diamond Crystal kosher salt, see notes above" },
      { amount: 0.25, unit: "cup", name: "fresh lemon juice" },
      { amount: 1.0, unit: nil, name: "garlic clove" },
      { amount: 2.0, unit: "tablespoons", name: "extra-virgin olive oil" },
      { amount: 1.0, unit: "teaspoon", name: "maple syrup" },
      { amount: 0.5, unit: "cup", name: "chives" },
      { amount: nil, unit: nil, name: "Flaky sea salt, optional, to taste" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a high-speed blender combine the cashews, ice water, salt, lemon juice, garlic, olive oil, and maple syrup. Blend at low speed for 10 seconds, then turn the blender to its highest setting and blend for another 50 seconds.",
      "The mixture should be completely smooth. Taste. And adjust with a pinch of flaky sea salt if necessary. Add the chives, and blend on low for another 10 seconds.",
      "The mixture will be slightly warm due to the intensity of the blending, and because of this, it’s difficult to accurately evaluate the flavor. Because of this, I recommend transferring it to a storage vessel and transferring it to the fridge for at least 2 hours before using. In this time, the ranch flavors will intensify and the dressing will thicken — you may want to thin the dressing with another tablespoon of water to make it a more pourable consistency before using. You may also want to add a pinch more kosher salt or flaky sea salt to taste."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a high-speed blender combine the cashews, ice water, salt, lemon juice, garlic, olive oil, and maple syrup. Blend at low speed for 10 seconds, then turn the blender to its highest setting and blend for another 50 seconds.\nThe mixture should be completely smooth. Taste. And adjust with a pinch of flaky sea salt if necessary. Add the chives, and blend on low for another 10 seconds.\nThe mixture will be slightly warm due to the intensity of the blending, and because of this, it’s difficult to accurately evaluate the flavor. Because of this, I recommend transferring it to a storage vessel and transferring it to the fridge for at least 2 hours before using. In this time, the ranch flavors will intensify and the dressing will thicken — you may want to thin the dressing with another tablespoon of water to make it a more pourable consistency before using. You may also want to add a pinch more kosher salt or flaky sea salt to taste.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("alexandracooks.com")
    expect(recipe.canonical_url).to eq("https://alexandracooks.com/2024/01/14/vegan-ranch-dressing-cashew-no-soak/")
    expect(recipe.site_name).to eq("Alexandra's Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Alexandra Stafford")
    expect(recipe.description).to eq("Adapted from The Full Helping's all-purpose cashew cream recipe. Notes: Salt: If you are using Morton Kosher salt or fine sea salt, use 3/4 teaspoon (or the same amount by weight. I have only ever used a high speed blender, which makes an especially creamy dressing without having to soak the cashews. If you do not have a Vitamix or other powerful blender, consider soaking the cashews in water for at least 2 hours before making the dressing.")
    expect(recipe.image).to eq("https://alexandracooks.com/wp-content/uploads/2022/03/veganranchdressing-225x225.jpg")
    expect(recipe.category).to eq("Dressing")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to eq("Blender")
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(120)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["cashew", "lemon juice", "garlic", "chives"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["VeganDiet"])
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(4)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
