# frozen_string_literal: true

RSpec.describe "feelgoodfoodie.net" do
  subject(:recipe) { scrape_cassette("net/feelgoodfoodie", url: "https://feelgoodfoodie.net/recipe/best-hummus/") }

  it "reads the title" do
    expect(recipe.title).to eq("Hummus")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 (15-ounce) can chickpeas",
      "3 tablespoons lemon juice",
      "2 tablespoons tahini",
      "2 small garlic cloves",
      "¾ teaspoon salt",
      "3 ice cubes",
      "Extra-virgin olive oil (for serving)",
      "Paprika (for serving)",
      "Chopped fresh parsley (for serving)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "can", name: "chickpeas" },
      { amount: 3.0, unit: "tablespoons", name: "lemon juice" },
      { amount: 2.0, unit: "tablespoons", name: "tahini" },
      { amount: 2.0, unit: nil, name: "small garlic cloves" },
      { amount: 0.75, unit: "teaspoon", name: "salt" },
      { amount: 3.0, unit: nil, name: "ice cubes" },
      { amount: nil, unit: nil, name: "Extra-virgin olive oil" },
      { amount: nil, unit: nil, name: "Paprika" },
      { amount: nil, unit: nil, name: "Chopped fresh parsley" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Place the chickpeas in a large bowl of warm water. Rub them with your fingers to release the skins, which will easily float to the surface of the water. Skim the skins from the water with a slotted spoon and discard. This is an optional step, but peeling the chickpeas is what yields a super creamy texture.",
      "Drain and dry the chickpeas as thoroughly as possible. Transfer the chickpeas to a food processor and pulse into a fine, breadcrumb-like texture, scraping down the sides as needed, about 15 seconds total.",
      "Add the lemon juice, tahini, garlic, salt, and ice cubes. Blend until completely smooth, about 5 minutes. Taste the hummus and adjust the flavor as needed by adding more lemon juice or salt.",
      "Spread the hummus onto a plate or into a bowl, sweeping the hummus with the back of a spoon to create swirls for catching the olive oil. Drizzle the hummus with olive oil and then sprinkle it with paprika and fresh parsley. Serve cool or at room temperature."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Place the chickpeas in a large bowl of warm water. Rub them with your fingers to release the skins, which will easily float to the surface of the water. Skim the skins from the water with a slotted spoon and discard. This is an optional step, but peeling the chickpeas is what yields a super creamy texture.\nDrain and dry the chickpeas as thoroughly as possible. Transfer the chickpeas to a food processor and pulse into a fine, breadcrumb-like texture, scraping down the sides as needed, about 15 seconds total.\nAdd the lemon juice, tahini, garlic, salt, and ice cubes. Blend until completely smooth, about 5 minutes. Taste the hummus and adjust the flavor as needed by adding more lemon juice or salt.\nSpread the hummus onto a plate or into a bowl, sweeping the hummus with the back of a spoon to create swirls for catching the olive oil. Drizzle the hummus with olive oil and then sprinkle it with paprika and fresh parsley. Serve cool or at room temperature.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("feelgoodfoodie.net")
    expect(recipe.canonical_url).to eq("https://feelgoodfoodie.net/recipe/best-hummus/")
    expect(recipe.site_name).to eq("Feel Good Foodie")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Yumna Jawad")
    expect(recipe.description).to eq("My hummus recipe is the BEST; an easy authentic Lebanese recipe made with 5 ingredients in a food processor with a tip to make it extra creamy")
    expect(recipe.image).to eq("https://feelgoodfoodie.net/wp-content/uploads/2023/04/Authentic-Lebanese-Hummus-12.jpg")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("Lebanese")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq([
      "authentic hummus",
      "avocado hummus recipe",
      "best hummus",
      "Chickpea Hummus",
      "Homemade Hummus",
      "Hummus Recipe"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.99)
    expect(recipe.ratings_count).to eq(1309)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "33 kcal",
      "carbohydrateContent" => "2 g",
      "proteinContent" => "1 g",
      "fatContent" => "3 g",
      "saturatedFatContent" => "0.4 g",
      "sodiumContent" => "293 mg",
      "fiberContent" => "0.3 g",
      "sugarContent" => "0.2 g",
      "unsaturatedFatContent" => "2 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 33.0 },
      { name: "carbohydrateContent", unit: "g", amount: 2.0 },
      { name: "proteinContent", unit: "g", amount: 1.0 },
      { name: "fatContent", unit: "g", amount: 3.0 },
      { name: "saturatedFatContent", unit: "g", amount: 0.4 },
      { name: "sodiumContent", unit: "mg", amount: 293.0 },
      { name: "fiberContent", unit: "g", amount: 0.3 },
      { name: "sugarContent", unit: "g", amount: 0.2 },
      { name: "unsaturatedFatContent", unit: "g", amount: 2.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
