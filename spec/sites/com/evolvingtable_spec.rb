# frozen_string_literal: true

RSpec.describe "evolvingtable.com" do
  subject(:recipe) { scrape_cassette("com/evolvingtable", url: "https://www.evolvingtable.com/sriracha-mayo/") }

  it "reads the title" do
    expect(recipe.title).to eq("Spicy Sriracha Mayo Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "½ cup mayonnaise",
      "1 tablespoon sriracha (plus more to taste)",
      "1 teaspoon lemon juice (from 1 lemon)",
      "1 garlic clove (finely minced)",
      "Pinch of salt (optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.5, unit: "cup", name: "mayonnaise" },
      { amount: 1.0, unit: "tablespoon", name: "sriracha" },
      { amount: 1.0, unit: "teaspoon", name: "lemon juice" },
      { amount: 1.0, unit: nil, name: "garlic clove" },
      { amount: 1.0, unit: "Pinch", name: "salt" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Add the mayonnaise, sriracha, lemon juice, garlic, and salt, if using, to a medium bowl. Whisk until well combined, taking care to scrape the ingredients from the bottom of the bowl as you go.",
      "Serve immediately or store in the refrigerator for up to 1 week."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Add the mayonnaise, sriracha, lemon juice, garlic, and salt, if using, to a medium bowl. Whisk until well combined, taking care to scrape the ingredients from the bottom of the bowl as you go.\nServe immediately or store in the refrigerator for up to 1 week.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("evolvingtable.com")
    expect(recipe.canonical_url).to eq("https://www.evolvingtable.com/sriracha-mayo/")
    expect(recipe.site_name).to eq("Evolving Table")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("London Lea")
    expect(recipe.description).to eq("Creamy, spicy, and ready in 5 minutes! Once you learn how easy it is to make this Spicy Sriracha Mayo at home, you're going to be serving it up with everything!! Sriracha, mayo, lemon juice and fresh garlic combine to make a dipping sauce that's perfect with fries, on fish tacos, burgers, or even drizzled over sushi.")
    expect(recipe.image).to eq("https://www.evolvingtable.com/wp-content/uploads/2024/05/Spicy-Sriracha-Mayo-2-2.jpg")
    expect(recipe.category).to eq("dip")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(5)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(%w[dip easy homemade quick spicy])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.92)
    expect(recipe.ratings_count).to eq(12)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "96 kcal",
      "carbohydrateContent" => "1 g",
      "proteinContent" => "1 g",
      "fatContent" => "10 g",
      "saturatedFatContent" => "2 g",
      "cholesterolContent" => "6 mg",
      "sodiumContent" => "211 mg",
      "sugarContent" => "1 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 96.0 },
      { name: "carbohydrateContent", unit: "g", amount: 1.0 },
      { name: "proteinContent", unit: "g", amount: 1.0 },
      { name: "fatContent", unit: "g", amount: 10.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "cholesterolContent", unit: "mg", amount: 6.0 },
      { name: "sodiumContent", unit: "mg", amount: 211.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
