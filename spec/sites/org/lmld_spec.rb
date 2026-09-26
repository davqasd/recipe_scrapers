# frozen_string_literal: true

RSpec.describe "lmld.org" do
  subject(:recipe) { scrape_cassette("org/lmld", url: "https://lmld.org/mini-levain-chocolate-chip-cookies/") }

  it "reads the title" do
    expect(recipe.title).to eq("Mini Levain Bakery Chocolate Chip Cookies")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup butter (cold, unsalted, two sticks)",
      "3/4 cup brown sugar (packed)",
      "1/2 cup white sugar",
      "2 large eggs",
      "1 tsp vanilla extract",
      "2 3/4 cups all purpose flour",
      "1 TBS cornstarch",
      "1 tsp baking soda",
      "1 tsp baking powder",
      "1/2 tsp salt",
      "3 cups chocolate chips"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "butter" },
      { amount: 0.75, unit: "cup", name: "brown sugar" },
      { amount: 0.5, unit: "cup", name: "white sugar" },
      { amount: 2.0, unit: nil, name: "large eggs" },
      { amount: 1.0, unit: "tsp", name: "vanilla extract" },
      { amount: 2.75, unit: "cups", name: "all purpose flour" },
      { amount: 1.0, unit: "TBS", name: "cornstarch" },
      { amount: 1.0, unit: "tsp", name: "baking soda" },
      { amount: 1.0, unit: "tsp", name: "baking powder" },
      { amount: 0.5, unit: "tsp", name: "salt" },
      { amount: 3.0, unit: "cups", name: "chocolate chips" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 400 degrees. Line a baking sheet or two with parchment paper.",
      "Cut your butter into slices. Add the butter slices into a large bowl (or stand mixer) with the sugars, and mix for a couple minutes until smooth. Scrape the bottom and sides of the bowl as needed. 1 cup butter, 3/4 cup brown sugar, 1/2 cup white sugar",
      "Add in the eggs and vanilla extract and mix until combined. 2 large eggs, 1 tsp vanilla extract",
      "Dump in the flour, cornstarch, baking soda, baking powder, and salt. Mix on low speed until the wet and dry ingredients combine into a soft dough. 2 3/4 cups all purpose flour, 1 TBS cornstarch, 1 tsp baking soda, 1 tsp baking powder, 1/2 tsp salt",
      "Add in the chocolate chips and fold them into the dough until they are evenly mixed throughout. 3 cups chocolate chips",
      "Measure out the batter to be 3 oz, grabbing and placing the dough with your hands. Don't pack it or roll the dough into a tight ball. Place 5 to 6 cookies per cookie sheet.",
      "Bake in the preheated oven for 8-10 minutes, or until the cookie top and bottom are golden. The tops won't look done.",
      "Remove from the oven and let the cookies rest on the baking pan for about 10 minutes. Transfer to a cooling rack to continue cooling completely, or for another 10 minutes to enjoy warm."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 400 degrees. Line a baking sheet or two with parchment paper.\nCut your butter into slices. Add the butter slices into a large bowl (or stand mixer) with the sugars, and mix for a couple minutes until smooth. Scrape the bottom and sides of the bowl as needed. 1 cup butter, 3/4 cup brown sugar, 1/2 cup white sugar\nAdd in the eggs and vanilla extract and mix until combined. 2 large eggs, 1 tsp vanilla extract\nDump in the flour, cornstarch, baking soda, baking powder, and salt. Mix on low speed until the wet and dry ingredients combine into a soft dough. 2 3/4 cups all purpose flour, 1 TBS cornstarch, 1 tsp baking soda, 1 tsp baking powder, 1/2 tsp salt\nAdd in the chocolate chips and fold them into the dough until they are evenly mixed throughout. 3 cups chocolate chips\nMeasure out the batter to be 3 oz, grabbing and placing the dough with your hands. Don't pack it or roll the dough into a tight ball. Place 5 to 6 cookies per cookie sheet.\nBake in the preheated oven for 8-10 minutes, or until the cookie top and bottom are golden. The tops won't look done.\nRemove from the oven and let the cookies rest on the baking pan for about 10 minutes. Transfer to a cooling rack to continue cooling completely, or for another 10 minutes to enjoy warm.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("lmld.org")
    expect(recipe.canonical_url).to eq("https://lmld.org/mini-levain-chocolate-chip-cookies/")
    expect(recipe.site_name).to eq("Like Mother, Like Daughter")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Aimee")
    expect(recipe.description).to eq("Levain Chocolate Chip Cookie Recipe is a homemade version of the famous Levain Bakery cookies. Delicious giant chocolate chip cookies with a crispy outside and gooey inside, these cookies are the best ever!")
    expect(recipe.image).to eq("https://lmld.org/wp-content/uploads/2018/02/Levain-Chocolate-Chip-Cookies-3.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("15 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq([
      "copycat",
      "copycat levain cookies",
      "levain chocolate chip cookies",
      "Mini Levain Bakery Chocolate Chip Cookies"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(12)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "453 kcal",
      "carbohydrateContent" => "60 g",
      "proteinContent" => "5 g",
      "fatContent" => "22 g",
      "saturatedFatContent" => "13 g",
      "transFatContent" => "1 g",
      "cholesterolContent" => "63 mg",
      "sodiumContent" => "286 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "40 g",
      "unsaturatedFatContent" => "4 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 453.0 },
      { name: "carbohydrateContent", unit: "g", amount: 60.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "fatContent", unit: "g", amount: 22.0 },
      { name: "saturatedFatContent", unit: "g", amount: 13.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 63.0 },
      { name: "sodiumContent", unit: "mg", amount: 286.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 40.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 4.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://lmld.org/")
  end
end
