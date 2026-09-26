# frozen_string_literal: true

RSpec.describe "fitslowcookerqueen.com" do
  subject(:recipe) { scrape_cassette("com/fitslowcookerqueen", url: "https://fitslowcookerqueen.com/slow-cooker-rosemary-dijon-chicken/") }

  it "reads the title" do
    expect(recipe.title).to eq("Slow Cooker Rosemary Dijon Chicken")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 pounds chicken, any cut",
      "salt & pepper to taste",
      "1 tablespoon oil (for Instant Pot)",
      "1 cup low-sodium chicken broth",
      "1/2 cup Dijon mustard",
      "1 tablespoon apple cider vinegar",
      "1 tablespoon dried rosemary",
      "2 garlic cloves, minced",
      "1 1/2 teaspoons salt",
      "1/2 teaspoon pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "pounds", name: "chicken, any cut" },
      { amount: nil, unit: nil, name: "salt & pepper to taste" },
      { amount: 1.0, unit: "tablespoon", name: "oil" },
      { amount: 1.0, unit: "cup", name: "low-sodium chicken broth" },
      { amount: 0.5, unit: "cup", name: "Dijon mustard" },
      { amount: 1.0, unit: "tablespoon", name: "apple cider vinegar" },
      { amount: 1.0, unit: "tablespoon", name: "dried rosemary" },
      { amount: 2.0, unit: nil, name: "garlic cloves, minced" },
      { amount: 1.5, unit: "teaspoons", name: "salt" },
      { amount: 0.5, unit: "teaspoon", name: "pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Season the chicken with salt & pepper and add it to the slow cooker.",
      "In a small bowl, mix together sauce ingredients. Pour the sauce on top of the chicken.",
      "Cook on HIGH 2 to 3 hours or LOW 4 to 6.",
      "Instant Pot",
      "If using skin-on chicken: Turn on the Instant Pot and select sauté. Once hot, add the oil to the pot. Add chicken the chicken, skin side down. Cook approximately 3 to 4 minutes per side or until the skin is crisp to your liking. If using skinless chicken, skip this step and add the chicken directly to the Instant Pot.",
      "In a small bowl, mix together the sauce ingredients. Pour the sauce on top of chicken",
      "Close & seal vent. Select high pressure and set time for 13 minutes. When cooking time is complete, quick-release the pressure."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Season the chicken with salt & pepper and add it to the slow cooker.\nIn a small bowl, mix together sauce ingredients. Pour the sauce on top of the chicken.\nCook on HIGH 2 to 3 hours or LOW 4 to 6.\nInstant Pot\nIf using skin-on chicken: Turn on the Instant Pot and select sauté. Once hot, add the oil to the pot. Add chicken the chicken, skin side down. Cook approximately 3 to 4 minutes per side or until the skin is crisp to your liking. If using skinless chicken, skip this step and add the chicken directly to the Instant Pot.\nIn a small bowl, mix together the sauce ingredients. Pour the sauce on top of chicken\nClose & seal vent. Select high pressure and set time for 13 minutes. When cooking time is complete, quick-release the pressure.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("fitslowcookerqueen.com")
    expect(recipe.canonical_url).to eq("https://fitslowcookerqueen.com/slow-cooker-rosemary-dijon-chicken/")
    expect(recipe.site_name).to eq("Fit Slow Cooker Queen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Shannon Epstein")
    expect(recipe.description).to eq("Slow cooker rosemary Dijon chicken is an easy and healthy recipe that's packed with flavor. Your preferred cut of chicken slow cooks in a homemade rosemary-Dijon sauce. The end result is impressive, falling off the bone chicken made with minimal effort. Instructions to make rosemary Dijon chicken in the Instant Pot are also included.")
    expect(recipe.image).to eq("https://fitslowcookerqueen.com/wp-content/uploads/2026/05/Slow-Cooker-Rosemary-Dijon-Chicken-1-scaled-225x225.jpeg")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to eq("Pressure Cooking")
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(190)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(180)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(3)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "131 calories",
      "sugarContent" => "2 g",
      "sodiumContent" => "82.4 mg",
      "fatContent" => "4.5 g",
      "saturatedFatContent" => "1 g",
      "transFatContent" => "0 g",
      "carbohydrateContent" => "5.6 g",
      "fiberContent" => "1.3 g",
      "proteinContent" => "16.6 g",
      "cholesterolContent" => "70 mg"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 131.0 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "sodiumContent", unit: "mg", amount: 82.4 },
      { name: "fatContent", unit: "g", amount: 4.5 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "transFatContent", unit: "g", amount: 0.0 },
      { name: "carbohydrateContent", unit: "g", amount: 5.6 },
      { name: "fiberContent", unit: "g", amount: 1.3 },
      { name: "proteinContent", unit: "g", amount: 16.6 },
      { name: "cholesterolContent", unit: "mg", amount: 70.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
