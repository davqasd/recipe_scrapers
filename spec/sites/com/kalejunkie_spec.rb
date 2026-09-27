# frozen_string_literal: true

RSpec.describe "kalejunkie.com" do
  subject(:recipe) { scrape_cassette("com/kalejunkie", url: "https://kalejunkie.com/the-ultimate-meatball-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("The Ultimate Meatball Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 Pound Ground Beef",
      "1 Pound Ground Pork",
      "1 Cup Panko Bread Crumbs (you can also substitute for gluten-free breadcrumbs!)",
      "1/2 Onion (finely diced)",
      "1/4 Cup Fresh Parsley (finely chopped)",
      "2 Cloves Garlic (mashed)",
      "3/4 Cup Parmigiano Reggiano (freshly grated, plus more for topping)",
      "1 1/2 Teaspoons Allspice",
      "1 Teaspoon Sea Salt",
      "1/2 Teaspoon Ground Black Pepper",
      "2 Eggs",
      "1 Jar Marinara Sauce of choice",
      "1 16 Ounce Package Spaghetti of choice"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "Pound", name: "Ground Beef" },
      { amount: 1.0, unit: "Pound", name: "Ground Pork" },
      { amount: 1.0, unit: "Cup", name: "Panko Bread Crumbs" },
      { amount: 0.5, unit: nil, name: "Onion" },
      { amount: 0.25, unit: "Cup", name: "Fresh Parsley" },
      { amount: 2.0, unit: "Cloves", name: "Garlic" },
      { amount: 0.75, unit: "Cup", name: "Parmigiano Reggiano" },
      { amount: 1.5, unit: "Teaspoons", name: "Allspice" },
      { amount: 1.0, unit: "Teaspoon", name: "Sea Salt" },
      { amount: 0.5, unit: "Teaspoon", name: "Ground Black Pepper" },
      { amount: 2.0, unit: nil, name: "Eggs" },
      { amount: 1.0, unit: "Jar", name: "Marinara Sauce of choice" },
      { amount: 1.0, unit: "Package", name: "Spaghetti of choice" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Add",
      "Start by adding all of your meatball ingredients to a large bowl.",
      "Mix",
      "Use your hands to mix all of the ingredients until they're well-combined, then roll them into evenly-sized meatballs. Place each meatball onto a baking sheet, then repeat until all of your meatballs are formed.",
      "Stovetop Method:",
      "Simmer",
      "To prepare these meatballs on the stove, start by preparing the sauce. Add the pasta sauce to a deep saucepan, on the stove and bring it to a gentle simmer.",
      "Cover",
      "Once the pasta sauce is simmering, add the meatballs to the pan and place the cover on top. Do not touch the pan for 25 minutes.",
      "Stir",
      "Once the 25 minutes are up, remove the cover and gently stir to cover all the meatballs in the sauce.",
      "Serve",
      "Finally, serve them over cooked spaghetti, and enjoy!",
      "Oven-Baked Method:",
      "Preheat Oven",
      "To prepare these meatballs in the oven, simply preheat your oven to 350 F.",
      "Bake Meatballs",
      "After the meatballs have been formed and placed onto the baking sheet, bake them for 20-22 minutes, until they're no longer pink inside."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Add\nStart by adding all of your meatball ingredients to a large bowl.\nMix\nUse your hands to mix all of the ingredients until they're well-combined, then roll them into evenly-sized meatballs. Place each meatball onto a baking sheet, then repeat until all of your meatballs are formed.\nStovetop Method:\nSimmer\nTo prepare these meatballs on the stove, start by preparing the sauce. Add the pasta sauce to a deep saucepan, on the stove and bring it to a gentle simmer.\nCover\nOnce the pasta sauce is simmering, add the meatballs to the pan and place the cover on top. Do not touch the pan for 25 minutes.\nStir\nOnce the 25 minutes are up, remove the cover and gently stir to cover all the meatballs in the sauce.\nServe\nFinally, serve them over cooked spaghetti, and enjoy!\nOven-Baked Method:\nPreheat Oven\nTo prepare these meatballs in the oven, simply preheat your oven to 350 F.\nBake Meatballs\nAfter the meatballs have been formed and placed onto the baking sheet, bake them for 20-22 minutes, until they're no longer pink inside.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("kalejunkie.com")
    expect(recipe.canonical_url).to eq("https://kalejunkie.com/the-ultimate-meatball-recipe/")
    expect(recipe.site_name).to eq("KaleJunkie")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Nicole Modic")
    expect(recipe.description).to eq("Meatballs are a classic dish that is delicious when served alongside spaghetti, on top of a nourish bowl, or simply eaten by themselves. But with hundreds of meatball recipes out there, what if I told you that I have come up with The Ultimate Meatball Recipe to meet ALL of your meatball cravings?! It's true! This recipe is a long-time family favorite that uses a combination of beef and pork, alongside a special seasoning to create the absolute perfect flavor.")
    expect(recipe.image).to eq("https://kalejunkie.com/wp-content/uploads/2023/03/Meatballs_Shot5_126.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["comfort food", "ground beef", "italian", "meatball", "meatballs", "pasta"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.6)
    expect(recipe.ratings_count).to eq(5)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "387 kcal",
      "carbohydrateContent" => "12 g",
      "proteinContent" => "25 g",
      "fatContent" => "27 g",
      "saturatedFatContent" => "11 g",
      "transFatContent" => "1 g",
      "cholesterolContent" => "87 mg",
      "sodiumContent" => "970 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "4 g",
      "unsaturatedFatContent" => "13 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 387.0 },
      { name: "carbohydrateContent", unit: "g", amount: 12.0 },
      { name: "proteinContent", unit: "g", amount: 25.0 },
      { name: "fatContent", unit: "g", amount: 27.0 },
      { name: "saturatedFatContent", unit: "g", amount: 11.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 87.0 },
      { name: "sodiumContent", unit: "mg", amount: 970.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 4.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 13.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#wp--skip-link--target")
  end
end
