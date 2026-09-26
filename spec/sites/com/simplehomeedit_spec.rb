# frozen_string_literal: true

RSpec.describe "simplehomeedit.com" do
  subject(:recipe) { scrape_cassette("com/simplehomeedit", url: "https://simplehomeedit.com/recipe/pork-belly-fried-rice/") }

  it "reads the title" do
    expect(recipe.title).to eq("Pork Belly Fried Rice")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 tbsp cooking oil (see note 1)",
      "400 g pork belly rashers, skin cut off, cut into small pieces (approximately 2 cm/¾ inch)",
      "1 tsp sea salt flakes, plus extra to taste",
      "1 tbsp freshly minced garlic",
      "1 tsp freshly minced ginger",
      "1 bunch bok choy, thickly sliced",
      "4 eggs, whisked",
      "555 g cooked, cold jasmine rice, or any rice of choice (see note 2 for freshly cooked rice)",
      "2 spring onions (scallions), finely sliced, plus extra to garnish",
      "1 tbsp Shaoxing wine or mirin (optional)",
      "1 tsp dark soy sauce",
      "2 tbsp tamari or all-purpose soy sauce",
      "1 tbsp sesame oil",
      "Freshly cracked black pepper, to taste",
      "1 tsp toasted sesame seeds",
      "2 tbsp kimchi (optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "tbsp", name: "cooking oil" },
      { amount: 400.0, unit: "g", name: "pork belly rashers, skin cut off, cut into small pieces" },
      { amount: 1.0, unit: "tsp", name: "sea salt flakes, plus extra to taste" },
      { amount: 1.0, unit: "tbsp", name: "freshly minced garlic" },
      { amount: 1.0, unit: "tsp", name: "freshly minced ginger" },
      { amount: 1.0, unit: "bunch", name: "bok choy, thickly sliced" },
      { amount: 4.0, unit: nil, name: "eggs, whisked" },
      { amount: 555.0, unit: "g", name: "cooked, cold jasmine rice, or any rice of choice" },
      { amount: 2.0, unit: nil, name: "spring onions, finely sliced, plus extra to garnish" },
      { amount: 1.0, unit: "tbsp", name: "Shaoxing wine or mirin" },
      { amount: 1.0, unit: "tsp", name: "dark soy sauce" },
      { amount: 2.0, unit: "tbsp", name: "tamari or all-purpose soy sauce" },
      { amount: 1.0, unit: "tbsp", name: "sesame oil" },
      { amount: nil, unit: nil, name: "Freshly cracked black pepper, to taste" },
      { amount: 1.0, unit: "tsp", name: "toasted sesame seeds" },
      { amount: 2.0, unit: "tbsp", name: "kimchi" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Cook the pork – Heat the cooking oil in a large, deep, heavy-based pan over high heat. Add the pork belly and salt and cook for 5–6 minutes until it becomes golden and crispy. Remove from the heat and set aside on a plate. Remove any excess pork fat from the pan, but leave 1 tablespoon.",
      "Add the veggies – To the same pan, add the garlic and ginger and cook, stirring, for 30 seconds. Stir through the sliced bok choy.",
      "Add the egg – Push the veggies to the side of the pan and add the whisked egg. Cook for 1–2 minutes until firm and then stir with the bok choy to combine.",
      "Combine everything and add the flavourings – Return the cooked pork to the pan, along with the cooked, cold rice (see note 2 if using freshly cooked rice), spring onion, Shaoxing wine or mirin, dark soy sauce, tamari or soy sauce and sesame oil. Toss to combine.",
      "Serve – Season to taste and serve topped with extra sliced spring onion, toasted sesame seeds and kimchi on the side, if using."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Cook the pork – Heat the cooking oil in a large, deep, heavy-based pan over high heat. Add the pork belly and salt and cook for 5–6 minutes until it becomes golden and crispy. Remove from the heat and set aside on a plate. Remove any excess pork fat from the pan, but leave 1 tablespoon.\nAdd the veggies – To the same pan, add the garlic and ginger and cook, stirring, for 30 seconds. Stir through the sliced bok choy.\nAdd the egg – Push the veggies to the side of the pan and add the whisked egg. Cook for 1–2 minutes until firm and then stir with the bok choy to combine.\nCombine everything and add the flavourings – Return the cooked pork to the pan, along with the cooked, cold rice (see note 2 if using freshly cooked rice), spring onion, Shaoxing wine or mirin, dark soy sauce, tamari or soy sauce and sesame oil. Toss to combine.\nServe – Season to taste and serve topped with extra sliced spring onion, toasted sesame seeds and kimchi on the side, if using.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("simplehomeedit.com")
    expect(recipe.canonical_url).to eq("https://simplehomeedit.com/recipe/pork-belly-fried-rice/")
    expect(recipe.site_name).to eq("Simple Home Edit")
    expect(recipe.language).to eq("en-AU")
    expect(recipe.author).to eq("Nicole")
    expect(recipe.description).to eq("This Pork Belly Fried Rice recipe is a fast and easy alternative to takeout that doesn’t skimp on flavour! It’s the perfect meal for busy weeknights.")
    expect(recipe.image).to eq("https://simplehomeedit.com/wp-content/uploads/2023/12/Pork-Belly-Fried-Rice-3.webp")
    expect(recipe.category).to eq("dinner")
    expect(recipe.cuisine).to eq("Chinese")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq(["fried rice recipe", "pork belly fried rice", "pork fried rice"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(5)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "617 kcal",
      "sugarContent" => "1 g",
      "sodiumContent" => "1421 mg",
      "fatContent" => "30 g",
      "saturatedFatContent" => "9 g",
      "carbohydrateContent" => "53 g",
      "fiberContent" => "2 g",
      "proteinContent" => "32 g",
      "cholesterolContent" => "259 mg",
      "unsaturatedFatContent" => "19 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 617.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 1421.0 },
      { name: "fatContent", unit: "g", amount: 30.0 },
      { name: "saturatedFatContent", unit: "g", amount: 9.0 },
      { name: "carbohydrateContent", unit: "g", amount: 53.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "proteinContent", unit: "g", amount: 32.0 },
      { name: "cholesterolContent", unit: "mg", amount: 259.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 19.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/simple-weeknights/")
  end
end
