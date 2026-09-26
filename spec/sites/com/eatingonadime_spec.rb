# frozen_string_literal: true

RSpec.describe "eatingonadime.com" do
  subject(:recipe) { scrape_cassette("com/eatingonadime", url: "https://www.eatingonadime.com/crock-pot-cinnamon-roll-casserole/") }

  it "reads the title" do
    expect(recipe.title).to eq("Crock Pot Cinnamon Roll Casserole")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cans of cinnamon rolls ((12 oz each) )",
      "4 eggs",
      "1/2 cup milk",
      "3 Tbsp maple syrup",
      "2 tsp vanilla",
      "1 tsp cinnamon"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cans", name: "cinnamon rolls" },
      { amount: 4.0, unit: nil, name: "eggs" },
      { amount: 0.5, unit: "cup", name: "milk" },
      { amount: 3.0, unit: "Tbsp", name: "maple syrup" },
      { amount: 2.0, unit: "tsp", name: "vanilla" },
      { amount: 1.0, unit: "tsp", name: "cinnamon" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Open the cinnamon rolls and set aside the icing for later.",
      "Cut each cinnamon roll into quarters.",
      "Spray your crock pot with non stick spray and place one of the package of cut rolls of cinnamon rolls in the bottom of the crock pot.",
      "In a small bowl whisk eggs, milk, maple syrup, vanilla, and cinnamon.",
      "Pour over the cinnamon rolls in the crock pot.",
      "Place the remaining cinnamon rolls on top.",
      "Drizzle one icing packet over the cinnamon rolls.",
      "Place the crock pot lid on top and cook on low for 2 to 2 1/2 hours until cooked through.",
      "Remove lid and drizzle the last icing packet over the cinnamon rolls.",
      "Serve immediately and enjoy with a glass of milk!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Open the cinnamon rolls and set aside the icing for later.\nCut each cinnamon roll into quarters.\nSpray your crock pot with non stick spray and place one of the package of cut rolls of cinnamon rolls in the bottom of the crock pot.\nIn a small bowl whisk eggs, milk, maple syrup, vanilla, and cinnamon.\nPour over the cinnamon rolls in the crock pot.\nPlace the remaining cinnamon rolls on top.\nDrizzle one icing packet over the cinnamon rolls.\nPlace the crock pot lid on top and cook on low for 2 to 2 1/2 hours until cooked through.\nRemove lid and drizzle the last icing packet over the cinnamon rolls.\nServe immediately and enjoy with a glass of milk!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("eatingonadime.com")
    expect(recipe.canonical_url).to eq("https://www.eatingonadime.com/crock-pot-cinnamon-roll-casserole/")
    expect(recipe.site_name).to eq("Eating on a Dime")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Carrie Barnard")
    expect(recipe.description).to eq("Quick and easy Crock pot Cinnamon Roll Casserole. It is the perfect breakfast casserole to throw together in minutes. Cinnamon rolls just got easier!")
    expect(recipe.image).to eq("https://www.eatingonadime.com/wp-content/uploads/2021/08/image-6.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(160)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(150)
    expect(recipe.keywords).to eq(["easy Crock pot Cinnamon Roll Casserole"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.96)
    expect(recipe.ratings_count).to eq(647)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "288 kcal",
      "carbohydrateContent" => "39 g",
      "proteinContent" => "5 g",
      "fatContent" => "12 g",
      "saturatedFatContent" => "5 g",
      "cholesterolContent" => "66 mg",
      "sodiumContent" => "518 mg",
      "sugarContent" => "19 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 288.0 },
      { name: "carbohydrateContent", unit: "g", amount: 39.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "fatContent", unit: "g", amount: 12.0 },
      { name: "saturatedFatContent", unit: "g", amount: 5.0 },
      { name: "cholesterolContent", unit: "mg", amount: 66.0 },
      { name: "sodiumContent", unit: "mg", amount: 518.0 },
      { name: "sugarContent", unit: "g", amount: 19.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
