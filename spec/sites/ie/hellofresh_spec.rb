# frozen_string_literal: true

RSpec.describe "hellofresh.ie" do
  subject(:recipe) { scrape_cassette("ie/hellofresh", url: "https://www.hellofresh.ie/recipes/beats-of-the-jungle-apple-and-beef-burger-inspired-by-timon-67c6dd7e8f112f54d1d74375") }

  it "reads the title" do
    expect(recipe.title).to eq("Beats of the Jungle: Apple & Beef Burger Inspired by Timon")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "600 grams Potatoes",
      "1 unit(s) Apple",
      "1 unit(s) Onion",
      "240 grams Irish Beef Mince",
      "2 sachet(s) Mayo",
      "2 unit(s) Brioche Buns",
      "50 grams Grated Cheese",
      "1 pack(s) Breadcrumbs",
      "2 sachet(s) Ketchup",
      "1 sachet(s) Balsamic Glaze",
      "½ sachet(s) Curry Powder",
      "1 sachet(s) Crispy Onions",
      "¼ tsp Salt",
      "1.5 tsp Sugar",
      "to taste Salt",
      "to taste Pepper",
      "to taste Oil",
      "to taste Water"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 600.0, unit: "grams", name: "Potatoes" },
      { amount: 1.0, unit: nil, name: "unit Apple" },
      { amount: 1.0, unit: nil, name: "unit Onion" },
      { amount: 240.0, unit: "grams", name: "Irish Beef Mince" },
      { amount: 2.0, unit: nil, name: "sachet Mayo" },
      { amount: 2.0, unit: nil, name: "unit Brioche Buns" },
      { amount: 50.0, unit: "grams", name: "Grated Cheese" },
      { amount: 1.0, unit: nil, name: "pack Breadcrumbs" },
      { amount: 2.0, unit: nil, name: "sachet Ketchup" },
      { amount: 1.0, unit: nil, name: "sachet Balsamic Glaze" },
      { amount: 0.5, unit: nil, name: "sachet Curry Powder" },
      { amount: 1.0, unit: nil, name: "sachet Crispy Onions" },
      { amount: 0.25, unit: "tsp", name: "Salt" },
      { amount: 1.5, unit: "tsp", name: "Sugar" },
      { amount: nil, unit: nil, name: "to taste Salt" },
      { amount: nil, unit: nil, name: "to taste Pepper" },
      { amount: nil, unit: nil, name: "to taste Oil" },
      { amount: nil, unit: nil, name: "to taste Water" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat your oven to 240°C/220°C fan/gas mark 9. Chop the potatoes lengthways into 1cm slices, then into 1cm wide chips (no need to peel). Pop the chips onto a lined baking tray. Drizzle with oil, season with salt and pepper then toss to coat. Spread out in a single layer. Cook on the top shelf until golden, 25-30 mins. Turn the tray halfway through. TIP: Use two baking trays if necessary.",
      "Halve, peel and thinly slice the onion. Place a medium pot over medium-high heat with a drizzle of oil. Once hot, add the onion and season with salt and pepper. Fry until soft and sweet, stirring occasionally, 4-6 mins.",
      "Meanwhile, quarter the apple, remove the core and seeds and coarsely grate. Once the onion is softened, add half a sachet of curry powder (per 2P) and cook for 1 min more. Pop in 150ml water (per 2P), 1 ½ tbsp sugar (per 2P), ¼ tsp salt (per 2P), the balsamic glaze and two-thirds of the grated apple. Cover and cook for another 6-8 mins, stirring occasionally. Add a splash of water if required.",
      "While the chutney cooks, combine the beef mince with the remaining grated apple and the breadcrumbs in a large bowl. IMPORTANT: Wash hands and equipment after handling raw mince. Season with salt and pepper and mix everything together by hand. Roll into evenly-sized balls, then shape into 1cm thick burgers, one per person.",
      "Place a pan over medium-high heat with a drizzle of oil. Once hot, fry the burgers until browned on the outside and cooked through, 12-14 mins. Carefully turn every 3-4 mins, adjusting the heat if necessary. IMPORTANT: Burgers are cooked when no longer pink in the middle. Once cooked, remove pan from heat and divide the cheese between burgers. Cover and set aside until the cheese is melted, 3-4 mins. Pop the buns into the oven to warm, 2-3 mins.",
      "To assemble the burgers, spread a spoonful of mayo and ketchup over each base bun. Top with the beef burger and apple onion chutney. Sandwich closed with the top bun. Serve with potatoes alongside and scatter over the crispy onion. Little chef's TIP: Kids can help to scatter over the crispy onion to make the grubby chips."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat your oven to 240°C/220°C fan/gas mark 9. Chop the potatoes lengthways into 1cm slices, then into 1cm wide chips (no need to peel). Pop the chips onto a lined baking tray. Drizzle with oil, season with salt and pepper then toss to coat. Spread out in a single layer. Cook on the top shelf until golden, 25-30 mins. Turn the tray halfway through. TIP: Use two baking trays if necessary.\nHalve, peel and thinly slice the onion. Place a medium pot over medium-high heat with a drizzle of oil. Once hot, add the onion and season with salt and pepper. Fry until soft and sweet, stirring occasionally, 4-6 mins.\nMeanwhile, quarter the apple, remove the core and seeds and coarsely grate. Once the onion is softened, add half a sachet of curry powder (per 2P) and cook for 1 min more. Pop in 150ml water (per 2P), 1 ½ tbsp sugar (per 2P), ¼ tsp salt (per 2P), the balsamic glaze and two-thirds of the grated apple. Cover and cook for another 6-8 mins, stirring occasionally. Add a splash of water if required.\nWhile the chutney cooks, combine the beef mince with the remaining grated apple and the breadcrumbs in a large bowl. IMPORTANT: Wash hands and equipment after handling raw mince. Season with salt and pepper and mix everything together by hand. Roll into evenly-sized balls, then shape into 1cm thick burgers, one per person.\nPlace a pan over medium-high heat with a drizzle of oil. Once hot, fry the burgers until browned on the outside and cooked through, 12-14 mins. Carefully turn every 3-4 mins, adjusting the heat if necessary. IMPORTANT: Burgers are cooked when no longer pink in the middle. Once cooked, remove pan from heat and divide the cheese between burgers. Cover and set aside until the cheese is melted, 3-4 mins. Pop the buns into the oven to warm, 2-3 mins.\nTo assemble the burgers, spread a spoonful of mayo and ketchup over each base bun. Top with the beef burger and apple onion chutney. Sandwich closed with the top bun. Serve with potatoes alongside and scatter over the crispy onion. Little chef's TIP: Kids can help to scatter over the crispy onion to make the grubby chips.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hellofresh.ie")
    expect(recipe.canonical_url).to eq("https://www.hellofresh.ie/recipes/beats-of-the-jungle-apple-and-beef-burger-inspired-by-timon-67c6dd7e8f112f54d1d74375")
    expect(recipe.site_name).to eq("HelloFresh")
    expect(recipe.language).to eq("en-IE")
    expect(recipe.author).to eq("HelloFresh")
    expect(recipe.description).to eq("More than just a mere meal, these juicy apple and beef burgers are a favourite among many, even Meerkats.")
    expect(recipe.image).to eq("https://img.hellofresh.com/f_auto,fl_lossy,h_640,q_auto,w_1200/hellofresh_s3/image/HF_Y25_R09_W21_IE_IEXFB37488-3_Main_high-c07bf995.jpg")
    expect(recipe.category).to eq("main course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.453883647918701)
    expect(recipe.ratings_count).to eq(103)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "1022 kcal",
      "fatContent" => "41.8 g",
      "saturatedFatContent" => "17.5 g",
      "carbohydrateContent" => "121.5 g",
      "sugarContent" => "26.7 g",
      "proteinContent" => "43.8 g",
      "fiberContent" => "0.4 g",
      "sodiumContent" => "2.7 g",
      "servingSize" => "670"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 1022.0 },
      { name: "fatContent", unit: "g", amount: 41.8 },
      { name: "saturatedFatContent", unit: "g", amount: 17.5 },
      { name: "carbohydrateContent", unit: "g", amount: 121.5 },
      { name: "sugarContent", unit: "g", amount: 26.7 },
      { name: "proteinContent", unit: "g", amount: 43.8 },
      { name: "fiberContent", unit: "g", amount: 0.4 },
      { name: "sodiumContent", unit: "g", amount: 2.7 },
      { name: "servingSize", unit: nil, amount: 670.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#page")
  end
end
