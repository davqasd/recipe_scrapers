# frozen_string_literal: true

RSpec.describe "sweetcsdesigns.com" do
  subject(:recipe) { scrape_cassette("com/sweetcsdesigns", url: "https://sweetcsdesigns.com/the-best-easy-air-fryer-french-fries-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Crispy Air Fryer Fries")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 large russet potatoes",
      "2-3 tablespoons olive oil",
      "Sea salt and pepper (to taste)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: nil, name: "large russet potatoes" },
      { amount: 2.0, unit: "tablespoons", name: "olive oil" },
      { amount: nil, unit: nil, name: "Sea salt and pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Using a mandoline or sharp knife, slice the potatoes into fries. I don't worry too much about the size of fry I am making- some are bigger, and some are smaller. That's fine!",
      "Next, place your potatoes in a cool water bath. Completely submerge the fries in water.",
      "Let fries sit one hour. This helps to remove excess starch and will help the fries crisp up more in the oven.",
      "Preheat air fryer to 375 degrees.",
      "After an hour, drain the water, and pat fries dry with a paper towel.",
      "Toss with a couple tablespoons of olive oil, salt and pepper.",
      "Add fries to bottom of air fryer basket, making sure they are all on the same level (don't stack them on top of each other.)",
      "Cook 15-20 minutes, until crispy and golden brown.",
      "Place on a baking sheet lined with paper towels and a cooling rack over it.",
      "Place in warm oven (set to the minimum temperature, not over 250 degrees) and let rest while other batches of fries are cooking.",
      "Serve hot and enjoy."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Using a mandoline or sharp knife, slice the potatoes into fries. I don't worry too much about the size of fry I am making- some are bigger, and some are smaller. That's fine!\nNext, place your potatoes in a cool water bath. Completely submerge the fries in water.\nLet fries sit one hour. This helps to remove excess starch and will help the fries crisp up more in the oven.\nPreheat air fryer to 375 degrees.\nAfter an hour, drain the water, and pat fries dry with a paper towel.\nToss with a couple tablespoons of olive oil, salt and pepper.\nAdd fries to bottom of air fryer basket, making sure they are all on the same level (don't stack them on top of each other.)\nCook 15-20 minutes, until crispy and golden brown.\nPlace on a baking sheet lined with paper towels and a cooling rack over it.\nPlace in warm oven (set to the minimum temperature, not over 250 degrees) and let rest while other batches of fries are cooking.\nServe hot and enjoy.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("sweetcsdesigns.com")
    expect(recipe.canonical_url).to eq("https://sweetcsdesigns.com/the-best-easy-air-fryer-french-fries-recipe/")
    expect(recipe.site_name).to eq("Sweet Cs Designs")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Courtney ODell")
    expect(recipe.description).to eq("Crispy, crunchy, healthier than deep fried air fryer french fries are a perfect, delicious, easy side dish everyone loves!")
    expect(recipe.image).to eq("https://sweetcsdesigns.com/wp-content/uploads/2023/06/air-fryer-french-fries-recipe-picture-1.jpg")
    expect(recipe.category).to eq("Side dishes")
    expect(recipe.cuisine).to eq("air fryer")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(85)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq([
      "air fryer french fries",
      "comfort food",
      "crispy",
      "easy french fries",
      "healthy french fries",
      "homemade french fries",
      "instant pot french fries",
      "party food",
      "potatoes",
      "quick",
      "side dish"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.88)
    expect(recipe.ratings_count).to eq(569)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 g",
      "calories" => "205 kcal",
      "carbohydrateContent" => "32 g",
      "proteinContent" => "4 g",
      "fatContent" => "7 g",
      "saturatedFatContent" => "1 g",
      "sodiumContent" => "70 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "2 g",
      "unsaturatedFatContent" => "6 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "g", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 205.0 },
      { name: "carbohydrateContent", unit: "g", amount: 32.0 },
      { name: "proteinContent", unit: "g", amount: 4.0 },
      { name: "fatContent", unit: "g", amount: 7.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 70.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 6.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
