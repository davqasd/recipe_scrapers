# frozen_string_literal: true

RSpec.describe "allthehealthythings.com" do
  subject(:recipe) { scrape_cassette("com/allthehealthythings", url: "https://allthehealthythings.com/cheddar-jalapeno-cornbread/") }

  it "reads the title" do
    expect(recipe.title).to eq("Cheddar Jalapeño Cornbread with Whipped Hot Honey Butter")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup all purpose flour",
      "1 cup yellow cornmeal",
      "1 tablespoon baking powder",
      "1 teaspoon salt",
      "4 oz sharp yellow cheddar, shredded",
      "1 jalapeño pepper, seeds removed and finely diced",
      "1 1/2 cups buttermilk",
      "2 eggs",
      "1/4 cup unsalted butter, melted + 2 tablespoons unsalted butter",
      "flakey sea salt, for garnish",
      "1/2 cup (1 stick) unsalted butter, softened",
      "1/4 cup hot honey, plus more for serving",
      "pinch of salt"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "all purpose flour" },
      { amount: 1.0, unit: "cup", name: "yellow cornmeal" },
      { amount: 1.0, unit: "tablespoon", name: "baking powder" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: 4.0, unit: "oz", name: "sharp yellow cheddar, shredded" },
      { amount: 1.0, unit: nil, name: "jalapeño pepper, seeds removed and finely diced" },
      { amount: 1.5, unit: "cups", name: "buttermilk" },
      { amount: 2.0, unit: nil, name: "eggs" },
      { amount: 0.25, unit: "cup", name: "unsalted butter, melted + 2 tablespoons unsalted butter" },
      { amount: nil, unit: nil, name: "flakey sea salt, for garnish" },
      { amount: 0.5, unit: "cup", name: "unsalted butter, softened" },
      { amount: 0.25, unit: "cup", name: "hot honey, plus more for serving" },
      { amount: 1.0, unit: "pinch", name: "salt" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Place a 8 or 9 inch skillet in the oven and then set to preheat at 400 degrees.",
      "To a large mixing bowl add the corn meal, flour, baking powder, and salt. Then, add the shredded cheese and jalapeño and stir until well combined.",
      "In another bowl, whisk together the eggs, buttermilk, and 1/4 cup melted butter.",
      "Pour the wet ingredients into the dry and gently fold until everything is well combined.",
      "Remove the hot skillet from the oven and add 2 tablespoons of butter. Add the skillet back to the oven and let melt completely. Once the butter has melted, remove the skillet from the oven and swirl the butter around until the skillet is fully coated. Pour the batter into the hot skillet.",
      "Bake the cornbread for around 25-30 minutes at 400 degrees or until a toothpick comes out clean. The center of the cornbread should be puffed and the edges golden brown.",
      "Make the Whipped Hot Honey Butter",
      "While the cornbread is baking make the whipped honey butter. Add the softened butter and honey to a mixing bowl. Use a hand mixer to beat at high speed for 1 minute until fluffy.",
      "While the cornbread is still hot, brush some of the honey butter overtop of the cornbread. Let cool for a few minutes and then slice the cornbread into 8 slices and serve warm with an extra dollop of honey butter, a drizzle of hot honey, and flaky sea salt."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Place a 8 or 9 inch skillet in the oven and then set to preheat at 400 degrees.\nTo a large mixing bowl add the corn meal, flour, baking powder, and salt. Then, add the shredded cheese and jalapeño and stir until well combined.\nIn another bowl, whisk together the eggs, buttermilk, and 1/4 cup melted butter.\nPour the wet ingredients into the dry and gently fold until everything is well combined.\nRemove the hot skillet from the oven and add 2 tablespoons of butter. Add the skillet back to the oven and let melt completely. Once the butter has melted, remove the skillet from the oven and swirl the butter around until the skillet is fully coated. Pour the batter into the hot skillet.\nBake the cornbread for around 25-30 minutes at 400 degrees or until a toothpick comes out clean. The center of the cornbread should be puffed and the edges golden brown.\nMake the Whipped Hot Honey Butter\nWhile the cornbread is baking make the whipped honey butter. Add the softened butter and honey to a mixing bowl. Use a hand mixer to beat at high speed for 1 minute until fluffy.\nWhile the cornbread is still hot, brush some of the honey butter overtop of the cornbread. Let cool for a few minutes and then slice the cornbread into 8 slices and serve warm with an extra dollop of honey butter, a drizzle of hot honey, and flaky sea salt.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("allthehealthythings.com")
    expect(recipe.canonical_url).to eq("https://allthehealthythings.com/cheddar-jalapeno-cornbread/")
    expect(recipe.site_name).to eq("All the Healthy Things")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Ashlea Carver")
    expect(recipe.description).to eq("This Cheddar Jalapeño Cornbread with Whipped Hot Honey Butter is absolutely delicious! The classic cheddar jalapeño skillet cornbread is taken to the next level with the perfect whipped hot honey butter to spread on top. Everyone will love it!")
    expect(recipe.image).to eq("https://allthehealthythings.com/wp-content/uploads/2023/08/Jalapeno-Cheddar-Skillet-Cornbread-with-Whipped-Hot-Honey-Butter-6-scaled-225x225.jpg")
    expect(recipe.category).to eq("Sides")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to eq("Baking")
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to eq([
      "jalapeno cheddar cornbread",
      "cheddar jalapeno cornbread",
      "jalapeno cornbread",
      "skillet cornbread",
      "cast iron skillet cornbread",
      "skillet cornbread recipe",
      "cornbread in cast iron skillet"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["GlutenFreeDiet"])
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "412 calories",
      "sugarContent" => "11.6 g",
      "sodiumContent" => "1172.4 mg",
      "fatContent" => "25.2 g",
      "saturatedFatContent" => "14.8 g",
      "transFatContent" => "0.1 g",
      "carbohydrateContent" => "37.9 g",
      "fiberContent" => "2 g",
      "proteinContent" => "9.7 g",
      "cholesterolContent" => "111.3 mg"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 412.0 },
      { name: "sugarContent", unit: "g", amount: 11.6 },
      { name: "sodiumContent", unit: "mg", amount: 1172.4 },
      { name: "fatContent", unit: "g", amount: 25.2 },
      { name: "saturatedFatContent", unit: "g", amount: 14.8 },
      { name: "transFatContent", unit: "g", amount: 0.1 },
      { name: "carbohydrateContent", unit: "g", amount: 37.9 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "proteinContent", unit: "g", amount: 9.7 },
      { name: "cholesterolContent", unit: "mg", amount: 111.3 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
