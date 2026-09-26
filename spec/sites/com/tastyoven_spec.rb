# frozen_string_literal: true

RSpec.describe "tastyoven.com" do
  subject(:recipe) { scrape_cassette("com/tastyoven", url: "https://tastyoven.com/air-fryer-baby-potatoes/") }

  it "reads the title" do
    expect(recipe.title).to eq("Crispy Air Fryer Baby Potatoes")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1.5 lbs baby potatoes (washed, dried and sliced in half)",
      "2 tbsp extra virgin olive oil (or avocado oil)",
      "1 tbsp garlic powder",
      "3 tsp dried rosemary (or 3 tbsp fresh)",
      "1 tsp salt",
      "1/2 tsp paprika",
      "1/8 tsp black pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.5, unit: "lbs", name: "baby potatoes" },
      { amount: 2.0, unit: "tbsp", name: "extra virgin olive oil" },
      { amount: 1.0, unit: "tbsp", name: "garlic powder" },
      { amount: 3.0, unit: "tsp", name: "dried rosemary" },
      { amount: 1.0, unit: "tsp", name: "salt" },
      { amount: 0.5, unit: "tsp", name: "paprika" },
      { amount: 0.13, unit: "tsp", name: "black pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a mixing bowl, rub the sliced baby potatoes in olive oil. Add the garlic powder, dried rosemary, paprika, salt and black pepper. Mix until potatoes are evenly coated.",
      "Spray the air fryer basket lightly with oil and place potatoes inside. Set to 400°F/204°C for 15-20 minutes. Shake basket or toss potatoes half way through. Test for doneness by piercing with a fork. If more time is needed, cook in 2 minute increments until potatoes are tender inside and with crispy, golden brown skins on the outside.",
      "Remove cooked potatoes from basket, toss with fresh herbs if desired and serve with your favorite main."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a mixing bowl, rub the sliced baby potatoes in olive oil. Add the garlic powder, dried rosemary, paprika, salt and black pepper. Mix until potatoes are evenly coated.\nSpray the air fryer basket lightly with oil and place potatoes inside. Set to 400°F/204°C for 15-20 minutes. Shake basket or toss potatoes half way through. Test for doneness by piercing with a fork. If more time is needed, cook in 2 minute increments until potatoes are tender inside and with crispy, golden brown skins on the outside.\nRemove cooked potatoes from basket, toss with fresh herbs if desired and serve with your favorite main.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("tastyoven.com")
    expect(recipe.canonical_url).to eq("https://tastyoven.com/air-fryer-baby-potatoes/")
    expect(recipe.site_name).to eq("Tasty Oven")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Kristina Tipps")
    expect(recipe.description).to eq("Air Fryer Baby Potatoes are crispy on the outside and creamy on the inside. Ready in 20 minutes, this quick air fryer side dish is packed with flavor from simple pantry seasonings. It's perfect for busy weeknights, holiday dinners or as any easy addition to any meal. No parboiling needed- just toss, air fry and serve perfectly golden potatoes every time.")
    expect(recipe.image).to eq("https://tastyoven.com/wp-content/uploads/2021/04/air-fryer-baby-potatoes-image.jpg")
    expect(recipe.category).to eq("Side Dish")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq([
      "air fried baby potatoes",
      "air fryer mini potatoes",
      "baby potatoes in air fryer",
      "little potatoes air fryer"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(%w[
      LowCalorieDiet
      LowFatDiet
      LowLactoseDiet
      VeganDiet
      VegetarianDiet
    ])
    expect(recipe.ratings).to eq(4.44)
    expect(recipe.ratings_count).to eq(472)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "6 oz",
      "calories" => "200 kcal",
      "carbohydrateContent" => "31 g",
      "proteinContent" => "4 g",
      "fatContent" => "7 g",
      "saturatedFatContent" => "1 g",
      "sodiumContent" => "593 mg",
      "fiberContent" => "4 g",
      "sugarContent" => "1 g",
      "unsaturatedFatContent" => "6 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "oz", amount: 6.0 },
      { name: "calories", unit: "kcal", amount: 200.0 },
      { name: "carbohydrateContent", unit: "g", amount: 31.0 },
      { name: "proteinContent", unit: "g", amount: 4.0 },
      { name: "fatContent", unit: "g", amount: 7.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 593.0 },
      { name: "fiberContent", unit: "g", amount: 4.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 6.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://tastyoven.com/")
  end
end
