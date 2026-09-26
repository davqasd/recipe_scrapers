# frozen_string_literal: true

RSpec.describe "melissaknorris.com" do
  subject(:recipe) { scrape_cassette("com/melissaknorris", url: "https://melissaknorris.com/pioneering-today-how-to-make-fresh-raspberry-juice/") }

  it "reads the title" do
    expect(recipe.title).to eq("Fresh Raspberry Juice Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups raspberries (fresh or frozen)",
      "4 ice cubes (omit if using frozen raspberries)",
      "2 Tablespoons honey ()",
      "¼ cup water (adjust if using frozen raspberries)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "raspberries" },
      { amount: 4.0, unit: nil, name: "ice cubes" },
      { amount: 2.0, unit: "Tablespoons", name: "honey" },
      { amount: 0.25, unit: "cup", name: "water" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Prepare the Ingredients: Gather fresh raspberries, ice cubes, sweetener of choice, and water.",
      "Blend: Place all ingredients in a blender and blend until liquefied.",
      "Taste and Adjust: Taste your raspberry juice and adjust sweetener, if needed. Add more water for a thinner consistency or more ice or frozen raspberries for a thicker consistency.",
      "Serve: Pour the juice into glasses. For an extra touch of flavor, add a sprig of mint and a squeeze of lime to each glass. If you prefer, you can blend the mint and lime juice directly into the juice."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Prepare the Ingredients: Gather fresh raspberries, ice cubes, sweetener of choice, and water.\nBlend: Place all ingredients in a blender and blend until liquefied.\nTaste and Adjust: Taste your raspberry juice and adjust sweetener, if needed. Add more water for a thinner consistency or more ice or frozen raspberries for a thicker consistency.\nServe: Pour the juice into glasses. For an extra touch of flavor, add a sprig of mint and a squeeze of lime to each glass. If you prefer, you can blend the mint and lime juice directly into the juice.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("melissaknorris.com")
    expect(recipe.canonical_url).to eq("https://melissaknorris.com/pioneering-today-how-to-make-fresh-raspberry-juice/")
    expect(recipe.site_name).to eq("Melissa K. Norris")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Melissa Norris")
    expect(recipe.description).to eq("Fresh raspberry juice is a simple, delicious, and healthy way to enjoy the bounty of summer. Whether you're looking to cool down on a hot day or want to explore new ways to use your raspberry harvest, this juice is a fantastic choice.")
    expect(recipe.image).to eq("https://melissaknorris.com/wp-content/uploads/2024/07/Raspberry-Juice_Hero_MKN.jpg")
    expect(recipe.category).to eq("Drinks")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(5)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["raspberry juice", "raspberry juice recipe"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(3.45)
    expect(recipe.ratings_count).to eq(65)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 cup",
      "calories" => "126 kcal",
      "carbohydrateContent" => "32 g",
      "proteinContent" => "2 g",
      "fatContent" => "1 g",
      "saturatedFatContent" => "0.03 g",
      "sodiumContent" => "5 mg",
      "fiberContent" => "8 g",
      "sugarContent" => "23 g",
      "unsaturatedFatContent" => "0.6 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "cup", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 126.0 },
      { name: "carbohydrateContent", unit: "g", amount: 32.0 },
      { name: "proteinContent", unit: "g", amount: 2.0 },
      { name: "fatContent", unit: "g", amount: 1.0 },
      { name: "saturatedFatContent", unit: "g", amount: 0.03 },
      { name: "sodiumContent", unit: "mg", amount: 5.0 },
      { name: "fiberContent", unit: "g", amount: 8.0 },
      { name: "sugarContent", unit: "g", amount: 23.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 0.6 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-content")
  end
end
