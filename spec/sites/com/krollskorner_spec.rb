# frozen_string_literal: true

RSpec.describe "krollskorner.com" do
  subject(:recipe) { scrape_cassette("com/krollskorner", url: "https://krollskorner.com/dietary/vegetarian/kung-pao-pasta/") }

  it "reads the title" do
    expect(recipe.title).to eq("Spicy Sesame Noodles")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 pound spaghetti (or egg noodles, ramen noodles, etc. )",
      "1/2 cup sesame oil",
      "1/3 cup avocado oil or canola oil",
      "2 tsp. red pepper chili flakes",
      "1/2 cup soy sauce",
      "1/3 heaping cup honey",
      "2 Tbsp. chili garlic sauce (or your favorite chili crunch)",
      "2 tsp. rice vinegar",
      "1 Tbsp. cornstarch + 1 Tbsp. water (optional )",
      "3/4 cup unsalted roasted peanuts, chopped",
      "1/2 cup fresh cilantro, chopped",
      "1/2 cup green onions, chopped",
      "2 Tbsp. toasted sesame seeds"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "pound", name: "spaghetti" },
      { amount: 0.5, unit: "cup", name: "sesame oil" },
      { amount: 0.33, unit: "cup", name: "avocado oil or canola oil" },
      { amount: 2.0, unit: "tsp", name: "red pepper chili flakes" },
      { amount: 0.5, unit: "cup", name: "soy sauce" },
      { amount: 0.33, unit: "cup", name: "honey" },
      { amount: 2.0, unit: "Tbsp", name: "chili garlic sauce" },
      { amount: 2.0, unit: "tsp", name: "rice vinegar" },
      { amount: 1.0, unit: "Tbsp", name: "cornstarch + 1 Tbsp. water" },
      { amount: 0.75, unit: "cup", name: "unsalted roasted peanuts, chopped" },
      { amount: 0.5, unit: "cup", name: "fresh cilantro, chopped" },
      { amount: 0.5, unit: "cup", name: "green onions, chopped" },
      { amount: 2.0, unit: "Tbsp", name: "toasted sesame seeds" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Cook spaghetti, or noodle of choice. Drain and set aside in a large bowl.",
      "Add sesame oil, avocado oil, and red pepper chili flakes to a saucepan over medium heat. Cook for just a few minutes or until the chili flakes begin to pop. The longer the chili flakes pop, the spicer the noodles will be.",
      "Turn the heat down to low and add the soy sauce, honey, chili garlic sauce, and rice vinegar. Stir and bring the sauce to a simmer.",
      "Optional to thicken the sauce add in cornstarch slurry: Start with 1 Tbsp. cornstarch mixed with 1 Tbsp. water and whisk into sauce. You will notice the consistency change. If you want it thicker, add more cornstarch slurry. I don't like my sauce very thick (but that's up to you!)",
      "Combine the cooked noodles with the sauce.",
      "Add in the peanuts, cilantro, green onions, and sesame seeds. Toss to combine. Garnish with more sesame seeds and green onions. Taste and adjust any seasonings to taste. Enjoy warm or chilled!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Cook spaghetti, or noodle of choice. Drain and set aside in a large bowl.\nAdd sesame oil, avocado oil, and red pepper chili flakes to a saucepan over medium heat. Cook for just a few minutes or until the chili flakes begin to pop. The longer the chili flakes pop, the spicer the noodles will be.\nTurn the heat down to low and add the soy sauce, honey, chili garlic sauce, and rice vinegar. Stir and bring the sauce to a simmer.\nOptional to thicken the sauce add in cornstarch slurry: Start with 1 Tbsp. cornstarch mixed with 1 Tbsp. water and whisk into sauce. You will notice the consistency change. If you want it thicker, add more cornstarch slurry. I don't like my sauce very thick (but that's up to you!)\nCombine the cooked noodles with the sauce.\nAdd in the peanuts, cilantro, green onions, and sesame seeds. Toss to combine. Garnish with more sesame seeds and green onions. Taste and adjust any seasonings to taste. Enjoy warm or chilled!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("krollskorner.com")
    expect(recipe.canonical_url).to eq("https://krollskorner.com/dietary/vegetarian/kung-pao-pasta/")
    expect(recipe.site_name).to eq("Kroll's Korner")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Krolls Korner")
    expect(recipe.description).to eq("These Spicy Sesame Noodles feature the nutty depth of flavor from the toasted sesame oil and a savory umami punch from the soy sauce. The chili garlic sauce and red pepper chili flakes add the fiery spice, balanced by the sweetness of honey and a little rice vinegar for a tangy finish. The cilantro and green onions add freshness and vibrancy and the peanuts add texture and crunch. Serve it cold or warm, you can't go wrong with these noodles; perfect for a main meal or side dish!")
    expect(recipe.image).to eq("https://krollskorner.com/wp-content/uploads/2019/06/sesamenoodlesupdate_20-1-of-1.jpg")
    expect(recipe.category).to eq("Side Dish")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.58)
    expect(recipe.ratings_count).to eq(7)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 serving",
      "calories" => "432 kcal",
      "carbohydrateContent" => "48 g",
      "proteinContent" => "13 g",
      "fatContent" => "22 g",
      "fiberContent" => "5 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "serving", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 432.0 },
      { name: "carbohydrateContent", unit: "g", amount: 48.0 },
      { name: "proteinContent", unit: "g", amount: 13.0 },
      { name: "fatContent", unit: "g", amount: 22.0 },
      { name: "fiberContent", unit: "g", amount: 5.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
