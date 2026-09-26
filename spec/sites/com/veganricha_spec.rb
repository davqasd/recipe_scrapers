# frozen_string_literal: true

RSpec.describe "veganricha.com" do
  subject(:recipe) { scrape_cassette("com/veganricha", url: "https://www.veganricha.com/german-chocolate-loaf-cake/") }

  it "reads the title" do
    expect(recipe.title).to eq("Vegan German Chocolate Cake Loaf")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup non dairy milk",
      "1 shot of espresso (or use 1 tsp instant coffee mixed in two tbsp of hot water)",
      "2 tsp vinegar (apple cider or white )",
      "2 tbsp vegan yogurt or apple sauce",
      "1/4 cup oil",
      "1/3 cup sugar (use 2 tbsp more for sweeter)",
      "1 tsp vanilla extract",
      "1 1/2 cups flour (I use all purpose)",
      "1 tbsp corn starch",
      "1/3 cup cocoa powder",
      "2 tsp baking powder",
      "1/4 tsp baking soda",
      "1/2 tsp salt",
      "1 cup packed soft dates",
      "1/2 cup plus 2 tbsp non dairy milk",
      "2 tbsp maple syrup",
      "1/3 cup toasted pecans",
      "1 cup lightly toasted coconut",
      "1/4 tsp salt"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "non dairy milk" },
      { amount: 1.0, unit: "shot", name: "espresso" },
      { amount: 2.0, unit: "tsp", name: "vinegar" },
      { amount: 2.0, unit: "tbsp", name: "vegan yogurt or apple sauce" },
      { amount: 0.25, unit: "cup", name: "oil" },
      { amount: 0.33, unit: "cup", name: "sugar" },
      { amount: 1.0, unit: "tsp", name: "vanilla extract" },
      { amount: 1.5, unit: "cups", name: "flour" },
      { amount: 1.0, unit: "tbsp", name: "corn starch" },
      { amount: 0.33, unit: "cup", name: "cocoa powder" },
      { amount: 2.0, unit: "tsp", name: "baking powder" },
      { amount: 0.25, unit: "tsp", name: "baking soda" },
      { amount: 0.5, unit: "tsp", name: "salt" },
      { amount: 1.0, unit: "cup", name: "packed soft dates" },
      { amount: 0.5, unit: "cup", name: "plus 2 tbsp non dairy milk" },
      { amount: 2.0, unit: "tbsp", name: "maple syrup" },
      { amount: 0.33, unit: "cup", name: "toasted pecans" },
      { amount: 1.0, unit: "cup", name: "lightly toasted coconut" },
      { amount: 0.25, unit: "tsp", name: "salt" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "To make the frosting:",
      "Soak the dates in hot water for at least 15 minutes, then drain. Blend the soaked dates with the milk, and maple syrup until well blended. If you haven't toasted the pecans and the coconut yet, add the pecans to a skillet over medium heat, and toast for 3-4 minutes, and add in the coconut and continue to toast for another 2-3 minutes.",
      "Mix this pecan coconut mixture into the blended date mixture. Add in the salt. Mix well. This is your frosting that you will layer on the cake.",
      "Mix all the dry ingredients for the cake in a bowl, until well combined.",
      "Heat the milk until it is hot, then add to a bowl. add in all of the rest of the wet ingredients and mix well. Add the dry to the wet ingredients, and mix well until you get a somewhat thick batter. If the batter is too thick, add in a tbsp or more of nondairy milk.",
      "Add half of the batter to a lined 9x5 inch loaf pan, even it out, then top it with half of the frosting mixture. Add in the rest of the batter, then top it with the rest of the frosting mixture.",
      "Bake at 375 degrees F (190 c ) for 45 - 55 minutes. Cover the pan lightly with parchment after the first 35 minutes so that the top frosting doesn't get too crusty or burnt.",
      "Check the toothpick from the center of the loaf to see if its done. (Check at 45 mins as ovens and pans vary, the toothpick shouldn’t have any chocolate batter )",
      "Once the cake has been sitting in the pan for 15 minutes, take it out of the pan. You can additionally add a drizzle of melted chocolate on top for a better look, and chocolate flavor.",
      "Cool completely before slicing. Store on the counter for up to a day, and in the fridge for up to 7 days."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["For the Cake Ingredients:", 7],
        ["Dry Ingredients-", 6],
        ["For the Coconut Frosting", 6]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("To make the frosting:\nSoak the dates in hot water for at least 15 minutes, then drain. Blend the soaked dates with the milk, and maple syrup until well blended. If you haven't toasted the pecans and the coconut yet, add the pecans to a skillet over medium heat, and toast for 3-4 minutes, and add in the coconut and continue to toast for another 2-3 minutes.\nMix this pecan coconut mixture into the blended date mixture. Add in the salt. Mix well. This is your frosting that you will layer on the cake.\nMix all the dry ingredients for the cake in a bowl, until well combined.\nHeat the milk until it is hot, then add to a bowl. add in all of the rest of the wet ingredients and mix well. Add the dry to the wet ingredients, and mix well until you get a somewhat thick batter. If the batter is too thick, add in a tbsp or more of nondairy milk.\nAdd half of the batter to a lined 9x5 inch loaf pan, even it out, then top it with half of the frosting mixture. Add in the rest of the batter, then top it with the rest of the frosting mixture.\nBake at 375 degrees F (190 c ) for 45 - 55 minutes. Cover the pan lightly with parchment after the first 35 minutes so that the top frosting doesn't get too crusty or burnt.\nCheck the toothpick from the center of the loaf to see if its done. (Check at 45 mins as ovens and pans vary, the toothpick shouldn’t have any chocolate batter )\nOnce the cake has been sitting in the pan for 15 minutes, take it out of the pan. You can additionally add a drizzle of melted chocolate on top for a better look, and chocolate flavor.\nCool completely before slicing. Store on the counter for up to a day, and in the fridge for up to 7 days.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("veganricha.com")
    expect(recipe.canonical_url).to eq("https://www.veganricha.com/german-chocolate-loaf-cake/")
    expect(recipe.site_name).to eq("Vegan Richa")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Vegan Richa")
    expect(recipe.description).to eq("This Vegan German Chocolate Loaf Cake is a rich and moist chocolate cake baked in a loaf pan, with the traditional nutty pecan and coconut caramel filling running through the middle!")
    expect(recipe.image).to eq("https://www.veganricha.com/wp-content/uploads/2021/03/German-Chocolate-Cake-4956.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(70)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(55)
    expect(recipe.keywords).to eq(["German Chocolate loaf cake", "Vegan chocolate loaf cake"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(14)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "247 kcal",
      "carbohydrateContent" => "34 g",
      "proteinContent" => "4 g",
      "fatContent" => "12 g",
      "saturatedFatContent" => "5 g",
      "sodiumContent" => "205 mg",
      "fiberContent" => "4 g",
      "sugarContent" => "17 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 247.0 },
      { name: "carbohydrateContent", unit: "g", amount: 34.0 },
      { name: "proteinContent", unit: "g", amount: 4.0 },
      { name: "fatContent", unit: "g", amount: 12.0 },
      { name: "saturatedFatContent", unit: "g", amount: 5.0 },
      { name: "sodiumContent", unit: "mg", amount: 205.0 },
      { name: "fiberContent", unit: "g", amount: 4.0 },
      { name: "sugarContent", unit: "g", amount: 17.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
