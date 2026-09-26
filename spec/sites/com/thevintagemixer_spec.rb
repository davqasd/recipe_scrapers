# frozen_string_literal: true

RSpec.describe "thevintagemixer.com" do
  subject(:recipe) { scrape_cassette("com/thevintagemixer", url: "https://www.thevintagemixer.com/cherry-baby-birthday-cake-party/") }

  it "reads the title" do
    expect(recipe.title).to eq("Gluten Free and Sugar Free Cherry Baby Smash Cake")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 tablespoons coconut flour, (+1 teaspoon)",
      "1/4 cup almond flour",
      "1/4 teaspoon baking powder",
      "1/6 teaspoon baking soda",
      "1/4 teaspoon salt",
      "1 ripe banana, (about 1/2 cup)",
      "2 tablespoons coconut oil, (room temp)",
      "2 tablespoons almond butter, (room temp)",
      "1 large egg, (beaten )",
      "1 tablespoon pure maple syrup",
      "1/2 teaspoon pure vanilla extract",
      "1/2 cup cherries, (pitted and chopped)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "tablespoons", name: "coconut flour" },
      { amount: 0.25, unit: "cup", name: "almond flour" },
      { amount: 0.25, unit: "teaspoon", name: "baking powder" },
      { amount: 0.17, unit: "teaspoon", name: "baking soda" },
      { amount: 0.25, unit: "teaspoon", name: "salt" },
      { amount: 1.0, unit: nil, name: "ripe banana" },
      { amount: 2.0, unit: "tablespoons", name: "coconut oil" },
      { amount: 2.0, unit: "tablespoons", name: "almond butter" },
      { amount: 1.0, unit: nil, name: "large egg" },
      { amount: 1.0, unit: "tablespoon", name: "pure maple syrup" },
      { amount: 0.5, unit: "teaspoon", name: "pure vanilla extract" },
      { amount: 0.5, unit: "cup", name: "cherries" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 375 and grease two small ramekins* with coconut oil.",
      "In a small mixing bowl combine the dry ingredients: coconut flour, almond flour, baking powder, baking soda, and salt.",
      "In a separate, medium-sized, bowl mash the banana then add in the coconut oil, almond butter, maple syrup and vanilla. Stir in the egg.",
      "Combine the dry ingredients to the wet and mix only until combined and smooth.",
      "Toss the chopped cherries with a teaspoon or so of coconut flour. Stir these into the batter. Spoon batter out into ramekins and bake at 375 for 20-25 minutes.",
      "Let cool 5 minutes in the pan then remove to a wire rack to cool completely. Wrap in plastic and freeze.",
      "To frost the cake",
      "About 1 hour before serving, remove cakes from freezer. If the cakes are puffed up at the top slice off the top to even them out and make it flat to layer the cakes.",
      "Dap a small amount of frosting under the first cake on the plate so it won't wiggle as you ice it then add a spoonful on top of the cake to place the second layer on top. Frost gently around the sides of the cake and on top. Top the cake with a few fresh cherries."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 375 and grease two small ramekins* with coconut oil.\nIn a small mixing bowl combine the dry ingredients: coconut flour, almond flour, baking powder, baking soda, and salt.\nIn a separate, medium-sized, bowl mash the banana then add in the coconut oil, almond butter, maple syrup and vanilla. Stir in the egg.\nCombine the dry ingredients to the wet and mix only until combined and smooth.\nToss the chopped cherries with a teaspoon or so of coconut flour. Stir these into the batter. Spoon batter out into ramekins and bake at 375 for 20-25 minutes.\nLet cool 5 minutes in the pan then remove to a wire rack to cool completely. Wrap in plastic and freeze.\nTo frost the cake\nAbout 1 hour before serving, remove cakes from freezer. If the cakes are puffed up at the top slice off the top to even them out and make it flat to layer the cakes.\nDap a small amount of frosting under the first cake on the plate so it won't wiggle as you ice it then add a spoonful on top of the cake to place the second layer on top. Frost gently around the sides of the cake and on top. Top the cake with a few fresh cherries.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thevintagemixer.com")
    expect(recipe.canonical_url).to eq("https://www.thevintagemixer.com/cherry-baby-birthday-cake-party/")
    expect(recipe.site_name).to eq("Vintage Mixer")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Becky")
    expect(recipe.description).to eq("This cute Cherry Cake for a baby's first birthday is gluten free, sugar free and paleo making it perfectly healthy for any baby.")
    expect(recipe.image).to eq("https://d6h7vs5ykbiug.cloudfront.net/wp-content/uploads/2017/08/Cherry-Baby-Birthday-Party-2-1.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.thevintagemixer.com")
  end
end
