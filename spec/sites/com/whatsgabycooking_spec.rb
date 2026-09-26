# frozen_string_literal: true

RSpec.describe "whatsgabycooking.com" do
  subject(:recipe) { scrape_cassette("com/whatsgabycooking", url: "https://whatsgabycooking.com/roasted-broccoli/") }

  it "reads the title" do
    expect(recipe.title).to eq("Caesar Parm Roasted Broccoli")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3-4 heads broccoli (split into florets)",
      "2 tablespoons olive oil",
      "Kosher salt and freshly cracked black pepper (to taste)",
      "1/2 teaspoon red pepper flakes",
      "2/3 cup freshly grated Parmesan cheese",
      "2/3 cup panko bread crumbs, sautéed in olive oil",
      "1 lemon (juiced and zested)",
      "1/2 cup Vegas Caesar Dressing"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "heads", name: "broccoli" },
      { amount: 2.0, unit: "tablespoons", name: "olive oil" },
      { amount: nil, unit: nil, name: "Kosher salt and freshly cracked black pepper" },
      { amount: 0.5, unit: "teaspoon", name: "red pepper flakes" },
      { amount: 0.67, unit: "cup", name: "freshly grated Parmesan cheese" },
      { amount: 0.67, unit: "cup", name: "panko bread crumbs, sautéed in olive oil" },
      { amount: 1.0, unit: nil, name: "lemon" },
      { amount: 0.5, unit: "cup", name: "Vegas Caesar Dressing" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 450 degrees F. Line a baking sheet with parchment paper. Spread the broccoli evenly on the baking sheet and drizzle with 2 tablespoons of olive oil. Using tongs, gently toss the florets in the oil to combine and season with 4 tablespoons of the Vegan Caesar Dressing, salt and pepper and red pepper flakes. Toss to combine.",
      "Transfer the baking sheet into the oven and roast for 15-20 minutes until the broccoli is just golden and slightly crispy.",
      "Remove the baking sheet from the oven and drizzle more 2-3 tablespoons more of the Vegan Caesar Dressing on top. Toss with the toasted buttered breadcrumbs, tons of freshly grated parmesan cheese, lemon juice and zest and serve as needed."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 450 degrees F. Line a baking sheet with parchment paper. Spread the broccoli evenly on the baking sheet and drizzle with 2 tablespoons of olive oil. Using tongs, gently toss the florets in the oil to combine and season with 4 tablespoons of the Vegan Caesar Dressing, salt and pepper and red pepper flakes. Toss to combine.\nTransfer the baking sheet into the oven and roast for 15-20 minutes until the broccoli is just golden and slightly crispy.\nRemove the baking sheet from the oven and drizzle more 2-3 tablespoons more of the Vegan Caesar Dressing on top. Toss with the toasted buttered breadcrumbs, tons of freshly grated parmesan cheese, lemon juice and zest and serve as needed.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("whatsgabycooking.com")
    expect(recipe.canonical_url).to eq("https://whatsgabycooking.com/roasted-broccoli/")
    expect(recipe.site_name).to eq("What's Gaby Cooking")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Gaby Dalkin")
    expect(recipe.description).to eq("This Caesar Roasted Broccoli is perhaps the most perfect roasted broccoli recipe to ever grace the pages of What's Gaby Cooking! Adults and kids will both be obsessed")
    expect(recipe.image).to eq("https://whatsgabycooking.com/wp-content/uploads/2023/01/WGC-__-Caesar-Parm-Roasted-Broccoli-1-870x580-1.jpg")
    expect(recipe.category).to eq("Side Dish")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq(["roasted broccoli", "caesar broccoli", "how to roast broccoli"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.89)
    expect(recipe.ratings_count).to eq(18)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "342 kcal",
      "carbohydrateContent" => "32 g",
      "proteinContent" => "16 g",
      "fatContent" => "20 g",
      "saturatedFatContent" => "4 g",
      "cholesterolContent" => "10 mg",
      "sodiumContent" => "354 mg",
      "fiberContent" => "10 g",
      "sugarContent" => "6 g",
      "unsaturatedFatContent" => "14 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 342.0 },
      { name: "carbohydrateContent", unit: "g", amount: 32.0 },
      { name: "proteinContent", unit: "g", amount: 16.0 },
      { name: "fatContent", unit: "g", amount: 20.0 },
      { name: "saturatedFatContent", unit: "g", amount: 4.0 },
      { name: "cholesterolContent", unit: "mg", amount: 10.0 },
      { name: "sodiumContent", unit: "mg", amount: 354.0 },
      { name: "fiberContent", unit: "g", amount: 10.0 },
      { name: "sugarContent", unit: "g", amount: 6.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 14.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
