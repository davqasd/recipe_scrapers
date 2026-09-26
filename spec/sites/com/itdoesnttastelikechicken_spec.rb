# frozen_string_literal: true

RSpec.describe "itdoesnttastelikechicken.com" do
  subject(:recipe) { scrape_cassette("com/itdoesnttastelikechicken", url: "https://itdoesnttastelikechicken.com/vegan-bbq-shredded-tofu-shredded-chicken/") }

  it "reads the title" do
    expect(recipe.title).to eq("Vegan BBQ Shredded Tofu")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 350g block extra-firm tofu, (drained and shredded (see step 2))",
      "1 tablespoon light oil (such as canola or vegetable)",
      "1 tablespoon soy sauce (gluten-free if preferred)",
      "2 teaspoons chili powder",
      "1/2 teaspoon smoked paprika",
      "1/2 teaspoon garlic powder",
      "1/4 cup vegan-friendly BBQ sauce",
      "1/4 cup water"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "block", name: "extra-firm tofu" },
      { amount: 1.0, unit: "tablespoon", name: "light oil" },
      { amount: 1.0, unit: "tablespoon", name: "soy sauce" },
      { amount: 2.0, unit: "teaspoons", name: "chili powder" },
      { amount: 0.5, unit: "teaspoon", name: "smoked paprika" },
      { amount: 0.5, unit: "teaspoon", name: "garlic powder" },
      { amount: 0.25, unit: "cup", name: "vegan-friendly BBQ sauce" },
      { amount: 0.25, unit: "cup", name: "water" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat your oven to 350F (180C). Line with parchment paper or lightly grease a large baking sheet.",
      "There is no need to press the tofu as it will dry out in the oven. Simply drain off the excess water and pat dry. Use the large side of a cheese grater to grate the block of tofu into shreds. Set aside.",
      "Mix the oil, soy sauce, chili powder, smoked paprika, and garlic powder in a large bowl. Add the shredded tofu, and use a spatula to gently toss to evenly coat the tofu in the seasonings.",
      "Spread the tofu evenly over the prepared pan. Bake for 28 – 33 minutes, stirring the tofu halfway through, until the tofu is browned. For chewier shreds you will want to bake them a little longer, or for more tender shreds bake them a little less.",
      "Heat the BBQ sauce and water in a pan, and then stir in the baked tofu. The tofu will absorb some of the liquid and it will soften to tofu slightly making the most perfectly meaty texture. Serve hot as a sandwich, in tacos, on nachos, in lettuce wraps, on a baked potato, any way you like! Or allow to cool completely before storing in an air-tight container in the fridge for 3 – 4 days."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat your oven to 350F (180C). Line with parchment paper or lightly grease a large baking sheet.\nThere is no need to press the tofu as it will dry out in the oven. Simply drain off the excess water and pat dry. Use the large side of a cheese grater to grate the block of tofu into shreds. Set aside.\nMix the oil, soy sauce, chili powder, smoked paprika, and garlic powder in a large bowl. Add the shredded tofu, and use a spatula to gently toss to evenly coat the tofu in the seasonings.\nSpread the tofu evenly over the prepared pan. Bake for 28 – 33 minutes, stirring the tofu halfway through, until the tofu is browned. For chewier shreds you will want to bake them a little longer, or for more tender shreds bake them a little less.\nHeat the BBQ sauce and water in a pan, and then stir in the baked tofu. The tofu will absorb some of the liquid and it will soften to tofu slightly making the most perfectly meaty texture. Serve hot as a sandwich, in tacos, on nachos, in lettuce wraps, on a baked potato, any way you like! Or allow to cool completely before storing in an air-tight container in the fridge for 3 – 4 days.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("itdoesnttastelikechicken.com")
    expect(recipe.canonical_url).to eq("https://itdoesnttastelikechicken.com/vegan-bbq-shredded-tofu-shredded-chicken/")
    expect(recipe.site_name).to eq("It Doesn't Taste Like Chicken")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Sam Turnbull @ It Doesn't Taste Like Chicken")
    expect(recipe.description).to eq("Just 8 ingredients and super easy to make. Use it any way you like- pile it bun for a pulled tofu sandwich, layer in a taco or in a burrito, use it for lettuce wraps, top on a baked potato, scatter over nachos. Make-ahead and meal-prep friendly. Gluten-free and oil-free options.")
    expect(recipe.image).to eq("https://itdoesnttastelikechicken.com/wp-content/uploads/2020/05/vegan-BBQ-shredded-tofu-pulled-chicken-best-baked-recipe-sandwich.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(43)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(33)
    expect(recipe.keywords).to eq(%w[
      barbeque
      bbq
      chicken
      pulled
      shredded
      tofu
      vegan
      vegetarian
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.98)
    expect(recipe.ratings_count).to eq(141)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 (recipe makes 4 servings)",
      "calories" => "117 kcal",
      "carbohydrateContent" => "10 g",
      "proteinContent" => "7 g",
      "fatContent" => "5 g",
      "saturatedFatContent" => "1 g",
      "sodiumContent" => "508 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "7 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: nil, amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 117.0 },
      { name: "carbohydrateContent", unit: "g", amount: 10.0 },
      { name: "proteinContent", unit: "g", amount: 7.0 },
      { name: "fatContent", unit: "g", amount: 5.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 508.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 7.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
