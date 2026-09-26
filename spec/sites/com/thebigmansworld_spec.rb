# frozen_string_literal: true

RSpec.describe "thebigmansworld.com" do
  subject(:recipe) { scrape_cassette("com/thebigmansworld", url: "https://thebigmansworld.com/hanger-steak/") }

  it "reads the title" do
    expect(recipe.title).to eq("Hanger Steak")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 pounds hanger steaks (2 large steaks)",
      "1/4 cup olive oil",
      "1/4 cup soy sauce",
      "2 cloves garlic (minced)",
      "1 tablespoon Worcestershire sauce",
      "1/2 teaspoon lemon juice",
      "1/2 teaspoon salt",
      "1/4 teaspoon pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "pounds", name: "hanger steaks" },
      { amount: 0.25, unit: "cup", name: "olive oil" },
      { amount: 0.25, unit: "cup", name: "soy sauce" },
      { amount: 2.0, unit: "cloves", name: "garlic" },
      { amount: 1.0, unit: "tablespoon", name: "Worcestershire sauce" },
      { amount: 0.5, unit: "teaspoon", name: "lemon juice" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 0.25, unit: "teaspoon", name: "pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Remove the steaks from the refrigerator and bring to room temperature.",
      "In a small bowl, whisk together the olive oil, soy sauce, garlic, lemon juice, and Worcestershire sauce.",
      "Season the steaks with salt and pepper and place them in a bowl. Pour the marinade all over it, cover, and refrigerate for 10 minutes or up to 8 hours.",
      "Preheat a grill to high heat or use the stovetop and cook the steaks in a skillet or grill pan. Once the grill is heated to high, remove the steaks from the marinade and grill for 4 minutes per side or until they reach an internal temperature of 135°F.",
      "Remove from the grill and let the meat rest for 10 minutes before slicing across the grain."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Remove the steaks from the refrigerator and bring to room temperature.\nIn a small bowl, whisk together the olive oil, soy sauce, garlic, lemon juice, and Worcestershire sauce.\nSeason the steaks with salt and pepper and place them in a bowl. Pour the marinade all over it, cover, and refrigerate for 10 minutes or up to 8 hours.\nPreheat a grill to high heat or use the stovetop and cook the steaks in a skillet or grill pan. Once the grill is heated to high, remove the steaks from the marinade and grill for 4 minutes per side or until they reach an internal temperature of 135°F.\nRemove from the grill and let the meat rest for 10 minutes before slicing across the grain.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thebigmansworld.com")
    expect(recipe.canonical_url).to eq("https://thebigmansworld.com/hanger-steak/")
    expect(recipe.site_name).to eq("The Big Man's World ®")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Arman Liew")
    expect(recipe.description).to eq("My hanger steak recipe transforms an underrated cut into a satisfying, steak-house quality dinner. It's so juicy and tender and cooks FAST. Watch the video below to see how I make it in my kitchen!")
    expect(recipe.image).to eq("https://thebigmansworld.com/wp-content/uploads/2024/07/hanger-steak-recipe2.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(18)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(8)
    expect(recipe.keywords).to eq(["hanger steak"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(17)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 serving",
      "calories" => "300 kcal",
      "carbohydrateContent" => "1 g",
      "proteinContent" => "37 g",
      "fatContent" => "15 g",
      "sodiumContent" => "668 mg",
      "fiberContent" => "0.1 g",
      "sugarContent" => "0.3 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "serving", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 300.0 },
      { name: "carbohydrateContent", unit: "g", amount: 1.0 },
      { name: "proteinContent", unit: "g", amount: 37.0 },
      { name: "fatContent", unit: "g", amount: 15.0 },
      { name: "sodiumContent", unit: "mg", amount: 668.0 },
      { name: "fiberContent", unit: "g", amount: 0.1 },
      { name: "sugarContent", unit: "g", amount: 0.3 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
