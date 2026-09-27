# frozen_string_literal: true

RSpec.describe "nibbledish.com" do
  subject(:recipe) { scrape_cassette("com/nibbledish", url: "https://nibbledish.com/korean-fried-chicken-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Korean Fried Chicken Recipe: How to Make Yangyeom Chicken")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 T. butter",
      "5 red chilies, sliced",
      "1 T. freshly grated ginger",
      "1/4 cup gochujang sauce",
      "2 T. ketchup",
      "1 T. rice wine vinegar",
      "1 T. soy sauce",
      "1/3 cup honey",
      "1 T. brown sugar",
      "1 t. salt",
      "1/2 t. ground black pepper",
      "1/2 t. baking powder",
      "1/2 t. garlic powder",
      "2 lbs. raw chicken wings or drumsticks",
      "1 T. freshly grated ginger",
      "1/2 cup cornstarch"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "T", name: "butter" },
      { amount: 5.0, unit: nil, name: "red chilies, sliced" },
      { amount: 1.0, unit: "T", name: "freshly grated ginger" },
      { amount: 0.25, unit: "cup", name: "gochujang sauce" },
      { amount: 2.0, unit: "T", name: "ketchup" },
      { amount: 1.0, unit: "T", name: "rice wine vinegar" },
      { amount: 1.0, unit: "T", name: "soy sauce" },
      { amount: 0.33, unit: "cup", name: "honey" },
      { amount: 1.0, unit: "T", name: "brown sugar" },
      { amount: 1.0, unit: "t", name: "salt" },
      { amount: 0.5, unit: "t", name: "ground black pepper" },
      { amount: 0.5, unit: "t", name: "baking powder" },
      { amount: 0.5, unit: "t", name: "garlic powder" },
      { amount: 2.0, unit: "lbs", name: "raw chicken wings or drumsticks" },
      { amount: 1.0, unit: "T", name: "freshly grated ginger" },
      { amount: 0.5, unit: "cup", name: "cornstarch" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Starting with the sauce: in a medium saucepan, saute the chilies, ginger, and garlic in butter. Cook until fragrant.",
      "Stir in the gochujang, ketchup, vinegar, soy sauce and bring to a boil. Stir in the honey and brown sugar. Reduce the heat to a simmer and cook until thickened. Set aside.",
      "Now for the wings: heat 4 to 6 cups of vegetable oil in a deep pot to 275 degrees Fahrenheit. Line a plate with paper towels.",
      "Whisk together salt, pepper, baking powder, and garlic powder.",
      "Season the wings and toss them in a baggie with corn starch to coat them.",
      "Fry the wings for about 15 minutes or until the skin is crispy. Drain them on the paper towel lined plate.",
      "Increase the frying oil to 400 degrees Fahrenheit. Deep fry the wings again for another 7 to 8 minutes or until they are fully cooked and golden brown colored.",
      "Remove wings and place them in a large bowl. Pour prepared sauce over the wings to thoroughly coat. Put finished wings on a presentation plate and sprinkle with sesame seeds. Garnish with sliced onions."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Starting with the sauce: in a medium saucepan, saute the chilies, ginger, and garlic in butter. Cook until fragrant.\nStir in the gochujang, ketchup, vinegar, soy sauce and bring to a boil. Stir in the honey and brown sugar. Reduce the heat to a simmer and cook until thickened. Set aside.\nNow for the wings: heat 4 to 6 cups of vegetable oil in a deep pot to 275 degrees Fahrenheit. Line a plate with paper towels.\nWhisk together salt, pepper, baking powder, and garlic powder.\nSeason the wings and toss them in a baggie with corn starch to coat them.\nFry the wings for about 15 minutes or until the skin is crispy. Drain them on the paper towel lined plate.\nIncrease the frying oil to 400 degrees Fahrenheit. Deep fry the wings again for another 7 to 8 minutes or until they are fully cooked and golden brown colored.\nRemove wings and place them in a large bowl. Pour prepared sauce over the wings to thoroughly coat. Put finished wings on a presentation plate and sprinkle with sesame seeds. Garnish with sliced onions.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("nibbledish.com")
    expect(recipe.canonical_url).to eq("https://nibbledish.com/korean-fried-chicken-recipe/")
    expect(recipe.site_name).to eq("NibbleDish")
    expect(recipe.language).to eq("en-CA")
    expect(recipe.author).to eq("Shannon Llewellyn")
    expect(recipe.description).to eq("Find yourself craving Yangyeom takeout? Why not try making Yangyeom chicken at home this time? Try our simple Korean fried chicken recipe!")
    expect(recipe.image).to eq("https://media.nibbledish.com/wp-content/uploads/2020/05/korean-fried-chicken-recipe.jpg")
    expect(recipe.category).to eq("Entrees")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(28)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "1277 calories",
      "fatContent" => "67.1g fat",
      "saturatedFatContent" => "20.6g saturated fat",
      "transFatContent" => "0g trans fat",
      "carbohydrateContent" => "42.8g carbohydrates",
      "fiberContent" => "0.7g fiber",
      "proteinContent" => "118.6g protein",
      "cholesterolContent" => "432mg cholesterol",
      "sodiumContent" => "1478mg sodium",
      "sugarContent" => "25.2g sugar"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 1277.0 },
      { name: "fatContent", unit: "g", amount: 67.1 },
      { name: "saturatedFatContent", unit: "g", amount: 20.6 },
      { name: "transFatContent", unit: "g", amount: 0.0 },
      { name: "carbohydrateContent", unit: "g", amount: 42.8 },
      { name: "fiberContent", unit: "g", amount: 0.7 },
      { name: "proteinContent", unit: "g", amount: 118.6 },
      { name: "cholesterolContent", unit: "mg", amount: 432.0 },
      { name: "sodiumContent", unit: "mg", amount: 1478.0 },
      { name: "sugarContent", unit: "g", amount: 25.2 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#")
  end
end
