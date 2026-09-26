# frozen_string_literal: true

RSpec.describe "valentinascorner.com" do
  subject(:recipe) { scrape_cassette("com/valentinascorner", url: "https://valentinascorner.com/avocado-toast-topping-ideas-and-tips/") }

  it "reads the title" do
    expect(recipe.title).to eq("Avocado Toast (Topping ideas and Tips)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 slices of bread",
      "1 ripe avocados",
      "everything bagel seasoning",
      "desired toppings"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "slices", name: "bread" },
      { amount: 1.0, unit: nil, name: "ripe avocados" },
      { amount: nil, unit: nil, name: "everything bagel seasoning" },
      { amount: nil, unit: nil, name: "desired toppings" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Toast the bread slices until reached desired crispiness.",
      "Remove the pit from the avocado. Scoop out the avocado and add to a bowl. Mash the avocado until chunky or smooth.",
      "Add the avocado spread to the toasted bread and top with everything bagel seasoning and desired toppings.",
      "Enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Toast the bread slices until reached desired crispiness.\nRemove the pit from the avocado. Scoop out the avocado and add to a bowl. Mash the avocado until chunky or smooth.\nAdd the avocado spread to the toasted bread and top with everything bagel seasoning and desired toppings.\nEnjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("valentinascorner.com")
    expect(recipe.canonical_url).to eq("https://valentinascorner.com/avocado-toast-topping-ideas-and-tips/")
    expect(recipe.site_name).to eq("Valentina's Corner")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Valentina Ablaev")
    expect(recipe.description).to eq("A classic avocado toast recipe that is simple, healthy and so GOOD! The best avocado toast topped with different toppings.")
    expect(recipe.image).to eq("https://valentinascorner.com/wp-content/uploads/2020/08/Avocado-Toast-3.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(5)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["avocado toast"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(3)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "236 kcal",
      "carbohydrateContent" => "22 g",
      "proteinContent" => "5 g",
      "fatContent" => "16 g",
      "saturatedFatContent" => "2 g",
      "sodiumContent" => "152 mg",
      "fiberContent" => "8 g",
      "sugarContent" => "2 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 236.0 },
      { name: "carbohydrateContent", unit: "g", amount: 22.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "fatContent", unit: "g", amount: 16.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "sodiumContent", unit: "mg", amount: 152.0 },
      { name: "fiberContent", unit: "g", amount: 8.0 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://valentinascorner.com")
  end
end
