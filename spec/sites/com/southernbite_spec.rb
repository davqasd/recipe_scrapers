# frozen_string_literal: true

RSpec.describe "southernbite.com" do
  subject(:recipe) { scrape_cassette("com/southernbite", url: "https://southernbite.com/old-fashioned-butter-rolls/") }

  it "reads the title" do
    expect(recipe.title).to eq("Old Fashioned Butter Rolls")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups self-rising flour",
      "1/2 cup shortening",
      "1/2 cup cold water",
      "1/2 cup unsalted butter, very soft",
      "1/4 cup sugar",
      "1/2 teaspoon ground nutmeg (or cinnamon)",
      "2 cups milk",
      "2/3 cup sugar",
      "1 teaspoon vanilla extract"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "self-rising flour" },
      { amount: 0.5, unit: "cup", name: "shortening" },
      { amount: 0.5, unit: "cup", name: "cold water" },
      { amount: 0.5, unit: "cup", name: "unsalted butter, very soft" },
      { amount: 0.25, unit: "cup", name: "sugar" },
      { amount: 0.5, unit: "teaspoon", name: "ground nutmeg" },
      { amount: 2.0, unit: "cups", name: "milk" },
      { amount: 0.67, unit: "cup", name: "sugar" },
      { amount: 1.0, unit: "teaspoon", name: "vanilla extract" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 350°F and lightly spray a 9x13-inch baking dish with nonstick cooking spray.",
      "In a large bowl, cut the shortening into the flour using a pastry blender or two forks. The goal is to get the shortening cut into tiny pea-size pieces.",
      "Add the water and stir until combined. Use your hands to gently knead the dough until it holds together.",
      "Turn the dough out onto a lightly floured surface and roll the dough into a thin rectangle that is about 10x16-inches. Spread the soft butter to cover the dough then sprinkle with the sugar and nutmeg (or cinnamon). Carefully and tightly roll the dough up jelly roll or cinnamon roll style and pinch to seal the long edge. Cut the dough into 12 even rolls and place them into the prepared dish.",
      "Make the sauce:",
      "Combine the milk and sugar in a small pot over medium high heat. Stir until the milk just begins to bubble. Remove from the heat and stir in the vanilla. Pour the mixture over the rolls.",
      "Bake uncovered for 35 to 45 minutes or until the rolls are brown on the tops. Serve warm."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 6],
        ["For the sauce:", 3]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 350°F and lightly spray a 9x13-inch baking dish with nonstick cooking spray.\nIn a large bowl, cut the shortening into the flour using a pastry blender or two forks. The goal is to get the shortening cut into tiny pea-size pieces.\nAdd the water and stir until combined. Use your hands to gently knead the dough until it holds together.\nTurn the dough out onto a lightly floured surface and roll the dough into a thin rectangle that is about 10x16-inches. Spread the soft butter to cover the dough then sprinkle with the sugar and nutmeg (or cinnamon). Carefully and tightly roll the dough up jelly roll or cinnamon roll style and pinch to seal the long edge. Cut the dough into 12 even rolls and place them into the prepared dish.\nMake the sauce:\nCombine the milk and sugar in a small pot over medium high heat. Stir until the milk just begins to bubble. Remove from the heat and stir in the vanilla. Pour the mixture over the rolls.\nBake uncovered for 35 to 45 minutes or until the rolls are brown on the tops. Serve warm.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("southernbite.com")
    expect(recipe.canonical_url).to eq("https://southernbite.com/old-fashioned-butter-rolls/")
    expect(recipe.site_name).to eq("Southern Bite")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Stacey Little")
    expect(recipe.description).to eq("These Old Fashioned Butter Rolls feature tender, flaky rolls baked in a sweetened milk sauce resulting in a moist and ooey-gooey dessert.")
    expect(recipe.image).to eq("https://southernbite.com/wp-content/uploads/2020/09/Old-Fashioned-Butter-Rolls-4.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(25)
    expect(recipe.cook_time).to eq(35)
    expect(recipe.keywords).to eq([
      "butter",
      "butter rolls",
      "butter sauce",
      "dessert",
      "old fashioned",
      "recipe",
      "rolls",
      "sauce",
      "southern",
      "vintage"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(8)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "303 kcal",
      "carbohydrateContent" => "32 g",
      "proteinContent" => "4 g",
      "fatContent" => "18 g",
      "saturatedFatContent" => "8 g",
      "transFatContent" => "1 g",
      "cholesterolContent" => "25 mg",
      "sodiumContent" => "18 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "17 g",
      "unsaturatedFatContent" => "9 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 303.0 },
      { name: "carbohydrateContent", unit: "g", amount: 32.0 },
      { name: "proteinContent", unit: "g", amount: 4.0 },
      { name: "fatContent", unit: "g", amount: 18.0 },
      { name: "saturatedFatContent", unit: "g", amount: 8.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 25.0 },
      { name: "sodiumContent", unit: "mg", amount: 18.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 17.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 9.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://southernbite.com/cookbooks/supper-made-simple/")
  end
end
