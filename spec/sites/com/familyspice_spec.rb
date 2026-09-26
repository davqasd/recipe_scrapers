# frozen_string_literal: true

RSpec.describe "familyspice.com" do
  subject(:recipe) { scrape_cassette("com/familyspice", url: "https://familyspice.com/campfire-chili-with-cornbread-crust-3/") }

  it "reads the title" do
    expect(recipe.title).to eq("Dutch Oven Cornbread Chili")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 tbsp extra virgin olive oil",
      "1 onion (diced)",
      "1 red bell pepper (seeded & diced)",
      "1 anaheim chile (seeded & diced)",
      "1 jalapeño pepper (seeded & diced)",
      "1 1/2 lb ground turkey",
      "4 garlic cloves (minced)",
      "2 tbsp chile powder",
      "1 tsp cumin",
      "1/2 tsp salt",
      "15 oz canned black beans (drained an rinsed)",
      "15 oz canned tomato sauce",
      "15 oz canned diced tomatoes",
      "3 oz chipotle chile in adobo sauce",
      "4 oz green chiles (canned, drained & diced)",
      "1/2 cup water (if needed)",
      "1 box of cornbread mix"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "tbsp", name: "extra virgin olive oil" },
      { amount: 1.0, unit: nil, name: "onion" },
      { amount: 1.0, unit: nil, name: "red bell pepper" },
      { amount: 1.0, unit: nil, name: "anaheim chile" },
      { amount: 1.0, unit: nil, name: "jalapeño pepper" },
      { amount: 1.5, unit: "lb", name: "ground turkey" },
      { amount: 4.0, unit: nil, name: "garlic cloves" },
      { amount: 2.0, unit: "tbsp", name: "chile powder" },
      { amount: 1.0, unit: "tsp", name: "cumin" },
      { amount: 0.5, unit: "tsp", name: "salt" },
      { amount: 15.0, unit: "oz", name: "canned black beans" },
      { amount: 15.0, unit: "oz", name: "canned tomato sauce" },
      { amount: 15.0, unit: "oz", name: "canned diced tomatoes" },
      { amount: 3.0, unit: "oz", name: "chipotle chile in adobo sauce" },
      { amount: 4.0, unit: "oz", name: "green chiles" },
      { amount: 0.5, unit: "cup", name: "water" },
      { amount: 1.0, unit: "box", name: "cornbread mix" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a fire ring or other fire-safe container add 35 charcoal briquettes.",
      "Light the briquettes and allow to heat up for approximately 20-30 minutes.",
      "When flames are down and coals are hot, place over the hot coals a 10-inch cast iron Dutch oven.",
      "Add olive oil into Dutch oven.",
      "Stir in diced onions, bell peppers, anaheim chile and jalapeño pepper.",
      "Cook until vegetables start to soften, approximately 5 minutes.",
      "Add ground turkey and garlic cloves to the vegetables and cook until meat is mostly browned.",
      "Season with chile powder, cumin and salt.",
      "Mix in beans, tomato sauce, diced tomatoes, chipotle chile and canned green chiles.",
      "If your coals are too hot you might need more water.",
      "Allow chili to simmer for at least 30 min or up to several hours. The longer the chili cooks, the more flavor the chili will have. If you are simmering the chili for hours, remove 10-15 coals from underneath the Dutch oven. Keep an eye on the coals and the heat while it cooks. You may need to to add new coals if the old ones die out.",
      "Mix together (per package directions 1 box of cornbread mix. There are brands that only require water to be added.",
      "Spread cornbread batter evenly over the top of your chili.",
      "Cover Dutch oven with lid and place approximately 16 hot coals on the lid.",
      "Allow chili and cornbread to cook until cornbread is browned and done, approximately 20-30 minutes."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a fire ring or other fire-safe container add 35 charcoal briquettes.\nLight the briquettes and allow to heat up for approximately 20-30 minutes.\nWhen flames are down and coals are hot, place over the hot coals a 10-inch cast iron Dutch oven.\nAdd olive oil into Dutch oven.\nStir in diced onions, bell peppers, anaheim chile and jalapeño pepper.\nCook until vegetables start to soften, approximately 5 minutes.\nAdd ground turkey and garlic cloves to the vegetables and cook until meat is mostly browned.\nSeason with chile powder, cumin and salt.\nMix in beans, tomato sauce, diced tomatoes, chipotle chile and canned green chiles.\nIf your coals are too hot you might need more water.\nAllow chili to simmer for at least 30 min or up to several hours. The longer the chili cooks, the more flavor the chili will have. If you are simmering the chili for hours, remove 10-15 coals from underneath the Dutch oven. Keep an eye on the coals and the heat while it cooks. You may need to to add new coals if the old ones die out.\nMix together (per package directions 1 box of cornbread mix. There are brands that only require water to be added.\nSpread cornbread batter evenly over the top of your chili.\nCover Dutch oven with lid and place approximately 16 hot coals on the lid.\nAllow chili and cornbread to cook until cornbread is browned and done, approximately 20-30 minutes.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("familyspice.com")
    expect(recipe.canonical_url).to eq("https://familyspice.com/campfire-chili-with-cornbread-crust-3/")
    expect(recipe.site_name).to eq("Family Spice")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Laura Bashar | Family Spice")
    expect(recipe.description).to eq("Whether you are camping or at home, make something special like this Dutch oven chili with cornbread where you bake the cornbread in the same pot as your chili! Also known as cowboy chili, you are sure to be a hit at the campground.")
    expect(recipe.image).to eq("https://familyspice.com/wp-content/uploads/2009/08/campfire_chili_cornbread_1200-2.jpg")
    expect(recipe.category).to eq("Recipes")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(60)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(45)
    expect(recipe.keywords).to eq([
      "campfire chili",
      "camping recipe",
      "chili and cornbread",
      "chili with cornbread crust",
      "cowboy chili",
      "dutch oven chili",
      "dutch oven cornbread"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.67)
    expect(recipe.ratings_count).to eq(21)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 bowl",
      "calories" => "213 kcal",
      "carbohydrateContent" => "21 g",
      "proteinContent" => "25 g",
      "fatContent" => "4 g",
      "saturatedFatContent" => "1 g",
      "transFatContent" => "0.01 g",
      "cholesterolContent" => "47 mg",
      "sodiumContent" => "859 mg",
      "fiberContent" => "8 g",
      "sugarContent" => "6 g",
      "unsaturatedFatContent" => "3 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "bowl", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 213.0 },
      { name: "carbohydrateContent", unit: "g", amount: 21.0 },
      { name: "proteinContent", unit: "g", amount: 25.0 },
      { name: "fatContent", unit: "g", amount: 4.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "transFatContent", unit: "g", amount: 0.01 },
      { name: "cholesterolContent", unit: "mg", amount: 47.0 },
      { name: "sodiumContent", unit: "mg", amount: 859.0 },
      { name: "fiberContent", unit: "g", amount: 8.0 },
      { name: "sugarContent", unit: "g", amount: 6.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 3.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://familyspice.com/")
  end
end
