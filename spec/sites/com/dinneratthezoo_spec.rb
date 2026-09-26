# frozen_string_literal: true

RSpec.describe "dinneratthezoo.com" do
  subject(:recipe) { scrape_cassette("com/dinneratthezoo", url: "https://www.dinneratthezoo.com/grilled-scallops/") }

  it "reads the title" do
    expect(recipe.title).to eq("Grilled Scallops")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 1/4 pounds large sea scallops",
      "1/4 cup olive oil",
      "2 tablespoons lemon juice",
      "1 teaspoon kosher salt",
      "1/4 teaspoon black pepper",
      "1 teaspoon Italian seasoning",
      "2 teaspoons minced garlic",
      "1 tablespoon chopped parsley",
      "lemon wedges for serving"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.25, unit: "pounds", name: "large sea scallops" },
      { amount: 0.25, unit: "cup", name: "olive oil" },
      { amount: 2.0, unit: "tablespoons", name: "lemon juice" },
      { amount: 1.0, unit: "teaspoon", name: "kosher salt" },
      { amount: 0.25, unit: "teaspoon", name: "black pepper" },
      { amount: 1.0, unit: "teaspoon", name: "Italian seasoning" },
      { amount: 2.0, unit: "teaspoons", name: "minced garlic" },
      { amount: 1.0, unit: "tablespoon", name: "chopped parsley" },
      { amount: nil, unit: nil, name: "lemon wedges for serving" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Place the olive oil, lemon juice, salt, pepper, Italian seasoning and garlic in a large bowl or resealable plastic bag. Stir to combine the ingredients.",
      "Add the scallops to the bag or bowl. Toss to coat evenly with the marinade. Seal the bag or cover the bowl.",
      "Refrigerate and marinate for at least 15 minutes or up to 2 hours. You don't want to marinate for longer than that, as the acid in the lemon juice will start to cook the scallops.",
      "Thread the scallops onto skewers. This is optional, if you have very large scallops you can skip the skewers and toss them directly onto the grill.",
      "Heat an outdoor grill or indoor grill pan over medium high heat.",
      "Place the skewers or loose scallops on the grill. Cook for 1-2 minutes on each side or until scallops are firm and opaque.",
      "Sprinkle with parsley and serve with lemon wedges."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Place the olive oil, lemon juice, salt, pepper, Italian seasoning and garlic in a large bowl or resealable plastic bag. Stir to combine the ingredients.\nAdd the scallops to the bag or bowl. Toss to coat evenly with the marinade. Seal the bag or cover the bowl.\nRefrigerate and marinate for at least 15 minutes or up to 2 hours. You don't want to marinate for longer than that, as the acid in the lemon juice will start to cook the scallops.\nThread the scallops onto skewers. This is optional, if you have very large scallops you can skip the skewers and toss them directly onto the grill.\nHeat an outdoor grill or indoor grill pan over medium high heat.\nPlace the skewers or loose scallops on the grill. Cook for 1-2 minutes on each side or until scallops are firm and opaque.\nSprinkle with parsley and serve with lemon wedges.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("dinneratthezoo.com")
    expect(recipe.canonical_url).to eq("https://www.dinneratthezoo.com/grilled-scallops/")
    expect(recipe.site_name).to eq("Dinner at the Zoo")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Sara Welch")
    expect(recipe.description).to eq("These grilled scallops are marinated in a blend of olive oil, lemon, garlic and herbs, then seared to golden brown perfection on the grill. A quick and easy meal option that's simple yet totally satisfying!")
    expect(recipe.image).to eq("https://www.dinneratthezoo.com/wp-content/uploads/2021/03/grilled-scallops-final-2.jpg")
    expect(recipe.category).to eq("Main")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq(["grilled scallops"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(33)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "206 kcal",
      "proteinContent" => "23 g",
      "fatContent" => "10 g",
      "saturatedFatContent" => "2 g",
      "cholesterolContent" => "285 mg",
      "sodiumContent" => "1317 mg",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 206.0 },
      { name: "proteinContent", unit: "g", amount: 23.0 },
      { name: "fatContent", unit: "g", amount: 10.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "cholesterolContent", unit: "mg", amount: 285.0 },
      { name: "sodiumContent", unit: "mg", amount: 1317.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
