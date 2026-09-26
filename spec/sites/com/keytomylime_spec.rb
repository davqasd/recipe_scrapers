# frozen_string_literal: true

RSpec.describe "keytomylime.com" do
  subject(:recipe) { scrape_cassette("com/keytomylime", url: "https://keytomylime.com/how-to-bake-eggs/") }

  it "reads the title" do
    expect(recipe.title).to eq("How to Bake Eggs")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "12 eggs",
      "Oil or butter to grease the pan",
      "Salt to taste",
      "Pepper to taste"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 12.0, unit: nil, name: "eggs" },
      { amount: nil, unit: nil, name: "Oil or butter to grease the pan" },
      { amount: nil, unit: nil, name: "Salt to taste" },
      { amount: nil, unit: nil, name: "Pepper to taste" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 350 F.",
      "Lightly grease the non-stick muffin pan with oil, butter, or spray oil.",
      "Crack each egg into one of the muffin openings.",
      "Season with salt and pepper to taste.",
      "Bake for 14-17 minutes, or until the whites don’t jiggle and the yolks reach your desired level of doneness (the ones in the photo were baked for 14 minutes)."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 350 F.\nLightly grease the non-stick muffin pan with oil, butter, or spray oil.\nCrack each egg into one of the muffin openings.\nSeason with salt and pepper to taste.\nBake for 14-17 minutes, or until the whites don’t jiggle and the yolks reach your desired level of doneness (the ones in the photo were baked for 14 minutes).")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("keytomylime.com")
    expect(recipe.canonical_url).to eq("https://keytomylime.com/how-to-bake-eggs/")
    expect(recipe.site_name).to eq("Key To My Lime")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Alexa Blay")
    expect(recipe.description).to eq("Baking eggs in a muffin tin is the easiest way to streamline your breakfast meal prep! Once you know how to bake eggs, you'll be amazed at how easy it is!")
    expect(recipe.image).to eq("https://keytomylime.com/wp-content/uploads/2019/09/Baked-Eggs-in-Muffin-Tin-2-480x480.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(19)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(14)
    expect(recipe.keywords).to eq(["breakfast", "eggs", "keto", "low carb", "meal prep"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["VegetarianDiet"])
    expect(recipe.ratings).to eq(4.8)
    expect(recipe.ratings_count).to eq(131)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "80 calories",
      "carbohydrateContent" => "0.6 grams carbohydrates",
      "fatContent" => "5.6 grams fat",
      "fiberContent" => "0 grams fiber",
      "proteinContent" => "6.3 grams protein",
      "servingSize" => "1 egg",
      "sugarContent" => "0.6 grams sugar"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 80.0 },
      { name: "carbohydrateContent", unit: "g", amount: 0.6 },
      { name: "fatContent", unit: "g", amount: 5.6 },
      { name: "fiberContent", unit: "g", amount: 0.0 },
      { name: "proteinContent", unit: "g", amount: 6.3 },
      { name: "servingSize", unit: "egg", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 0.6 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
