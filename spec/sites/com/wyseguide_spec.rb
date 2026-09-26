# frozen_string_literal: true

RSpec.describe "wyseguide.com" do
  subject(:recipe) { scrape_cassette("com/wyseguide", url: "https://www.wyseguide.com/blueberry-cobbler/") }

  it "reads the title" do
    expect(recipe.title).to eq("Blueberry Cobbler")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 tablespoons unsalted butter",
      "3 cups blueberries",
      "¾ cup all-purpose flour",
      "½ cup granulated sugar",
      "1 ½ teaspoons baking powder",
      "¾ teaspoon kosher salt",
      "⅔ cup whole milk",
      "1 teaspoon vanilla extract"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: "tablespoons", name: "unsalted butter" },
      { amount: 3.0, unit: "cups", name: "blueberries" },
      { amount: 0.75, unit: "cup", name: "all-purpose flour" },
      { amount: 0.5, unit: "cup", name: "granulated sugar" },
      { amount: 1.5, unit: "teaspoons", name: "baking powder" },
      { amount: 0.75, unit: "teaspoon", name: "kosher salt" },
      { amount: 0.67, unit: "cup", name: "whole milk" },
      { amount: 1.0, unit: "teaspoon", name: "vanilla extract" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Melt the butter: Add the butter to an 8 x 8-inch baking dish. Set the baking dish in the oven and preheat the oven to 350°F. Once the butter is melted in the oven, remove the baking dish, 4-6 minutes. Set the baking dish aside while preparing the batter.",
      "Prepare the batter: Mix the flour, sugar, baking powder, and salt in a bowl. Add the milk and vanilla extract and whisk until smooth.",
      "Assemble: Pour the batter into the baking dish with the melted butter. There is no need to stir. Add the blueberries directly on top of the batter.",
      "Bake in the preheated oven until the cobbler is golden and set in the middle, 45-55 minutes. Once baked, remove from the oven and cool for 15 minutes before serving."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Melt the butter: Add the butter to an 8 x 8-inch baking dish. Set the baking dish in the oven and preheat the oven to 350°F. Once the butter is melted in the oven, remove the baking dish, 4-6 minutes. Set the baking dish aside while preparing the batter.\nPrepare the batter: Mix the flour, sugar, baking powder, and salt in a bowl. Add the milk and vanilla extract and whisk until smooth.\nAssemble: Pour the batter into the baking dish with the melted butter. There is no need to stir. Add the blueberries directly on top of the batter.\nBake in the preheated oven until the cobbler is golden and set in the middle, 45-55 minutes. Once baked, remove from the oven and cool for 15 minutes before serving.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("wyseguide.com")
    expect(recipe.canonical_url).to eq("https://www.wyseguide.com/blueberry-cobbler/")
    expect(recipe.site_name).to eq("Wyse Guide")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Kaleb")
    expect(recipe.description).to eq("This simple blueberry cobbler is buttery, golden, and bursting with juicy blueberries. With pantry staples, it's a quick, comforting dessert that’s perfect year-round.")
    expect(recipe.image).to eq("https://www.wyseguide.com/wp-content/uploads/2025/06/Blueberry-Cobbler-009.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("9 servings")
    expect(recipe.total_time).to eq(75)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(60)
    expect(recipe.keywords).to eq(["blueberry", "cobbler", "dessert", "summer", "summer dessert"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.72)
    expect(recipe.ratings_count).to eq(7)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "servingSize" => "1 serving", "calories" => "163 kcal" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "serving", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 163.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
