# frozen_string_literal: true

RSpec.describe "primaledgehealth.com" do
  subject(:recipe) { scrape_cassette("com/primaledgehealth", url: "https://www.primaledgehealth.com/horseradish-sauce/") }

  it "reads the title" do
    expect(recipe.title).to eq("5-Ingredient Horseradish Sauce Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup mayonnaise",
      "½ cup prepared horseradish",
      "2 cloves garlic (minced)",
      "½ teaspoon salt",
      "¼ teaspoon ground black pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "mayonnaise" },
      { amount: 0.5, unit: "cup", name: "prepared horseradish" },
      { amount: 2.0, unit: "cloves", name: "garlic" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 0.25, unit: "teaspoon", name: "ground black pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Combine all the ingredients with a spoon in a small or medium mixing bowl.",
      "Chill",
      "Transfer to an airtight storage container or cover the bowl with plastic wrap and chill in the refrigerator for at least 30 minutes before serving to let flavors develop."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Combine all the ingredients with a spoon in a small or medium mixing bowl.\nChill\nTransfer to an airtight storage container or cover the bowl with plastic wrap and chill in the refrigerator for at least 30 minutes before serving to let flavors develop.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("primaledgehealth.com")
    expect(recipe.canonical_url).to eq("https://www.primaledgehealth.com/horseradish-sauce/")
    expect(recipe.site_name).to eq("Primal Edge Health")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jessica Haggard")
    expect(recipe.description).to eq("No more boring, simple meals with this horseradish sauce around! It takes just under 5 minutes to mix together with 5 basic ingredients. It’s a delicious thick, creamy, and sugar-free condiment that’s an excellent accompaniment to summer BBQs, pork roasts, grilled meats, and many more.")
    expect(recipe.image).to eq("https://www.primaledgehealth.com/wp-content/uploads/2025/07/horseradish-sauce-3-1.jpg")
    expect(recipe.category).to eq("Sauces, Dressings, and Dips")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["horseradish sauce"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 g",
      "calories" => "130 kcal",
      "carbohydrateContent" => "1 g",
      "proteinContent" => "0.3 g",
      "fatContent" => "14 g",
      "saturatedFatContent" => "2 g",
      "sodiumContent" => "255 mg",
      "fiberContent" => "0.4 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "g", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 130.0 },
      { name: "carbohydrateContent", unit: "g", amount: 1.0 },
      { name: "proteinContent", unit: "g", amount: 0.3 },
      { name: "fatContent", unit: "g", amount: 14.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "sodiumContent", unit: "mg", amount: 255.0 },
      { name: "fiberContent", unit: "g", amount: 0.4 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
