# frozen_string_literal: true

RSpec.describe "lazycatkitchen.com" do
  subject(:recipe) { scrape_cassette("com/lazycatkitchen", url: "https://www.lazycatkitchen.com/puttanesca-pasta/") }

  it "reads the title" do
    expect(recipe.title).to eq("Puttanesca pasta")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "200 g / 7 oz linguine or spaghetti (gluten-free if needed)",
      "2-3 tbsp / 30-45 ml olive oil",
      "2 garlic cloves, sliced finely",
      "1 red chilli* or ½-1 tsp chilli flakes, adjust to preference",
      "20 g / 2 tbsp capers in brine, roughly chopped if large",
      "12 black olives, I used Kalamata",
      "100 g / 3.5 oz cherry tomatoes (optional)",
      "400 g / 14 oz can of quality tomatoes",
      "salt and black pepper, to taste",
      "a handful of fresh parsley, chopped finely"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 200.0, unit: "g", name: "linguine or spaghetti" },
      { amount: 2.0, unit: "tbsp", name: "olive oil" },
      { amount: 2.0, unit: nil, name: "garlic cloves, sliced finely" },
      { amount: 1.0, unit: nil, name: "red chilli* or ½-1 tsp chilli flakes, adjust to preference" },
      { amount: 20.0, unit: "g", name: "capers in brine, roughly chopped if large" },
      { amount: 12.0, unit: nil, name: "black olives, I used Kalamata" },
      { amount: 100.0, unit: "g", name: "cherry tomatoes" },
      { amount: 400.0, unit: "g", name: "can of quality tomatoes" },
      { amount: nil, unit: nil, name: "salt and black pepper, to taste" },
      { amount: 1.0, unit: "handful", name: "fresh parsley, chopped finely" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Heat up 2 tbsp of olive oil on low-medium heat. Add finely sliced garlic and finely chopped chilli (deseed it first if you want less spice).",
      "Allow the garlic to sizzle gently in the oil until it's golden, but be sure it doesn't turn brown as it will make the dish taste bitter - keep the flame low and stir frequently.",
      "Once garlic is ready, add capers blotted on a piece of paper towel. Carry on frying them off gently for a couple of minutes.",
      "Next, add halves olives and tomatoes - both canned and fresh cherry toms - to the pan. If you are using a can of whole plum tomatoes or tomato chunks, squash them down first using a potato masher or a fork - this will speed things up.",
      "Season with pepper and a generous pinch of salt, then increase the heat to medium and allow the sauce to thicken while you cook your pasta. Once reduced, taste and adjust the seasoning. Add a touch of sugar if the sauce is too acidic.",
      "While the sauce is bubbling away, cook your pasta until just shy of al dente. Drain, reserving about half a cup (120 ml) of pasta cooking water.",
      "Transfer drained pasta into the pan with the pasta. Use a splash of pasta cooking water if the sauce needs loosening up a bit.",
      "Divide between two (100 g / 3.5 oz of pasta per person) or three (just under 70 g / 2.5 oz pasta per person) plates. Serve immediately, with finely chopped parsley on top."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Heat up 2 tbsp of olive oil on low-medium heat. Add finely sliced garlic and finely chopped chilli (deseed it first if you want less spice).\nAllow the garlic to sizzle gently in the oil until it's golden, but be sure it doesn't turn brown as it will make the dish taste bitter - keep the flame low and stir frequently.\nOnce garlic is ready, add capers blotted on a piece of paper towel. Carry on frying them off gently for a couple of minutes.\nNext, add halves olives and tomatoes - both canned and fresh cherry toms - to the pan. If you are using a can of whole plum tomatoes or tomato chunks, squash them down first using a potato masher or a fork - this will speed things up.\nSeason with pepper and a generous pinch of salt, then increase the heat to medium and allow the sauce to thicken while you cook your pasta. Once reduced, taste and adjust the seasoning. Add a touch of sugar if the sauce is too acidic.\nWhile the sauce is bubbling away, cook your pasta until just shy of al dente. Drain, reserving about half a cup (120 ml) of pasta cooking water.\nTransfer drained pasta into the pan with the pasta. Use a splash of pasta cooking water if the sauce needs loosening up a bit.\nDivide between two (100 g / 3.5 oz of pasta per person) or three (just under 70 g / 2.5 oz pasta per person) plates. Serve immediately, with finely chopped parsley on top.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("lazycatkitchen.com")
    expect(recipe.canonical_url).to eq("https://www.lazycatkitchen.com/puttanesca-pasta/")
    expect(recipe.site_name).to eq("Lazy Cat Kitchen")
    expect(recipe.language).to eq("en-GB")
    expect(recipe.author).to eq("Ania")
    expect(recipe.description).to eq("Puttanesca pasta is an incredibly tasty and easy Italian dish that comes together in minutes. It's full of flavour, naturally vegan, can be gluten-free.")
    expect(recipe.image).to eq("https://cdn77-s3.lazycatkitchen.com/wp-content/uploads/2025/07/puttanesca-pasta-pan-150x150.jpg")
    expect(recipe.category).to eq("large plates")
    expect(recipe.cuisine).to eq("Italian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["comfort food", "easy", "gluten-free", "Italian"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(3)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "404.71 calories",
      "carbohydrateContent" => "63.18 grams",
      "cholesterolContent" => "0 milligrams",
      "fatContent" => "12.73 grams",
      "fiberContent" => "5.68 grams",
      "proteinContent" => "11.78 grams",
      "saturatedFatContent" => "1.93 grams",
      "sodiumContent" => "784.54 milligrams",
      "sugarContent" => "8.41 grams",
      "transFatContent" => "0 grams",
      "unsaturatedFatContent" => "10.8 grams"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 404.71 },
      { name: "carbohydrateContent", unit: "g", amount: 63.18 },
      { name: "cholesterolContent", unit: "mg", amount: 0.0 },
      { name: "fatContent", unit: "g", amount: 12.73 },
      { name: "fiberContent", unit: "g", amount: 5.68 },
      { name: "proteinContent", unit: "g", amount: 11.78 },
      { name: "saturatedFatContent", unit: "g", amount: 1.93 },
      { name: "sodiumContent", unit: "mg", amount: 784.54 },
      { name: "sugarContent", unit: "g", amount: 8.41 },
      { name: "transFatContent", unit: "g", amount: 0.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 10.8 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://instagram.com/lazycatkitchen/")
  end
end
