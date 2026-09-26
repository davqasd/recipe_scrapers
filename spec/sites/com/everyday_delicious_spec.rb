# frozen_string_literal: true

RSpec.describe "everyday-delicious.com" do
  subject(:recipe) { scrape_cassette("com/everyday_delicious", url: "https://www.everyday-delicious.com/strawberry-bread/") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy strawberry bread (one bowl)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1/2 cup buttermilk (125g)",
      "2 large eggs",
      "2 teaspoons vanilla extract",
      "1/2 cup melted butter (115g)",
      "1 cup granulated sugar (200g)",
      "2 cups + 2 tablespoons flour (270g)",
      "1/2 teaspoon baking soda",
      "2 teaspoons baking powder",
      "1/4 teaspoon fine sea salt",
      "11 oz strawberries (310g)",
      "2 tablespoons flour"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.5, unit: "cup", name: "buttermilk" },
      { amount: 2.0, unit: nil, name: "large eggs" },
      { amount: 2.0, unit: "teaspoons", name: "vanilla extract" },
      { amount: 0.5, unit: "cup", name: "melted butter" },
      { amount: 1.0, unit: "cup", name: "granulated sugar" },
      { amount: 2.0, unit: "cups", name: "flour" },
      { amount: 0.5, unit: "teaspoon", name: "baking soda" },
      { amount: 2.0, unit: "teaspoons", name: "baking powder" },
      { amount: 0.25, unit: "teaspoon", name: "fine sea salt" },
      { amount: 11.0, unit: "oz", name: "strawberries" },
      { amount: 2.0, unit: "tablespoons", name: "flour" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Prepare a 9×5 inch loaf pan (23×13 cm) or 10×4.5 inch pan (25.5×11.5cm) by buttering it and lining it with parchment paper.",
      "Preheat the oven to 350°F / 180°C / Gas Mark 4 (if you have a convection oven reduce the temperature by about 20° or follow the manufacturer's instructions).",
      "Add the buttermilk, eggs, vanilla, melted and cooled butter, and sugar into a large bowl.",
      "Mix with an electric mixer or just a whisk until combined.",
      "Hang a fine mesh strainer over the bowl, add the flour (2 cups), baking soda, baking powder, and salt. Stir it briefly with a spoon then sift into the bowl.",
      "Whisk until almost combined.",
      "Wash the strawberries, pat them dry with paper towels, cut off the tops then cut them into small pieces. Toss with 2 tablespoons flour until coated on all sides.",
      "Add 2/3 of the strawberries and all the flour from the bottom of the bowl to the batter. Fold in with a silicone spatula until combined.",
      "Transfer the batter to the loaf pan.",
      "Top with the remaining strawberries.",
      "Bake for 1h 10 mins or until a cake tester (or a wooden skewer) comes out clean (check after 1h). After about 30 minutes, you can cover the cake loosely with a piece of aluminum foil, if it's browning too much. The baking time may vary depending on the oven.",
      "Leave on a cooling rack to cool slightly then cut into slices and serve.",
      "Enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Prepare a 9×5 inch loaf pan (23×13 cm) or 10×4.5 inch pan (25.5×11.5cm) by buttering it and lining it with parchment paper.\nPreheat the oven to 350°F / 180°C / Gas Mark 4 (if you have a convection oven reduce the temperature by about 20° or follow the manufacturer's instructions).\nAdd the buttermilk, eggs, vanilla, melted and cooled butter, and sugar into a large bowl.\nMix with an electric mixer or just a whisk until combined.\nHang a fine mesh strainer over the bowl, add the flour (2 cups), baking soda, baking powder, and salt. Stir it briefly with a spoon then sift into the bowl.\nWhisk until almost combined.\nWash the strawberries, pat them dry with paper towels, cut off the tops then cut them into small pieces. Toss with 2 tablespoons flour until coated on all sides.\nAdd 2/3 of the strawberries and all the flour from the bottom of the bowl to the batter. Fold in with a silicone spatula until combined.\nTransfer the batter to the loaf pan.\nTop with the remaining strawberries.\nBake for 1h 10 mins or until a cake tester (or a wooden skewer) comes out clean (check after 1h). After about 30 minutes, you can cover the cake loosely with a piece of aluminum foil, if it's browning too much. The baking time may vary depending on the oven.\nLeave on a cooling rack to cool slightly then cut into slices and serve.\nEnjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("everyday-delicious.com")
    expect(recipe.canonical_url).to eq("https://www.everyday-delicious.com/strawberry-bread/")
    expect(recipe.site_name).to eq("Everyday Delicious")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Aleksandra")
    expect(recipe.description).to eq("This strawberry bread is so easy and quick to whip out. You only need one bowl and just a couple of ingredients. This easy cake is super moist and filled with strawberries")
    expect(recipe.image).to eq("https://www.everyday-delicious.com/wp-content/uploads/2021/07/strawberry-bread-everyday-delicious-1.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("1 servings")
    expect(recipe.total_time).to eq(80)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(70)
    expect(recipe.keywords).to eq(["Easy strawberry bread", "Quick strawberry bread"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "calories" => "285 kcal", "servingSize" => "1 serving" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 285.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.everyday-delicious.com/subscribe/")
  end
end
