# frozen_string_literal: true

RSpec.describe "bongeats.com" do
  subject(:recipe) { scrape_cassette("com/bongeats", url: "https://www.bongeats.com/recipe/eggplant-and-morning-glory-stir-fry/") }

  it "reads the title" do
    expect(recipe.title).to eq("Eggplant and Morning Glory Stir-fry")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "400 g minced pork (with fat)",
      "500 g brinjal (4-cm cubes)",
      "350 g morning glory (kolmi shaak, trimmed and cleaned)",
      "35 g dried shiitake mushrooms",
      "50 g vegetable oil",
      "50 g garlic (5 g sliced; 45 g minced)",
      "8 g green chillies (minced)",
      "25 g toban djan (chilli bean sauce)",
      "25 g oyster sauce",
      "25 g soy sauce",
      "7 g salt",
      "15 g sugar",
      "¼ tsp pepper",
      "3 tsp cornflour",
      "1 tsp vinegar",
      "water"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 400.0, unit: "g", name: "minced pork" },
      { amount: 500.0, unit: "g", name: "brinjal" },
      { amount: 350.0, unit: "g", name: "morning glory" },
      { amount: 35.0, unit: "g", name: "dried shiitake mushrooms" },
      { amount: 50.0, unit: "g", name: "vegetable oil" },
      { amount: 50.0, unit: "g", name: "garlic" },
      { amount: 8.0, unit: "g", name: "green chillies" },
      { amount: 25.0, unit: "g", name: "toban djan" },
      { amount: 25.0, unit: "g", name: "oyster sauce" },
      { amount: 25.0, unit: "g", name: "soy sauce" },
      { amount: 7.0, unit: "g", name: "salt" },
      { amount: 15.0, unit: "g", name: "sugar" },
      { amount: 0.25, unit: "tsp", name: "pepper" },
      { amount: 3.0, unit: "tsp", name: "cornflour" },
      { amount: 1.0, unit: "tsp", name: "vinegar" },
      { amount: nil, unit: nil, name: "water" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Trim the silver skin from the pork, cut it in cubes, and mince using a cleaver.",
      "Soak the dried shiitake in hot water until they are rehydrated. Rinse well using a salt rub, and squeeze out all excess water.",
      "Chop them in bite-sized pieces. Coat with 1 tsp cornflour and 1 tsp oil and set aside.",
      "Trim the morning glory, discarding the tougher stalks. Soak in water for 15 mins to dislodge all the soil and dirt. Rinse well, and set it to drain over a colander. When dry, chop roughly.",
      "Slice two large cloves of garlic, and mince the rest. Mince green chillies.",
      "Divide the brinjal in 4-cm cubes. Soak in a solution of 1 tsp salt, 1 tsp vinegar and 1 L water for 15 mins.",
      "Make a slurry with 2 tsp cornflour.",
      "Bring a pot of water to a boil. Parboil the brinjal for 3–4 mins, then strain them over a colander.",
      "Heat the wok thoroughly. Add about 35 g vegetable oil.",
      "Add the pork mince and fry on high heat until brown.",
      "Add the minced garlic and chillies, and stir-fry for a minute. Add shiitake.",
      "Add toban djan, soy sauce, oyster sauce, sugar and pepper. Continue stir-frying on high heat.",
      "Add the brinjal and about 5 g salt. Mix until well combined.",
      "When everything is well fried, remove from the heat and set aside.",
      "Wash your wok, and reheat it on high flame. Add 15 g vegetable oil.",
      "Mix in 2 g salt with the morning glory. Add this to the wok along with a splash of water.",
      "Stir-fry on high heat for 1–2 mins, until limp.",
      "Mix the minced meat mixture back in and stir to combine.",
      "Serve with plain rice or with congee."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Trim the silver skin from the pork, cut it in cubes, and mince using a cleaver.\nSoak the dried shiitake in hot water until they are rehydrated. Rinse well using a salt rub, and squeeze out all excess water.\nChop them in bite-sized pieces. Coat with 1 tsp cornflour and 1 tsp oil and set aside.\nTrim the morning glory, discarding the tougher stalks. Soak in water for 15 mins to dislodge all the soil and dirt. Rinse well, and set it to drain over a colander. When dry, chop roughly.\nSlice two large cloves of garlic, and mince the rest. Mince green chillies.\nDivide the brinjal in 4-cm cubes. Soak in a solution of 1 tsp salt, 1 tsp vinegar and 1 L water for 15 mins.\nMake a slurry with 2 tsp cornflour.\nBring a pot of water to a boil. Parboil the brinjal for 3–4 mins, then strain them over a colander.\nHeat the wok thoroughly. Add about 35 g vegetable oil.\nAdd the pork mince and fry on high heat until brown.\nAdd the minced garlic and chillies, and stir-fry for a minute. Add shiitake.\nAdd toban djan, soy sauce, oyster sauce, sugar and pepper. Continue stir-frying on high heat.\nAdd the brinjal and about 5 g salt. Mix until well combined.\nWhen everything is well fried, remove from the heat and set aside.\nWash your wok, and reheat it on high flame. Add 15 g vegetable oil.\nMix in 2 g salt with the morning glory. Add this to the wok along with a splash of water.\nStir-fry on high heat for 1–2 mins, until limp.\nMix the minced meat mixture back in and stir to combine.\nServe with plain rice or with congee.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("bongeats.com")
    expect(recipe.canonical_url).to eq("https://www.bongeats.com/eggplant-and-morning-glory-stir-fry")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Bong Eats")
    expect(recipe.description).to eq("A home-style Hakka stir-fry with morning glory, brinjal and pork")
    expect(recipe.image).to eq("https://www.bongeats.com/60d34b8627f6e735cf28df18/682f9f5164062ea5ed797c5e_Website%201080x1080.avif")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to eq("Indian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(25)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(98.6)
    expect(recipe.ratings_count).to eq(4144)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "310"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: nil, amount: 310.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#recipe-ingredients")
  end
end
