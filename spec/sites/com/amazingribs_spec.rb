# frozen_string_literal: true

RSpec.describe "amazingribs.com" do
  subject(:recipe) { scrape_cassette("com/amazingribs", url: "https://amazingribs.com/tested-recipes/sausage-recipes/texas-hot-guts-smoked-sausage/") }

  it "reads the title" do
    expect(recipe.title).to eq("Texas Hot Guts Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 teaspoons whole black peppercorns",
      "2 teaspoons fresh ground black pepper",
      "2 teaspoons Morton Coarse Kosher Salt",
      "2 teaspoons rubbed sage",
      "2 teaspoons mild American paprika",
      "1 teaspoon cayenne flakes",
      "1 teaspoon garlic powder",
      "16 ounces ground pork butt (80% lean)",
      "16 ounces ground beef chuck (80% lean)",
      "2 tablespoons dry nonfat milk (this is a binder)",
      "⅓ cup very cold water",
      "4 feet pork sausage casings"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "teaspoons", name: "whole black peppercorns" },
      { amount: 2.0, unit: "teaspoons", name: "fresh ground black pepper" },
      { amount: 2.0, unit: "teaspoons", name: "Morton Coarse Kosher Salt" },
      { amount: 2.0, unit: "teaspoons", name: "rubbed sage" },
      { amount: 2.0, unit: "teaspoons", name: "mild American paprika" },
      { amount: 1.0, unit: "teaspoon", name: "cayenne flakes" },
      { amount: 1.0, unit: "teaspoon", name: "garlic powder" },
      { amount: 16.0, unit: "ounces", name: "ground pork butt" },
      { amount: 16.0, unit: "ounces", name: "ground beef chuck" },
      { amount: 2.0, unit: "tablespoons", name: "dry nonfat milk" },
      { amount: 0.33, unit: "cup", name: "very cold water" },
      { amount: 4.0, unit: "feet", name: "pork sausage casings" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Prep. Put the whole black peppercorns into a plastic bag and smash the heck outta them with a small frying pan until you have chunks of cracked peppercorns. Mix them with the rest of the black pepper, paprika, garlic powder, salt, sage, and chile powder in a small bowl.",
      "Optional. I have made this with 2 finely minced jalapeños, 1 medium onion, and 4 cloves of garlic. Then I went back to Texas and tasted a lot of sausages and only a few had these additions, so they are now optional. I like 'em. If you decide to use them, remove the seeds and stems from the jalapeño and mince it into tiny bits. Peel the onion and garlic and mince them too. Now, go to our article on the Science of Making Sausage and follow steps (1) through (16).",
      "Smoke. Set up your grill or smoker and maintain a steady 225°F (107.2°C). Smoke the sausages at 225°F (107.2°C) until they hit 160°F (71.1°C) internal temperature, about 1 to 2 hours. As long as they hit that internal temp, you can experiment with the time to get your preferred level of smoke on the sausage.",
      "Serve. You can serve Hot Guts nekkid on a plate with some saltine crackers and hot sauce (traditional Texas style) or with some potatoes and a salad, or on a bun, or incorporate them into a dish like German Potato Salad or Choucroute Garnie, the classic Alsatian hot dish of sauerkraut, potatoes, various charcuterie, and mustard."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Prep. Put the whole black peppercorns into a plastic bag and smash the heck outta them with a small frying pan until you have chunks of cracked peppercorns. Mix them with the rest of the black pepper, paprika, garlic powder, salt, sage, and chile powder in a small bowl.\nOptional. I have made this with 2 finely minced jalapeños, 1 medium onion, and 4 cloves of garlic. Then I went back to Texas and tasted a lot of sausages and only a few had these additions, so they are now optional. I like 'em. If you decide to use them, remove the seeds and stems from the jalapeño and mince it into tiny bits. Peel the onion and garlic and mince them too. Now, go to our article on the Science of Making Sausage and follow steps (1) through (16).\nSmoke. Set up your grill or smoker and maintain a steady 225°F (107.2°C). Smoke the sausages at 225°F (107.2°C) until they hit 160°F (71.1°C) internal temperature, about 1 to 2 hours. As long as they hit that internal temp, you can experiment with the time to get your preferred level of smoke on the sausage.\nServe. You can serve Hot Guts nekkid on a plate with some saltine crackers and hot sauce (traditional Texas style) or with some potatoes and a salad, or on a bun, or incorporate them into a dish like German Potato Salad or Choucroute Garnie, the classic Alsatian hot dish of sauerkraut, potatoes, various charcuterie, and mustard.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("amazingribs.com")
    expect(recipe.canonical_url).to eq("https://amazingribs.com/tested-recipes/sausage-recipes/texas-hot-guts-smoked-sausage/")
    expect(recipe.site_name).to eq("Meathead's AmazingRibs.com")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Meathead Goldwyn")
    expect(recipe.description).to eq("In the Lone Star state, smoked sausage is as central to barbecue as brisket. There is no standard recipe, but natural casing (the guts) always hold the ground meat mixture. IMPORTANT: Before you get started, read our article on The Science of Sausage Making. NOTE: This recipe was revised on 2/6/2024")
    expect(recipe.image).to eq("https://amazingribs.com/wp-content/uploads/2020/10/hot-guts-open.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(165)
    expect(recipe.prep_time).to eq(45)
    expect(recipe.cook_time).to eq(120)
    expect(recipe.keywords).to eq(["brisket", "brisket sausage", "sausage", "smoked sausage"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.1)
    expect(recipe.ratings_count).to eq(111)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "233 kcal",
      "carbohydrateContent" => "3 g",
      "proteinContent" => "21 g",
      "fatContent" => "15 g",
      "saturatedFatContent" => "6 g",
      "transFatContent" => "1 g",
      "cholesterolContent" => "75 mg",
      "sodiumContent" => "667 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "1 g",
      "unsaturatedFatContent" => "7 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 233.0 },
      { name: "carbohydrateContent", unit: "g", amount: 3.0 },
      { name: "proteinContent", unit: "g", amount: 21.0 },
      { name: "fatContent", unit: "g", amount: 15.0 },
      { name: "saturatedFatContent", unit: "g", amount: 6.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 75.0 },
      { name: "sodiumContent", unit: "mg", amount: 667.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 7.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://amazingribs.com/information-about-our-pitmaster-club/")
  end
end
