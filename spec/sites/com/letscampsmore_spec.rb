# frozen_string_literal: true

RSpec.describe "letscampsmore.com" do
  subject(:recipe) { scrape_cassette("com/letscampsmore", url: "https://letscampsmore.com/dutch-oven-lasagna/") }

  it "reads the title" do
    expect(recipe.title).to eq("Dutch Oven Lasagna")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1-2 pounds ground meat of choice",
      "Optional: 1 chopped onion, 1 cup sliced mushrooms",
      "2 jars pasta sauce",
      "Oven-ready lasagna noodles",
      "1 container ricotta cheese",
      "1½ TBSP Italian seasoning",
      "1½ - 2 cups shredded mozzarella or Italian cheese",
      "Optional: grated Parmesan cheese"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "pounds", name: "ground meat of choice" },
      { amount: 1.0, unit: nil, name: "chopped onion, 1 cup sliced mushrooms" },
      { amount: 2.0, unit: "jars", name: "pasta sauce" },
      { amount: nil, unit: nil, name: "Oven-ready lasagna noodles" },
      { amount: 1.0, unit: "container", name: "ricotta cheese" },
      { amount: 1.5, unit: "TBSP", name: "Italian seasoning" },
      { amount: 1.5, unit: "cups", name: "shredded mozzarella or Italian cheese" },
      { amount: nil, unit: nil, name: "Optional: grated Parmesan cheese" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Prepare coals. I have an eight-quart cast-iron Dutch oven, so I light 25+ charcoal briquettes.",
      "Brown the ground meat at home ahead of time, or cook it in the Dutch oven over a campfire. We add chopped onion and sliced mushrooms while cooking the meat.",
      "Prepare the cheese filling by combining ricotta cheese with Italian seasoning.",
      "Assemble the lasagna in the order shown below.",
      "Cover the Dutch oven, and put the entire pot over a circle of eight coals. Place 17 coals on the lid.",
      "Bake for 30 minutes, rotating the lid and pot a quarter turn in opposite directions every 10 minutes.",
      "The lasagna is done when the cheese is melted and the noodles are cooked. If needed, bake an additional 5-10 minutes.",
      "Sauce - about ? a jar",
      "Noodles - break them up to create a single layer",
      "Sauce - another ?",
      "Half of the browned meat",
      "Half of the ricotta mix",
      "A layer of shredded cheese",
      "Sauce - ? of a jar",
      "Another layer of noodles",
      "The remaining sauce",
      "Rest of the meat",
      "The other half of the ricotta",
      "A thick layer of shredded cheese",
      "Parmesan cheese"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Prepare coals. I have an eight-quart cast-iron Dutch oven, so I light 25+ charcoal briquettes.\nBrown the ground meat at home ahead of time, or cook it in the Dutch oven over a campfire. We add chopped onion and sliced mushrooms while cooking the meat.\nPrepare the cheese filling by combining ricotta cheese with Italian seasoning.\nAssemble the lasagna in the order shown below.\nCover the Dutch oven, and put the entire pot over a circle of eight coals. Place 17 coals on the lid.\nBake for 30 minutes, rotating the lid and pot a quarter turn in opposite directions every 10 minutes.\nThe lasagna is done when the cheese is melted and the noodles are cooked. If needed, bake an additional 5-10 minutes.\nSauce - about ? a jar\nNoodles - break them up to create a single layer\nSauce - another ?\nHalf of the browned meat\nHalf of the ricotta mix\nA layer of shredded cheese\nSauce - ? of a jar\nAnother layer of noodles\nThe remaining sauce\nRest of the meat\nThe other half of the ricotta\nA thick layer of shredded cheese\nParmesan cheese")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("letscampsmore.com")
    expect(recipe.canonical_url).to eq("https://letscampsmore.com/dutch-oven-lasagna/")
    expect(recipe.site_name).to eq("Let's Camp S'more")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Let's Camp S'more")
    expect(recipe.description).to eq("Experience the comfort of homemade cooking with this Dutch Oven Lasagna. This satisfying one-pot dish is simple to prepare.")
    expect(recipe.image).to eq("https://letscampsmore.com/wp-content/uploads/2023/07/Easy-Camping-Lasagna-in-a-Dutch-Oven-Recipe-720x720.jpg")
    expect(recipe.category).to eq("Dutch Oven")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["lasagna", "camping", "Dutch Oven"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "648 calories",
      "carbohydrateContent" => "15 grams carbohydrates",
      "cholesterolContent" => "175 milligrams cholesterol",
      "fatContent" => "39 grams fat",
      "fiberContent" => "2 grams fiber",
      "proteinContent" => "57 grams protein",
      "saturatedFatContent" => "17 grams saturated fat",
      "servingSize" => "1",
      "sodiumContent" => "691 milligrams sodium",
      "sugarContent" => "5 grams sugar",
      "transFatContent" => "2 grams trans fat",
      "unsaturatedFatContent" => "17 grams unsaturated fat"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 648.0 },
      { name: "carbohydrateContent", unit: "g", amount: 15.0 },
      { name: "cholesterolContent", unit: "mg", amount: 175.0 },
      { name: "fatContent", unit: "g", amount: 39.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "proteinContent", unit: "g", amount: 57.0 },
      { name: "saturatedFatContent", unit: "g", amount: 17.0 },
      { name: "servingSize", unit: nil, amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 691.0 },
      { name: "sugarContent", unit: "g", amount: 5.0 },
      { name: "transFatContent", unit: "g", amount: 2.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 17.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
