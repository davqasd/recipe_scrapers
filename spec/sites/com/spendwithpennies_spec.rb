# frozen_string_literal: true

RSpec.describe "spendwithpennies.com" do
  subject(:recipe) { scrape_cassette("com/spendwithpennies", url: "https://www.spendwithpennies.com/cranberry-jalapeno-dip/") }

  it "reads the title" do
    expect(recipe.title).to eq("Cranberry Jalapeno Dip")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 ounces fresh cranberries",
      "¼ cup granulated sugar",
      "8 ounces cream cheese (softened)",
      "½ cup sour cream",
      "4 ounces diced jalapeños (drained)",
      "1 green onion (finely chopped)",
      "2 tablespoons chopped fresh cilantro"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: "ounces", name: "fresh cranberries" },
      { amount: 0.25, unit: "cup", name: "granulated sugar" },
      { amount: 8.0, unit: "ounces", name: "cream cheese" },
      { amount: 0.5, unit: "cup", name: "sour cream" },
      { amount: 4.0, unit: "ounces", name: "diced jalapeños" },
      { amount: 1.0, unit: nil, name: "green onion" },
      { amount: 2.0, unit: "tablespoons", name: "chopped fresh cilantro" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a small saucepan, bring cranberries, sugar, and 2 tablespoons water to a boil. Simmer for 8 to 10 minutes. Cool completely before using, the sauce will thicken as it cools.",
      "In a medium bowl, beat the cream cheese and sour cream with a hand mixer on medium speed until fluffy.",
      "Add the cranberry sauce, diced jalapenos, green onion, and cilantro.",
      "Stir well to combine and refrigerate 30 minutes before serving."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a small saucepan, bring cranberries, sugar, and 2 tablespoons water to a boil. Simmer for 8 to 10 minutes. Cool completely before using, the sauce will thicken as it cools.\nIn a medium bowl, beat the cream cheese and sour cream with a hand mixer on medium speed until fluffy.\nAdd the cranberry sauce, diced jalapenos, green onion, and cilantro.\nStir well to combine and refrigerate 30 minutes before serving.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("spendwithpennies.com")
    expect(recipe.canonical_url).to eq("https://www.spendwithpennies.com/cranberry-jalapeno-dip/")
    expect(recipe.site_name).to eq("Spend With Pennies")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Holly Nilsson")
    expect(recipe.description).to eq("A perfect mix of sweet and spicy flavors in a light fluffy dip!")
    expect(recipe.image).to eq("https://www.spendwithpennies.com/wp-content/uploads/2024/01/Cranberry-Jalapeno-Dip-SpendWithPennies-7.jpg")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(55)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["best recipe", "Cranberry Jalapeno Dip", "easy"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(3)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "326 kcal",
      "carbohydrateContent" => "22 g",
      "proteinContent" => "5 g",
      "fatContent" => "25 g",
      "saturatedFatContent" => "14 g",
      "cholesterolContent" => "74 mg",
      "sodiumContent" => "189 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "18 g",
      "unsaturatedFatContent" => "7 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 326.0 },
      { name: "carbohydrateContent", unit: "g", amount: 22.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "fatContent", unit: "g", amount: 25.0 },
      { name: "saturatedFatContent", unit: "g", amount: 14.0 },
      { name: "cholesterolContent", unit: "mg", amount: 74.0 },
      { name: "sodiumContent", unit: "mg", amount: 189.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 18.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 7.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
