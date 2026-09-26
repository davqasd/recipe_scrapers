# frozen_string_literal: true

RSpec.describe "bellyfull.net" do
  subject(:recipe) { scrape_cassette("net/bellyfull", url: "https://bellyfull.net/grilled-salmon-with-blackberry-sauce/") }

  it "reads the title" do
    expect(recipe.title).to eq("Grilled Salmon with Blackberry Sauce")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1/4 cup unseasoned rice vinegar",
      "1 cup fresh blackberries",
      "3 tablespoons honey",
      "1 teaspoon fresh ginger",
      "1 teaspoon dried lemongrass",
      "1 teaspoon sesame oil",
      "salt and pepper to taste",
      "1 1/2 pounds skinless salmon filets (, (4 filets, 1-inch thick))",
      "2 tablespoons chili garlic sauce"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.25, unit: "cup", name: "unseasoned rice vinegar" },
      { amount: 1.0, unit: "cup", name: "fresh blackberries" },
      { amount: 3.0, unit: "tablespoons", name: "honey" },
      { amount: 1.0, unit: "teaspoon", name: "fresh ginger" },
      { amount: 1.0, unit: "teaspoon", name: "dried lemongrass" },
      { amount: 1.0, unit: "teaspoon", name: "sesame oil" },
      { amount: nil, unit: nil, name: "salt and pepper to taste" },
      { amount: 1.5, unit: "pounds", name: "skinless salmon filets" },
      { amount: 2.0, unit: "tablespoons", name: "chili garlic sauce" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a food processor or blender, puree the rice vinegar, blackberries, honey, ginger, lemongrass, sesame oil, and a sprinkle of salt and pepper, until combined and smooth. Set aside.",
      "Brush the salmon filets with chili garlic sauce.",
      "Heat a grill to medium. Oil the grill grates very well; cook the salmon for about 5 minutes per side (for medium to medium well.) Remove from heat and let rest for 5 minutes. The salmon is done when it flakes easily with a fork.)",
      "Serve the salmon with the blackberry sauce and your favorite green vegetable."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a food processor or blender, puree the rice vinegar, blackberries, honey, ginger, lemongrass, sesame oil, and a sprinkle of salt and pepper, until combined and smooth. Set aside.\nBrush the salmon filets with chili garlic sauce.\nHeat a grill to medium. Oil the grill grates very well; cook the salmon for about 5 minutes per side (for medium to medium well.) Remove from heat and let rest for 5 minutes. The salmon is done when it flakes easily with a fork.)\nServe the salmon with the blackberry sauce and your favorite green vegetable.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("bellyfull.net")
    expect(recipe.canonical_url).to eq("https://bellyfull.net/grilled-salmon-with-blackberry-sauce/")
    expect(recipe.site_name).to eq("Belly Full")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Amy Flanigan")
    expect(recipe.description).to eq("This Grilled Salmon with Blackberry Sauce is the perfect balance of flavors and will make your palate sing this summer!")
    expect(recipe.image).to eq("https://bellyfull.net/wp-content/uploads/2019/06/Grilled-Salmon-with-Blackberry-Sauce-blog-2.jpg")
    expect(recipe.category).to eq("main")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq(["blackberry sauce", "grilled salmon"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "327 kcal",
      "carbohydrateContent" => "19 g",
      "proteinContent" => "34 g",
      "fatContent" => "12 g",
      "saturatedFatContent" => "2 g",
      "cholesterolContent" => "94 mg",
      "sodiumContent" => "494 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "16 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 327.0 },
      { name: "carbohydrateContent", unit: "g", amount: 19.0 },
      { name: "proteinContent", unit: "g", amount: 34.0 },
      { name: "fatContent", unit: "g", amount: 12.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "cholesterolContent", unit: "mg", amount: 94.0 },
      { name: "sodiumContent", unit: "mg", amount: 494.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 16.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
