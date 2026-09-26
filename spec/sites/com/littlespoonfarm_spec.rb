# frozen_string_literal: true

RSpec.describe "littlespoonfarm.com" do
  subject(:recipe) { scrape_cassette("com/littlespoonfarm", url: "https://littlespoonfarm.com/sourdough-oatmeal-bars-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Sourdough Oatmeal Bars")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1/3 cup sourdough discard",
      "1/2 cup unsalted butter (melted)",
      "1/4 cup maple syrup (or honey)",
      "2 cups old-fashioned rolled oats",
      "1 cup all-purpose flour",
      "1 teaspoon fine sea salt",
      "3/4 cup cherry jam",
      "1/4 cup creamy peanut butter (optional topping)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.33, unit: "cup", name: "sourdough discard" },
      { amount: 0.5, unit: "cup", name: "unsalted butter" },
      { amount: 0.25, unit: "cup", name: "maple syrup" },
      { amount: 2.0, unit: "cups", name: "old-fashioned rolled oats" },
      { amount: 1.0, unit: "cup", name: "all-purpose flour" },
      { amount: 1.0, unit: "teaspoon", name: "fine sea salt" },
      { amount: 0.75, unit: "cup", name: "cherry jam" },
      { amount: 0.25, unit: "cup", name: "creamy peanut butter" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat your oven to 350°F (168°C). Line an 8\"x8\" baking dish with parchment paper.",
      "In a large bowl, combine 1/3 cup sourdough discard, 1/2 cup unsalted butter, melted, and 1/4 cup maple syrup. Stir until smooth.",
      "In a separate bowl, mix 2 cups old-fashioned rolled oats, 1 cup all-purpose flour, and 1 teaspoon fine sea salt. Add the wet ingredients to the dry ingredients and mix until everything is well combined.",
      "Press 2/3 of the mixture into the bottom of the prepared baking tin. Spread 3/4 cup cherry jam over the crust, keeping it about 1 inch away from the edges. Crumble the remaining oat mixture over the top.",
      "Bake for 30 minutes, or until the top is golden brown. Let the bars cool completely before slicing into squares. Drizzle with melted peanut butter if desired."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat your oven to 350°F (168°C). Line an 8\"x8\" baking dish with parchment paper.\nIn a large bowl, combine 1/3 cup sourdough discard, 1/2 cup unsalted butter, melted, and 1/4 cup maple syrup. Stir until smooth.\nIn a separate bowl, mix 2 cups old-fashioned rolled oats, 1 cup all-purpose flour, and 1 teaspoon fine sea salt. Add the wet ingredients to the dry ingredients and mix until everything is well combined.\nPress 2/3 of the mixture into the bottom of the prepared baking tin. Spread 3/4 cup cherry jam over the crust, keeping it about 1 inch away from the edges. Crumble the remaining oat mixture over the top.\nBake for 30 minutes, or until the top is golden brown. Let the bars cool completely before slicing into squares. Drizzle with melted peanut butter if desired.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("littlespoonfarm.com")
    expect(recipe.canonical_url).to eq("https://littlespoonfarm.com/sourdough-oatmeal-bars-recipe/")
    expect(recipe.site_name).to eq("Little Spoon Farm")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Carmyn Suzor")
    expect(recipe.description).to eq("Sourdough Oatmeal Bars with Jam are a delicious way to use sourdough discard. Made with hearty oats and a sweet layer of jam, these bars are quick to prepare and perfect for breakfast on busy mornings. They’re also an easy, kid-friendly snack that packs well in lunchboxes.")
    expect(recipe.image).to eq("https://littlespoonfarm.com/wp-content/uploads/2025/09/Sourdough-oatmeal-bars-recipe.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("9 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["sourdough oatmeal bars", "sourdough oatmeal bars with jam filling"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(15)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "364 kcal",
      "carbohydrateContent" => "52 g",
      "proteinContent" => "6 g",
      "fatContent" => "15 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 364.0 },
      { name: "carbohydrateContent", unit: "g", amount: 52.0 },
      { name: "proteinContent", unit: "g", amount: 6.0 },
      { name: "fatContent", unit: "g", amount: 15.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
