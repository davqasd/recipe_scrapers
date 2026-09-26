# frozen_string_literal: true

RSpec.describe "closetcooking.com" do
  subject(:recipe) { scrape_cassette("com/closetcooking", url: "https://www.closetcooking.com/jalapeno-popper-skillet-chicken/") }

  it "reads the title" do
    expect(recipe.title).to eq("Jalapeno Popper Skillet Chicken")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 tablespoon oil",
      "1 pound chicken, boneless and skinless, diced",
      "salt and pepper to taste",
      "1 small onion, diced",
      "2 jalapenos, sliced or diced",
      "2 cloves garlic, chopped",
      "1 cup chicken broth",
      "4 ounces cream cheese, softened",
      "1 cup cheddar cheese, shredded"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "tablespoon", name: "oil" },
      { amount: 1.0, unit: "pound", name: "chicken, boneless and skinless, diced" },
      { amount: nil, unit: nil, name: "salt and pepper to taste" },
      { amount: 1.0, unit: nil, name: "small onion, diced" },
      { amount: 2.0, unit: nil, name: "jalapenos, sliced or diced" },
      { amount: 2.0, unit: "cloves", name: "garlic, chopped" },
      { amount: 1.0, unit: "cup", name: "chicken broth" },
      { amount: 4.0, unit: "ounces", name: "cream cheese, softened" },
      { amount: 1.0, unit: "cup", name: "cheddar cheese, shredded" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Heat the oil in a pan over medium-high heat, add the chicken (seasoned with salt and pepper) and cook until lightly golden brown.",
      "Add the onions and jalapenos and cook until tender, about a minute before adding the garlic and cooking another minute.",
      "Add the chicken broth and deglaze the skillet by scraping the brown bits up off of the bottom of the pan as the broth sizzles.",
      "Add the cheese and cook until it has melted and the sauce is nice and smooth"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Heat the oil in a pan over medium-high heat, add the chicken (seasoned with salt and pepper) and cook until lightly golden brown.\nAdd the onions and jalapenos and cook until tender, about a minute before adding the garlic and cooking another minute.\nAdd the chicken broth and deglaze the skillet by scraping the brown bits up off of the bottom of the pan as the broth sizzles.\nAdd the cheese and cook until it has melted and the sauce is nice and smooth")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("closetcooking.com")
    expect(recipe.canonical_url).to eq("https://www.closetcooking.com/jalapeno-popper-skillet-chicken/")
    expect(recipe.site_name).to eq("Closet Cooking")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Chicken in a cheesy jalapeno sauce! All of the flavours of jalapeno poppers in a skillet chicken dinner!")
    expect(recipe.image).to eq("https://www.closetcooking.com/wp-content/uploads/2017/10/JalapenoPopperSkilletChicken8005532.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("5 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "Calories 415",
      "fatContent" => "Fat 32g",
      "saturatedFatContent" => "Saturated 13g",
      "transFatContent" => "Trans 0.2g",
      "cholesterolContent" => "Cholesterol 117mg",
      "sodiumContent" => "Sodium 361mg",
      "carbohydrateContent" => "Carbs 4g",
      "fiberContent" => "Fiber 0.4g",
      "sugarContent" => "Sugars 2g",
      "proteinContent" => "Protein 25g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: nil, amount: 415.0 },
      { name: "fatContent", unit: "g", amount: 32.0 },
      { name: "saturatedFatContent", unit: "g", amount: 13.0 },
      { name: "transFatContent", unit: "g", amount: 0.2 },
      { name: "cholesterolContent", unit: "mg", amount: 117.0 },
      { name: "sodiumContent", unit: "mg", amount: 361.0 },
      { name: "carbohydrateContent", unit: "g", amount: 4.0 },
      { name: "fiberContent", unit: "g", amount: 0.4 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "proteinContent", unit: "g", amount: 25.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
