# frozen_string_literal: true

RSpec.describe "thewoodenskillet.com" do
  subject(:recipe) { scrape_cassette("com/thewoodenskillet", url: "https://thewoodenskillet.com/grilled-ribeye-steak/") }

  it "reads the title" do
    expect(recipe.title).to eq("Grilled Ribeye Steak on a Gas Grill")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1-2 pounds ribeye steaks",
      "kosher salt and ground black pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "pounds", name: "ribeye steaks" },
      { amount: nil, unit: nil, name: "kosher salt and ground black pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Prep: Clean the grill grates and preheat the gas grill to a high heat (450-500℉). Let 1-2 pounds ribeye steaks come to room temperature while the grill heats.",
      "Season: Season the steaks with kosher salt and ground black pepper on both sides (option to use an easy steak marinade or homemade steak dry rub, for even more flavor).",
      "Grill: Place steaks directly on the hot grill grates over direct heat. Let sear for 3-4 minutes with the cover closed. Flip steaks and let cook for another 3-4 minutes. Use a meat thermometer to take the internal temperature of each steak. If they haven't reached your desired internal temperature (see Notes) then move them to indirect heat until that desired temperature is reached.",
      "Rest + Serve: Remove steaks from the grill and let rest for 5 minutes. Option to serve with an easy herbed butter or enjoy in our grilled steak rice bowl!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Prep: Clean the grill grates and preheat the gas grill to a high heat (450-500℉). Let 1-2 pounds ribeye steaks come to room temperature while the grill heats.\nSeason: Season the steaks with kosher salt and ground black pepper on both sides (option to use an easy steak marinade or homemade steak dry rub, for even more flavor).\nGrill: Place steaks directly on the hot grill grates over direct heat. Let sear for 3-4 minutes with the cover closed. Flip steaks and let cook for another 3-4 minutes. Use a meat thermometer to take the internal temperature of each steak. If they haven't reached your desired internal temperature (see Notes) then move them to indirect heat until that desired temperature is reached.\nRest + Serve: Remove steaks from the grill and let rest for 5 minutes. Option to serve with an easy herbed butter or enjoy in our grilled steak rice bowl!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thewoodenskillet.com")
    expect(recipe.canonical_url).to eq("https://thewoodenskillet.com/grilled-ribeye-steak/")
    expect(recipe.site_name).to eq("The Wooden Skillet")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Erin Jensen")
    expect(recipe.description).to eq("Make this incredibly tender Grilled Ribeye Steak on a Gas Grill for dinner tonight, it turns out perfectly juicy every time!")
    expect(recipe.image).to eq("https://thewoodenskillet.com/wp-content/uploads/2025/07/grilled-ribeye-steak-recipe-1.jpg")
    expect(recipe.category).to eq("Dinner/Entree")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(15)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq([
      "grilled ribeye steak",
      "how long to cook grilled ribeye steak on a gas grill",
      "how long to grill ribeye steak medium rare on gas grill",
      "how long to grill ribeye steak Weber",
      "how to grill boneless ribeye steak on gas grill",
      "how to grill ribeyes steak",
      "steak recipes"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "236 kcal",
      "sodiumContent" => "350 mg",
      "fatContent" => "16 g",
      "saturatedFatContent" => "7 g",
      "proteinContent" => "23 g",
      "cholesterolContent" => "69 mg",
      "unsaturatedFatContent" => "9 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 236.0 },
      { name: "sodiumContent", unit: "mg", amount: 350.0 },
      { name: "fatContent", unit: "g", amount: 16.0 },
      { name: "saturatedFatContent", unit: "g", amount: 7.0 },
      { name: "proteinContent", unit: "g", amount: 23.0 },
      { name: "cholesterolContent", unit: "mg", amount: 69.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 9.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
