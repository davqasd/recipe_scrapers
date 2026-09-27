# frozen_string_literal: true

RSpec.describe "hellofresh.co.nz" do
  subject(:recipe) { scrape_cassette("nz/hellofresh", url: "https://www.hellofresh.co.nz/recipes/teriyaki-chicken-and-garlic-rice-bowl-with-japanese-mayo-and-sesame-seeds-61ad6802821687387403bc27") }

  it "reads the title" do
    expect(recipe.title).to eq("Teriyaki Chicken & Garlic Rice Bowl with Japanese Mayo & Sesame Seeds Top rated | Available all January")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 olive oil",
      "20 g butter",
      "1 packet jasmine rice",
      "1 carrot",
      "1 packet chicken breast",
      "40 g mayonnaise",
      "½ sachet mixed sesame seeds",
      "65 g teriyaki sauce",
      "2 tsp soy sauce",
      "1 bag herbs",
      "2 clove garlic",
      "1.25 cup water (for the rice)",
      "1 head Asian Greens",
      "30 g Japanese Dressing",
      "1 tbs water (for the sauce)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "olive oil" },
      { amount: 20.0, unit: "g", name: "butter" },
      { amount: 1.0, unit: "packet", name: "jasmine rice" },
      { amount: 1.0, unit: nil, name: "carrot" },
      { amount: 1.0, unit: "packet", name: "chicken breast" },
      { amount: 40.0, unit: "g", name: "mayonnaise" },
      { amount: 0.5, unit: nil, name: "sachet mixed sesame seeds" },
      { amount: 65.0, unit: "g", name: "teriyaki sauce" },
      { amount: 2.0, unit: "tsp", name: "soy sauce" },
      { amount: 1.0, unit: "bag", name: "herbs" },
      { amount: 2.0, unit: "clove", name: "garlic" },
      { amount: 1.25, unit: "cup", name: "water" },
      { amount: 1.0, unit: "head", name: "Asian Greens" },
      { amount: 30.0, unit: "g", name: "Japanese Dressing" },
      { amount: 1.0, unit: "tbs", name: "water" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Finely chop the garlic. In a medium saucepan, melt the butter with a dash of olive oil over a medium heat. Cook the garlic until fragrant, 1-2 minutes. Add the jasmine rice, water (for the rice) and a pinch of salt, stir, then bring to the boil. Reduce the heat to low and cover with a lid. Cook for 12 minutes, then remove from the heat and keep covered until the rice is tender and the water is absorbed, 10-15 minutes. TIP: The rice will finish cooking in its own steam so don't peek!",
      "While the rice is cooking, thinly slice the carrot into half-moons. Roughly chop the Asian greens. Cut the chicken breast into 2cm chunks. In a small bowl, combine the mayonnaise and Japanese dressing. Set aside.",
      "Heat a large frying pan over a medium-high heat. Toast the mixed sesame seeds (see ingredients), tossing, until golden, 2-3 minutes. Transfer to a bowl.",
      "Return the frying pan to a medium-high heat with a drizzle of olive oil. Cook the carrot until tender, 4-5 minutes. Add the Asian greens and cook until wilted, 2-3 minutes. Season with salt and pepper, then transfer to a medium bowl.",
      "Return the frying pan to a high heat with a drizzle of olive oil. When the oil is hot, cook the chicken, tossing occasionally, until browned and cooked through, 5-6 minutes (cook in batches if your pan is getting crowded). Add the teriyaki sauce, water (for the sauce) and soy sauce and cook until bubbling and reduced slightly, 30 seconds.",
      "Roughly chop the herbs. Divide the garlic rice between bowls. Top with the veggies and teriyaki chicken (plus any remaining glaze from the pan). Sprinkle over the herbs and toasted sesame seeds. Serve with the Japanese mayo."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Finely chop the garlic. In a medium saucepan, melt the butter with a dash of olive oil over a medium heat. Cook the garlic until fragrant, 1-2 minutes. Add the jasmine rice, water (for the rice) and a pinch of salt, stir, then bring to the boil. Reduce the heat to low and cover with a lid. Cook for 12 minutes, then remove from the heat and keep covered until the rice is tender and the water is absorbed, 10-15 minutes. TIP: The rice will finish cooking in its own steam so don't peek!\nWhile the rice is cooking, thinly slice the carrot into half-moons. Roughly chop the Asian greens. Cut the chicken breast into 2cm chunks. In a small bowl, combine the mayonnaise and Japanese dressing. Set aside.\nHeat a large frying pan over a medium-high heat. Toast the mixed sesame seeds (see ingredients), tossing, until golden, 2-3 minutes. Transfer to a bowl.\nReturn the frying pan to a medium-high heat with a drizzle of olive oil. Cook the carrot until tender, 4-5 minutes. Add the Asian greens and cook until wilted, 2-3 minutes. Season with salt and pepper, then transfer to a medium bowl.\nReturn the frying pan to a high heat with a drizzle of olive oil. When the oil is hot, cook the chicken, tossing occasionally, until browned and cooked through, 5-6 minutes (cook in batches if your pan is getting crowded). Add the teriyaki sauce, water (for the sauce) and soy sauce and cook until bubbling and reduced slightly, 30 seconds.\nRoughly chop the herbs. Divide the garlic rice between bowls. Top with the veggies and teriyaki chicken (plus any remaining glaze from the pan). Sprinkle over the herbs and toasted sesame seeds. Serve with the Japanese mayo.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hellofresh.co.nz")
    expect(recipe.canonical_url).to eq("https://www.hellofresh.co.nz/recipes/teriyaki-chicken-and-garlic-rice-bowl-with-japanese-mayo-and-sesame-seeds-61ad6802821687387403bc27")
    expect(recipe.site_name).to eq("HelloFresh")
    expect(recipe.language).to eq("en-NZ")
    expect(recipe.author).to eq("HelloFresh")
    expect(recipe.description).to eq("When mayo gets together with Japanese dressing, our tastebuds start doing a happy dance. And when juicy pieces of teriyaki chicken, crunchy greens and mouth-watering garlic rice join the mix, it's our kind of party!")
    expect(recipe.image).to eq("https://img.hellofresh.com/f_auto,fl_lossy,h_640,q_auto,w_1200/hellofresh_s3/image/teriyaki-chicken-garlic-rice-bowl-745de1d2.jpg")
    expect(recipe.category).to eq("main course")
    expect(recipe.cuisine).to eq("Japanese")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.6682098507881165)
    expect(recipe.ratings_count).to eq(162)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "fatContent" => "35.1 g",
      "saturatedFatContent" => "10.3 g",
      "carbohydrateContent" => "84.9 g",
      "sugarContent" => "16.2 g",
      "proteinContent" => "42.1 g",
      "sodiumContent" => "1159 mg"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "fatContent", unit: "g", amount: 35.1 },
      { name: "saturatedFatContent", unit: "g", amount: 10.3 },
      { name: "carbohydrateContent", unit: "g", amount: 84.9 },
      { name: "sugarContent", unit: "g", amount: 16.2 },
      { name: "proteinContent", unit: "g", amount: 42.1 },
      { name: "sodiumContent", unit: "mg", amount: 1159.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#page")
  end
end
