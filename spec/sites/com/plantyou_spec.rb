# frozen_string_literal: true

RSpec.describe "plantyou.com" do
  subject(:recipe) { scrape_cassette("com/plantyou", url: "https://plantyou.com/banana-oatmeal-muffins/") }

  it "reads the title" do
    expect(recipe.title).to eq("Banana Oatmeal Muffins")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2½ cups oats (or 2 cups oat flour)",
      "3 ripe bananas (large, mashed)",
      "2 tbsp ground flaxseed (mixed with 5 tbsp of water)",
      "¾ cup plant-based milk",
      "1½ tsp vanilla extract",
      "⅓ cup maple syrup",
      "2½ tsp baking powder",
      "½ cup mini chocolate chips (vegan)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.5, unit: "cups", name: "oats" },
      { amount: 3.0, unit: nil, name: "ripe bananas" },
      { amount: 2.0, unit: "tbsp", name: "ground flaxseed" },
      { amount: 0.75, unit: "cup", name: "plant-based milk" },
      { amount: 1.5, unit: "tsp", name: "vanilla extract" },
      { amount: 0.33, unit: "cup", name: "maple syrup" },
      { amount: 2.5, unit: "tsp", name: "baking powder" },
      { amount: 0.5, unit: "cup", name: "mini chocolate chips" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 350F.",
      "First, prepare the flax egg by combining the ground flax with water. Set aside to thicken.",
      "In a casserole dish or bowl, mash the bananas. Add the plant-based milk, vanilla extract, maple syrup and flax “egg”. Stir until combined.",
      "Now, in a blender, add the oats. Blend until a fine flour is formed. Skip this step if using store-bought oat flour.",
      "Into the bowl with the wet ingredients, add the flour and baking powder, and gently stir until a thick batter is formed. Fold in the mini chocolate chips until smooth.",
      "Transfer to a muffin tray, and bake for 25 minutes, until a toothpick comes out clean. This will make approximately 12 muffins."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 350F.\nFirst, prepare the flax egg by combining the ground flax with water. Set aside to thicken.\nIn a casserole dish or bowl, mash the bananas. Add the plant-based milk, vanilla extract, maple syrup and flax “egg”. Stir until combined.\nNow, in a blender, add the oats. Blend until a fine flour is formed. Skip this step if using store-bought oat flour.\nInto the bowl with the wet ingredients, add the flour and baking powder, and gently stir until a thick batter is formed. Fold in the mini chocolate chips until smooth.\nTransfer to a muffin tray, and bake for 25 minutes, until a toothpick comes out clean. This will make approximately 12 muffins.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("plantyou.com")
    expect(recipe.canonical_url).to eq("https://plantyou.com/banana-oatmeal-muffins/")
    expect(recipe.site_name).to eq("PlantYou")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("carleigh")
    expect(recipe.description).to eq("A delicious and healthy vegan muffin recipe that features ripe bananas, oats, and let's not forget chocolate chips!")
    expect(recipe.image).to eq("https://plantyou.com/wp-content/uploads/2025/08/DSC07929-scaled.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to eq([
      "banana muffin",
      "banana oatmeal muffins",
      "chocolate chip muffins",
      "gluten free dessert",
      "gluten free muffins",
      "hidden veggies",
      "low waste recipe",
      "ripe banana recipe",
      "ripe bananas",
      "scrappy cooking",
      "vegan banana muffins",
      "vegan chocolate chip muffins"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(4)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "166.8 kcal",
      "carbohydrateContent" => "30.5 g",
      "proteinContent" => "3.6 g",
      "fatContent" => "3.7 g",
      "saturatedFatContent" => "1.4 g",
      "transFatContent" => "0.01 g",
      "cholesterolContent" => "1.1 mg",
      "sodiumContent" => "103.3 mg",
      "fiberContent" => "3.1 g",
      "sugarContent" => "14.3 g",
      "unsaturatedFatContent" => "1.4 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 166.8 },
      { name: "carbohydrateContent", unit: "g", amount: 30.5 },
      { name: "proteinContent", unit: "g", amount: 3.6 },
      { name: "fatContent", unit: "g", amount: 3.7 },
      { name: "saturatedFatContent", unit: "g", amount: 1.4 },
      { name: "transFatContent", unit: "g", amount: 0.01 },
      { name: "cholesterolContent", unit: "mg", amount: 1.1 },
      { name: "sodiumContent", unit: "mg", amount: 103.3 },
      { name: "fiberContent", unit: "g", amount: 3.1 },
      { name: "sugarContent", unit: "g", amount: 14.3 },
      { name: "unsaturatedFatContent", unit: "g", amount: 1.4 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
