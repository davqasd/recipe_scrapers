# frozen_string_literal: true

RSpec.describe "brokenovenbaking.com" do
  subject(:recipe) { scrape_cassette("com/brokenovenbaking", url: "https://brokenovenbaking.com/easy-homemade-strawberry-muffins/") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy Homemade Strawberry Muffins")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2¼ cups all-purpose flour (divided (weighed in grams for best results))",
      "2 teaspoons baking powder",
      "½ teaspoon salt",
      "½ cup vegetable oil (or other neutral oil)",
      "1 cup granulated sugar",
      "2 large eggs (room temperature)",
      "1½ teaspoons vanilla extract",
      "¼ teaspoon almond extract (optional)",
      "½ cup Lifeway Organic Strawberry Whole Milk Kefir (room temperature)",
      "2 cups chopped strawberries (divided)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.25, unit: "cups", name: "all-purpose flour" },
      { amount: 2.0, unit: "teaspoons", name: "baking powder" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 0.5, unit: "cup", name: "vegetable oil" },
      { amount: 1.0, unit: "cup", name: "granulated sugar" },
      { amount: 2.0, unit: nil, name: "large eggs" },
      { amount: 1.5, unit: "teaspoons", name: "vanilla extract" },
      { amount: 0.25, unit: "teaspoon", name: "almond extract" },
      { amount: 0.5, unit: "cup", name: "Lifeway Organic Strawberry Whole Milk Kefir" },
      { amount: 2.0, unit: "cups", name: "chopped strawberries" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 375°F and fill a muffin pan with liners or grease with non-stick spray.",
      "In a medium bowl, whisk together 2 cups of flour, the baking powder, and salt.",
      "In a large bowl, whisk together the vegetable oil, sugar, eggs, vanilla extract, almond extract (if using), and strawberry kefir.",
      "Chop and measure the strawberries. Pat them dry if they're super juicy.Set aside ½ cup of the chopped berries. Coat 1½ cups of them in ¼ cup of flour.",
      "Stir the dry ingredients into the wet ingredients until just a few flour streaks are visible.",
      "Fold the flour-coated strawberries into the batter just until combined.",
      "Fill the muffin liners about ¾ full with batter. Top with the remaining ½ cup of strawberries and optional coarse sugar.",
      "Bake on the middle rack until a toothpick comes out of the center clean (about 20-25 minutes).",
      "Once the muffins are cool enough to touch, transfer them to a wire cooling rack."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 375°F and fill a muffin pan with liners or grease with non-stick spray.\nIn a medium bowl, whisk together 2 cups of flour, the baking powder, and salt.\nIn a large bowl, whisk together the vegetable oil, sugar, eggs, vanilla extract, almond extract (if using), and strawberry kefir.\nChop and measure the strawberries. Pat them dry if they're super juicy.Set aside ½ cup of the chopped berries. Coat 1½ cups of them in ¼ cup of flour.\nStir the dry ingredients into the wet ingredients until just a few flour streaks are visible.\nFold the flour-coated strawberries into the batter just until combined.\nFill the muffin liners about ¾ full with batter. Top with the remaining ½ cup of strawberries and optional coarse sugar.\nBake on the middle rack until a toothpick comes out of the center clean (about 20-25 minutes).\nOnce the muffins are cool enough to touch, transfer them to a wire cooling rack.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("brokenovenbaking.com")
    expect(recipe.canonical_url).to eq("https://brokenovenbaking.com/easy-homemade-strawberry-muffins/")
    expect(recipe.site_name).to eq("Broken Oven Baking")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Kayla Burton")
    expect(recipe.description).to eq("Enjoy homemade strawberry muffins for breakfast in just 30 minutes! This recipe is easy to make with real fresh or frozen strawberries.")
    expect(recipe.image).to eq("https://brokenovenbaking.com/wp-content/uploads/2024/02/strawberry-muffins-12.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq(["strawberry muffins"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "258 kcal",
      "carbohydrateContent" => "37 g",
      "proteinContent" => "4 g",
      "fatContent" => "11 g",
      "saturatedFatContent" => "2 g",
      "transFatContent" => "0.1 g",
      "cholesterolContent" => "32 mg",
      "sodiumContent" => "186 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "18 g",
      "unsaturatedFatContent" => "8 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 258.0 },
      { name: "carbohydrateContent", unit: "g", amount: 37.0 },
      { name: "proteinContent", unit: "g", amount: 4.0 },
      { name: "fatContent", unit: "g", amount: 11.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "transFatContent", unit: "g", amount: 0.1 },
      { name: "cholesterolContent", unit: "mg", amount: 32.0 },
      { name: "sodiumContent", unit: "mg", amount: 186.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 18.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 8.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://brokenovenbaking.com/")
  end
end
