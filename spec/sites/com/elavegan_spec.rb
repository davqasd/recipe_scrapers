# frozen_string_literal: true

RSpec.describe "elavegan.com" do
  subject(:recipe) { scrape_cassette("com/elavegan", url: "https://elavegan.com/red-lentil-dahl/") }

  it "reads the title" do
    expect(recipe.title).to eq("Red Lentil Dahl")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 1/2 cups dry red lentils",
      "1 large carrot (finely diced (see notes))",
      "1 small bell pepper",
      "1 large onion (chopped)",
      "4 cloves of garlic (minced)",
      "1 heaped tbsp fresh ginger (minced)",
      "1/2 tbsp vegetable oil",
      "3 cups vegetable broth (or water)",
      "1 cup canned coconut milk (see notes)",
      "1 1/2 tsp ground cumin",
      "1 tbsp curry powder",
      "1/2 tbsp sweetener of choice",
      "1 tsp ground turmeric",
      "1 tsp paprika",
      "Sea salt and black pepper (to taste)",
      "1/3 tsp red pepper flakes (optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.5, unit: "cups", name: "dry red lentils" },
      { amount: 1.0, unit: nil, name: "large carrot" },
      { amount: 1.0, unit: nil, name: "small bell pepper" },
      { amount: 1.0, unit: nil, name: "large onion" },
      { amount: 4.0, unit: "cloves", name: "garlic" },
      { amount: 1.0, unit: "tbsp", name: "fresh ginger" },
      { amount: 0.5, unit: "tbsp", name: "vegetable oil" },
      { amount: 3.0, unit: "cups", name: "vegetable broth" },
      { amount: 1.0, unit: "cup", name: "canned coconut milk" },
      { amount: 1.5, unit: "tsp", name: "ground cumin" },
      { amount: 1.0, unit: "tbsp", name: "curry powder" },
      { amount: 0.5, unit: "tbsp", name: "sweetener of choice" },
      { amount: 1.0, unit: "tsp", name: "ground turmeric" },
      { amount: 1.0, unit: "tsp", name: "paprika" },
      { amount: nil, unit: nil, name: "Sea salt and black pepper" },
      { amount: 0.33, unit: "tsp", name: "red pepper flakes" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "You can watch the short video for visual instructions.Rinse lentils under running water. Chop the onion, garlic, ginger, bell pepper, and carrot.",
      "Heat oil in a pot and sauté onion for about 3-4 minutes over medium heat. Add ginger, garlic, carrot, and bell pepper.",
      "Add all spices, sweetener, lentils, and vegetable broth or water. Bring to a boil and let simmer for about 10 minutes.",
      "Finally, add coconut milk and cook for a further 5 minutes or until the desired thickness of the dahl is reached.",
      "Season with black pepper and salt. Taste and adjust the seasonings as needed.",
      "Serve warm with basmati rice, potatoes, or naan (flatbread) and garnish with fresh herbs."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("You can watch the short video for visual instructions.Rinse lentils under running water. Chop the onion, garlic, ginger, bell pepper, and carrot.\nHeat oil in a pot and sauté onion for about 3-4 minutes over medium heat. Add ginger, garlic, carrot, and bell pepper.\nAdd all spices, sweetener, lentils, and vegetable broth or water. Bring to a boil and let simmer for about 10 minutes.\nFinally, add coconut milk and cook for a further 5 minutes or until the desired thickness of the dahl is reached.\nSeason with black pepper and salt. Taste and adjust the seasonings as needed.\nServe warm with basmati rice, potatoes, or naan (flatbread) and garnish with fresh herbs.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("elavegan.com")
    expect(recipe.canonical_url).to eq("https://elavegan.com/red-lentil-dahl/")
    expect(recipe.site_name).to eq("Elavegan")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Ela")
    expect(recipe.description).to eq("This easy, creamy red lentil dahl is frugal, hearty, comforting, flavorful, packed with plant-based protein, and ready in just 30 minutes! Serve with home-cooked rice and naan bread for a gluten-free, dairy-free Indian-inspired feast!")
    expect(recipe.image).to eq("https://elavegan.com/wp-content/uploads/2019/10/Red-Lentil-Dhal-with-rice.jpg")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to eq("Indian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq(%w[creamy curry dal dhal lentils])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.95)
    expect(recipe.ratings_count).to eq(211)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "302 kcal",
      "proteinContent" => "14 g",
      "carbohydrateContent" => "35 g",
      "fatContent" => "9.7 g",
      "sugarContent" => "5.8 g",
      "fiberContent" => "8.1 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 302.0 },
      { name: "proteinContent", unit: "g", amount: 14.0 },
      { name: "carbohydrateContent", unit: "g", amount: 35.0 },
      { name: "fatContent", unit: "g", amount: 9.7 },
      { name: "sugarContent", unit: "g", amount: 5.8 },
      { name: "fiberContent", unit: "g", amount: 8.1 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://view.flodesk.com/pages/611ea2e42000c36218680523")
  end
end
