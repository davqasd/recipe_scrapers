# frozen_string_literal: true

RSpec.describe "errenskitchen.com" do
  subject(:recipe) { scrape_cassette("com/errenskitchen", url: "https://www.errenskitchen.com/chicken-sundried-tomato-pasta/") }

  it "reads the title" do
    expect(recipe.title).to eq("Creamy Sun-Dried Tomato Pasta with Chicken")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 tablespoon olive oil",
      "2 lbs boneless chicken thighs (or breasts, cubed)",
      "1 onion (chopped)",
      "¼ cup sun-dried tomatoes (drained and chopped)",
      "2 tablespoons sun-dried tomato paste",
      "3 garlic cloves (minced)",
      "¾ cup chicken stock",
      "¾ cup freshly grated Parmesan cheese",
      "1½ cups half and half (or whipping cream)",
      "1 pound pasta",
      "1 tablespoon fresh basil (chopped)",
      "Salt and pepper to taste"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "tablespoon", name: "olive oil" },
      { amount: 2.0, unit: "lbs", name: "boneless chicken thighs" },
      { amount: 1.0, unit: nil, name: "onion" },
      { amount: 0.25, unit: "cup", name: "sun-dried tomatoes" },
      { amount: 2.0, unit: "tablespoons", name: "sun-dried tomato paste" },
      { amount: 3.0, unit: nil, name: "garlic cloves" },
      { amount: 0.75, unit: "cup", name: "chicken stock" },
      { amount: 0.75, unit: "cup", name: "freshly grated Parmesan cheese" },
      { amount: 1.5, unit: "cups", name: "half and half" },
      { amount: 1.0, unit: "pound", name: "pasta" },
      { amount: 1.0, unit: "tablespoon", name: "fresh basil" },
      { amount: nil, unit: nil, name: "Salt and pepper to taste" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pat the chicken meat dry with paper towels. Cut it into evenly cut bite-sized pieces and season well with salt and pepper.",
      "In a large pot, start a pot of salted water to cook the pasta.",
      "While waiting for the water to boil, heat the olive oil in a large skillet over medium heat. Add the cubed chicken, seasoned with salt and pepper, and cook until golden brown and thoroughly cooked. Once done, set the chicken aside.",
      "Use the same skillet to sauté the chopped onion until it becomes soft and translucent. Follow this by adding the chopped sun-dried tomatoes, sun-dried tomato paste, and minced garlic, cooking for an additional minute.",
      "Mix in the chicken stock half and half, and freshly grated Parmesan cheese. Stir to combine the ingredients and bring the mixture to a boil. Lower the heat to low, and simmer for 5 to 10 minutes to reduce and thicken.",
      "Meanwhile, cook the pasta in the boiling water, making sure to undercook it by about 2-3 minutes less than the package instructions for al dente pasta. Remember to reserve a cup of the pasta water before draining.",
      "Drain the slightly undercooked pasta and add it directly into the skillet containing the sauce. Mix the pasta well into the sauce, gradually adding the reserved pasta water until the sauce reaches your desired thickness.",
      "Finally, add the cooked chicken back into the skillet, stirring it into the mixture. Allow everything to simmer together for a few minutes until the pasta is fully cooked and has absorbed some of the flavorful sauce (adding pasta water if necessary to loosen).",
      "Taste for seasoning and season the pasta with salt and pepper as needed. Serve right away."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pat the chicken meat dry with paper towels. Cut it into evenly cut bite-sized pieces and season well with salt and pepper.\nIn a large pot, start a pot of salted water to cook the pasta.\nWhile waiting for the water to boil, heat the olive oil in a large skillet over medium heat. Add the cubed chicken, seasoned with salt and pepper, and cook until golden brown and thoroughly cooked. Once done, set the chicken aside.\nUse the same skillet to sauté the chopped onion until it becomes soft and translucent. Follow this by adding the chopped sun-dried tomatoes, sun-dried tomato paste, and minced garlic, cooking for an additional minute.\nMix in the chicken stock half and half, and freshly grated Parmesan cheese. Stir to combine the ingredients and bring the mixture to a boil. Lower the heat to low, and simmer for 5 to 10 minutes to reduce and thicken.\nMeanwhile, cook the pasta in the boiling water, making sure to undercook it by about 2-3 minutes less than the package instructions for al dente pasta. Remember to reserve a cup of the pasta water before draining.\nDrain the slightly undercooked pasta and add it directly into the skillet containing the sauce. Mix the pasta well into the sauce, gradually adding the reserved pasta water until the sauce reaches your desired thickness.\nFinally, add the cooked chicken back into the skillet, stirring it into the mixture. Allow everything to simmer together for a few minutes until the pasta is fully cooked and has absorbed some of the flavorful sauce (adding pasta water if necessary to loosen).\nTaste for seasoning and season the pasta with salt and pepper as needed. Serve right away.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("errenskitchen.com")
    expect(recipe.canonical_url).to eq("https://www.errenskitchen.com/chicken-sundried-tomato-pasta/")
    expect(recipe.site_name).to eq("Erren's Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Erren Hart")
    expect(recipe.description).to eq("This Creamy Sun-Dried Tomato Pasta with Chicken is rich, savory, and packed with flavor! Juicy chicken, tangy sun-dried tomatoes, and a velvety Parmesan cream sauce coat tender pasta for the ultimate comforting meal.")
    expect(recipe.image).to eq("https://www.errenskitchen.com/wp-content/uploads/2023/09/Creamy-Sun-Dried-Tomato-Pasta-with-Chicken-1-18.jpg")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to eq("Italian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("5 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to eq([
      "Creamy Sun-Dried Tomato Pasta",
      "Creamy Sun-Dried Tomato Pasta with Chicken",
      "Sun-Dried Tomato Pasta"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(17)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "1208 kcal",
      "carbohydrateContent" => "98 g",
      "proteinContent" => "64 g",
      "fatContent" => "60 g",
      "saturatedFatContent" => "21 g",
      "transFatContent" => "0.2 g",
      "cholesterolContent" => "268 mg",
      "sodiumContent" => "752 mg",
      "fiberContent" => "5 g",
      "sugarContent" => "11 g",
      "unsaturatedFatContent" => "33 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 1208.0 },
      { name: "carbohydrateContent", unit: "g", amount: 98.0 },
      { name: "proteinContent", unit: "g", amount: 64.0 },
      { name: "fatContent", unit: "g", amount: 60.0 },
      { name: "saturatedFatContent", unit: "g", amount: 21.0 },
      { name: "transFatContent", unit: "g", amount: 0.2 },
      { name: "cholesterolContent", unit: "mg", amount: 268.0 },
      { name: "sodiumContent", unit: "mg", amount: 752.0 },
      { name: "fiberContent", unit: "g", amount: 5.0 },
      { name: "sugarContent", unit: "g", amount: 11.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 33.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#wp--skip-link--target")
  end
end
