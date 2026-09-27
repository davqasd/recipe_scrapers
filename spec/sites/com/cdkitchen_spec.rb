# frozen_string_literal: true

RSpec.describe "cdkitchen.com" do
  subject(:recipe) { scrape_cassette("com/cdkitchen", url: "https://www.cdkitchen.com/recipes/recs/364/Pot-Roast-With-Vegetables82229.shtml") }

  it "reads the title" do
    expect(recipe.title).to eq("Pressure Cooker Pot Roast With Vegetables")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 pounds boneless beef sirloin tip roast",
      "2 tablespoons vegetable oil",
      "4 large potatoes, peeled and quartered",
      "4 large carrots, cut into 2-inch pieces",
      "1 large onion, cut into wedges",
      "2 cups water",
      "1 teaspoon beef bouillon granules",
      "1/2 teaspoon salt",
      "1/4 teaspoon black pepper",
      "3 tablespoons cornstarch",
      "3 tablespoons cold water"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "pounds", name: "boneless beef sirloin tip roast" },
      { amount: 2.0, unit: "tablespoons", name: "vegetable oil" },
      { amount: 4.0, unit: nil, name: "large potatoes, peeled and quartered" },
      { amount: 4.0, unit: nil, name: "large carrots, cut into 2-inch pieces" },
      { amount: 1.0, unit: nil, name: "large onion, cut into wedges" },
      { amount: 2.0, unit: "cups", name: "water" },
      { amount: 1.0, unit: "teaspoon", name: "beef bouillon granules" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 0.25, unit: "teaspoon", name: "black pepper" },
      { amount: 3.0, unit: "tablespoons", name: "cornstarch" },
      { amount: 3.0, unit: "tablespoons", name: "cold water" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a pressure cooker, brown roast in oil on all sides. Add potatoes, carrots, onion and water.",
      "Close cover securely and place pressure regulator on vent pipe. Bring cooker to full pressure over high heat. Reduce heat to medium-high and cook for 40 minutes (Pressure regulator should maintain a slow steady rocking motion; adjust heat if needed).",
      "Remove from the heat and allow pressure to drop on its own. Remove meat and vegetables and keep warm.",
      "Bring cooking juices in pressure cooker to a boil. Add bouillon, salt and pepper. Combine cornstarch and cold water until smooth, then stir into juices. Bring to a boil, cook and stir for 2 minutes or until thickened.",
      "Serve with roast and vegetables."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a pressure cooker, brown roast in oil on all sides. Add potatoes, carrots, onion and water.\nClose cover securely and place pressure regulator on vent pipe. Bring cooker to full pressure over high heat. Reduce heat to medium-high and cook for 40 minutes (Pressure regulator should maintain a slow steady rocking motion; adjust heat if needed).\nRemove from the heat and allow pressure to drop on its own. Remove meat and vegetables and keep warm.\nBring cooking juices in pressure cooker to a boil. Add bouillon, salt and pepper. Combine cornstarch and cold water until smooth, then stir into juices. Bring to a boil, cook and stir for 2 minutes or until thickened.\nServe with roast and vegetables.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cdkitchen.com")
    expect(recipe.canonical_url).to eq("https://www.cdkitchen.com/recipes/recs/364/Pot-Roast-With-Vegetables82229.shtml")
    expect(recipe.site_name).to eq("CDKitchen")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Ilovevegas")
    expect(recipe.description).to eq("A pressure cooker is a home cook's secret weapon when it comes to making a perfect pot roast.")
    expect(recipe.image).to eq("https://cdn.cdkitchen.com/recipes/images/2025/12/53013-10123-mx.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(14)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "616 calories",
      "servingSize" => "per serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 616.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#inpagereview")
  end
end
