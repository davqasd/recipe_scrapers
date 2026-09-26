# frozen_string_literal: true

RSpec.describe "pinkowlkitchen.com" do
  subject(:recipe) { scrape_cassette("com/pinkowlkitchen", url: "https://pinkowlkitchen.com/chocolate-chess-pie/") }

  it "reads the title" do
    expect(recipe.title).to eq("Chocolate Chess Pie")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1, 9-inch pie crust (homemade, refrigerated, or frozen, my homemade pie crust from my sweet potato pie recipe is linked)",
      "1 1/2 cups granulated sugar",
      "1/4 cup unsweetened cocoa powder (regular or Dutch-processed)",
      "1/4 teaspoon salt",
      "1/4 cup melted butter (unsalted)",
      "3 large eggs (beaten)",
      "1/2 cup evaporated milk (see note)",
      "1 1/2 teaspoons pure vanilla extract"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "9-inch pie crust" },
      { amount: 1.5, unit: "cups", name: "granulated sugar" },
      { amount: 0.25, unit: "cup", name: "unsweetened cocoa powder" },
      { amount: 0.25, unit: "teaspoon", name: "salt" },
      { amount: 0.25, unit: "cup", name: "melted butter" },
      { amount: 3.0, unit: nil, name: "large eggs" },
      { amount: 0.5, unit: "cup", name: "evaporated milk" },
      { amount: 1.5, unit: "teaspoons", name: "pure vanilla extract" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat your oven to 350°F. Prepare your pie crust by gently pressing your homemade or refrigerated pie crust into your pie plate and crimping the edges, or by setting your frozen pie crust out on the counter while you prepare the filling.",
      "In a large mixing bowl, whisk together the sugar, cocoa powder, and salt until combined. Add the melted butter, beaten eggs, evaporated milk, and vanilla extract to the bowl and whisk until the filling is smooth and lump free.",
      "Pour the filling into your prepared pie crust and bake the pie in the preheated oven for 50 to 55 minutes, until the pie has puffed up and the center is just barely jiggly.",
      "Allow the pie to cool to room temperature on a wire rack. Enjoy chilled or room temperature with a dollop of fresh whipped cream!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat your oven to 350°F. Prepare your pie crust by gently pressing your homemade or refrigerated pie crust into your pie plate and crimping the edges, or by setting your frozen pie crust out on the counter while you prepare the filling.\nIn a large mixing bowl, whisk together the sugar, cocoa powder, and salt until combined. Add the melted butter, beaten eggs, evaporated milk, and vanilla extract to the bowl and whisk until the filling is smooth and lump free.\nPour the filling into your prepared pie crust and bake the pie in the preheated oven for 50 to 55 minutes, until the pie has puffed up and the center is just barely jiggly.\nAllow the pie to cool to room temperature on a wire rack. Enjoy chilled or room temperature with a dollop of fresh whipped cream!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("pinkowlkitchen.com")
    expect(recipe.canonical_url).to eq("https://pinkowlkitchen.com/chocolate-chess-pie/")
    expect(recipe.site_name).to eq("Pink Owl Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Ashley Boyd")
    expect(recipe.description).to eq("Chocolate chess pie is a decadent, fudgy custard pie baked in a buttery homemade pie crust. This tasty pie is a chocolate lover's dream and makes the perfect Thanksgiving dessert!")
    expect(recipe.image).to eq("https://pinkowlkitchen.com/wp-content/uploads/2023/08/chocolate-chess-pie-featured-image.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(60)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(50)
    expect(recipe.keywords).to eq(["chess pie", "chocolate chess pie", "chocolate pie"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 slice",
      "calories" => "260 kcal",
      "carbohydrateContent" => "38.9 g",
      "proteinContent" => "3.5 g",
      "fatContent" => "11.3 g",
      "saturatedFatContent" => "4.7 g",
      "cholesterolContent" => "65 mg",
      "sodiumContent" => "173 mg",
      "fiberContent" => "0.8 g",
      "sugarContent" => "32 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "slice", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 260.0 },
      { name: "carbohydrateContent", unit: "g", amount: 38.9 },
      { name: "proteinContent", unit: "g", amount: 3.5 },
      { name: "fatContent", unit: "g", amount: 11.3 },
      { name: "saturatedFatContent", unit: "g", amount: 4.7 },
      { name: "cholesterolContent", unit: "mg", amount: 65.0 },
      { name: "sodiumContent", unit: "mg", amount: 173.0 },
      { name: "fiberContent", unit: "g", amount: 0.8 },
      { name: "sugarContent", unit: "g", amount: 32.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-content")
  end
end
