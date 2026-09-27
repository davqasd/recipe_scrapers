# frozen_string_literal: true

RSpec.describe "30seconds.com" do
  subject(:recipe) { scrape_cassette("com/30seconds", url: "https://www.30seconds.com/food/tip/17444/Pumpkin-Pie-French-Toast-Recipe-Is-Whats-for-Breakfast-This-Weekend-20-Minutes") }

  it "reads the title" do
    expect(recipe.title).to eq("Pumpkin Pie French Toast Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "5 large eggs",
      "1 cup half and half or almond milk",
      "1 cup pumpkin puree",
      "1/2 teaspoon ground cinnamon",
      "1/2 teaspoon ground ginger",
      "1/4 teaspoon ground cloves",
      "1/4 teaspoon ground nutmeg",
      "1/4 teaspoon allspice",
      "1 teaspoon vanilla",
      "1/4 teaspoon kosher salt",
      "2 tablespoons dark brown sugar",
      "1 large loaf brioche, cut into 1-inch thick slices",
      "1/2 cup unsalted butter, divided",
      "1/4 cup maple syrup",
      "1/2 cup candied pecans, crushed",
      "powered sugar, for garnish"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 5.0, unit: nil, name: "large eggs" },
      { amount: 1.0, unit: "cup", name: "half and half or almond milk" },
      { amount: 1.0, unit: "cup", name: "pumpkin puree" },
      { amount: 0.5, unit: "teaspoon", name: "ground cinnamon" },
      { amount: 0.5, unit: "teaspoon", name: "ground ginger" },
      { amount: 0.25, unit: "teaspoon", name: "ground cloves" },
      { amount: 0.25, unit: "teaspoon", name: "ground nutmeg" },
      { amount: 0.25, unit: "teaspoon", name: "allspice" },
      { amount: 1.0, unit: "teaspoon", name: "vanilla" },
      { amount: 0.25, unit: "teaspoon", name: "kosher salt" },
      { amount: 2.0, unit: "tablespoons", name: "dark brown sugar" },
      { amount: 1.0, unit: "loaf", name: "brioche, cut into 1-inch thick slices" },
      { amount: 0.5, unit: "cup", name: "unsalted butter, divided" },
      { amount: 0.25, unit: "cup", name: "maple syrup" },
      { amount: 0.5, unit: "cup", name: "candied pecans, crushed" },
      { amount: nil, unit: nil, name: "powered sugar, for garnish" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large mixing bowl, whisk together eggs, half and half or milk, pumpkin puree, spices, salt, brown sugar and vanilla. Working one or two slices at a time, dip bread into the egg mixture, allowing it to bathe for at least 10 to 20 seconds to soak up the egg mixture.",
      "In a large sauté pan, melt 1 to 2 tablespoons of butter over medium heat. Working in batches, add the egg-soaked bread slices to the pan and cook until evenly golden brown and caramelized, about 2 to 3 minutes on each side. Continue with the remaining slices.",
      "Serve immediately with maple syrup, and garnish with crushed candied pecans and powdered sugar, if desired."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large mixing bowl, whisk together eggs, half and half or milk, pumpkin puree, spices, salt, brown sugar and vanilla. Working one or two slices at a time, dip bread into the egg mixture, allowing it to bathe for at least 10 to 20 seconds to soak up the egg mixture.\nIn a large sauté pan, melt 1 to 2 tablespoons of butter over medium heat. Working in batches, add the egg-soaked bread slices to the pan and cook until evenly golden brown and caramelized, about 2 to 3 minutes on each side. Continue with the remaining slices.\nServe immediately with maple syrup, and garnish with crushed candied pecans and powdered sugar, if desired.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("30seconds.com")
    expect(recipe.canonical_url).to eq("https://30seconds.com/food/tip/17444/Pumpkin-Pie-French-Toast-Recipe-Is-Whats-for-Breakfast-This-Weekend-20-Minutes")
    expect(recipe.site_name).to eq("30Seconds Food")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Chef Gigi")
    expect(recipe.description).to eq("Pumpkin pie french toast? Yes, please! With fall and pumpkin season in full swing, you need to add this amazing pumpkin pie french toast recipe to your breakfast recipe arsenal.To make this high-protein pumpkin spice french toast recipe you will need eggs, milk, pumpkin puree, ground cinnamon (read...")
    expect(recipe.image).to eq("https://media.30seconds.com/tip/orig/Best-Pumpkin-Spice-French-Toast-Recipe-This-Is-What-to-Ser-17444-129e54aa53-1635426984.jpg")
    expect(recipe.category).to eq("breakfast, brunch, high protein, fall recipes")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq(["pumpkin french toast", "pumpkin pie french toast", "french toast"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "458",
      "fatContent" => "31",
      "saturatedFatContent" => "16",
      "carbohydrateContent" => "37",
      "fiberContent" => "1",
      "sugarContent" => "14",
      "proteinContent" => "10",
      "sodiumContent" => "362",
      "cholesterolContent" => "230"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: nil, amount: 458.0 },
      { name: "fatContent", unit: nil, amount: 31.0 },
      { name: "saturatedFatContent", unit: nil, amount: 16.0 },
      { name: "carbohydrateContent", unit: nil, amount: 37.0 },
      { name: "fiberContent", unit: nil, amount: 1.0 },
      { name: "sugarContent", unit: nil, amount: 14.0 },
      { name: "proteinContent", unit: nil, amount: 10.0 },
      { name: "sodiumContent", unit: nil, amount: 362.0 },
      { name: "cholesterolContent", unit: nil, amount: 230.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#comments")
  end
end
