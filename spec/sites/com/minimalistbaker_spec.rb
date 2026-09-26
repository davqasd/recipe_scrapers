# frozen_string_literal: true

RSpec.describe "minimalistbaker.com" do
  subject(:recipe) { scrape_cassette("com/minimalistbaker", url: "https://minimalistbaker.com/vegan-cashew-ricotta-cheese-soy-free-fast-easy/") }

  it "reads the title" do
    expect(recipe.title).to eq("Cashew Ricotta Cheese (Soy-Free, Fast, Easy!)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 ¼ cup raw cashews",
      "1 Tbsp lemon juice",
      "1 Tbsp nutritional yeast, plus more to taste",
      "1/2 tsp garlic powder",
      "1/4-1/2 tsp sea salt (plus more to taste)",
      "4-6 Tbsp water",
      "1/4 cup fresh chopped parsley or cilantro"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.25, unit: "cup", name: "raw cashews" },
      { amount: 1.0, unit: "Tbsp", name: "lemon juice" },
      { amount: 1.0, unit: "Tbsp", name: "nutritional yeast, plus more to taste" },
      { amount: 0.5, unit: "tsp", name: "garlic powder" },
      { amount: 0.25, unit: "tsp", name: "sea salt" },
      { amount: 4.0, unit: "Tbsp", name: "water" },
      { amount: 0.25, unit: "cup", name: "fresh chopped parsley or cilantro" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Soak cashews in very hot water for 30 minutes to 1 hour, or overnight (or 6 hours) in cool water. Then drain, rinse, and set aside.",
      "Add soaked, drained cashews to a food processor (or a high-speed blender) along with lemon juice, nutritional yeast, garlic powder, sea salt, and lesser amount of water (4 Tbsp or 60 ml as original recipe is written // adjust if altering batch size). Mix/blend, scraping down sides as needed. Then add more water 1 Tbsp (15 ml) at a time until a thick paste forms. I find I get the best texture results with a food processor, but in a pinch, a blender can work too. It just generally requires more scraping and more liquid.",
      "Taste and adjust flavor as needed, adding more nutritional yeast for cheesy flavor, salt to taste, lemon juice for acidity, or garlic powder for garlic flavor. Blend again to combine.",
      "At this point, the \"cheese\" is ready to enjoy! The flavors continue to develop and thicken when chilled. Delicious on things like pizza, pasta, lasagna, salads, and more.",
      "Best when fresh. Store leftover nut \"cheese\" in the refrigerator for up to 5-7 days or in the freezer up to 1 month (let thaw at room temperature or in the refrigerator before serving)."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["RICOTTA", 6],
        ["FOR TOPPING optional", 1]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Soak cashews in very hot water for 30 minutes to 1 hour, or overnight (or 6 hours) in cool water. Then drain, rinse, and set aside.\nAdd soaked, drained cashews to a food processor (or a high-speed blender) along with lemon juice, nutritional yeast, garlic powder, sea salt, and lesser amount of water (4 Tbsp or 60 ml as original recipe is written // adjust if altering batch size). Mix/blend, scraping down sides as needed. Then add more water 1 Tbsp (15 ml) at a time until a thick paste forms. I find I get the best texture results with a food processor, but in a pinch, a blender can work too. It just generally requires more scraping and more liquid.\nTaste and adjust flavor as needed, adding more nutritional yeast for cheesy flavor, salt to taste, lemon juice for acidity, or garlic powder for garlic flavor. Blend again to combine.\nAt this point, the \"cheese\" is ready to enjoy! The flavors continue to develop and thicken when chilled. Delicious on things like pizza, pasta, lasagna, salads, and more.\nBest when fresh. Store leftover nut \"cheese\" in the refrigerator for up to 5-7 days or in the freezer up to 1 month (let thaw at room temperature or in the refrigerator before serving).")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("minimalistbaker.com")
    expect(recipe.canonical_url).to eq("https://minimalistbaker.com/vegan-cashew-ricotta-cheese-soy-free-fast-easy/")
    expect(recipe.site_name).to eq("Minimalist Baker")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Minimalist Baker")
    expect(recipe.description).to eq("Quick, fluffy vegan ricotta cheese made with 5 simple ingredients including cashews, lemon, and garlic. Comes together in a food processor or blender and is perfect for pasta, pizza, salads, and more!")
    expect(recipe.image).to eq("https://minimalistbaker.com/wp-content/uploads/2020/05/Cashew-Ricotta-Cheese-sQUARE.jpg")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("Gluten-Free")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(40)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["vegan ricotta"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.75)
    expect(recipe.ratings_count).to eq(12)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 two-tablespoon serving",
      "calories" => "117 kcal",
      "carbohydrateContent" => "6.8 g",
      "proteinContent" => "4.3 g",
      "fatContent" => "9 g",
      "saturatedFatContent" => "1.6 g",
      "sodiumContent" => "76 mg",
      "fiberContent" => "0.9 g",
      "sugarContent" => "1.3 g",
      "unsaturatedFatContent" => "6.42 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "two-tablespoon", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 117.0 },
      { name: "carbohydrateContent", unit: "g", amount: 6.8 },
      { name: "proteinContent", unit: "g", amount: 4.3 },
      { name: "fatContent", unit: "g", amount: 9.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.6 },
      { name: "sodiumContent", unit: "mg", amount: 76.0 },
      { name: "fiberContent", unit: "g", amount: 0.9 },
      { name: "sugarContent", unit: "g", amount: 1.3 },
      { name: "unsaturatedFatContent", unit: "g", amount: 6.42 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
