# frozen_string_literal: true

RSpec.describe "ministryofcurry.com" do
  subject(:recipe) { scrape_cassette("com/ministryofcurry", url: "https://ministryofcurry.com/slow-cooker-chicken-tikka-masala/") }

  it "reads the title" do
    expect(recipe.title).to eq("Slow Cooker EASY Chicken Tikka Masala")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 pounds chicken breasts (skinless boneless)",
      "2½ teaspoons kosher salt",
      "1 tablespoon lemon juice",
      "3 tablespoons plain yogurt",
      "1 tablespoon kashmiri red chili powder",
      "½ teaspoon ground turmeric",
      "1½ teaspoon garam masala",
      "1 tablespoon ginger (grated)",
      "1 tablespoon garlic (minced)",
      "2 tablespoons oil",
      "2 medium yellow onions (finely diced)",
      "1½ cups tomato puree",
      "½ to ¾ cup heavy cream",
      "1 to 2 tablespoons tomato paste",
      "2 tablespoons kasoori methi (dried fenugreek leaves) (kasoori methi)",
      "½ cup cilantro (chopped)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "pounds", name: "chicken breasts" },
      { amount: 2.5, unit: "teaspoons", name: "kosher salt" },
      { amount: 1.0, unit: "tablespoon", name: "lemon juice" },
      { amount: 3.0, unit: "tablespoons", name: "plain yogurt" },
      { amount: 1.0, unit: "tablespoon", name: "kashmiri red chili powder" },
      { amount: 0.5, unit: "teaspoon", name: "ground turmeric" },
      { amount: 1.5, unit: "teaspoon", name: "garam masala" },
      { amount: 1.0, unit: "tablespoon", name: "ginger" },
      { amount: 1.0, unit: "tablespoon", name: "garlic" },
      { amount: 2.0, unit: "tablespoons", name: "oil" },
      { amount: 2.0, unit: nil, name: "medium yellow onions" },
      { amount: 1.5, unit: "cups", name: "tomato puree" },
      { amount: 0.5, unit: "cup", name: "heavy cream" },
      { amount: 1.0, unit: "tablespoons", name: "tomato paste" },
      { amount: 2.0, unit: "tablespoons", name: "kasoori methi" },
      { amount: 0.5, unit: "cup", name: "cilantro" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Cut the chicken breasts into 2 to 3-inch cubes. Add 2 teaspoon salt and lemon juice and mix well. Add yogurt, red chili powder, turmeric, garam masala, ginger, and garlic. Mix well and allow to marinate while you prep the remaining ingredients.",
      "Heat oil in a medium pan. Add onions and 1/2 teaspoon of salt. Cook over medium heat for 5 minutes stirring frequently until the onions start to soften and turn translucent. Note: If you are using Instant Pot as a slow cooker, you can saute in the instant pot itself.",
      "Add the cooked onions to the crockpot / slow cooker and spread it evenly. Evenly layer tomato puree over the onions. Line the marinated chicken over the tomato puree. Place the crockpot lid and set the cooking time to Slow Cook (Hi) and adjust the cooking time to 4 hours.",
      "After 4 hours, your kitchen will be filled with the beautiful aromas of the curry. Add heavy cream, crush the fenugreek leaves on the palm of your hands and add to the curry. Mix well, taste, and add tomato paste. Mix well and more cream if needed. Note: Optionally you can add 1 teaspoon of sugar to balance all the flavors. Garnish with cilantro and enjoy with basmati rice and naan.",
      "Notes:",
      "To make chicken tikka masala without cream or dairy-free, you can either use unsweetened coconut cream (I love Trader Joe's) or homemade cashew cream. To make the cashew cream at home simply blend 1/2 cup of cashews in half a cup of warm water and make a smooth paste.",
      "I have tested this recipe using a Crockpot slow cooker, Instant Pot slow cooker function, and Instant Pot AURA Multi Cooker. The advantage with the Instant Pot models is that you can saute the onions in the same pot. With a crockpot slow cooker, you saute the onions in a separate pan on the stovetop.",
      "If you do not have a good brand of tomato puree like the Pomi one, you can puree 3 fresh tomatoes in a blender and use that instead.",
      "I like to use chicken breasts in this recipe, but you can also use chicken thighs, simply cut each thigh into 2 pieces."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 12],
        ["Garnish:", 4]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Cut the chicken breasts into 2 to 3-inch cubes. Add 2 teaspoon salt and lemon juice and mix well. Add yogurt, red chili powder, turmeric, garam masala, ginger, and garlic. Mix well and allow to marinate while you prep the remaining ingredients.\nHeat oil in a medium pan. Add onions and 1/2 teaspoon of salt. Cook over medium heat for 5 minutes stirring frequently until the onions start to soften and turn translucent. Note: If you are using Instant Pot as a slow cooker, you can saute in the instant pot itself.\nAdd the cooked onions to the crockpot / slow cooker and spread it evenly. Evenly layer tomato puree over the onions. Line the marinated chicken over the tomato puree. Place the crockpot lid and set the cooking time to Slow Cook (Hi) and adjust the cooking time to 4 hours.\nAfter 4 hours, your kitchen will be filled with the beautiful aromas of the curry. Add heavy cream, crush the fenugreek leaves on the palm of your hands and add to the curry. Mix well, taste, and add tomato paste. Mix well and more cream if needed. Note: Optionally you can add 1 teaspoon of sugar to balance all the flavors. Garnish with cilantro and enjoy with basmati rice and naan.\nNotes:\nTo make chicken tikka masala without cream or dairy-free, you can either use unsweetened coconut cream (I love Trader Joe's) or homemade cashew cream. To make the cashew cream at home simply blend 1/2 cup of cashews in half a cup of warm water and make a smooth paste.\nI have tested this recipe using a Crockpot slow cooker, Instant Pot slow cooker function, and Instant Pot AURA Multi Cooker. The advantage with the Instant Pot models is that you can saute the onions in the same pot. With a crockpot slow cooker, you saute the onions in a separate pan on the stovetop.\nIf you do not have a good brand of tomato puree like the Pomi one, you can puree 3 fresh tomatoes in a blender and use that instead.\nI like to use chicken breasts in this recipe, but you can also use chicken thighs, simply cut each thigh into 2 pieces.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("ministryofcurry.com")
    expect(recipe.canonical_url).to eq("https://ministryofcurry.com/slow-cooker-chicken-tikka-masala/")
    expect(recipe.site_name).to eq("Ministry of Curry")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Archana Mundhe")
    expect(recipe.description).to eq("Tender chicken marinated in aromatic spices is slow cooked in a delicious tomato-based curry for the best Indian meal.")
    expect(recipe.image).to eq("https://ministryofcurry.com/wp-content/uploads/2019/10/Pomi-Chicken-Tikka-Masala-1-2.jpg")
    expect(recipe.category).to eq("dinner")
    expect(recipe.cuisine).to eq("Indian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(240)
    expect(recipe.keywords).to eq(["chicken tikka masala", "slow cooker"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.75)
    expect(recipe.ratings_count).to eq(217)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "323 kcal",
      "carbohydrateContent" => "8 g",
      "proteinContent" => "34 g",
      "fatContent" => "17 g",
      "saturatedFatContent" => "6 g",
      "cholesterolContent" => "125 mg",
      "sodiumContent" => "1183 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "4 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 323.0 },
      { name: "carbohydrateContent", unit: "g", amount: 8.0 },
      { name: "proteinContent", unit: "g", amount: 34.0 },
      { name: "fatContent", unit: "g", amount: 17.0 },
      { name: "saturatedFatContent", unit: "g", amount: 6.0 },
      { name: "cholesterolContent", unit: "mg", amount: 125.0 },
      { name: "sodiumContent", unit: "mg", amount: 1183.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 4.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://ministryofcurry.com/")
  end
end
