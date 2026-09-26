# frozen_string_literal: true

RSpec.describe "castironskilletcooking.com" do
  subject(:recipe) { scrape_cassette("com/castironskilletcooking", url: "https://www.castironskilletcooking.com/elk-steak-stroganoff/") }

  it "reads the title" do
    expect(recipe.title).to eq("Elk Steak Stroganoff")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 lb elk steaks",
      "2 tablespoons of cooking oil (olive oil or similar)",
      "1 teaspoon salt (sea salt work well)",
      "1/2 teaspoon ground black pepper",
      "1 yellow onion (diced)",
      "10 oz white mushrooms (sliced)",
      "4 tablespoons butter",
      "3 tablespoons all-purpose flour (or sub for cornstarch)",
      "2 cups beef broth",
      "1/2 cup heavy whipping cream",
      "1 tablespoon Dijon mustard",
      "egg noodles for serving"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "lb", name: "elk steaks" },
      { amount: 2.0, unit: "tablespoons", name: "cooking oil" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: 0.5, unit: "teaspoon", name: "ground black pepper" },
      { amount: 1.0, unit: nil, name: "yellow onion" },
      { amount: 10.0, unit: "oz", name: "white mushrooms" },
      { amount: 4.0, unit: "tablespoons", name: "butter" },
      { amount: 3.0, unit: "tablespoons", name: "all-purpose flour" },
      { amount: 2.0, unit: "cups", name: "beef broth" },
      { amount: 0.5, unit: "cup", name: "heavy whipping cream" },
      { amount: 1.0, unit: "tablespoon", name: "Dijon mustard" },
      { amount: nil, unit: nil, name: "egg noodles for serving" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Slice elk steaks into thin strips and season with salt and pepper.",
      "Sear elk strips in a hot skillet for 2 minutes, flipping every 30 seconds. Set aside.",
      "Saute onions in butter until soft, then add mushrooms and cook until browned.",
      "Stir in flour, then add beef broth, heavy cream, and Dijon mustard. Mix well.",
      "Return elk strips to the skillet, bring to a simmer, then reduce heat to thicken sauce and finish cooking meat.",
      "Salt and pepper to taste.",
      "Serve over egg noodles or rice."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Slice elk steaks into thin strips and season with salt and pepper.\nSear elk strips in a hot skillet for 2 minutes, flipping every 30 seconds. Set aside.\nSaute onions in butter until soft, then add mushrooms and cook until browned.\nStir in flour, then add beef broth, heavy cream, and Dijon mustard. Mix well.\nReturn elk strips to the skillet, bring to a simmer, then reduce heat to thicken sauce and finish cooking meat.\nSalt and pepper to taste.\nServe over egg noodles or rice.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("castironskilletcooking.com")
    expect(recipe.canonical_url).to eq("https://www.castironskilletcooking.com/elk-steak-stroganoff/")
    expect(recipe.site_name).to eq("Cast Iron Skillet Cooking")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Laura")
    expect(recipe.description).to eq("Homemade elk steak stroganoff with a creamy mushroom sauce.")
    expect(recipe.image).to eq("https://www.castironskilletcooking.com/wp-content/uploads/2024/02/elk-steak-stroganoff-2.jpg")
    expect(recipe.category).to eq("main")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["easy", "one dish", "Elk Steak Stroganoff"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.8)
    expect(recipe.ratings_count).to eq(5)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "271 kcal",
      "carbohydrateContent" => "5 g",
      "proteinContent" => "25 g",
      "fatContent" => "17 g",
      "saturatedFatContent" => "9 g",
      "transFatContent" => "0.3 g",
      "cholesterolContent" => "32 mg",
      "sodiumContent" => "635 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "2 g",
      "unsaturatedFatContent" => "8 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 271.0 },
      { name: "carbohydrateContent", unit: "g", amount: 5.0 },
      { name: "proteinContent", unit: "g", amount: 25.0 },
      { name: "fatContent", unit: "g", amount: 17.0 },
      { name: "saturatedFatContent", unit: "g", amount: 9.0 },
      { name: "transFatContent", unit: "g", amount: 0.3 },
      { name: "cholesterolContent", unit: "mg", amount: 32.0 },
      { name: "sodiumContent", unit: "mg", amount: 635.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 8.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
