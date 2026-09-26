# frozen_string_literal: true

RSpec.describe "leitesculinaria.com" do
  subject(:recipe) { scrape_cassette("com/leitesculinaria", url: "https://leitesculinaria.com/67202/recipes-homemade-sriracha-sauce.html") }

  it "reads the title" do
    expect(recipe.title).to eq("Homemade Sriracha Sauce")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 3/4 pounds red jalapeño peppers (stems removed and halved lengthwise)",
      "3 garlic cloves",
      "2 tablespoons garlic powder (optional)",
      "2 tablespoons granulated sugar (plus more as needed)",
      "1 tablespoon light brown sugar",
      "1 tablespoon kosher salt (plus more as needed)",
      "1/2 cup distilled white vinegar (plus more as needed)",
      "Water (as needed)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.75, unit: "pounds", name: "red jalapeño peppers" },
      { amount: 3.0, unit: nil, name: "garlic cloves" },
      { amount: 2.0, unit: "tablespoons", name: "garlic powder" },
      { amount: 2.0, unit: "tablespoons", name: "granulated sugar" },
      { amount: 1.0, unit: "tablespoon", name: "light brown sugar" },
      { amount: 1.0, unit: "tablespoon", name: "kosher salt" },
      { amount: 0.5, unit: "cup", name: "distilled white vinegar" },
      { amount: nil, unit: nil, name: "Water" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Process",
      "To make the Sriracha, in the bowl of a food processor, combine the peppers, garlic, garlic powder, if desired, sugars, and salt. Pulse until a coarse purée forms.",
      "Ferment",
      "Transfer to a glass jar, seal, and store at room temperature for 7 days, stirring daily. (It may get a little fizzy; that's to be expected.)",
      "Simmer",
      "After 1 week, pour the chile mixture into a small saucepan over medium heat. Add the vinegar and bring to a boil. Lower the heat and simmer gently for 5 minutes. [Editor's note: If you'd like to preserve the gut-friendly bacteria that has been brewing in your hot sauce, skip the simmering step and purée the pepper mixture and vinegar together in the next step.]",
      "Cool",
      "Let the mixture cool and then purée it in a food processor for 2 to 3 minutes, until a smooth, uniform paste forms. If the mixture is too thick to blend properly, add a small amount of water.",
      "Strain",
      "Pass the mixture through a fine-mesh strainer. Press on the solids with the back of a spoon to squeeze out every last bit of goodness you’ve been waiting a week to get.",
      "Season",
      "Taste and adjust the seasoning and consistency of the final sauce, adding additional vinegar, water, salt, granulated sugar, or garlic powder to suit your taste. Transfer to a glass jar, close the lid tightly, and refrigerate for up to 6 months."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Process\nTo make the Sriracha, in the bowl of a food processor, combine the peppers, garlic, garlic powder, if desired, sugars, and salt. Pulse until a coarse purée forms.\nFerment\nTransfer to a glass jar, seal, and store at room temperature for 7 days, stirring daily. (It may get a little fizzy; that's to be expected.)\nSimmer\nAfter 1 week, pour the chile mixture into a small saucepan over medium heat. Add the vinegar and bring to a boil. Lower the heat and simmer gently for 5 minutes. [Editor's note: If you'd like to preserve the gut-friendly bacteria that has been brewing in your hot sauce, skip the simmering step and purée the pepper mixture and vinegar together in the next step.]\nCool\nLet the mixture cool and then purée it in a food processor for 2 to 3 minutes, until a smooth, uniform paste forms. If the mixture is too thick to blend properly, add a small amount of water.\nStrain\nPass the mixture through a fine-mesh strainer. Press on the solids with the back of a spoon to squeeze out every last bit of goodness you’ve been waiting a week to get.\nSeason\nTaste and adjust the seasoning and consistency of the final sauce, adding additional vinegar, water, salt, granulated sugar, or garlic powder to suit your taste. Transfer to a glass jar, close the lid tightly, and refrigerate for up to 6 months.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("leitesculinaria.com")
    expect(recipe.canonical_url).to eq("https://leitesculinaria.com/67202/recipes-homemade-sriracha-sauce.html")
    expect(recipe.site_name).to eq("Leite's Culinaria")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("David Leite")
    expect(recipe.description).to eq("This homemade Sriracha sauce, made with everyday ingredients including hot peppers, vinegar, garlic, and salt, is easy to make, incendiary in taste, and less salty than the traditional version.")
    expect(recipe.image).to eq("https://leitesculinaria.com/wp-content/uploads/2023/11/homemade-sriracha-sauce-1200.jpg")
    expect(recipe.category).to eq("Condiments")
    expect(recipe.cuisine).to eq("Thai")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("16 servings")
    expect(recipe.total_time).to eq(10_080)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["homemade spicy sriracha sauce", "vinegar pepper sauce"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.85)
    expect(recipe.ratings_count).to eq(63)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "2 tablespoons",
      "calories" => "34 kcal",
      "carbohydrateContent" => "8 g",
      "proteinContent" => "1 g",
      "fatContent" => "1 g",
      "saturatedFatContent" => "1 g",
      "sodiumContent" => "442 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "5 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "tablespoons", amount: 2.0 },
      { name: "calories", unit: "kcal", amount: 34.0 },
      { name: "carbohydrateContent", unit: "g", amount: 8.0 },
      { name: "proteinContent", unit: "g", amount: 1.0 },
      { name: "fatContent", unit: "g", amount: 1.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 442.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 5.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
