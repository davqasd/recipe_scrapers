# frozen_string_literal: true

RSpec.describe "delish.com" do
  subject(:recipe) { scrape_cassette("com/delish", url: "https://www.delish.com/cooking/recipe-ideas/recipes/a56732/pumpkin-cheesecake-roll-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Pumpkin Cheesecake Roll")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "Cooking spray",
      "3/4 c. (90 g.) all-purpose flour",
      "1 tsp. baking soda",
      "1/2 tsp. kosher salt",
      "1/2 tsp. pumpkin spice",
      "3 large eggs",
      "1 c. (200 g.) granulated sugar",
      "2/3 c. pumpkin puree",
      "Confectioners' sugar, for rolling",
      "12 oz. cream cheese, softened",
      "1 tbsp. unsalted butter, melted",
      "1 1/4 c. (145 g.) confectioners' sugar, plus more for dusting",
      "1 tsp. pure vanilla extract"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "Cooking spray" },
      { amount: 0.75, unit: "c", name: "all-purpose flour" },
      { amount: 1.0, unit: "tsp", name: "baking soda" },
      { amount: 0.5, unit: "tsp", name: "kosher salt" },
      { amount: 0.5, unit: "tsp", name: "pumpkin spice" },
      { amount: 3.0, unit: nil, name: "large eggs" },
      { amount: 1.0, unit: "c", name: "granulated sugar" },
      { amount: 0.67, unit: "c", name: "pumpkin puree" },
      { amount: nil, unit: nil, name: "Confectioners' sugar, for rolling" },
      { amount: 12.0, unit: "oz", name: "cream cheese, softened" },
      { amount: 1.0, unit: "tbsp", name: "unsalted butter, melted" },
      { amount: 1.25, unit: "c", name: "confectioners' sugar, plus more for dusting" },
      { amount: 1.0, unit: "tsp", name: "pure vanilla extract" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Cake",
      "Preheat oven to 350°. Line a 15\" x 10\" jelly roll pan with parchment and grease with cooking spray.",
      "In a medium bowl, whisk flour, baking soda, salt, and pumpkin spice. In a large bowl, whisk eggs, granulated sugar, and pumpkin puree until smooth. Add dry ingredients to egg mixture and whisk just to combine. Spread into prepared pan.",
      "Bake cake until a tester inserted into the center comes out clean, about 15 minutes.",
      "Meanwhile, lay out a large kitchen towel on your counter (try to use one with little to no texture) and dust with confectioners' sugar. When cake is done baking, flip onto kitchen towel and gently peel off parchment.",
      "Starting at a short end, gently but tightly roll cake into a log. Let cool completely.",
      "Filling",
      "In a large bowl, using a handheld mixer on medium-high speed, beat cream cheese, butter, and salt until light and fluffy. Add confectioners' sugar and vanilla and continue to beat until smooth.",
      "When cake is cooled, gently unroll (it’s okay if it remains slightly curled) and spread with cream cheese filling. Using towel if needed, roll back up and dust with more confectioners' sugar."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Cake\nPreheat oven to 350°. Line a 15\" x 10\" jelly roll pan with parchment and grease with cooking spray.\nIn a medium bowl, whisk flour, baking soda, salt, and pumpkin spice. In a large bowl, whisk eggs, granulated sugar, and pumpkin puree until smooth. Add dry ingredients to egg mixture and whisk just to combine. Spread into prepared pan.\nBake cake until a tester inserted into the center comes out clean, about 15 minutes.\nMeanwhile, lay out a large kitchen towel on your counter (try to use one with little to no texture) and dust with confectioners' sugar. When cake is done baking, flip onto kitchen towel and gently peel off parchment.\nStarting at a short end, gently but tightly roll cake into a log. Let cool completely.\nFilling\nIn a large bowl, using a handheld mixer on medium-high speed, beat cream cheese, butter, and salt until light and fluffy. Add confectioners' sugar and vanilla and continue to beat until smooth.\nWhen cake is cooled, gently unroll (it’s okay if it remains slightly curled) and spread with cream cheese filling. Using towel if needed, roll back up and dust with more confectioners' sugar.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("delish.com")
    expect(recipe.canonical_url).to eq("https://www.delish.com/cooking/recipe-ideas/a56732/pumpkin-cheesecake-roll-recipe/")
    expect(recipe.site_name).to eq("Delish")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Lena Abraham")
    expect(recipe.description).to eq("The pumpkin roll's iconic swirls make it a staple stunning dessert during the fall season—learn how to perfect it with our easy recipe.")
    expect(recipe.image).to eq("https://hips.hearstapps.com/hmg-prod/images/pumpkin-cheesecake-roll-index-64f7952c6df54.jpg?crop=0.500xw:1.00xh;0.249xw,0&resize=1200:*")
    expect(recipe.category).to eq("autumn")
    expect(recipe.cuisine).to eq("Cake Cuisine")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(60)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq([
      "pumpkin roll",
      "pumpkin desserts",
      "fall desserts",
      "swiss roll",
      "cream cheese frosting",
      "thanksgiving desserts",
      "pumpkin cake"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.3333335)
    expect(recipe.ratings_count).to eq(15)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "427 Calories",
      "fatContent" => "20 g",
      "saturatedFatContent" => "10 g",
      "transFatContent" => "1 g",
      "cholesterolContent" => "117 mg",
      "sodiumContent" => "332 mg",
      "carbohydrateContent" => "57 g",
      "fiberContent" => "1 g",
      "sugarContent" => "47 g",
      "proteinContent" => "6 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 427.0 },
      { name: "fatContent", unit: "g", amount: 20.0 },
      { name: "saturatedFatContent", unit: "g", amount: 10.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 117.0 },
      { name: "sodiumContent", unit: "mg", amount: 332.0 },
      { name: "carbohydrateContent", unit: "g", amount: 57.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 47.0 },
      { name: "proteinContent", unit: "g", amount: 6.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/my-stuff")
  end
end
