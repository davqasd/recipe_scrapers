# frozen_string_literal: true

RSpec.describe "naturallyella.com" do
  subject(:recipe) { scrape_cassette("com/naturallyella", url: "https://naturallyella.com/lemon-vinaigrette/") }

  it "reads the title" do
    expect(recipe.title).to eq("Lemon Vinaigrette")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1/4 cup olive oil",
      "2 tablespoons fresh lemon juice",
      "2 tablespoons minced shallot",
      "1/4 teaspoon salt",
      "1/4 teaspoon black pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.25, unit: "cup", name: "olive oil" },
      { amount: 2.0, unit: "tablespoons", name: "fresh lemon juice" },
      { amount: 2.0, unit: "tablespoons", name: "minced shallot" },
      { amount: 0.25, unit: "teaspoon", name: "salt" },
      { amount: 0.25, unit: "teaspoon", name: "black pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Combine all ingredients in a jar with a tight-fitting lid. Shake until well combined and emulsified. Store in an airtight container in the refrigerator for up to a week, bringing to room temperature before using."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Combine all ingredients in a jar with a tight-fitting lid. Shake until well combined and emulsified. Store in an airtight container in the refrigerator for up to a week, bringing to room temperature before using.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("naturallyella.com")
    expect(recipe.canonical_url).to eq("https://naturallyella.com/lemon-vinaigrette/")
    expect(recipe.site_name).to eq("Naturally Ella")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Erin Alderson")
    expect(recipe.description).to eq("This easy homemade dressing is the perfect base for many different flavors and use in many different")
    expect(recipe.image).to eq("https://naturallyella.com/wp-content/uploads/2017/04/lemon-vinaigrette.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(5)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "calories" => "125 kcal", "servingSize" => "1 serving" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 125.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://naturallyella.com/recipes/")
  end
end
