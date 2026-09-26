# frozen_string_literal: true

RSpec.describe "tasteandtellblog.com" do
  subject(:recipe) { scrape_cassette("com/tasteandtellblog", url: "https://www.tasteandtellblog.com/dump-cake-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Dump Cake Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 (21 oz) can cherry pie filling",
      "1 (15 to 20 oz) can crushed pineapple*",
      "1 (15.25 oz) box packaged yellow cake mix",
      "1 cup butter"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "can", name: "cherry pie filling" },
      { amount: 1.0, unit: "can", name: "crushed pineapple*" },
      { amount: 1.0, unit: "box", name: "packaged yellow cake mix" },
      { amount: 1.0, unit: "cup", name: "butter" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Prep",
      "Preheat the oven to 325ºF. Spray a 9x13-inch baking dish with nonstick cooking spray.",
      "Spread the pie filling in the bottom of the baking dish.",
      "Pour",
      "Evenly pour the pineapple over the top of the cherry pie filling.",
      "Sprinkle the dry cake mix over the pineapple.",
      "Melt 1/2 cup of the butter and pour evenly over the top of the cake mix.",
      "Cut",
      "Take the remaining 1/2 cup of butter and cut into small pieces. Place the pieces of butter over the top of the cake.",
      "Bake the cake in the preheated oven until the top is golden brown and the filling is bubbling around the edges, about 40 minutes.",
      "Serve the cake warm with ice cream, if desired."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Prep\nPreheat the oven to 325ºF. Spray a 9x13-inch baking dish with nonstick cooking spray.\nSpread the pie filling in the bottom of the baking dish.\nPour\nEvenly pour the pineapple over the top of the cherry pie filling.\nSprinkle the dry cake mix over the pineapple.\nMelt 1/2 cup of the butter and pour evenly over the top of the cake mix.\nCut\nTake the remaining 1/2 cup of butter and cut into small pieces. Place the pieces of butter over the top of the cake.\nBake the cake in the preheated oven until the top is golden brown and the filling is bubbling around the edges, about 40 minutes.\nServe the cake warm with ice cream, if desired.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("tasteandtellblog.com")
    expect(recipe.canonical_url).to eq("https://www.tasteandtellblog.com/dump-cake-recipe/")
    expect(recipe.site_name).to eq("Taste and Tell")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Deborah")
    expect(recipe.description).to eq("A blast from the past, this easy Dump Cake recipe only takes 4 ingredients. Switch up the filling ingredients depending on what you have on hand or what your favorite flavor is. A scoop of ice cream on top takes it to another level!")
    expect(recipe.image).to eq("https://www.tasteandtellblog.com/wp-content/uploads/2020/02/Dump-Cake-recipe-7.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(40)
    expect(recipe.keywords).to eq(["dump cake"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.73)
    expect(recipe.ratings_count).to eq(54)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 /12 of cake",
      "calories" => "434 kcal",
      "sugarContent" => "13 g",
      "sodiumContent" => "277 mg",
      "fatContent" => "25 g",
      "saturatedFatContent" => "12 g",
      "carbohydrateContent" => "48 g",
      "proteinContent" => "3 g",
      "cholesterolContent" => "96 mg",
      "unsaturatedFatContent" => "5 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: nil, amount: 0.08333333333333333 },
      { name: "calories", unit: "kcal", amount: 434.0 },
      { name: "sugarContent", unit: "g", amount: 13.0 },
      { name: "sodiumContent", unit: "mg", amount: 277.0 },
      { name: "fatContent", unit: "g", amount: 25.0 },
      { name: "saturatedFatContent", unit: "g", amount: 12.0 },
      { name: "carbohydrateContent", unit: "g", amount: 48.0 },
      { name: "proteinContent", unit: "g", amount: 3.0 },
      { name: "cholesterolContent", unit: "mg", amount: 96.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 5.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
