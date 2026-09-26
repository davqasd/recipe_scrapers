# frozen_string_literal: true

RSpec.describe "iambaker.net" do
  subject(:recipe) { scrape_cassette("net/iambaker", url: "https://iambaker.net/butter-swim-bread/") }

  it "reads the title" do
    expect(recipe.title).to eq("Butter Swim Bread")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 ½ cups (312.5 g) all-purpose flour",
      "4 teaspoons baking powder",
      "1 tablespoon granulated sugar",
      "2 teaspoons kosher salt",
      "2 cups (490 g) buttermilk",
      "½ cup (1 stick / 113 g) unsalted butter, (melted, divided)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.5, unit: "cups", name: "all-purpose flour" },
      { amount: 4.0, unit: "teaspoons", name: "baking powder" },
      { amount: 1.0, unit: "tablespoon", name: "granulated sugar" },
      { amount: 2.0, unit: "teaspoons", name: "kosher salt" },
      { amount: 2.0, unit: "cups", name: "buttermilk" },
      { amount: 0.5, unit: "cup", name: "unsalted butter" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven. Prepare loaf pan.",
      "Preheat oven to 400°F. Spray a 9×5-inch loaf pan* with nonstick spray.",
      "Whisk dry ingredients.",
      "In a medium bowl, whisk together flour, baking powder, sugar, and salt.",
      "Pour in buttermilk.",
      "Pour in the buttermilk and stir until mostly combined, being careful not to overwork the batter.",
      "Pour melted butter into pan.",
      "Pour about 4 tablespoons of the melted butter to the prepared loaf pan, swirling to coat the bottom and sides.",
      "Stir melted butter into batter.",
      "Stir the remaining melted butter into the batter.",
      "Transfer batter to loaf pan.",
      "Transfer the batter to the loaf pan, spreading evenly.",
      "Bake for 35-45 minutes, or until the top is golden brown and a toothpick inserted into the center comes out with a few crumbs, but no wet batter.",
      "Let bread rest.",
      "Let the bread sit for a few minutes to allow the butter to be absorbed into the loaf before slicing.",
      "Serve warm."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven. Prepare loaf pan.\nPreheat oven to 400°F. Spray a 9×5-inch loaf pan* with nonstick spray.\nWhisk dry ingredients.\nIn a medium bowl, whisk together flour, baking powder, sugar, and salt.\nPour in buttermilk.\nPour in the buttermilk and stir until mostly combined, being careful not to overwork the batter.\nPour melted butter into pan.\nPour about 4 tablespoons of the melted butter to the prepared loaf pan, swirling to coat the bottom and sides.\nStir melted butter into batter.\nStir the remaining melted butter into the batter.\nTransfer batter to loaf pan.\nTransfer the batter to the loaf pan, spreading evenly.\nBake for 35-45 minutes, or until the top is golden brown and a toothpick inserted into the center comes out with a few crumbs, but no wet batter.\nLet bread rest.\nLet the bread sit for a few minutes to allow the butter to be absorbed into the loaf before slicing.\nServe warm.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("iambaker.net")
    expect(recipe.canonical_url).to eq("https://iambaker.net/butter-swim-bread/")
    expect(recipe.site_name).to eq("i am baker")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Amanda Rettke--iambaker.net")
    expect(recipe.description).to eq("Soft, buttery, and golden, Butter Swim Bread is a quick bread loaf baked right in melted butter, perfect for breakfast, snacks, or anytime.")
    expect(recipe.image).to eq("https://iambaker.net/wp-content/uploads/2025/09/Butter-Swim-Bread-5.jpg")
    expect(recipe.category).to eq("Bread")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(35)
    expect(recipe.keywords).to eq(["Butter Swim Bread"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "servingSize" => "1 slice", "calories" => "184 kcal" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "slice", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 184.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
