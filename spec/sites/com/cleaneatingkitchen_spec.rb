# frozen_string_literal: true

RSpec.describe "cleaneatingkitchen.com" do
  subject(:recipe) { scrape_cassette("com/cleaneatingkitchen", url: "https://www.cleaneatingkitchen.com/iced-coffee-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Iced Coffee Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups ice cubes or coffee ice cubes (see notes)",
      "16 ounces brewed coffee, at room temperature or chilled (see notes)",
      "¼ cup milk or plant milk (I used almond milk)",
      "Sweetener of choice, optional"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "ice cubes or coffee ice cubes" },
      { amount: 16.0, unit: "ounces", name: "brewed coffee, at room temperature or chilled" },
      { amount: 0.25, unit: "cup", name: "milk or plant milk" },
      { amount: nil, unit: nil, name: "Sweetener of choice, optional" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Divide your ice cubes between two glasses. You can also use crushed ice, if you prefer.",
      "Pour the coffee between the two glasses.",
      "Top with milk and sweetener.",
      "Stir to combine and serve immediately."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Divide your ice cubes between two glasses. You can also use crushed ice, if you prefer.\nPour the coffee between the two glasses.\nTop with milk and sweetener.\nStir to combine and serve immediately.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cleaneatingkitchen.com")
    expect(recipe.canonical_url).to eq("https://www.cleaneatingkitchen.com/iced-coffee-recipe/")
    expect(recipe.site_name).to eq("Clean Eating Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Carrie Forrest, MPH in Nutrition")
    expect(recipe.description).to eq("This Iced Coffee recipe is a perfect drink for hot summer days. Skip the store-bought versions and make your own instead. I’ll share how to make the boldest and strongest iced coffee you’ve ever had!")
    expect(recipe.image).to eq("https://www.cleaneatingkitchen.com/wp-content/uploads/2022/05/pouring-milk-into-iced-coffee-on-table-225x225.jpg")
    expect(recipe.category).to eq("Drink")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to eq("Easy")
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(7)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(2)
    expect(recipe.keywords).to eq(["how to make iced coffee", "keto iced coffee", "sugar-free iced coffee"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["LowCalorieDiet"])
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "7 calories",
      "sugarContent" => "0 g",
      "sodiumContent" => "37.3 mg",
      "fatContent" => "0.4 g",
      "saturatedFatContent" => "0 g",
      "transFatContent" => "0 g",
      "carbohydrateContent" => "0.2 g",
      "fiberContent" => "0 g",
      "proteinContent" => "0.5 g",
      "cholesterolContent" => "0 mg"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 7.0 },
      { name: "sugarContent", unit: "g", amount: 0.0 },
      { name: "sodiumContent", unit: "mg", amount: 37.3 },
      { name: "fatContent", unit: "g", amount: 0.4 },
      { name: "saturatedFatContent", unit: "g", amount: 0.0 },
      { name: "transFatContent", unit: "g", amount: 0.0 },
      { name: "carbohydrateContent", unit: "g", amount: 0.2 },
      { name: "fiberContent", unit: "g", amount: 0.0 },
      { name: "proteinContent", unit: "g", amount: 0.5 },
      { name: "cholesterolContent", unit: "mg", amount: 0.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
