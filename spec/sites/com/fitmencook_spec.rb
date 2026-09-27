# frozen_string_literal: true

RSpec.describe "fitmencook.com" do
  subject(:recipe) { scrape_cassette("com/fitmencook", url: "https://fitmencook.com/recipes/low-sugar-mango-jam/") }

  it "reads the title" do
    expect(recipe.title).to eq("Low Sugar Mango Jam")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "10oz (284g) frozen mango, thawed",
      "1/2 cup coconut sugar",
      "juice from 2 limes",
      "1 tablespoon lime zest"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 10.0, unit: "oz", name: "frozen mango, thawed" },
      { amount: 0.5, unit: "cup", name: "coconut sugar" },
      { amount: nil, unit: nil, name: "juice from 2 limes" },
      { amount: 1.0, unit: "tablespoon", name: "lime zest" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Add all of the ingredients to a NONSTICK skillet set on low-medium heat. Note: you MUST use the lime juice and zest. Lime naturally has pectin and will act as the gelling agent in this recipe.",
      "Stir and bring to a light simmer, then cover and cook on low heat for 10 – 12 minutes, ensuring the mango is not sticking or burning.",
      "Remove the lid and stir. Use the back of a wooden spatula to mash the mango in the skillet to create the jam. Store the jam in an airtight jar and place in the fridge upside down to vacuum seal it for 45 minutes to 1 hour, or until cool/chilled.",
      "Enjoy! Should last for 2 – 3 weeks in the fridge but I bet it won’t last 1 full week before you eat it all up!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Add all of the ingredients to a NONSTICK skillet set on low-medium heat. Note: you MUST use the lime juice and zest. Lime naturally has pectin and will act as the gelling agent in this recipe.\nStir and bring to a light simmer, then cover and cook on low heat for 10 – 12 minutes, ensuring the mango is not sticking or burning.\nRemove the lid and stir. Use the back of a wooden spatula to mash the mango in the skillet to create the jam. Store the jam in an airtight jar and place in the fridge upside down to vacuum seal it for 45 minutes to 1 hour, or until cool/chilled.\nEnjoy! Should last for 2 – 3 weeks in the fridge but I bet it won’t last 1 full week before you eat it all up!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("fitmencook.com")
    expect(recipe.canonical_url).to eq("https://fitmencook.com/recipes/low-sugar-mango-jam/")
    expect(recipe.site_name).to eq("Fit Men Cook")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Kevin Curry")
    expect(recipe.description).to eq("Add all of the ingredients to a NONSTICK skillet set on low-medium heat. Note: you MUST use the lime juice and zest. Lime naturally has pectin and will act as the gelling agent in this recipe. Stir and bring to a light simmer, then cover and cook on low heat for 10 – 12 minutes, ensuring the mango is not sticking or burning. Remove the lid and stir. Use the back of a wooden spatula to mash the mango in the skillet to create the jam. Store the jam in an airtight jar and place in the fridge upside down to vacuum seal it for 45 minutes to 1 hour, or until cool/chilled.")
    expect(recipe.image).to eq("https://fitmencook.com/wp-content/uploads/2021/04/mango-jam-3-900x506.jpg")
    expect(recipe.category).to eq("Gluten Free")
    expect(recipe.cuisine).to eq("International")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["Gluten Free", "International", "Low Carb / Keto", "Snacks", "Vegan", "Vegetarian"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "60 kcal",
      "carbohydrateContent" => "16 g",
      "fiberContent" => "1 g",
      "sugarContent" => "14 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 60.0 },
      { name: "carbohydrateContent", unit: "g", amount: 16.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 14.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#primary")
  end
end
