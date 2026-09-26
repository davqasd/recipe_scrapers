# frozen_string_literal: true

RSpec.describe "thinlicious.com" do
  subject(:recipe) { scrape_cassette("com/thinlicious", url: "https://thinlicious.com/keto-hot-dog-buns/") }

  it "reads the title" do
    expect(recipe.title).to eq("Keto Hot Dog Buns")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "¾ cups almond meal/flour",
      "3 tbsp ground flaxseed/linseed",
      "½ tbsp baking powder",
      "1¾ cups pre-shredded/grated mozzarella",
      "2 tbsp natural unsweetened yoghurt",
      "1 eggs",
      "½ tbsp apple cider vinegar",
      "1 tbsp extra virgin olive oil"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.75, unit: "cups", name: "almond meal/flour" },
      { amount: 3.0, unit: "tbsp", name: "ground flaxseed/linseed" },
      { amount: 0.5, unit: "tbsp", name: "baking powder" },
      { amount: 1.75, unit: "cups", name: "pre-shredded/grated mozzarella" },
      { amount: 2.0, unit: "tbsp", name: "natural unsweetened yoghurt" },
      { amount: 1.0, unit: nil, name: "eggs" },
      { amount: 0.5, unit: "tbsp", name: "apple cider vinegar" },
      { amount: 1.0, unit: "tbsp", name: "extra virgin olive oil" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Start by preheating the oven to 350°F (175°C) and line a baking sheet with parchment paper.",
      "Combine the mozzarella cheese, almond flour, ground flaxseed, and plain yogurt in a microwave-safe bowl. Microwave in 30-second increments until melted and well combined. This use takes 2 to 3 increments in the microwave.",
      "Once melted, let the mixture cool slightly. Transfer the slightly cooled mixture to a food processor. Add the egg, apple cider vinegar, and baking powder. Process until a smooth dough forms.",
      "Remove the dough from the food processor and knead it into a ball. Cut the dough into 6 equal pieces.",
      "Shape the dough into hot dog bun shapes on the prepared baking sheet. Brush with olive oil and bake for 15-20 minutes until golden brown.When the buns are done baking let them cool for about 5 minutes then slice them down the center and serve with a grilled hot dog or sausage."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Start by preheating the oven to 350°F (175°C) and line a baking sheet with parchment paper.\nCombine the mozzarella cheese, almond flour, ground flaxseed, and plain yogurt in a microwave-safe bowl. Microwave in 30-second increments until melted and well combined. This use takes 2 to 3 increments in the microwave.\nOnce melted, let the mixture cool slightly. Transfer the slightly cooled mixture to a food processor. Add the egg, apple cider vinegar, and baking powder. Process until a smooth dough forms.\nRemove the dough from the food processor and knead it into a ball. Cut the dough into 6 equal pieces.\nShape the dough into hot dog bun shapes on the prepared baking sheet. Brush with olive oil and bake for 15-20 minutes until golden brown.When the buns are done baking let them cool for about 5 minutes then slice them down the center and serve with a grilled hot dog or sausage.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thinlicious.com")
    expect(recipe.canonical_url).to eq("https://thinlicious.com/keto-hot-dog-buns/")
    expect(recipe.site_name).to eq("Thinlicious")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Thinlicious")
    expect(recipe.description).to eq("Keto hot dog buns are low-carb, gluten-free buns made with a combination of mozzarella cheese, almond flour, and other keto-friendly ingredients, providing a delicious and satisfying alternative for those following a ketogenic or low-carb lifestyle.")
    expect(recipe.image).to eq("https://thinlicious.com/wp-content/uploads/2023/07/Keto-Hot-Dog-Buns-Featured-Image-Template-1200x1200-1.jpg")
    expect(recipe.category).to eq("Baking")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["keto hot dog bun"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 bun (makes 6 buns)",
      "calories" => "334.6 kcal",
      "carbohydrateContent" => "9.7 g",
      "proteinContent" => "17 g",
      "fatContent" => "27.2 g",
      "sodiumContent" => "364.4 mg",
      "fiberContent" => "4.3 g",
      "sugarContent" => "2 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "bun", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 334.6 },
      { name: "carbohydrateContent", unit: "g", amount: 9.7 },
      { name: "proteinContent", unit: "g", amount: 17.0 },
      { name: "fatContent", unit: "g", amount: 27.2 },
      { name: "sodiumContent", unit: "mg", amount: 364.4 },
      { name: "fiberContent", unit: "g", amount: 4.3 },
      { name: "sugarContent", unit: "g", amount: 2.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
