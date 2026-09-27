# frozen_string_literal: true

RSpec.describe "usapears.org" do
  subject(:recipe) { scrape_cassette("org/usapears", url: "https://www.usapears.org/recipe/vegan-korean-plant-based-ground-beef-stir-fry-with-pears/") }

  it "reads the title" do
    expect(recipe.title).to eq("Vegan Korean Plant-Based Ground Beef Stir-Fry with Pears")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "½ Red Anjou USA Pear, peeled and chopped",
      "½ onion, chopped",
      "1 1/2 tsp minced garlic",
      "2 tsp minced ginger",
      "1 tsp black pepper",
      "1-2 tbsp gochujang (substitute chili paste)",
      "1/4 cup soy sauce",
      "3 tbsp agave (substitute 3 tbsp light brown sugar)",
      "1 tsp cornstarch",
      "3 tbsp sesame oil",
      "1-2 tbsp vegetable or canola oil",
      "1/2 onion, diced",
      "1 package alternative plant-based ground beef",
      "½ Anjou pear, diced (preferably green Anjou)",
      "Green onions, thinly sliced",
      "Sesame seeds for garnish",
      "Cooked white or jasmine rice",
      "Suggestions: Include bok choy and kimchi as sides."
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.5, unit: nil, name: "Red Anjou USA Pear, peeled and chopped" },
      { amount: 0.5, unit: nil, name: "onion, chopped" },
      { amount: 1.5, unit: "tsp", name: "minced garlic" },
      { amount: 2.0, unit: "tsp", name: "minced ginger" },
      { amount: 1.0, unit: "tsp", name: "black pepper" },
      { amount: 1.0, unit: "tbsp", name: "gochujang" },
      { amount: 0.25, unit: "cup", name: "soy sauce" },
      { amount: 3.0, unit: "tbsp", name: "agave" },
      { amount: 1.0, unit: "tsp", name: "cornstarch" },
      { amount: 3.0, unit: "tbsp", name: "sesame oil" },
      { amount: 1.0, unit: "tbsp", name: "vegetable or canola oil" },
      { amount: 0.5, unit: nil, name: "onion, diced" },
      { amount: 1.0, unit: "package", name: "alternative plant-based ground beef" },
      { amount: 0.5, unit: nil, name: "Anjou pear, diced" },
      { amount: nil, unit: nil, name: "Green onions, thinly sliced" },
      { amount: nil, unit: nil, name: "Sesame seeds for garnish" },
      { amount: nil, unit: nil, name: "Cooked white or jasmine rice" },
      { amount: nil, unit: nil, name: "Suggestions: Include bok choy and kimchi as sides." }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Cook rice according to package instructions.",
      "Add sauce ingredients to a blender and blend until smooth.",
      "On medium-high heat, add vegetable or canola oil to frying pan. Add diced onion and cook for 2 mins until it starts to soften. Add plant-based beef to pan and break into grounds with spatula and cook for about 5 mins until it begins brown (drain excess liquid if needed). Then add prepared sauce and cook for an additional 2-3 mins. Remove plant-based beef from pan and set aside.",
      "Season diced pears with salt and pepper. Add 1/2 tbsp of oil to the same pan that you used to cook the plant-based beef. On medium heat, cook diced pears for about 2 mins. Then add plant-based beef to pan and toss with pears.",
      "Serve Korean plant-based ground be over rice and add garnish"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Cook rice according to package instructions.\nAdd sauce ingredients to a blender and blend until smooth.\nOn medium-high heat, add vegetable or canola oil to frying pan. Add diced onion and cook for 2 mins until it starts to soften. Add plant-based beef to pan and break into grounds with spatula and cook for about 5 mins until it begins brown (drain excess liquid if needed). Then add prepared sauce and cook for an additional 2-3 mins. Remove plant-based beef from pan and set aside.\nSeason diced pears with salt and pepper. Add 1/2 tbsp of oil to the same pan that you used to cook the plant-based beef. On medium heat, cook diced pears for about 2 mins. Then add plant-based beef to pan and toss with pears.\nServe Korean plant-based ground be over rice and add garnish")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("usapears.org")
    expect(recipe.canonical_url).to eq("https://www.usapears.org/recipe/vegan-korean-plant-based-ground-beef-stir-fry-with-pears/")
    expect(recipe.site_name).to eq("USA Pears")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Make vegan Korean pear stir-fry with plant-based ground beef and gochujang for a bold, savory dinner with sweet pear flavor.")
    expect(recipe.image).to eq("https://www.usapears.org/wp-content/uploads/2026/03/Plant-Based-Korean-Ground-Beef.webp")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.usapears.org/member/sign-in/")
  end
end
