# frozen_string_literal: true

RSpec.describe "lecremedelacrumb.com" do
  subject(:recipe) { scrape_cassette("com/lecremedelacrumb", url: "https://www.lecremedelacrumb.com/instant-pot-shredded-chicken-tacos/") }

  it "reads the title" do
    expect(recipe.title).to eq("Instant Pot Shredded Chicken Tacos")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3-4 medium to large boneless skinless chicken breasts",
      "1 cup chicken broth (or water)",
      "1 teaspoon salt",
      "1 teaspoon ground cumin",
      "1 teaspoon chili powder",
      "1 teaspoon garlic powder",
      "1 15-ounce can fire roasted tomatoes",
      "corn or flour taco-size tortillas",
      "avocado, tomatoes, cheese, cilantro, sour cream (for serving)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: nil, name: "medium to large boneless skinless chicken breasts" },
      { amount: 1.0, unit: "cup", name: "chicken broth" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: 1.0, unit: "teaspoon", name: "ground cumin" },
      { amount: 1.0, unit: "teaspoon", name: "chili powder" },
      { amount: 1.0, unit: "teaspoon", name: "garlic powder" },
      { amount: 1.0, unit: "can", name: "fire roasted tomatoes" },
      { amount: nil, unit: nil, name: "corn or flour taco-size tortillas" },
      { amount: nil, unit: nil, name: "avocado, tomatoes, cheese, cilantro, sour cream" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In your instant pot/pressure cooker combine chicken, broth or water, cumin, chili powder, garlic powder, and fire roasted tomatoes (with liquid).",
      "Cover and set to PRESSURE COOK or MANUAL for 20 minutes. (30 minutes if using frozen chicken breasts)",
      "Do a quick release (turn vent knob to the VENT position and allow to de-pressurize until the float valve drops down) then uncover and shred chicken with two forks.",
      "Serve chicken in tortillas topped with cheese, tomatoes, avocado, cilantro, or any other favorite toppings."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In your instant pot/pressure cooker combine chicken, broth or water, cumin, chili powder, garlic powder, and fire roasted tomatoes (with liquid).\nCover and set to PRESSURE COOK or MANUAL for 20 minutes. (30 minutes if using frozen chicken breasts)\nDo a quick release (turn vent knob to the VENT position and allow to de-pressurize until the float valve drops down) then uncover and shred chicken with two forks.\nServe chicken in tortillas topped with cheese, tomatoes, avocado, cilantro, or any other favorite toppings.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("lecremedelacrumb.com")
    expect(recipe.canonical_url).to eq("https://www.lecremedelacrumb.com/instant-pot-shredded-chicken-tacos/")
    expect(recipe.site_name).to eq("Creme De La Crumb")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Tiffany")
    expect(recipe.description).to eq("These are the BEST Instant Pot Shredded Chicken Tacos, hands down. You'll love how quick, easy, and healthy this recipe is!")
    expect(recipe.image).to eq("https://www.lecremedelacrumb.com/wp-content/uploads/2019/01/instant-pot-shredded-chicken-tacos-5.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("Mexican")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq(["Chicken", "healthy", "instant pot", "slow cooker"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.84)
    expect(recipe.ratings_count).to eq(186)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "202 kcal",
      "carbohydrateContent" => "1 g",
      "proteinContent" => "37 g",
      "fatContent" => "5 g",
      "saturatedFatContent" => "1 g",
      "transFatContent" => "1 g",
      "cholesterolContent" => "108 mg",
      "sodiumContent" => "1003 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "1 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 202.0 },
      { name: "carbohydrateContent", unit: "g", amount: 1.0 },
      { name: "proteinContent", unit: "g", amount: 37.0 },
      { name: "fatContent", unit: "g", amount: 5.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 108.0 },
      { name: "sodiumContent", unit: "mg", amount: 1003.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
