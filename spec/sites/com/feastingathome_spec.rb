# frozen_string_literal: true

RSpec.describe "feastingathome.com" do
  subject(:recipe) { scrape_cassette("com/feastingathome", url: "https://www.feastingathome.com/tomato-risotto/") }

  it "reads the title" do
    expect(recipe.title).to eq("Tomato Risotto with Saffron")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 lb cherry or grape tomatoes",
      "1 tablespoon olive oil",
      "1 white or yellow onion, diced",
      "2 tablespoons olive oil",
      "4-6 cloves garlic, rough chopped",
      "1 teaspoon dried thyme (or 1 tablespoon fresh)",
      "1 1/2 cups arborio rice or Spanish short-grain rice",
      "pinch saffron",
      "1/2 teaspoon salt",
      "1/2 teaspoon pepper",
      "1/4 teaspoon smoked paprika",
      "6-8 cups veggie stock or chicken stock, warmed",
      "1 tablespoon butter",
      "1/4 cup grated parmesan",
      "16 ounces large shrimp -raw, peeled, deveined (or sub a white fish)",
      "1 tablespoon cumin",
      "1 tablespoon smoked paprika",
      "2 teaspoons granulated garlic",
      "1 teaspoon salt",
      "oil for searing"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "lb", name: "cherry or grape tomatoes" },
      { amount: 1.0, unit: "tablespoon", name: "olive oil" },
      { amount: 1.0, unit: nil, name: "white or yellow onion, diced" },
      { amount: 2.0, unit: "tablespoons", name: "olive oil" },
      { amount: 4.0, unit: "cloves", name: "garlic, rough chopped" },
      { amount: 1.0, unit: "teaspoon", name: "dried thyme" },
      { amount: 1.5, unit: "cups", name: "arborio rice or Spanish short-grain rice" },
      { amount: 1.0, unit: "pinch", name: "saffron" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 0.5, unit: "teaspoon", name: "pepper" },
      { amount: 0.25, unit: "teaspoon", name: "smoked paprika" },
      { amount: 6.0, unit: "cups", name: "veggie stock or chicken stock, warmed" },
      { amount: 1.0, unit: "tablespoon", name: "butter" },
      { amount: 0.25, unit: "cup", name: "grated parmesan" },
      { amount: 16.0, unit: "ounces", name: "large shrimp -raw, peeled, deveined" },
      { amount: 1.0, unit: "tablespoon", name: "cumin" },
      { amount: 1.0, unit: "tablespoon", name: "smoked paprika" },
      { amount: 2.0, unit: "teaspoons", name: "granulated garlic" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: nil, unit: nil, name: "oil for searing" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "BLISTER TOMATOES",
      "In a large skillet, heat oil over medium-high heat. Add tomatoes (whole) and sear, stirring occasionally, until they burst and soften, about 7 minutes. Turn heat off. Chop if extra-large.",
      "MAKE RISOTTO",
      "At the same time, in a large heavy-bottomed pot or dutch oven, heat the olive oil over medium heat and add the onions. Saute until golden about 10-12 minutes. Add garlic and thyme, saute 2 more minutes until fragrant.",
      "Add the rice, saute 1 minute, stirring. Add 2 cups warm stock (enough to cover the rice), saffron and smoked paprika, stir and bring to a simmer. Simmer until most of the liquid is absorbed. Add 1 cup broth and the tomatoes and all their juices. Stir until all the liquid is absorbed. Continue adding broth 1 cup at a time, letting the rice absorb it slowly, stirring often over med-low heat, until the rice is plumped, slightly al dente, yet creamy, about 20-25 minutes. You may not need all 8 cups. ( I used 6 3/4).",
      "Stir in the butter and parmesan. Season generously with salt, pepper, and optional chili flakes. Taste, adjust salt. If bland, it probably needs more salt.",
      "Serve",
      "as a flavorful side or vegetarian main, garnishing with fresh parsley and lemon zest.",
      "Optional Seared Prawns:",
      "If adding the prawns, mix spices and salt in a bowl. Coat shrimp with the spices. Heat 2-3 tablespoons oil in a skillet (you may need to do this in batches) over medium-high heat, sear each side 2-3 minutes or until cooked through. Top the risotto with the seared prawns."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("BLISTER TOMATOES\nIn a large skillet, heat oil over medium-high heat. Add tomatoes (whole) and sear, stirring occasionally, until they burst and soften, about 7 minutes. Turn heat off. Chop if extra-large.\nMAKE RISOTTO\nAt the same time, in a large heavy-bottomed pot or dutch oven, heat the olive oil over medium heat and add the onions. Saute until golden about 10-12 minutes. Add garlic and thyme, saute 2 more minutes until fragrant.\nAdd the rice, saute 1 minute, stirring. Add 2 cups warm stock (enough to cover the rice), saffron and smoked paprika, stir and bring to a simmer. Simmer until most of the liquid is absorbed. Add 1 cup broth and the tomatoes and all their juices. Stir until all the liquid is absorbed. Continue adding broth 1 cup at a time, letting the rice absorb it slowly, stirring often over med-low heat, until the rice is plumped, slightly al dente, yet creamy, about 20-25 minutes. You may not need all 8 cups. ( I used 6 3/4).\nStir in the butter and parmesan. Season generously with salt, pepper, and optional chili flakes. Taste, adjust salt. If bland, it probably needs more salt.\nServe\nas a flavorful side or vegetarian main, garnishing with fresh parsley and lemon zest.\nOptional Seared Prawns:\nIf adding the prawns, mix spices and salt in a bowl. Coat shrimp with the spices. Heat 2-3 tablespoons oil in a skillet (you may need to do this in batches) over medium-high heat, sear each side 2-3 minutes or until cooked through. Top the risotto with the seared prawns.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("feastingathome.com")
    expect(recipe.canonical_url).to eq("https://www.feastingathome.com/tomato-risotto/")
    expect(recipe.site_name).to eq("Feasting At Home")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Sylvia Fountaine | feasting at home")
    expect(recipe.description).to eq("Tomato Risotto with juicy vine-ripened tomatoes, and infused with saffron, can be served as a vegetarian main or side dish, or topped off with smoky shrimp.")
    expect(recipe.image).to eq("https://www.feastingathome.com/wp-content/uploads/2020/08/tomato-risotto-225x225.jpg")
    expect(recipe.category).to eq("vegetarian")
    expect(recipe.cuisine).to eq("Spanish")
    expect(recipe.cooking_method).to eq("stovetop")
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(60)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(45)
    expect(recipe.keywords).to eq(["tomato risotto", "vegetarian risotto", "shrimp risotto"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["VegetarianDiet"])
    expect(recipe.ratings).to eq(4.9)
    expect(recipe.ratings_count).to eq(40)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 ½ cup serving without shrimp",
      "calories" => "435 calories",
      "sugarContent" => "6.9 g",
      "sodiumContent" => "943.1 mg",
      "fatContent" => "12.1 g",
      "saturatedFatContent" => "3.8 g",
      "transFatContent" => "0 g",
      "carbohydrateContent" => "73.1 g",
      "fiberContent" => "2.8 g",
      "proteinContent" => "9 g",
      "cholesterolContent" => "11.2 mg"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "cup", amount: 1.5 },
      { name: "calories", unit: "kcal", amount: 435.0 },
      { name: "sugarContent", unit: "g", amount: 6.9 },
      { name: "sodiumContent", unit: "mg", amount: 943.1 },
      { name: "fatContent", unit: "g", amount: 12.1 },
      { name: "saturatedFatContent", unit: "g", amount: 3.8 },
      { name: "transFatContent", unit: "g", amount: 0.0 },
      { name: "carbohydrateContent", unit: "g", amount: 73.1 },
      { name: "fiberContent", unit: "g", amount: 2.8 },
      { name: "proteinContent", unit: "g", amount: 9.0 },
      { name: "cholesterolContent", unit: "mg", amount: 11.2 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
