# frozen_string_literal: true

RSpec.describe "platingpixels.com" do
  subject(:recipe) { scrape_cassette("com/platingpixels", url: "https://www.platingpixels.com/korean-short-ribs-kalbi/") }

  it "reads the title" do
    expect(recipe.title).to eq("Instant Pot Korean Short Ribs (Kalbi)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 pounds flanken beef short ribs",
      "¾ cup soy sauce",
      "¼ cup honey",
      "2 tablespoons sesame oil",
      "2 tablespoons garlic chili paste",
      "1 tablespoon rice vinegar",
      "½ teaspoon black pepper",
      "½ teaspoon crushed red chili flakes",
      "3 cloves garlic (minced)",
      "1 tablespoon fresh grated ginger",
      "Sesame seeds and sliced green onions (as garnishes)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: "pounds", name: "flanken beef short ribs" },
      { amount: 0.75, unit: "cup", name: "soy sauce" },
      { amount: 0.25, unit: "cup", name: "honey" },
      { amount: 2.0, unit: "tablespoons", name: "sesame oil" },
      { amount: 2.0, unit: "tablespoons", name: "garlic chili paste" },
      { amount: 1.0, unit: "tablespoon", name: "rice vinegar" },
      { amount: 0.5, unit: "teaspoon", name: "black pepper" },
      { amount: 0.5, unit: "teaspoon", name: "crushed red chili flakes" },
      { amount: 3.0, unit: "cloves", name: "garlic" },
      { amount: 1.0, unit: "tablespoon", name: "fresh grated ginger" },
      { amount: nil, unit: nil, name: "Sesame seeds and sliced green onions" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large bowl, whisk together all ingredients except ribs and sesame seeds. Add beef short ribs and toss to coat. Let rest for 15 minutes for flavors to soak in.",
      "Place the prepared ribs on a wire rack in the Instant Pot. Pour remaining liquid over the ribs. Close the lid and cook on manual HIGH pressure for 30 minutes.",
      "Once cooked, allow steam to release manually. Or open the release valve after 5 minutes with tongs. Remove the ribs carefully, set aside, and cover with foil to keep warm.",
      "Set the Instant Pot to high saute and simmer sauce with the lid open until thickened, about 5-10 minutes. Note: Depeding on the amount of moisure leftover from cooking, you can add 1 to 3 tablespoons of cornstarch and simmer to thicken the sauce.",
      "Coat both sides of the ribs with the sauce, sprinkle with sesame seeds and green onions before serving."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large bowl, whisk together all ingredients except ribs and sesame seeds. Add beef short ribs and toss to coat. Let rest for 15 minutes for flavors to soak in.\nPlace the prepared ribs on a wire rack in the Instant Pot. Pour remaining liquid over the ribs. Close the lid and cook on manual HIGH pressure for 30 minutes.\nOnce cooked, allow steam to release manually. Or open the release valve after 5 minutes with tongs. Remove the ribs carefully, set aside, and cover with foil to keep warm.\nSet the Instant Pot to high saute and simmer sauce with the lid open until thickened, about 5-10 minutes. Note: Depeding on the amount of moisure leftover from cooking, you can add 1 to 3 tablespoons of cornstarch and simmer to thicken the sauce.\nCoat both sides of the ribs with the sauce, sprinkle with sesame seeds and green onions before serving.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("platingpixels.com")
    expect(recipe.canonical_url).to eq("https://platingpixels.com/korean-short-ribs-kalbi/")
    expect(recipe.site_name).to eq("Plating Pixels")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Written by Matt | Plating Pixels")
    expect(recipe.description).to eq("Instant Pot Korean Short Ribs (Kalbi) coated in a thick homemade glaze that's bursting with umami, sweet and spicy flavors.")
    expect(recipe.image).to eq("https://platingpixels.com/wp-content/uploads/2021/01/Instant-Pot-Beef-Short-Ribs-recipe-1.jpg")
    expect(recipe.category).to eq("Entree")
    expect(recipe.cuisine).to eq("Asian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["beef short ribs", "Instant pot ribs", "kalbi recipe", "Korean short ribs"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.88)
    expect(recipe.ratings_count).to eq(8)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "3 ribs",
      "calories" => "247 kcal",
      "carbohydrateContent" => "7 g",
      "proteinContent" => "23 g",
      "fatContent" => "14 g",
      "saturatedFatContent" => "5 g",
      "cholesterolContent" => "65 mg",
      "sodiumContent" => "1152 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "6 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "ribs", amount: 3.0 },
      { name: "calories", unit: "kcal", amount: 247.0 },
      { name: "carbohydrateContent", unit: "g", amount: 7.0 },
      { name: "proteinContent", unit: "g", amount: 23.0 },
      { name: "fatContent", unit: "g", amount: 14.0 },
      { name: "saturatedFatContent", unit: "g", amount: 5.0 },
      { name: "cholesterolContent", unit: "mg", amount: 65.0 },
      { name: "sodiumContent", unit: "mg", amount: 1152.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 6.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
