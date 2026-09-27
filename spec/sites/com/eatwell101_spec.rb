# frozen_string_literal: true

RSpec.describe "eatwell101.com" do
  subject(:recipe) { scrape_cassette("com/eatwell101", url: "https://www.eatwell101.com/meal-prep-garlic-butter-salmon-asparagus-recipe") }

  it "reads the title" do
    expect(recipe.title).to eq("Meal-Prep Salmon and Asparagus in (15-Minute )")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 medium salmon fillet, cut in 3 or 4 chunks",
      "2 bunches of asparagus, rinsed and trimmed",
      "1 teaspoon olive oil",
      "2 teaspoons minced garlic",
      "1/2 cup (125ml) low-sodium vegetable broth (or white wine)",
      "1/2 stick butter",
      "1 cup halved cherry or grape tomatoes",
      "1/2 small red onion, minced",
      "1 tablespoon hot sauce, optional (we used Sriracha)",
      "Juice of 1/2 lemon",
      "1 tablespoon minced parsley (or cilantro)",
      "Crushed red chili pepper flakes, optional",
      "Slices of lemon, for garnish"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "medium salmon fillet, cut in 3 or 4 chunks" },
      { amount: 2.0, unit: "bunches", name: "asparagus, rinsed and trimmed" },
      { amount: 1.0, unit: "teaspoon", name: "olive oil" },
      { amount: 2.0, unit: "teaspoons", name: "minced garlic" },
      { amount: 0.5, unit: "cup", name: "low-sodium vegetable broth" },
      { amount: 0.5, unit: "stick", name: "butter" },
      { amount: 1.0, unit: "cup", name: "halved cherry or grape tomatoes" },
      { amount: 0.5, unit: nil, name: "small red onion, minced" },
      { amount: 1.0, unit: "tablespoon", name: "hot sauce, optional" },
      { amount: nil, unit: nil, name: "Juice of 1/2 lemon" },
      { amount: 1.0, unit: "tablespoon", name: "minced parsley" },
      { amount: nil, unit: nil, name: "Crushed red chili pepper flakes, optional" },
      { amount: nil, unit: nil, name: "Slices of lemon, for garnish" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "To make the salmon meal prep: Combine halved cherry tomatoes with olive oil, minced red onion, salt, and pepper. Marinate in a shallow plate or bowl while cooking salmon and asparagus.",
      "Season salmon with salt and pepper. Let's sit while you prepare the asparagus.",
      "Wash and trim the ends of the asparagus, then blanch them in boiling water for 2- 3 minutes, then soak in ice water to stop cooking. This way, they will cook faster and evenly in the skillet. You can skip this step if you have very thin asparagus. Drain and set aside.",
      "Heat olive oil in a large cast iron skillet over medium-low heat. Gently cook salmon on both sides until golden brown. Remove the salmon fillets from the skillet and set aside on a plate.",
      "In the same skillet over medium heat, add minced garlic, then deglaze with vegetable broth (or wine). Bring to a simmer. Add butter, lemon juice, hot sauce, and parsley. Give a quick stir to combine.",
      "Add the drained, blanched asparagus and toss for 2 minutes to cook it up. Add salmon back to the pan and reheat for another minute.",
      "Divide the meal prep salmon and asparagus into meal prep containers, add marinated tomatoes, and store in the refrigerator for up to 5 days."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("To make the salmon meal prep: Combine halved cherry tomatoes with olive oil, minced red onion, salt, and pepper. Marinate in a shallow plate or bowl while cooking salmon and asparagus.\nSeason salmon with salt and pepper. Let's sit while you prepare the asparagus.\nWash and trim the ends of the asparagus, then blanch them in boiling water for 2- 3 minutes, then soak in ice water to stop cooking. This way, they will cook faster and evenly in the skillet. You can skip this step if you have very thin asparagus. Drain and set aside.\nHeat olive oil in a large cast iron skillet over medium-low heat. Gently cook salmon on both sides until golden brown. Remove the salmon fillets from the skillet and set aside on a plate.\nIn the same skillet over medium heat, add minced garlic, then deglaze with vegetable broth (or wine). Bring to a simmer. Add butter, lemon juice, hot sauce, and parsley. Give a quick stir to combine.\nAdd the drained, blanched asparagus and toss for 2 minutes to cook it up. Add salmon back to the pan and reheat for another minute.\nDivide the meal prep salmon and asparagus into meal prep containers, add marinated tomatoes, and store in the refrigerator for up to 5 days.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("eatwell101.com")
    expect(recipe.canonical_url).to eq("https://www.eatwell101.com/meal-prep-garlic-butter-salmon-asparagus-recipe")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Christina Cherrier")
    expect(recipe.description).to eq("This easy salmon meal prep recipe is a great way to guide yourself into a healthier lifestyle.")
    expect(recipe.image).to eq("https://www.eatwell101.com/wp-content/uploads/2019/07/salmon-and-asparagus-meal-prep-recipe-idea.jpg")
    expect(recipe.category).to eq("Cook, Cooking & Meals, Fish and Seafood, Lunch, main dishes, salmon recipes,")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq(["15mn Meals", "30mn or less", "beginners", "bowl", "cooking with kids", "fresh and easy", "gluten free", "gluten free main dishes", "happy body", "high-protein", "keto", "low-carb", "lunch", "Make It - Take It", "meal prep", "Most Popular", "Paleo Diet", "pescatarian", "salmon", "seafood", "summer cooking", "summer main dishes", "tomatoes"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "408 calories"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 408.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#topcomment")
  end
end
