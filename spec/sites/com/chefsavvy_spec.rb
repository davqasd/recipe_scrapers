# frozen_string_literal: true

RSpec.describe "chefsavvy.com" do
  subject(:recipe) { scrape_cassette("com/chefsavvy", url: "https://chefsavvy.com/slow-cooker-broccoli-beef/") }

  it "reads the title" do
    expect(recipe.title).to eq("Slow Cooker Broccoli Beef")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 pounds chuck steak (sliced thin (about 1-inch thick))",
      "1 cup low sodium beef broth",
      "1/2 cup low sodium soy sauce",
      "4 garlic cloves (minced)",
      "1/4 cup oyster sauce",
      "1/4 cup brown sugar",
      "2 teaspoons sesame oil",
      "2 tablespoons cornstarch",
      "2 heads broccoli (cut into florets)",
      "sesame seeds for garnish, if desired"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "pounds", name: "chuck steak" },
      { amount: 1.0, unit: "cup", name: "low sodium beef broth" },
      { amount: 0.5, unit: "cup", name: "low sodium soy sauce" },
      { amount: 4.0, unit: nil, name: "garlic cloves" },
      { amount: 0.25, unit: "cup", name: "oyster sauce" },
      { amount: 0.25, unit: "cup", name: "brown sugar" },
      { amount: 2.0, unit: "teaspoons", name: "sesame oil" },
      { amount: 2.0, unit: "tablespoons", name: "cornstarch" },
      { amount: 2.0, unit: "heads", name: "broccoli" },
      { amount: nil, unit: nil, name: "sesame seeds for garnish, if desired" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Add steak, broth, soy sauce, garlic, oyster sauce, brown sugar and sesame oil to a slow cooker. Stir to combine.Cook on low for 4-5 hours or until steak is tender.",
      "Reserve 1/4 cup of the cooking liquid and whisk in the cornstarch to the reserved liquid.",
      "Slowly stir the cornstarch mixture into the slow cooker along with the broccoli and continue cooking on low for an additional 30 minutes or until sauce has thickened and broccoli is tender.",
      "Serve immediately with rice and enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Add steak, broth, soy sauce, garlic, oyster sauce, brown sugar and sesame oil to a slow cooker. Stir to combine.Cook on low for 4-5 hours or until steak is tender.\nReserve 1/4 cup of the cooking liquid and whisk in the cornstarch to the reserved liquid.\nSlowly stir the cornstarch mixture into the slow cooker along with the broccoli and continue cooking on low for an additional 30 minutes or until sauce has thickened and broccoli is tender.\nServe immediately with rice and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("chefsavvy.com")
    expect(recipe.canonical_url).to eq("https://chefsavvy.com/slow-cooker-broccoli-beef/")
    expect(recipe.site_name).to eq("Chef Savvy")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Kelley Simmons")
    expect(recipe.description).to eq("Slow Cooker Broccoli Beef. Super tender steak cooked low and slow for 5 hours! Serve over a bowl of rice or noodles!")
    expect(recipe.image).to eq("https://chefsavvy.com/wp-content/uploads/easy-slow-cooker-broccoli-beef.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("Chinese")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(310)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(300)
    expect(recipe.keywords).to eq(["Chuck Roast", "Garlic", "Sesame", "Slow Cooker Broccoli Beef"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.7)
    expect(recipe.ratings_count).to eq(20)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "711 kcal",
      "carbohydrateContent" => "43 g",
      "proteinContent" => "54 g",
      "fatContent" => "39 g",
      "saturatedFatContent" => "15 g",
      "cholesterolContent" => "154 mg",
      "sodiumContent" => "1828 mg",
      "fiberContent" => "8 g",
      "sugarContent" => "19 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 711.0 },
      { name: "carbohydrateContent", unit: "g", amount: 43.0 },
      { name: "proteinContent", unit: "g", amount: 54.0 },
      { name: "fatContent", unit: "g", amount: 39.0 },
      { name: "saturatedFatContent", unit: "g", amount: 15.0 },
      { name: "cholesterolContent", unit: "mg", amount: 154.0 },
      { name: "sodiumContent", unit: "mg", amount: 1828.0 },
      { name: "fiberContent", unit: "g", amount: 8.0 },
      { name: "sugarContent", unit: "g", amount: 19.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#body")
  end
end
