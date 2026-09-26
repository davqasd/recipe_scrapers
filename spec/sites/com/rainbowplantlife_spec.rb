# frozen_string_literal: true

RSpec.describe "rainbowplantlife.com" do
  subject(:recipe) { scrape_cassette("com/rainbowplantlife", url: "https://rainbowplantlife.com/vegan-brown-butter-peach-cobbler/") }

  it "reads the title" do
    expect(recipe.title).to eq("Vegan Brown Butter Peach Cobbler")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 pound (454g) ripe but relatively firm peaches",
      "1/2 cup (80g) fresh blueberries",
      "1/3 cup (55g) organic brown sugar (or coconut sugar)",
      "1 teaspoon ground cinnamon",
      "1/4 teaspoon freshly grated nutmeg",
      "Scant 1/2 teaspoon ground ginger",
      "1/8 teaspoon ground cardamom (optional)",
      "10 tablespoons (140g) vegan butter (see Note 1)",
      "1 1/2 cups (188g) all-purpose flour",
      "Scant 2/3 cup (65g) old-fashioned rolled oats",
      "1 cup (200g) organic cane sugar",
      "Scant 1/2 teaspoon kosher salt ((see Note 2) )",
      "2 teaspoons baking powder",
      "1 1/4 cups (300 mL) full-fat oat milk ((see Note 3) )",
      "1 1/2 teaspoons pure vanilla extract",
      "1/4 teaspoon pure almond extract (optional)",
      "For serving: vegan vanilla ice cream (optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "pound", name: "ripe but relatively firm peaches" },
      { amount: 0.5, unit: "cup", name: "fresh blueberries" },
      { amount: 0.33, unit: "cup", name: "organic brown sugar" },
      { amount: 1.0, unit: "teaspoon", name: "ground cinnamon" },
      { amount: 0.25, unit: "teaspoon", name: "freshly grated nutmeg" },
      { amount: 0.5, unit: "teaspoon", name: "ground ginger" },
      { amount: 0.13, unit: "teaspoon", name: "ground cardamom" },
      { amount: 10.0, unit: "tablespoons", name: "vegan butter" },
      { amount: 1.5, unit: "cups", name: "all-purpose flour" },
      { amount: 0.67, unit: "cup", name: "old-fashioned rolled oats" },
      { amount: 1.0, unit: "cup", name: "organic cane sugar" },
      { amount: 0.5, unit: "teaspoon", name: "kosher salt" },
      { amount: 2.0, unit: "teaspoons", name: "baking powder" },
      { amount: 1.25, unit: "cups", name: "full-fat oat milk" },
      { amount: 1.5, unit: "teaspoons", name: "pure vanilla extract" },
      { amount: 0.25, unit: "teaspoon", name: "pure almond extract" },
      { amount: nil, unit: nil, name: "For serving: vegan vanilla ice cream" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Arrange a rack in the middle of your oven and preheat it to 375°F/190°C.",
      "Cut the peaches in half and remove the pits, then cut the peaches into ¼ to ½ inch thick slices (~ 1 cm thick). Transfer the peaches to a medium or large bowl. Add the blueberries, brown sugar, cinnamon, nutmeg, ginger, and cardamom (if using), and toss gently to combine.Set aside for 30 minutes to allow the fruit to absorb the flavors.",
      "Toast the butter. Heat a 12-inch cast iron skillet over medium heat. Add the vegan butter to the pan, and use a spatula to spread it across the sides of the pan. Once it’s melted, foamy, and at a bubble (it should take 2 to 3 minutes), heat for another 2 minutes, stirring frequently to prevent burning, then take the pan off the heat.NOTE: If the butter doesn’t turn golden but still smells nutty in aroma, that’s fine. See Note 4 if you don't have a cast iron skillet.",
      "Make the cake batter. In a medium or large bowl, combine the flour, oats, cane sugar, salt, and baking powder. Whisk well to combine. Add in the oat milk and vanilla extract and almond extract (if using) and fold with a silicone spatula until combined.",
      "Using a ladle or measuring cup, ladle the batter on top of the brown butter in the pan in different spots (ladling, instead of pouring all of the batter on top at once, helps the butter swirl and mix into batter). Arrange the peaches on top, then the blueberries, and spoon on the reserved juices.",
      "Bake the cobbler for 45 to 50 minutes, rotating the pan 180° halfway through to ensure even browning, until the top is deeply golden brown and bubbling.",
      "Transfer to a wire rack to cool for 10 to 20 minutes, then serve warm. If desired, scoop some vegan vanilla ice cream on each slice before serving."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Arrange a rack in the middle of your oven and preheat it to 375°F/190°C.\nCut the peaches in half and remove the pits, then cut the peaches into ¼ to ½ inch thick slices (~ 1 cm thick). Transfer the peaches to a medium or large bowl. Add the blueberries, brown sugar, cinnamon, nutmeg, ginger, and cardamom (if using), and toss gently to combine.Set aside for 30 minutes to allow the fruit to absorb the flavors.\nToast the butter. Heat a 12-inch cast iron skillet over medium heat. Add the vegan butter to the pan, and use a spatula to spread it across the sides of the pan. Once it’s melted, foamy, and at a bubble (it should take 2 to 3 minutes), heat for another 2 minutes, stirring frequently to prevent burning, then take the pan off the heat.NOTE: If the butter doesn’t turn golden but still smells nutty in aroma, that’s fine. See Note 4 if you don't have a cast iron skillet.\nMake the cake batter. In a medium or large bowl, combine the flour, oats, cane sugar, salt, and baking powder. Whisk well to combine. Add in the oat milk and vanilla extract and almond extract (if using) and fold with a silicone spatula until combined.\nUsing a ladle or measuring cup, ladle the batter on top of the brown butter in the pan in different spots (ladling, instead of pouring all of the batter on top at once, helps the butter swirl and mix into batter). Arrange the peaches on top, then the blueberries, and spoon on the reserved juices.\nBake the cobbler for 45 to 50 minutes, rotating the pan 180° halfway through to ensure even browning, until the top is deeply golden brown and bubbling.\nTransfer to a wire rack to cool for 10 to 20 minutes, then serve warm. If desired, scoop some vegan vanilla ice cream on each slice before serving.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("rainbowplantlife.com")
    expect(recipe.canonical_url).to eq("https://rainbowplantlife.com/vegan-brown-butter-peach-cobbler/")
    expect(recipe.site_name).to eq("Rainbow Plant Life")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Nisha Vora")
    expect(recipe.description).to eq("A delicious twist on the classic Southern peach cobbler. Peaches and blueberries get swirled with vegan brown butter and cobbler, making for a cake that’s sticky and caramelized on the outside yet fluffy and tender on the inside. It’s truly the best vegan peach cobbler!")
    expect(recipe.image).to eq("https://rainbowplantlife.com/wp-content/uploads/2020/11/peachblueberrrycobbler286of1029.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("Baking")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(60)
    expect(recipe.prep_time).to eq(35)
    expect(recipe.cook_time).to eq(45)
    expect(recipe.keywords).to eq(%w[cobbler nut-free peach soy-free])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["VeganDiet"])
    expect(recipe.ratings).to eq(4.92)
    expect(recipe.ratings_count).to eq(93)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "304 kcal",
      "carbohydrateContent" => "51 g",
      "proteinContent" => "3 g",
      "fatContent" => "12 g",
      "saturatedFatContent" => "2 g",
      "transFatContent" => "2 g",
      "sodiumContent" => "314 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "34 g",
      "unsaturatedFatContent" => "9 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 304.0 },
      { name: "carbohydrateContent", unit: "g", amount: 51.0 },
      { name: "proteinContent", unit: "g", amount: 3.0 },
      { name: "fatContent", unit: "g", amount: 12.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "transFatContent", unit: "g", amount: 2.0 },
      { name: "sodiumContent", unit: "mg", amount: 314.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 34.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 9.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
