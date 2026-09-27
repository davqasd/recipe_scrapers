# frozen_string_literal: true

RSpec.describe "hellofresh.co.uk" do
  subject(:recipe) { scrape_cassette("uk/hellofresh", url: "https://www.hellofresh.co.uk/recipes/one-pan-hoisin-beef-and-pork-mince-and-veggie-gyoza-udon-689494eccc90c7911daf375f") }

  it "reads the title" do
    expect(recipe.title).to eq("One Pan Hoisin Beef and Pork Mince & Veggie Gyoza Udon with Tenderstem® Broccoli and Carrot")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "160 grams Tenderstem® Broccoli",
      "1 unit(s) Carrot",
      "2 unit(s) Garlic Clove",
      "240 grams British Beef and Pork Mince",
      "60 grams Hoisin Sauce",
      "20 milliliter(s) Ketjap Manis",
      "220 grams Udon Noodles",
      "10 unit(s) Vegetable Gyozas",
      "50 milliliter(s) Water for the Sauce"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 160.0, unit: "grams", name: "Tenderstem® Broccoli" },
      { amount: 1.0, unit: nil, name: "unit Carrot" },
      { amount: 2.0, unit: nil, name: "unit Garlic Clove" },
      { amount: 240.0, unit: "grams", name: "British Beef and Pork Mince" },
      { amount: 60.0, unit: "grams", name: "Hoisin Sauce" },
      { amount: 20.0, unit: "milliliter", name: "Ketjap Manis" },
      { amount: 220.0, unit: "grams", name: "Udon Noodles" },
      { amount: 10.0, unit: nil, name: "unit Vegetable Gyozas" },
      { amount: 50.0, unit: "milliliter", name: "Water for the Sauce" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "a) Preheat your oven to 220°C/200°C fan/gas mark 7. Pop the gyozas onto a baking tray and drizzle with oil. Toss to coat. Bake on the top shelf of your oven, 10-12 mins. b) Halve any thick broccoli stems lengthways. Trim the carrot, then halve lengthways (no need to peel). Slice widthways into pieces about ½cm thick. c) Peel and grate the garlic (or use a garlic press).",
      "a) Heat a drizzle of oil in a large frying pan on medium-high heat. b) Once hot, add the Tenderstem® and carrot. Stir-fry for 2-3 mins. Add a splash of water, then cover with a lid (or foil) and allow to cook until tender, 2-3 mins more. Season with salt and pepper. c) Remove the veg and place in a medium bowl. Cover to keep warm.",
      "a) Wipe out your frying pan, then pop back on medium-high heat with a drizzle of oil. b) Once hot, add the beef and pork mince. Fry until the mince has browned, 5-6 mins. Use a spoon to break it up as it cooks. c) When the mince has browned, drain and discard any excess fat. Season with salt and pepper. IMPORTANT: Wash your hands and equipment after handling raw mince. It's cooked when no longer pink in the middle.",
      "a) Once the mince is cooked, add the garlic and fry for 1 min more. b) Stir in the hoisin, ketjap and water for the sauce (see pantry for amount). c) Simmer the sauce until slightly thickened, 2-3 mins.",
      "a) Add the udon noodles to the pan along with the broccoli and carrot. b) Toss to coat in the sauce, using a fork to gently separate the noodles. Simmer until piping hot, 1-2 mins. c) Taste and season with salt and pepper if needed. Add a splash of water if the sauce is too thick.",
      "a) Share the noodles between your serving bowls. b) Top with the veggie gyozas."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("a) Preheat your oven to 220°C/200°C fan/gas mark 7. Pop the gyozas onto a baking tray and drizzle with oil. Toss to coat. Bake on the top shelf of your oven, 10-12 mins. b) Halve any thick broccoli stems lengthways. Trim the carrot, then halve lengthways (no need to peel). Slice widthways into pieces about ½cm thick. c) Peel and grate the garlic (or use a garlic press).\na) Heat a drizzle of oil in a large frying pan on medium-high heat. b) Once hot, add the Tenderstem® and carrot. Stir-fry for 2-3 mins. Add a splash of water, then cover with a lid (or foil) and allow to cook until tender, 2-3 mins more. Season with salt and pepper. c) Remove the veg and place in a medium bowl. Cover to keep warm.\na) Wipe out your frying pan, then pop back on medium-high heat with a drizzle of oil. b) Once hot, add the beef and pork mince. Fry until the mince has browned, 5-6 mins. Use a spoon to break it up as it cooks. c) When the mince has browned, drain and discard any excess fat. Season with salt and pepper. IMPORTANT: Wash your hands and equipment after handling raw mince. It's cooked when no longer pink in the middle.\na) Once the mince is cooked, add the garlic and fry for 1 min more. b) Stir in the hoisin, ketjap and water for the sauce (see pantry for amount). c) Simmer the sauce until slightly thickened, 2-3 mins.\na) Add the udon noodles to the pan along with the broccoli and carrot. b) Toss to coat in the sauce, using a fork to gently separate the noodles. Simmer until piping hot, 1-2 mins. c) Taste and season with salt and pepper if needed. Add a splash of water if the sauce is too thick.\na) Share the noodles between your serving bowls. b) Top with the veggie gyozas.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hellofresh.co.uk")
    expect(recipe.canonical_url).to eq("https://www.hellofresh.co.uk/recipes/one-pan-hoisin-beef-and-pork-mince-and-veggie-gyoza-udon-689494eccc90c7911daf375f")
    expect(recipe.site_name).to eq("HelloFresh")
    expect(recipe.language).to eq("en-GB")
    expect(recipe.author).to eq("HelloFresh")
    expect(recipe.description).to eq("A fast favourite, stir-frying is the perfect method to build flavour and cook quickly! This One Pan Hoisin Beef and Pork Udon with Veggie Gyozas will be on your table in less than 25 minutes and is great for a balanced lifestyle.")
    expect(recipe.image).to eq("https://img.hellofresh.com/f_auto,fl_lossy,h_640,q_auto,w_1200/hellofresh_s3/image/HF_Y25_R11_W02_UK_QR18418-14_Main_Veggie_gyozas_edit_high-4ee36fab.jpg")
    expect(recipe.category).to eq("main course")
    expect(recipe.cuisine).to eq("Chinese")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.173857999435101)
    expect(recipe.ratings_count).to eq(4751)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "754 kcal",
      "fatContent" => "30.8 g",
      "saturatedFatContent" => "7.4 g",
      "carbohydrateContent" => "76.5 g",
      "sugarContent" => "23.1 g",
      "proteinContent" => "41.3 g",
      "fiberContent" => "11.1 g",
      "sodiumContent" => "3.1 g",
      "servingSize" => "534"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 754.0 },
      { name: "fatContent", unit: "g", amount: 30.8 },
      { name: "saturatedFatContent", unit: "g", amount: 7.4 },
      { name: "carbohydrateContent", unit: "g", amount: 76.5 },
      { name: "sugarContent", unit: "g", amount: 23.1 },
      { name: "proteinContent", unit: "g", amount: 41.3 },
      { name: "fiberContent", unit: "g", amount: 11.1 },
      { name: "sodiumContent", unit: "g", amount: 3.1 },
      { name: "servingSize", unit: nil, amount: 534.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#page")
  end
end
