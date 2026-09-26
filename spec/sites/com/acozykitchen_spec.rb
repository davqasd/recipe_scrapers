# frozen_string_literal: true

RSpec.describe "acozykitchen.com" do
  subject(:recipe) { scrape_cassette("com/acozykitchen", url: "https://www.acozykitchen.com/burger-sauce") }

  it "reads the title" do
    expect(recipe.title).to eq("Burger Sauce Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2-3 small bread and butter pickles",
      "1/2 cup mayonnaise",
      "2 tablespoons ketchup",
      "1 teaspoon Dijon mustard",
      "Pinch garlic powder",
      "Pinch kosher salt",
      "Freshly ground pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "small bread and butter pickles" },
      { amount: 0.5, unit: "cup", name: "mayonnaise" },
      { amount: 2.0, unit: "tablespoons", name: "ketchup" },
      { amount: 1.0, unit: "teaspoon", name: "Dijon mustard" },
      { amount: 1.0, unit: "Pinch", name: "garlic powder" },
      { amount: 1.0, unit: "Pinch", name: "kosher salt" },
      { amount: nil, unit: nil, name: "Freshly ground pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Dice up the pickles. If you want it smaller, feel free to mince it. I like it a bit chunky so I keep it diced.",
      "Add all of the ingredients to a small bowl and mix up. Add this sauce to smash burgers, Big Macs, animal-style French fries and more. Store in an airtight container for up to two weeks."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Dice up the pickles. If you want it smaller, feel free to mince it. I like it a bit chunky so I keep it diced.\nAdd all of the ingredients to a small bowl and mix up. Add this sauce to smash burgers, Big Macs, animal-style French fries and more. Store in an airtight container for up to two weeks.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("acozykitchen.com")
    expect(recipe.canonical_url).to eq("https://www.acozykitchen.com/burger-sauce")
    expect(recipe.site_name).to eq("A Cozy Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Adrianna Adarme")
    expect(recipe.description).to eq("Use this burger sauce recipe for your favorite Smash Burgers, Shake Shake Copycat Burgers, Big Macs or animal-style fries. It's super easy to mix up and smother on all your favorite diner classics.")
    expect(recipe.image).to eq("https://www.acozykitchen.com/wp-content/uploads/2025/03/BurgerSauce-4.jpg")
    expect(recipe.category).to eq("Condiment")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("0 items")
    expect(recipe.total_time).to eq(7)
    expect(recipe.prep_time).to eq(2)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["animal fries sauce", "burger sauce", "in and out sauce"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["GlutenFreeDiet"])
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "50 kcal",
      "carbohydrateContent" => "2 g",
      "fatContent" => "12 g",
      "saturatedFatContent" => "7 g",
      "transFatContent" => "0.3 g",
      "cholesterolContent" => "32 mg",
      "sodiumContent" => "32 mg",
      "fiberContent" => "0.4 g",
      "sugarContent" => "1 g",
      "unsaturatedFatContent" => "5 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 50.0 },
      { name: "carbohydrateContent", unit: "g", amount: 2.0 },
      { name: "fatContent", unit: "g", amount: 12.0 },
      { name: "saturatedFatContent", unit: "g", amount: 7.0 },
      { name: "transFatContent", unit: "g", amount: 0.3 },
      { name: "cholesterolContent", unit: "mg", amount: 32.0 },
      { name: "sodiumContent", unit: "mg", amount: 32.0 },
      { name: "fiberContent", unit: "g", amount: 0.4 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 5.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
