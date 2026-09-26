# frozen_string_literal: true

RSpec.describe "joyfullymad.com" do
  subject(:recipe) { scrape_cassette("com/joyfullymad", url: "https://joyfullymad.com/chewy-oatmeal-cookies/") }

  it "reads the title" do
    expect(recipe.title).to eq("Chewy Oatmeal Cookies")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup unsalted butter (softened)",
      "1 ½ cups brown sugar",
      "1 teaspoon vanilla extract",
      "1 ½ cups all-purpose flour",
      "1 tablespoon cornstarch",
      "2 teaspoon baking powder",
      "½ teaspoon baking soda",
      "1 teaspoon cinnamon",
      "½ teaspoon salt",
      "2 ½ cups old-fashioned oats"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "unsalted butter" },
      { amount: 1.5, unit: "cups", name: "brown sugar" },
      { amount: 1.0, unit: "teaspoon", name: "vanilla extract" },
      { amount: 1.5, unit: "cups", name: "all-purpose flour" },
      { amount: 1.0, unit: "tablespoon", name: "cornstarch" },
      { amount: 2.0, unit: "teaspoon", name: "baking powder" },
      { amount: 0.5, unit: "teaspoon", name: "baking soda" },
      { amount: 1.0, unit: "teaspoon", name: "cinnamon" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 2.5, unit: "cups", name: "old-fashioned oats" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Start by preheating your oven to 350°F (177°C) and lining your baking sheet with parchment paper.",
      "Then cream together the softened 1 cup unsalted butter, 1 ½ cups brown sugar, and 1 teaspoon vanilla extract.",
      "Stir in the 1 ½ cups all-purpose flour, 1 tablespoon cornstarch, 2 teaspoon baking powder, ½ teaspoon baking soda, 1 teaspoon cinnamon, and ½ teaspoon salt until a gooey dough is formed, then fold in the 2 ½ cups old-fashioned oats.",
      "Use your 2-tablespoon cookie scoop to scoop 6 cookie dough balls onto your parchment lined baking sheet.",
      "Bake for about 11-12 minutes, then let cool for at least 5 minutes on the baking sheet before moving to a cooling rack.",
      "Repeat with the rest of the cookie dough and enjoy when cooled!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Start by preheating your oven to 350°F (177°C) and lining your baking sheet with parchment paper.\nThen cream together the softened 1 cup unsalted butter, 1 ½ cups brown sugar, and 1 teaspoon vanilla extract.\nStir in the 1 ½ cups all-purpose flour, 1 tablespoon cornstarch, 2 teaspoon baking powder, ½ teaspoon baking soda, 1 teaspoon cinnamon, and ½ teaspoon salt until a gooey dough is formed, then fold in the 2 ½ cups old-fashioned oats.\nUse your 2-tablespoon cookie scoop to scoop 6 cookie dough balls onto your parchment lined baking sheet.\nBake for about 11-12 minutes, then let cool for at least 5 minutes on the baking sheet before moving to a cooling rack.\nRepeat with the rest of the cookie dough and enjoy when cooled!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("joyfullymad.com")
    expect(recipe.canonical_url).to eq("https://joyfullymad.com/chewy-oatmeal-cookies/")
    expect(recipe.site_name).to eq("A Joyfully Mad Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Madison Wetherill")
    expect(recipe.description).to eq("These soft and chewy oatmeal cookies are a breeze to whip up and boast cinnamon, vanilla and oat flavors in every bite. They pair well with a cup of coffee or tea, and are also ideal for cookie trays.")
    expect(recipe.image).to eq("https://joyfullymad.com/wp-content/uploads/2026/04/Chewy-Oatmeal-Cookies-13.jpg")
    expect(recipe.category).to eq("Desserts")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("30 servings")
    expect(recipe.total_time).to eq(31)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(11)
    expect(recipe.keywords).to eq(["cookies", "desserts", "oatmeal", "oatmeal cookies"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 cookie",
      "calories" => "146 kcal",
      "carbohydrateContent" => "21 g",
      "proteinContent" => "2 g",
      "fatContent" => "7 g",
      "saturatedFatContent" => "4 g",
      "transFatContent" => "0.2 g",
      "cholesterolContent" => "16 mg",
      "sodiumContent" => "90 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "11 g",
      "unsaturatedFatContent" => "2.4 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "cookie", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 146.0 },
      { name: "carbohydrateContent", unit: "g", amount: 21.0 },
      { name: "proteinContent", unit: "g", amount: 2.0 },
      { name: "fatContent", unit: "g", amount: 7.0 },
      { name: "saturatedFatContent", unit: "g", amount: 4.0 },
      { name: "transFatContent", unit: "g", amount: 0.2 },
      { name: "cholesterolContent", unit: "mg", amount: 16.0 },
      { name: "sodiumContent", unit: "mg", amount: 90.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 11.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 2.4 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
