# frozen_string_literal: true

RSpec.describe "simple-veganista.com" do
  subject(:recipe) { scrape_cassette("com/simple_veganista", url: "https://simple-veganista.com/vegan-jambalaya/") }

  it "reads the title" do
    expect(recipe.title).to eq("Vegan Jambalaya")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 tablespoon olive oil or 1/4 cup water",
      "1 medium onion, diced",
      "4 cloves garlic, minced",
      "3 large bell peppers (green, red & yellow), seeded and diced",
      "2 large celery ribs, diced",
      "2 teaspoons smoked paprika",
      "1 teaspoon EACH dried thyme + oregano",
      "1/4 – 1/2 teaspoon cayenne or red pepper flakes",
      "1 can (14oz) crushed tomatoes",
      "1 1/2 cups dry long-grain rice (for grain-free see notes)",
      "1 – 2 bay leaves",
      "3 1/2 – 4 cups low-sodium vegetable broth",
      "1 can (14oz) red kidney beans, drained and rinsed",
      "3 – 4 vegan sausages (about 14 oz), sliced and cooked (or extra can of beans)",
      "1 teaspoon pink salt, or to taste",
      "fresh cracked pepper, to taste",
      "sliced scallions (green onions)",
      "chopped parsley",
      "dash of hot sauce (Tabasco, Frank’s, or your favorite)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "tablespoon", name: "olive oil or 1/4 cup water" },
      { amount: 1.0, unit: nil, name: "medium onion, diced" },
      { amount: 4.0, unit: "cloves", name: "garlic, minced" },
      { amount: 3.0, unit: nil, name: "large bell peppers, seeded and diced" },
      { amount: 2.0, unit: nil, name: "large celery ribs, diced" },
      { amount: 2.0, unit: "teaspoons", name: "smoked paprika" },
      { amount: 1.0, unit: "teaspoon", name: "EACH dried thyme + oregano" },
      { amount: 0.25, unit: "teaspoon", name: "cayenne or red pepper flakes" },
      { amount: 1.0, unit: "can", name: "crushed tomatoes" },
      { amount: 1.5, unit: "cups", name: "dry long-grain rice" },
      { amount: 1.0, unit: nil, name: "bay leaves" },
      { amount: 3.5, unit: "cups", name: "low-sodium vegetable broth" },
      { amount: 1.0, unit: "can", name: "red kidney beans, drained and rinsed" },
      { amount: 3.0, unit: nil, name: "vegan sausages, sliced and cooked" },
      { amount: 1.0, unit: "teaspoon", name: "pink salt, or to taste" },
      { amount: nil, unit: nil, name: "fresh cracked pepper, to taste" },
      { amount: nil, unit: nil, name: "sliced scallions" },
      { amount: nil, unit: nil, name: "chopped parsley" },
      { amount: 1.0, unit: "dash", name: "hot sauce" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Vegan sausage",
      "If using plant-based sausage, you’ll want to cook it first. Slice it into bite-size pieces and cook in a skillet with 1 tablespoon oil, over medium heat until browned, about 3 – 5 minutes on each side. Transfer to a small plate lined with a paper napkin to soak up excess oil.",
      "Saute",
      "In a large pan, heat oil/water over medium-high heat, add the onion, garlic, celery, and bell peppers, saute for 5 minutes. Add the smoked paprika, thyme, oregano, and cayenne, and saute for 1 minute more.",
      "Simmer",
      "Add the crushed tomatoes, rice, bay leaves, and broth, bring to a boil, reduce heat, cover askew, and simmer on low for 20 – 25 minutes, stirring every 7 minutes or so to keep the rice from sticking to the bottom of the pan. In the last 5 minutes, add the beans and/or sausage and continue to cook until warmed through. Remove bay leaves, season with salt and pepper.",
      "Serve",
      "Spoon into serving bowls and top with garnish of choice.",
      "Serves 6 – 8",
      "Store",
      "Leftovers can be stored for up to 5 days in the refrigerator. For longer storage, keep in the freezer for up to 2 months. Let thaw before reheating on the stovetop or in the microwave."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Vegan sausage\nIf using plant-based sausage, you’ll want to cook it first. Slice it into bite-size pieces and cook in a skillet with 1 tablespoon oil, over medium heat until browned, about 3 – 5 minutes on each side. Transfer to a small plate lined with a paper napkin to soak up excess oil.\nSaute\nIn a large pan, heat oil/water over medium-high heat, add the onion, garlic, celery, and bell peppers, saute for 5 minutes. Add the smoked paprika, thyme, oregano, and cayenne, and saute for 1 minute more.\nSimmer\nAdd the crushed tomatoes, rice, bay leaves, and broth, bring to a boil, reduce heat, cover askew, and simmer on low for 20 – 25 minutes, stirring every 7 minutes or so to keep the rice from sticking to the bottom of the pan. In the last 5 minutes, add the beans and/or sausage and continue to cook until warmed through. Remove bay leaves, season with salt and pepper.\nServe\nSpoon into serving bowls and top with garnish of choice.\nServes 6 – 8\nStore\nLeftovers can be stored for up to 5 days in the refrigerator. For longer storage, keep in the freezer for up to 2 months. Let thaw before reheating on the stovetop or in the microwave.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("simple-veganista.com")
    expect(recipe.canonical_url).to eq("https://simple-veganista.com/vegan-jambalaya/")
    expect(recipe.site_name).to eq("THE SIMPLE VEGANISTA")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Julie | The Simple Veganista")
    expect(recipe.description).to eq("Made in 1 pot, this easy Louisiana Vegan Jambalaya is loaded with healthy veggies and plant-based protein for a delicious Creole-style rice dish that even the picky eaters will love!")
    expect(recipe.image).to eq("https://simple-veganista.com/wp-content/uploads/2022/02/easy-vegan-jambalaya-recipe-5-225x225.jpg")
    expect(recipe.category).to eq("Entree")
    expect(recipe.cuisine).to eq("Creole")
    expect(recipe.cooking_method).to eq("Simmer")
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.9)
    expect(recipe.ratings_count).to eq(16)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "358 calories",
      "sugarContent" => "9.4 g",
      "sodiumContent" => "504.5 mg",
      "fatContent" => "1.9 g",
      "saturatedFatContent" => "0.5 g",
      "transFatContent" => "0 g",
      "carbohydrateContent" => "74 g",
      "fiberContent" => "10.7 g",
      "proteinContent" => "15.7 g",
      "cholesterolContent" => "0 mg"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 358.0 },
      { name: "sugarContent", unit: "g", amount: 9.4 },
      { name: "sodiumContent", unit: "mg", amount: 504.5 },
      { name: "fatContent", unit: "g", amount: 1.9 },
      { name: "saturatedFatContent", unit: "g", amount: 0.5 },
      { name: "transFatContent", unit: "g", amount: 0.0 },
      { name: "carbohydrateContent", unit: "g", amount: 74.0 },
      { name: "fiberContent", unit: "g", amount: 10.7 },
      { name: "proteinContent", unit: "g", amount: 15.7 },
      { name: "cholesterolContent", unit: "mg", amount: 0.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
