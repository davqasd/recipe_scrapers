# frozen_string_literal: true

RSpec.describe "natashaskitchen.com" do
  subject(:recipe) { scrape_cassette("com/natashaskitchen", url: "https://natashaskitchen.com/sugar-cookies-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Christmas Sugar Cookies Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup unsalted butter (softened at room temperature)",
      "1 cup granulated sugar",
      "1 egg (large)",
      "1 tsp vanilla extract",
      "3 cups all-purpose flour (measured correctly)",
      "1 Tbsp baking powder (use aluminum free)",
      "1/4 tsp salt"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "unsalted butter" },
      { amount: 1.0, unit: "cup", name: "granulated sugar" },
      { amount: 1.0, unit: nil, name: "egg" },
      { amount: 1.0, unit: "tsp", name: "vanilla extract" },
      { amount: 3.0, unit: "cups", name: "all-purpose flour" },
      { amount: 1.0, unit: "Tbsp", name: "baking powder" },
      { amount: 0.25, unit: "tsp", name: "salt" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 350 °F with a rack in the center. Whisk together flour with baking powder and salt in a small bowl and set aside.",
      "Using a stand-up or handheld mixer, beat the butter together with sugar. To the mixture add vanilla extract and egg and beat to combine.",
      "To the butter mixture, add flour in 3 parts until fully incorporated.",
      "Divide the dough into two equal parts. On a lightly floured surface, roll into ¼-inch thickness. Use a cookie cutter to cut out your favorite shapes.",
      "Bake cookies on a parchment or silicone-lined baking sheet at 350˚F for 10 minutes, or until the edges are just beginning to turn golden.",
      "Let the cookies cool for about 5 minutes on the baking sheet before moving them to a wire rack to cool completely and decorating with cookie icing."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 350 °F with a rack in the center. Whisk together flour with baking powder and salt in a small bowl and set aside.\nUsing a stand-up or handheld mixer, beat the butter together with sugar. To the mixture add vanilla extract and egg and beat to combine.\nTo the butter mixture, add flour in 3 parts until fully incorporated.\nDivide the dough into two equal parts. On a lightly floured surface, roll into ¼-inch thickness. Use a cookie cutter to cut out your favorite shapes.\nBake cookies on a parchment or silicone-lined baking sheet at 350˚F for 10 minutes, or until the edges are just beginning to turn golden.\nLet the cookies cool for about 5 minutes on the baking sheet before moving them to a wire rack to cool completely and decorating with cookie icing.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("natashaskitchen.com")
    expect(recipe.canonical_url).to eq("https://natashaskitchen.com/sugar-cookies-recipe/")
    expect(recipe.site_name).to eq("NatashasKitchen.com")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Natalya Drozhzhin")
    expect(recipe.description).to eq("Everyone needs an Easy Sugar Cookies Recipe! These are literally melt-in-your-mouth delicious. I am positive these Christmas cookies will win you over. You can use store-bought icing or our easy 3-ingredient sugar cookie icing.")
    expect(recipe.image).to eq("https://natashaskitchen.com/wp-content/uploads/2019/12/Sugar-Cookies-8.jpg")
    expect(recipe.category).to eq("Cookies")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("40 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq(["sugar cookies"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.96)
    expect(recipe.ratings_count).to eq(618)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "96 kcal",
      "carbohydrateContent" => "12 g",
      "proteinContent" => "1 g",
      "fatContent" => "5 g",
      "saturatedFatContent" => "3 g",
      "cholesterolContent" => "16 mg",
      "sodiumContent" => "17 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "5 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 96.0 },
      { name: "carbohydrateContent", unit: "g", amount: 12.0 },
      { name: "proteinContent", unit: "g", amount: 1.0 },
      { name: "fatContent", unit: "g", amount: 5.0 },
      { name: "saturatedFatContent", unit: "g", amount: 3.0 },
      { name: "cholesterolContent", unit: "mg", amount: 16.0 },
      { name: "sodiumContent", unit: "mg", amount: 17.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 5.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#body")
  end
end
