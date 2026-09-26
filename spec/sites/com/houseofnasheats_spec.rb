# frozen_string_literal: true

RSpec.describe "houseofnasheats.com" do
  subject(:recipe) { scrape_cassette("com/houseofnasheats", url: "https://houseofnasheats.com/shoofly-pie/") }

  it "reads the title" do
    expect(recipe.title).to eq("Amish Shoofly Pie")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 unbaked pie crust (1/2 of my recipe)",
      "1 1/2 cups (212g) all-purpose flour",
      "3/4 cup (150g) brown sugar",
      "1 teaspoon ground cinnamon",
      "1/4 teaspoon ground nutmeg",
      "1/4 teaspoon salt",
      "6 Tablespoons cold salted butter",
      "3/4 cup hot water",
      "3/4 teaspoon baking soda",
      "3/4 cup (227g) unsulphured molasses (not blackstrap molasses)",
      "1 teaspoon pure vanilla extract"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "unbaked pie crust" },
      { amount: 1.5, unit: "cups", name: "all-purpose flour" },
      { amount: 0.75, unit: "cup", name: "brown sugar" },
      { amount: 1.0, unit: "teaspoon", name: "ground cinnamon" },
      { amount: 0.25, unit: "teaspoon", name: "ground nutmeg" },
      { amount: 0.25, unit: "teaspoon", name: "salt" },
      { amount: 6.0, unit: "Tablespoons", name: "cold salted butter" },
      { amount: 0.75, unit: "cup", name: "hot water" },
      { amount: 0.75, unit: "teaspoon", name: "baking soda" },
      { amount: 0.75, unit: "cup", name: "unsulphured molasses" },
      { amount: 1.0, unit: "teaspoon", name: "pure vanilla extract" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 425℉ (220℃).",
      "Roll out the pie crust on a floured surface and use it to line a 9-inch pie plate. Crimp the edges and set it in the fridge to chill while preparing the filling.",
      "In a food processor, combine flour, sugar, cinnamon, nutmeg, and salt. Cut in butter until it resembles crumbs.",
      "In a bowl, combine hot water and soda until dissolved. Whisk in the molasses and vanilla.",
      "Pour the molasses mixture into the crust. Sprinkle with the crumb mixture, making sure to cover the pie evenly and go all the way to the edges of the crust.",
      "Bake for 15 minutes, then reduce the heat to 350℉ (175℃) and bake for another 22-28 minutes. Center might be slightly jiggly. Cool completely. Top with whipped cream or ice cream."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 425℉ (220℃).\nRoll out the pie crust on a floured surface and use it to line a 9-inch pie plate. Crimp the edges and set it in the fridge to chill while preparing the filling.\nIn a food processor, combine flour, sugar, cinnamon, nutmeg, and salt. Cut in butter until it resembles crumbs.\nIn a bowl, combine hot water and soda until dissolved. Whisk in the molasses and vanilla.\nPour the molasses mixture into the crust. Sprinkle with the crumb mixture, making sure to cover the pie evenly and go all the way to the edges of the crust.\nBake for 15 minutes, then reduce the heat to 350℉ (175℃) and bake for another 22-28 minutes. Center might be slightly jiggly. Cool completely. Top with whipped cream or ice cream.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("houseofnasheats.com")
    expect(recipe.canonical_url).to eq("https://houseofnasheats.com/shoofly-pie/")
    expect(recipe.site_name).to eq("House of Nash Eats")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Amy Nash")
    expect(recipe.description).to eq("Shoofly Pie is an American classic from Amish country, where the sticky molasses filling is a tradition among the Pennsylvania Dutch and others familiar with the region. It bakes up perfectly moist and has the perfect balances of spices, rich molasses, and a buttery, flaky crust.")
    expect(recipe.image).to eq("https://houseofnasheats.com/wp-content/uploads/2025/11/shoo-fly-pie-square-1.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(175)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(45)
    expect(recipe.keywords).to eq([
      "Amish shoo fly pie",
      "Pennsylvania Dutch shoo fly pie",
      "shoo fly pie",
      "shoofly pie"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "437 kcal",
      "carbohydrateContent" => "72 g",
      "proteinContent" => "4 g",
      "fatContent" => "15 g",
      "saturatedFatContent" => "7 g",
      "transFatContent" => "0.3 g",
      "cholesterolContent" => "47 mg",
      "sodiumContent" => "350 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "44 g",
      "unsaturatedFatContent" => "6 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 437.0 },
      { name: "carbohydrateContent", unit: "g", amount: 72.0 },
      { name: "proteinContent", unit: "g", amount: 4.0 },
      { name: "fatContent", unit: "g", amount: 15.0 },
      { name: "saturatedFatContent", unit: "g", amount: 7.0 },
      { name: "transFatContent", unit: "g", amount: 0.3 },
      { name: "cholesterolContent", unit: "mg", amount: 47.0 },
      { name: "sodiumContent", unit: "mg", amount: 350.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 44.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 6.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
