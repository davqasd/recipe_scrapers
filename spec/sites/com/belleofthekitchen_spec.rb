# frozen_string_literal: true

RSpec.describe "belleofthekitchen.com" do
  subject(:recipe) { scrape_cassette("com/belleofthekitchen", url: "https://belleofthekitchen.com/instant-pot-mac-and-cheese/") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy Instant Pot Mac and Cheese")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 Tablespoon butter",
      "1/2 cup finely diced onion",
      "2 cloves minced garlic",
      "3 cups water",
      "12 oz dry elbow macaroni pasta",
      "1 teaspoon salt",
      "pepper to taste",
      "1 12 oz can evaporated milk (full fat)",
      "3 heaping cups shredded cheddar cheese (I prefer sharp cheddar)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "Tablespoon", name: "butter" },
      { amount: 0.5, unit: "cup", name: "finely diced onion" },
      { amount: 2.0, unit: "cloves", name: "minced garlic" },
      { amount: 3.0, unit: "cups", name: "water" },
      { amount: 12.0, unit: "oz", name: "dry elbow macaroni pasta" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: nil, unit: nil, name: "pepper to taste" },
      { amount: 1.0, unit: "can", name: "evaporated milk" },
      { amount: 3.0, unit: "cups", name: "shredded cheddar cheese" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Turn Instant Pot to sauté and melt the butter. Add in the onions and cook until soft, about 2-3 minutes. Add in the garlic and cook for one additional minute, stirring constantly to prevent garlic from burning.",
      "Pour in the water, dry macaroni, salt, and pepper to taste. Stir everything together then place the lid on the Instant Pot and turn the valve to \"sealing.\" Cook over manual high pressure for 4 minutes.",
      "When the time is up, perform a quick release and flip the valve to \"venting\" to release the steam. Once the steam is completely released and the pin has dropped, open the lid and stir the noodles. Turn the pot to sauté again, and pour in the evaporated milk and half of the shredded cheese. Cook for about 5 minutes until thick and creamy. Stir very often to keep the noodles from sticking to the bottom of the pot.",
      "Hit \"cancel\" to turn off the heat, then add in the rest of the cheese. Stir well and serve. Enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Turn Instant Pot to sauté and melt the butter. Add in the onions and cook until soft, about 2-3 minutes. Add in the garlic and cook for one additional minute, stirring constantly to prevent garlic from burning.\nPour in the water, dry macaroni, salt, and pepper to taste. Stir everything together then place the lid on the Instant Pot and turn the valve to \"sealing.\" Cook over manual high pressure for 4 minutes.\nWhen the time is up, perform a quick release and flip the valve to \"venting\" to release the steam. Once the steam is completely released and the pin has dropped, open the lid and stir the noodles. Turn the pot to sauté again, and pour in the evaporated milk and half of the shredded cheese. Cook for about 5 minutes until thick and creamy. Stir very often to keep the noodles from sticking to the bottom of the pot.\nHit \"cancel\" to turn off the heat, then add in the rest of the cheese. Stir well and serve. Enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("belleofthekitchen.com")
    expect(recipe.canonical_url).to eq("https://belleofthekitchen.com/instant-pot-mac-and-cheese/")
    expect(recipe.site_name).to eq("Belle of the Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Ashlyn Edwards")
    expect(recipe.description).to eq("This Instant Pot Mac and Cheese is ready in under 30 minutes, and is SO creamy and delicious! This homemade macaroni and cheese is WAY better than the boxed version, and is perfect as a side or main dish for an easy dinner!")
    expect(recipe.image).to eq("https://belleofthekitchen.com/wp-content/uploads/2025/05/instant-pot-mac-and-cheese-2-3.jpg")
    expect(recipe.category).to eq("Main")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq([
      "best macaroni and cheese",
      "instant pot mac and cheese",
      "instant pot macaroni and cheese",
      "macaroni and cheese recipe"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.99)
    expect(recipe.ratings_count).to eq(71)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "538 kcal",
      "carbohydrateContent" => "50 g",
      "proteinContent" => "25 g",
      "fatContent" => "25 g",
      "saturatedFatContent" => "15 g",
      "cholesterolContent" => "80 mg",
      "sodiumContent" => "825 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "8 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 538.0 },
      { name: "carbohydrateContent", unit: "g", amount: 50.0 },
      { name: "proteinContent", unit: "g", amount: 25.0 },
      { name: "fatContent", unit: "g", amount: 25.0 },
      { name: "saturatedFatContent", unit: "g", amount: 15.0 },
      { name: "cholesterolContent", unit: "mg", amount: 80.0 },
      { name: "sodiumContent", unit: "mg", amount: 825.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 8.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
