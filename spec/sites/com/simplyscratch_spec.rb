# frozen_string_literal: true

RSpec.describe "simplyscratch.com" do
  subject(:recipe) { scrape_cassette("com/simplyscratch", url: "https://www.simplyscratch.com/rhubarb-almond-cake-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Rhubarb Almond Cake")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1¼ cup unbleached all-purpose flour",
      "1/2 teaspoon kosher salt",
      "1/2 teaspoon baking soda",
      "1/4 teaspoon baking powder",
      "1/2 teaspoon ground nutmeg",
      "3/4 cup light brown sugar",
      "1/2 cup unsweetened applesauce",
      "1 large egg",
      "1/2 teaspoon pure vanilla extract",
      "1/2 teaspoon almond extract",
      "3/4 cup low-fat buttermilk",
      "1½ cups diced rhubarb",
      "1/4 cup sliced almonds",
      "1 tablespoon powdered sugar (for serving)",
      "3 tablespoons granulated sugar",
      "1/4 cup sliced almonds",
      "1½ tablespoons salted butter"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.25, unit: "cup", name: "unbleached all-purpose flour" },
      { amount: 0.5, unit: "teaspoon", name: "kosher salt" },
      { amount: 0.5, unit: "teaspoon", name: "baking soda" },
      { amount: 0.25, unit: "teaspoon", name: "baking powder" },
      { amount: 0.5, unit: "teaspoon", name: "ground nutmeg" },
      { amount: 0.75, unit: "cup", name: "light brown sugar" },
      { amount: 0.5, unit: "cup", name: "unsweetened applesauce" },
      { amount: 1.0, unit: nil, name: "large egg" },
      { amount: 0.5, unit: "teaspoon", name: "pure vanilla extract" },
      { amount: 0.5, unit: "teaspoon", name: "almond extract" },
      { amount: 0.75, unit: "cup", name: "low-fat buttermilk" },
      { amount: 1.5, unit: "cups", name: "diced rhubarb" },
      { amount: 0.25, unit: "cup", name: "sliced almonds" },
      { amount: 1.0, unit: "tablespoon", name: "powdered sugar" },
      { amount: 3.0, unit: "tablespoons", name: "granulated sugar" },
      { amount: 0.25, unit: "cup", name: "sliced almonds" },
      { amount: 1.5, unit: "tablespoons", name: "salted butter" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat your oven to 350℉ (or 180℃) and grease a 9-inch cake pan.",
      "In a medium mixing bowl, measure and add the flour, salt, baking soda, baking powder and nutmeg. Whisk to combine.",
      "In a larger mixing bowl, combine the sugar, applesauce, egg, vanilla and almond extract. Whisking to combine.",
      "Alternate adding 1/3 of the dry ingredients with 1/3 of the buttermilk mixing after each addition, repeating until all are incorporated.",
      "Stir in the rhubarb and the 1/4 cup of sliced almonds before pouring the batter into the prepared pan.",
      "In a small bowl, combine the sugar, 1/4 cup of almonds and butter. Spoon overtop of the cake and bake on the middle rack of your preheated oven for 30 minutes or until a tester comes out clean with only a few crumbs attached.",
      "Allow to cool a bit before dusting with powdered sugar and serving."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 14],
        ["FOR THE ALMOND TOPPING:", 3]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat your oven to 350℉ (or 180℃) and grease a 9-inch cake pan.\nIn a medium mixing bowl, measure and add the flour, salt, baking soda, baking powder and nutmeg. Whisk to combine.\nIn a larger mixing bowl, combine the sugar, applesauce, egg, vanilla and almond extract. Whisking to combine.\nAlternate adding 1/3 of the dry ingredients with 1/3 of the buttermilk mixing after each addition, repeating until all are incorporated.\nStir in the rhubarb and the 1/4 cup of sliced almonds before pouring the batter into the prepared pan.\nIn a small bowl, combine the sugar, 1/4 cup of almonds and butter. Spoon overtop of the cake and bake on the middle rack of your preheated oven for 30 minutes or until a tester comes out clean with only a few crumbs attached.\nAllow to cool a bit before dusting with powdered sugar and serving.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("simplyscratch.com")
    expect(recipe.canonical_url).to eq("https://www.simplyscratch.com/rhubarb-almond-cake-recipe/")
    expect(recipe.site_name).to eq("Simply Scratch")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Laurie McNamara")
    expect(recipe.description).to eq("Whether it's for brunch of dessert, this Rhubarb Almond Cake is moist and the perfect balance of sweet and tart. In this recipe, fresh rhubarb and almonds are folded into a simple buttermilk batter before being baked into a moist and delicious cake.")
    expect(recipe.image).to eq("https://www.simplyscratch.com/wp-content/uploads/2019/06/Rhubarb-Almond-Cake-l-SimplyScratch.com-rhubarb-almond-cake-summer-dessert-homemade-22.jpg")
    expect(recipe.category).to eq("Desserts & Sweet Treats")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(%w[almond brunch cake dessert rhubarb])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(6)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 g",
      "calories" => "358 kcal",
      "carbohydrateContent" => "61 g",
      "proteinContent" => "8 g",
      "fatContent" => "10 g",
      "saturatedFatContent" => "3 g",
      "cholesterolContent" => "40 mg",
      "sodiumContent" => "381 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "37 g",
      "transFatContent" => "1 g",
      "unsaturatedFatContent" => "7 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "g", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 358.0 },
      { name: "carbohydrateContent", unit: "g", amount: 61.0 },
      { name: "proteinContent", unit: "g", amount: 8.0 },
      { name: "fatContent", unit: "g", amount: 10.0 },
      { name: "saturatedFatContent", unit: "g", amount: 3.0 },
      { name: "cholesterolContent", unit: "mg", amount: 40.0 },
      { name: "sodiumContent", unit: "mg", amount: 381.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 37.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 7.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#commentform")
  end
end
