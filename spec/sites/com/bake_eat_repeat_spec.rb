# frozen_string_literal: true

RSpec.describe "bake-eat-repeat.com" do
  subject(:recipe) { scrape_cassette("com/bake_eat_repeat", url: "https://bake-eat-repeat.com/hawaiian-sliders-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Hawaiian Sliders")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "12 Hawaiian dinner rolls",
      "1/2 cup BBQ sauce",
      "12 slices deli ham",
      "12 pineapple rings",
      "2 cups shredded mozzarella cheese",
      "1/4 cup unsalted butter, melted",
      "3/4 teaspoon garlic salt",
      "1 teaspoon onion powder",
      "1 1/2 teaspoons dried parsley"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 12.0, unit: nil, name: "Hawaiian dinner rolls" },
      { amount: 0.5, unit: "cup", name: "BBQ sauce" },
      { amount: 12.0, unit: "slices", name: "deli ham" },
      { amount: 12.0, unit: nil, name: "pineapple rings" },
      { amount: 2.0, unit: "cups", name: "shredded mozzarella cheese" },
      { amount: 0.25, unit: "cup", name: "unsalted butter, melted" },
      { amount: 0.75, unit: "teaspoon", name: "garlic salt" },
      { amount: 1.0, unit: "teaspoon", name: "onion powder" },
      { amount: 1.5, unit: "teaspoons", name: "dried parsley" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 375 degrees F.",
      "Lightly spray a 9x13 inch baking pan with cooking spray.",
      "Slice the dinner rolls in half, if they are pull apart rolls you can leave them stuck together and slice them all at the same time. Place the bottom halves into the prepared baking dish.",
      "Spread the BBQ sauce over the bottom halves of the dinner rolls.",
      "Top with the ham slices and the pineapple rings.",
      "Sprinkle the shredded mozzarella cheese over top of the pineapple.",
      "Cover with the top halves of the dinner rolls.",
      "In a small bowl, whisk together the melted butter, garlic salt, onion powder, and parsley.",
      "Brush this mixture over top of the sliders and cover the whole dish tightly with aluminum foil.",
      "Bake for 15-20 minutes, or until the cheese is melted and the sliders are heated through. Serve warm."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 375 degrees F.\nLightly spray a 9x13 inch baking pan with cooking spray.\nSlice the dinner rolls in half, if they are pull apart rolls you can leave them stuck together and slice them all at the same time. Place the bottom halves into the prepared baking dish.\nSpread the BBQ sauce over the bottom halves of the dinner rolls.\nTop with the ham slices and the pineapple rings.\nSprinkle the shredded mozzarella cheese over top of the pineapple.\nCover with the top halves of the dinner rolls.\nIn a small bowl, whisk together the melted butter, garlic salt, onion powder, and parsley.\nBrush this mixture over top of the sliders and cover the whole dish tightly with aluminum foil.\nBake for 15-20 minutes, or until the cheese is melted and the sliders are heated through. Serve warm.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("bake-eat-repeat.com")
    expect(recipe.canonical_url).to eq("https://bake-eat-repeat.com/hawaiian-sliders-recipe/")
    expect(recipe.site_name).to eq("Bake. Eat. Repeat.")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Bake.Eat.Repeat.")
    expect(recipe.description).to eq("These baked Hawaiian sliders make an easy weeknight dinner that everyone loves! Ham, cheese, and pineapple baked sandwiches are delicious!")
    expect(recipe.image).to eq("https://bake-eat-repeat.com/wp-content/uploads/2021/10/Hawaiian-Sliders-7-720x720.jpg")
    expect(recipe.category).to eq("30 Minute Meals")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq([
      "hawaiian sliders",
      "hawaiian baked sliders",
      "hawaiian sandwiches",
      "hawaiian baked sandwiches",
      "baked sandwiches",
      "baked sliders",
      "sliders recipe",
      "ham and cheese sliders",
      "ham and pineapple sliders",
      "easy weeknight meal",
      "easy dinner recipe",
      "easy recipe"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "400 calories",
      "carbohydrateContent" => "56 grams carbohydrates",
      "cholesterolContent" => "54 milligrams cholesterol",
      "fatContent" => "15 grams fat",
      "fiberContent" => "5 grams fiber",
      "proteinContent" => "15 grams protein",
      "saturatedFatContent" => "8 grams saturated fat",
      "servingSize" => "2 buns",
      "sodiumContent" => "1114 milligrams sodium",
      "sugarContent" => "41 grams sugar",
      "transFatContent" => "0 grams trans fat",
      "unsaturatedFatContent" => "5 grams unsaturated fat"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 400.0 },
      { name: "carbohydrateContent", unit: "g", amount: 56.0 },
      { name: "cholesterolContent", unit: "mg", amount: 54.0 },
      { name: "fatContent", unit: "g", amount: 15.0 },
      { name: "fiberContent", unit: "g", amount: 5.0 },
      { name: "proteinContent", unit: "g", amount: 15.0 },
      { name: "saturatedFatContent", unit: "g", amount: 8.0 },
      { name: "servingSize", unit: "buns", amount: 2.0 },
      { name: "sodiumContent", unit: "mg", amount: 1114.0 },
      { name: "sugarContent", unit: "g", amount: 41.0 },
      { name: "transFatContent", unit: "g", amount: 0.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 5.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
