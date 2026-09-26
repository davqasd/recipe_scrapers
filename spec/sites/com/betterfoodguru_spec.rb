# frozen_string_literal: true

RSpec.describe "betterfoodguru.com" do
  subject(:recipe) { scrape_cassette("com/betterfoodguru", url: "https://betterfoodguru.com/southwest-quinoa-bean-salad/") }

  it "reads the title" do
    expect(recipe.title).to eq("Southwest Quinoa & Bean Salad")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups quinoa (cooked and cooked, measured after cooking)",
      "2 sweet potatoes (peeled and cubed)",
      "15 oz black beans (canned, drained)",
      "1 cup frozen corn (thawed)",
      "1/4 red onion (diced)",
      "1 tbsp olive oil",
      "1/4 Salt and pepper",
      "1 cup Cole slaw mix (red and green cabbage & carrots)",
      "2 avocados (peeled and cubed)",
      "1/4 cup sesame tahini",
      "2 limes juiced",
      "1/4 cup water",
      "1 bunch cilantro",
      "1/2 tsp salt"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "quinoa" },
      { amount: 2.0, unit: nil, name: "sweet potatoes" },
      { amount: 15.0, unit: "oz", name: "black beans" },
      { amount: 1.0, unit: "cup", name: "frozen corn" },
      { amount: 0.25, unit: nil, name: "red onion" },
      { amount: 1.0, unit: "tbsp", name: "olive oil" },
      { amount: 0.25, unit: nil, name: "Salt and pepper" },
      { amount: 1.0, unit: "cup", name: "Cole slaw mix" },
      { amount: 2.0, unit: nil, name: "avocados" },
      { amount: 0.25, unit: "cup", name: "sesame tahini" },
      { amount: 2.0, unit: nil, name: "limes juiced" },
      { amount: 0.25, unit: "cup", name: "water" },
      { amount: 1.0, unit: "bunch", name: "cilantro" },
      { amount: 0.5, unit: "tsp", name: "salt" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "First, cook quinoa according to boxes instructions and let cool",
      "Then, preheat oven to 400",
      "Next, on a sheet pan spread the sweet potato in a single layer, toss with olive oil and salt and bake for 25 minutes flipping once halfway",
      "Make the dressing by combining tahini, lime juice, water, salt and cilantro in a blender and puree until creamy.",
      "In a large bowl add the cloe slaw mix, cooled quinoa, sweet potatoes, avocadoes, corn and onions.",
      "Last, add the dressing and toss well. Enjoy within 3 days for best quality."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("First, cook quinoa according to boxes instructions and let cool\nThen, preheat oven to 400\nNext, on a sheet pan spread the sweet potato in a single layer, toss with olive oil and salt and bake for 25 minutes flipping once halfway\nMake the dressing by combining tahini, lime juice, water, salt and cilantro in a blender and puree until creamy.\nIn a large bowl add the cloe slaw mix, cooled quinoa, sweet potatoes, avocadoes, corn and onions.\nLast, add the dressing and toss well. Enjoy within 3 days for best quality.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("betterfoodguru.com")
    expect(recipe.canonical_url).to eq("https://betterfoodguru.com/southwest-quinoa-bean-salad/")
    expect(recipe.site_name).to eq("BetterFoodGuru")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Sara Tercero")
    expect(recipe.description).to eq("This loaded quinoa salad with Southwestern flavors and a creamy tahini lime dressing is delicious. It is super hearty and full of black beans, corn and sweet potatoes. Perfect for a dinner salad or a lunch meal prep, this one is sure to be a favorite.")
    expect(recipe.image).to eq("https://betterfoodguru.com/wp-content/uploads/2023/05/Loaded-Quinoa-Salad.jpg")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(40)
    expect(recipe.keywords).to eq([
      "black beans",
      "blender dressing",
      "cilantro",
      "Easy",
      "glutenfree",
      "healthy",
      "quinoa",
      "tahini"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(14)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "458 kcal",
      "carbohydrateContent" => "63 g",
      "proteinContent" => "15 g",
      "fatContent" => "19 g",
      "saturatedFatContent" => "3 g",
      "sodiumContent" => "253 mg",
      "fiberContent" => "17 g",
      "sugarContent" => "5 g",
      "unsaturatedFatContent" => "16 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 458.0 },
      { name: "carbohydrateContent", unit: "g", amount: 63.0 },
      { name: "proteinContent", unit: "g", amount: 15.0 },
      { name: "fatContent", unit: "g", amount: 19.0 },
      { name: "saturatedFatContent", unit: "g", amount: 3.0 },
      { name: "sodiumContent", unit: "mg", amount: 253.0 },
      { name: "fiberContent", unit: "g", amount: 17.0 },
      { name: "sugarContent", unit: "g", amount: 5.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 16.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
