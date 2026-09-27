# frozen_string_literal: true

RSpec.describe "aberlehome.com" do
  subject(:recipe) { scrape_cassette("com/aberlehome", url: "https://aberlehome.com/german-apple-pancake-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("German Apple Pancake")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 eggs, room temperature",
      "1/2 cup milk, room temperature",
      "1 teaspoon pure vanilla extract",
      "1 tablespoon real maple syrup",
      "1/4 teaspoon ground nutmeg",
      "1/2 cup unbleached all-purpose flour",
      "1/4 teaspoon kosher salt",
      "4 tablespoons butter, melted for baking pan",
      "Powdered sugar for dusting",
      "1 large apple, peeled, cored, and sliced thinly (I used a pink lady)",
      "1 tablespoon butter",
      "1/8 cup real maple syrup",
      "1 tablespoon lemon juice (less if using a tart apple)",
      "1 ½ teaspoons ground cinnamon",
      "1/3 cup water (plus more as needed)",
      "Pinch of salt"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: nil, name: "eggs, room temperature" },
      { amount: 0.5, unit: "cup", name: "milk, room temperature" },
      { amount: 1.0, unit: "teaspoon", name: "pure vanilla extract" },
      { amount: 1.0, unit: "tablespoon", name: "real maple syrup" },
      { amount: 0.25, unit: "teaspoon", name: "ground nutmeg" },
      { amount: 0.5, unit: "cup", name: "unbleached all-purpose flour" },
      { amount: 0.25, unit: "teaspoon", name: "kosher salt" },
      { amount: 4.0, unit: "tablespoons", name: "butter, melted for baking pan" },
      { amount: nil, unit: nil, name: "Powdered sugar for dusting" },
      { amount: 1.0, unit: nil, name: "large apple, peeled, cored, and sliced thinly" },
      { amount: 1.0, unit: "tablespoon", name: "butter" },
      { amount: 0.13, unit: "cup", name: "real maple syrup" },
      { amount: 1.0, unit: "tablespoon", name: "lemon juice" },
      { amount: 1.5, unit: "teaspoons", name: "ground cinnamon" },
      { amount: 0.33, unit: "cup", name: "water" },
      { amount: 1.0, unit: "Pinch", name: "salt" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Apple Topping: Combine apple slices, butter, maple syrup, lemon juice, cinnamon, water, and a pinch of salt in a small pan over medium heat. Stir to combine. Once the mixture begins to simmer, reduce heat to medium-low and simmer until the apples are tender (but still have a bite to them) and syrup has reduced. Add more water as needed if the syrup becomes too thick or cover with a lid. Remove from heat and set aside.",
      "German Pancake: Meanwhile, preheat oven to 425°F. Once oven is preheated, place a 10-inch cast iron skillet or similar size stoneware pan in the oven to preheat for 10 minutes.",
      "While the pan is preheating, blend or whisk together eggs, milk, vanilla, maple syrup, nutmeg, flour, and salt until no lumps remain.",
      "Carefully remove preheated baking pan from oven and pour the melted butter into the pan. Tilt the pan to make sure the butter coats the entire bottom. Pour your egg mixture into the very center of the pan and return to the hot oven on the center rack.",
      "Bake for 17 minutes, then turn off the oven, and leave the German pancake to bake for 5 more minutes until it's puffed, golden, and the center is set.",
      "Once out of the oven, tilt the pancake to evenly distribute any melted butter that remains on the surface. Pour apple topping over the inside and spread evenly. Dust generously with powdered sugar, and slice and serve immediately."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["German Pancake", 9],
        ["Apple Topping", 7]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Apple Topping: Combine apple slices, butter, maple syrup, lemon juice, cinnamon, water, and a pinch of salt in a small pan over medium heat. Stir to combine. Once the mixture begins to simmer, reduce heat to medium-low and simmer until the apples are tender (but still have a bite to them) and syrup has reduced. Add more water as needed if the syrup becomes too thick or cover with a lid. Remove from heat and set aside.\nGerman Pancake: Meanwhile, preheat oven to 425°F. Once oven is preheated, place a 10-inch cast iron skillet or similar size stoneware pan in the oven to preheat for 10 minutes.\nWhile the pan is preheating, blend or whisk together eggs, milk, vanilla, maple syrup, nutmeg, flour, and salt until no lumps remain.\nCarefully remove preheated baking pan from oven and pour the melted butter into the pan. Tilt the pan to make sure the butter coats the entire bottom. Pour your egg mixture into the very center of the pan and return to the hot oven on the center rack.\nBake for 17 minutes, then turn off the oven, and leave the German pancake to bake for 5 more minutes until it's puffed, golden, and the center is set.\nOnce out of the oven, tilt the pancake to evenly distribute any melted butter that remains on the surface. Pour apple topping over the inside and spread evenly. Dust generously with powdered sugar, and slice and serve immediately.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("aberlehome.com")
    expect(recipe.canonical_url).to eq("https://aberlehome.com/german-apple-pancake-recipe/")
    expect(recipe.site_name).to eq("Aberle Home")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Leanna Aberle")
    expect(recipe.description).to eq("This German apple pancake recipe is a welcome variation on a classic German pancake (also known as a Dutch baby or puff pancake). It puffs up gloriously in the oven and is topped with syrupy cinnamon apples and a dusting of powdered sugar.")
    expect(recipe.image).to eq("https://aberlehome.com/wp-content/uploads/2021/10/german-apple-pancake-20-480x480.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(37)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(22)
    expect(recipe.keywords).to eq(["german apple pancake recipe", "puff apple pancake", "dutch apple baby"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "444 calories",
      "carbohydrateContent" => "62 grams carbohydrates",
      "cholesterolContent" => "180 milligrams cholesterol",
      "fatContent" => "19 grams fat",
      "fiberContent" => "2 grams fiber",
      "proteinContent" => "8 grams protein",
      "saturatedFatContent" => "11 grams saturated fat",
      "servingSize" => "1",
      "sodiumContent" => "299 milligrams sodium",
      "sugarContent" => "46 grams sugar",
      "transFatContent" => "1 grams trans fat",
      "unsaturatedFatContent" => "7 grams unsaturated fat"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 444.0 },
      { name: "carbohydrateContent", unit: "g", amount: 62.0 },
      { name: "cholesterolContent", unit: "mg", amount: 180.0 },
      { name: "fatContent", unit: "g", amount: 19.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "proteinContent", unit: "g", amount: 8.0 },
      { name: "saturatedFatContent", unit: "g", amount: 11.0 },
      { name: "servingSize", unit: nil, amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 299.0 },
      { name: "sugarContent", unit: "g", amount: 46.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 7.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
