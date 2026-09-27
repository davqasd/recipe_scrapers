# frozen_string_literal: true

RSpec.describe "bluejeanchef.com" do
  subject(:recipe) { scrape_cassette("com/bluejeanchef", url: "https://bluejeanchef.com/recipes/chicken-tortilla-soup/") }

  it "reads the title" do
    expect(recipe.title).to eq("Chicken Tortilla Soup")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 tablespoons olive oil",
      "1 onion (finely diced (about 1 cup))",
      "2 cloves garlic (minced)",
      "1 Jalapeño pepper (minced or sliced into rings)",
      "1 red bell pepper (chopped)",
      "1 tablespoon chili powder",
      "1 teaspoon ground cumin",
      "28 ounces fire-roasted tomatoes (diced)",
      "3 cups good-quality or homemade unsalted chicken stock",
      "15 ounces canned black beans (drained and rinsed)",
      "15 ounces canned red kidney beans (drained and rinsed)",
      "1 teaspoons salt",
      "2 boneless skinless chicken breasts",
      "3 cups corn tortilla chips (broken into pieces)",
      "1 avocado (peeled and sliced)",
      "½ cup fresh cilantro leaves",
      "1 cup Cheddar cheese (grated)",
      "1 lime (cut into wedges)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "tablespoons", name: "olive oil" },
      { amount: 1.0, unit: nil, name: "onion" },
      { amount: 2.0, unit: "cloves", name: "garlic" },
      { amount: 1.0, unit: nil, name: "Jalapeño pepper" },
      { amount: 1.0, unit: nil, name: "red bell pepper" },
      { amount: 1.0, unit: "tablespoon", name: "chili powder" },
      { amount: 1.0, unit: "teaspoon", name: "ground cumin" },
      { amount: 28.0, unit: "ounces", name: "fire-roasted tomatoes" },
      { amount: 3.0, unit: "cups", name: "good-quality or homemade unsalted chicken stock" },
      { amount: 15.0, unit: "ounces", name: "canned black beans" },
      { amount: 15.0, unit: "ounces", name: "canned red kidney beans" },
      { amount: 1.0, unit: "teaspoons", name: "salt" },
      { amount: 2.0, unit: nil, name: "boneless skinless chicken breasts" },
      { amount: 3.0, unit: "cups", name: "corn tortilla chips" },
      { amount: 1.0, unit: nil, name: "avocado" },
      { amount: 0.5, unit: "cup", name: "fresh cilantro leaves" },
      { amount: 1.0, unit: "cup", name: "Cheddar cheese" },
      { amount: 1.0, unit: nil, name: "lime" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pre-heat the pressure cooker using the BROWN or SAUTE setting.",
      "Add the olive oil. Sauté the onion for 3 to 4 minutes, stirring occasionally. Add the garlic, Jalapeño pepper, red pepper and spices, and cook for another minute or two. Add the tomatoes, chicken stock, beans and salt, give it a good stir and push the chicken breasts under the liquid. Lock the lid in place.",
      "Pressure cook on HIGH for 8 minutes.",
      "Reduce the pressure with QUICK-RELEASE method and carefully remove the lid. Remove the chicken to a side plate and when cool enough to touch, shred the chicken with two forks into small pieces.",
      "Return the chicken to the soup and season to taste with salt and freshly ground black pepper. Place some tortilla chips into each bowl and ladle the soup on top. Garnish with avocado, cilantro, Cheddar cheese and a lime wedge to squeeze."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pre-heat the pressure cooker using the BROWN or SAUTE setting.\nAdd the olive oil. Sauté the onion for 3 to 4 minutes, stirring occasionally. Add the garlic, Jalapeño pepper, red pepper and spices, and cook for another minute or two. Add the tomatoes, chicken stock, beans and salt, give it a good stir and push the chicken breasts under the liquid. Lock the lid in place.\nPressure cook on HIGH for 8 minutes.\nReduce the pressure with QUICK-RELEASE method and carefully remove the lid. Remove the chicken to a side plate and when cool enough to touch, shred the chicken with two forks into small pieces.\nReturn the chicken to the soup and season to taste with salt and freshly ground black pepper. Place some tortilla chips into each bowl and ladle the soup on top. Garnish with avocado, cilantro, Cheddar cheese and a lime wedge to squeeze.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("bluejeanchef.com")
    expect(recipe.canonical_url).to eq("https://bluejeanchef.com/recipes/chicken-tortilla-soup/")
    expect(recipe.site_name).to eq("Blue Jean Chef - Meredith Laurence")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("theyadmin")
    expect(recipe.description).to eq("It doesn’t happen very often in my house that I have any leftover or stale tortilla chips, but if you do…chicken tortilla soup is a great way to use them up. If you don't have leftover tortilla chips, this is still a great soup to make. In fact, it's even better to serve with some chips, salsa, guacamole and other toppings along side.")
    expect(recipe.image).to eq("https://bluejeanchef.com/uploads/2019/05/Chicken-Tortilla-Soup-1280-1205.jpg")
    expect(recipe.category).to eq("Soups")
    expect(recipe.cuisine).to eq("Tex-Mex")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(22)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(12)
    expect(recipe.keywords).to eq(["Pasta", "One Pot Meal", "Quick and Easy", "Chicken"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.34)
    expect(recipe.ratings_count).to eq(3)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "692 kcal",
      "carbohydrateContent" => "76 g",
      "proteinContent" => "30 g",
      "fatContent" => "32 g",
      "saturatedFatContent" => "8 g",
      "cholesterolContent" => "44 mg",
      "sodiumContent" => "1535 mg",
      "fiberContent" => "17 g",
      "sugarContent" => "8 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 692.0 },
      { name: "carbohydrateContent", unit: "g", amount: 76.0 },
      { name: "proteinContent", unit: "g", amount: 30.0 },
      { name: "fatContent", unit: "g", amount: 32.0 },
      { name: "saturatedFatContent", unit: "g", amount: 8.0 },
      { name: "cholesterolContent", unit: "mg", amount: 44.0 },
      { name: "sodiumContent", unit: "mg", amount: 1535.0 },
      { name: "fiberContent", unit: "g", amount: 17.0 },
      { name: "sugarContent", unit: "g", amount: 8.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://bluejeanchef.com/about/")
  end
end
