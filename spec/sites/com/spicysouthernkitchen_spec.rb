# frozen_string_literal: true

RSpec.describe "spicysouthernkitchen.com" do
  subject(:recipe) { scrape_cassette("com/spicysouthernkitchen", url: "https://spicysouthernkitchen.com/fried-oreos/") }

  it "reads the title" do
    expect(recipe.title).to eq("Fried Oreos")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup milk",
      "1 large egg",
      "2 teaspoons vegetable oil",
      "1 teaspoon vanilla extract",
      "1½ cups pancake mix",
      "1 tablespoon granulated sugar",
      "12 to 15 Double Stuff Oreo Cookies",
      "powdered sugar",
      "Vegetable oil"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "milk" },
      { amount: 1.0, unit: nil, name: "large egg" },
      { amount: 2.0, unit: "teaspoons", name: "vegetable oil" },
      { amount: 1.0, unit: "teaspoon", name: "vanilla extract" },
      { amount: 1.5, unit: "cups", name: "pancake mix" },
      { amount: 1.0, unit: "tablespoon", name: "granulated sugar" },
      { amount: 12.0, unit: nil, name: "Double Stuff Oreo Cookies" },
      { amount: nil, unit: nil, name: "powdered sugar" },
      { amount: nil, unit: nil, name: "Vegetable oil" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Whisk together milk, egg, vegetable oil, and vanilla extract in a mixing bowl.",
      "Add pancake mix and granulated sugar and stir just until combined. Let sit 5 to 10 minutes.",
      "Pour 1 to 2 inches of oil into a Dutch oven. Heat oil to 350 to 370 degrees.",
      "Use a fork to dip the oreos into the batter and coat on both sides and then drop into the oil. Fry for about 2 minutes per side.",
      "Drain on a paper towel-lined plate. Sprinkle with powdered sugar and serve."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Whisk together milk, egg, vegetable oil, and vanilla extract in a mixing bowl.\nAdd pancake mix and granulated sugar and stir just until combined. Let sit 5 to 10 minutes.\nPour 1 to 2 inches of oil into a Dutch oven. Heat oil to 350 to 370 degrees.\nUse a fork to dip the oreos into the batter and coat on both sides and then drop into the oil. Fry for about 2 minutes per side.\nDrain on a paper towel-lined plate. Sprinkle with powdered sugar and serve.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("spicysouthernkitchen.com")
    expect(recipe.canonical_url).to eq("https://spicysouthernkitchen.com/fried-oreos/")
    expect(recipe.site_name).to eq("Spicy Southern Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Christin Mahrlig")
    expect(recipe.description).to eq("You'll feel like you're at the county fair when you whip up a batch of these Fried Oreos. Coated in a golden pancake batter, the cookies get soft and melty inside. They are the perfect sweet treat.")
    expect(recipe.image).to eq("https://spicysouthernkitchen.com/wp-content/uploads/2025/07/Deep-Fried-Oreos-10-1-of-1.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "322 kcal",
      "carbohydrateContent" => "30 g",
      "proteinContent" => "6 g",
      "fatContent" => "20 g",
      "saturatedFatContent" => "5 g",
      "transFatContent" => "0.1 g",
      "cholesterolContent" => "59 mg",
      "sodiumContent" => "285 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "14 g",
      "unsaturatedFatContent" => "14 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 322.0 },
      { name: "carbohydrateContent", unit: "g", amount: 30.0 },
      { name: "proteinContent", unit: "g", amount: 6.0 },
      { name: "fatContent", unit: "g", amount: 20.0 },
      { name: "saturatedFatContent", unit: "g", amount: 5.0 },
      { name: "transFatContent", unit: "g", amount: 0.1 },
      { name: "cholesterolContent", unit: "mg", amount: 59.0 },
      { name: "sodiumContent", unit: "mg", amount: 285.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 14.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 14.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
