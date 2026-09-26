# frozen_string_literal: true

RSpec.describe "ricardocuisine.com" do
  subject(:recipe) { scrape_cassette("com/ricardocuisine", url: "https://www.ricardocuisine.com/en/recipes/3111-slow-cooked-pulled-pork") }

  it "reads the title" do
    expect(recipe.title).to eq("Slow-Cooked Pulled Pork")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 can (398 ml/14 oz) plum tomatoes, drained",
      "1/2 cup (125 ml) ketchup",
      "1 1/2 tablespoons (22.5 ml) Worcestershire sauce",
      "1/4 cup (60 ml) cider vinegar",
      "1 tablespoon (15 ml) molasses",
      "1 teaspoon (5 ml) dry mustard",
      "1 tablespoon (15 ml) soy sauce",
      "1 onion, coarsely chopped",
      "2 cloves garlic",
      "Hot pepper sauce, to taste",
      "1 pork shoulder roast, about 4 lb (1.8 kg) (with or without bone, untied)",
      "Salt and pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "can", name: "plum tomatoes, drained" },
      { amount: 0.5, unit: "cup", name: "ketchup" },
      { amount: 1.5, unit: "tablespoons", name: "Worcestershire sauce" },
      { amount: 0.25, unit: "cup", name: "cider vinegar" },
      { amount: 1.0, unit: "tablespoon", name: "molasses" },
      { amount: 1.0, unit: "teaspoon", name: "dry mustard" },
      { amount: 1.0, unit: "tablespoon", name: "soy sauce" },
      { amount: 1.0, unit: nil, name: "onion, coarsely chopped" },
      { amount: 2.0, unit: "cloves", name: "garlic" },
      { amount: nil, unit: nil, name: "Hot pepper sauce, to taste" },
      { amount: 1.0, unit: nil, name: "pork shoulder roast, about 4 lb" },
      { amount: nil, unit: nil, name: "Salt and pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Slow-Cooked Pulled Pork",
      "In a blender, purée all ingredients except the pork. Season with salt and pepper.",
      "Season the pork with salt and pepper. Place it in the slow cooker with the sauce. Cover and cook on low heat for about 8 hours. Alternatively, cook on high for 6 hours.",
      "Place the meat on a plate and tent with aluminum foil. Let stand 15 minutes, then shred using a fork.",
      "Meanwhile, in a saucepan, bring the sauce to a boil and reduce until syrupy, about half the original volume. Add the meat and coat well with the sauce."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Slow-Cooked Pulled Pork\nIn a blender, purée all ingredients except the pork. Season with salt and pepper.\nSeason the pork with salt and pepper. Place it in the slow cooker with the sauce. Cover and cook on low heat for about 8 hours. Alternatively, cook on high for 6 hours.\nPlace the meat on a plate and tent with aluminum foil. Let stand 15 minutes, then shred using a fork.\nMeanwhile, in a saucepan, bring the sauce to a boil and reduce until syrupy, about half the original volume. Add the meat and coat well with the sauce.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("ricardocuisine.com")
    expect(recipe.canonical_url).to eq("https://www.ricardocuisine.com/en/recipes/3111-slow-cooked-pulled-pork")
    expect(recipe.site_name).to eq("Ricardo")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Ricardocuisine")
    expect(recipe.description).to eq("Plum tomatoes, ketchup, molasses and soy sauce come together to create a succulent sauce for simmering pork shoulder. Once the meat is in the slow cooker, just wait and enjoy the lovely smell wafting through the house. Once cooked, the pork is shredded and ready to garnish a mouth-watering burger.")
    expect(recipe.image).to eq("https://ucarecdn.com/2b9d3927-d80d-42d2-a81f-ea53e2e1277a/-/crop/1919x2592/1,0/-/preview/-/crop/1:1/")
    expect(recipe.category).to eq("Main Dishes")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(500)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(480)
    expect(recipe.keywords).to eq([
      "weeknight dinner ideas",
      "weeknight recipes",
      "unique dinner ideas",
      "easy weeknight dinner recipes",
      "quick dinner ideas for family",
      "comfort food recipes",
      "cheap dinner recipes",
      "cheap and easy dinner recipes",
      "pulled pork recipe slow cooker",
      "pulled pork recipes",
      "pork shoulder recipe",
      "slow cooker pork shoulder recipes",
      "slow cooker recipes",
      "pulled pork burger"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(137)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "calories" => "590 calories" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 590.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/en")
  end
end
