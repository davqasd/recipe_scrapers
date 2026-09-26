# frozen_string_literal: true

RSpec.describe "kennethtemple.com" do
  subject(:recipe) { scrape_cassette("com/kennethtemple", url: "https://kennethtemple.com/stuffed-bell-peppers-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Vegan Stuffed Bell Peppers")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 16 oz. baby portobello mushrooms (washed, sliced)",
      "½ cup avocado oil",
      "1 medium onion (chopped small)",
      "4 stalks celery chopped small",
      "8 garlic cloves chopped small",
      "6 sprigs fresh thyme",
      "2 tablespoons savory seasoning",
      "2 teaspoons kosher salt",
      "½ cup unsalted vegetable stock",
      "1 cup panko bread crumbs",
      "4 bell peppers (seeded)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "16 oz. baby portobello mushrooms" },
      { amount: 0.5, unit: "cup", name: "avocado oil" },
      { amount: 1.0, unit: nil, name: "medium onion" },
      { amount: 4.0, unit: "stalks", name: "celery chopped small" },
      { amount: 8.0, unit: nil, name: "garlic cloves chopped small" },
      { amount: 6.0, unit: "sprigs", name: "fresh thyme" },
      { amount: 2.0, unit: "tablespoons", name: "savory seasoning" },
      { amount: 2.0, unit: "teaspoons", name: "kosher salt" },
      { amount: 0.5, unit: "cup", name: "unsalted vegetable stock" },
      { amount: 1.0, unit: "cup", name: "panko bread crumbs" },
      { amount: 4.0, unit: nil, name: "bell peppers" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 425°F. In a food processor add mushrooms in batches and blitz on high for 30 seconds, until mushrooms resemble ground meat. Turn on the heat to medium high in a medium pot add 4 tablespoons of oil and mushrooms, cook for 8 minutes, stirring occasionally.",
      "Add the onion, celery, garlic and thyme, cook for 2 minutes. Add savory and salt, stir once or twice. Stir in stock and ½ cup of breadcrumbs, mixture should hold when pressed together. Add bell peppers to a foiled liner baking sheet. Evenly add mixture in bell peppers, sprinkle with remaining bread crumbs and drizzle remaining oil over top. Bake for 25-30 minutes, until breadcrumbs are golden brown."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 425°F. In a food processor add mushrooms in batches and blitz on high for 30 seconds, until mushrooms resemble ground meat. Turn on the heat to medium high in a medium pot add 4 tablespoons of oil and mushrooms, cook for 8 minutes, stirring occasionally.\nAdd the onion, celery, garlic and thyme, cook for 2 minutes. Add savory and salt, stir once or twice. Stir in stock and ½ cup of breadcrumbs, mixture should hold when pressed together. Add bell peppers to a foiled liner baking sheet. Evenly add mixture in bell peppers, sprinkle with remaining bread crumbs and drizzle remaining oil over top. Bake for 25-30 minutes, until breadcrumbs are golden brown.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("kennethtemple.com")
    expect(recipe.canonical_url).to eq("https://kennethtemple.com/stuffed-bell-peppers-recipe/")
    expect(recipe.site_name).to eq("Kenneth Temple")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Kenneth Temple")
    expect(recipe.description).to eq("Traditional New Orleans stuffed bell pepper recipes include ham, shrimp, and ground beef for holidays and celebrations. This recipe is vegan but still is full of rich, deep, Cajun flavors.")
    expect(recipe.image).to eq("https://kennethtemple.com/wp-content/uploads/2021/02/Stuffed-Bell-Peppers.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("African")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq([
      "bell peppers stuffed",
      "new orleans recipe",
      "new orleans stuffed recipe",
      "stuffed bell pepper",
      "stuffed bell peppers",
      "stuffed bell peppers recipe",
      "vegetarian stuffed bell peppers"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "184 kcal",
      "carbohydrateContent" => "13 g",
      "proteinContent" => "2 g",
      "fatContent" => "14 g",
      "saturatedFatContent" => "2 g",
      "sodiumContent" => "715 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "4 g",
      "unsaturatedFatContent" => "12 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 184.0 },
      { name: "carbohydrateContent", unit: "g", amount: 13.0 },
      { name: "proteinContent", unit: "g", amount: 2.0 },
      { name: "fatContent", unit: "g", amount: 14.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "sodiumContent", unit: "mg", amount: 715.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 4.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 12.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://kennethtemple.com/")
  end
end
