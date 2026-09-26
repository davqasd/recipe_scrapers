# frozen_string_literal: true

RSpec.describe "cakewhiz.com" do
  subject(:recipe) { scrape_cassette("com/cakewhiz", url: "https://cakewhiz.com/blueberry-pie-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy Blueberry Pie")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 package Refrigerated pie crust (Contains 2 pie crusts)",
      "5 cups Fresh blueberries (Or frozen but not thawed)",
      "2/3 cup Granulated sugar",
      "1 tsp Lemon zest (Optional but highly recommended)",
      "1/4 tsp Cinnamon powder (Optional but highly recommended)",
      "4.5 tbsp Cornstarch"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "package", name: "Refrigerated pie crust" },
      { amount: 5.0, unit: "cups", name: "Fresh blueberries" },
      { amount: 0.67, unit: "cup", name: "Granulated sugar" },
      { amount: 1.0, unit: "tsp", name: "Lemon zest" },
      { amount: 0.25, unit: "tsp", name: "Cinnamon powder" },
      { amount: 4.5, unit: "tbsp", name: "Cornstarch" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Unfold one pie crust and spread it in a 9 inch pie dish. Trim and crimp the edges. Keep aside.",
      "In a large mixing bowl, add blueberries, sugar, lemon zest, cinnamon, cornstarch and mix.",
      "Spread this blueberry mixture evenly in the prepared pie crust.",
      "Unfold the other pie crust and place it on top of the blueberries. Trim and crimp the edges to make a double crust pie. Use a knife to make slits for venting. (Instead of this, you can also do a lattice top with strip of pie crusts).",
      "Cover the pie crust edges with aluminum foil and place the dish on a baking tray.",
      "Bake at 425 degrees F for 10 minutes on the middle rack.",
      "Then, lower the temperature to 350 degrees F and bake for another 40-45 minutes or until crust is golden brown.",
      "Allow this pie to cool down completely (3-5 hours). I like to chill it overnight. Enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Unfold one pie crust and spread it in a 9 inch pie dish. Trim and crimp the edges. Keep aside.\nIn a large mixing bowl, add blueberries, sugar, lemon zest, cinnamon, cornstarch and mix.\nSpread this blueberry mixture evenly in the prepared pie crust.\nUnfold the other pie crust and place it on top of the blueberries. Trim and crimp the edges to make a double crust pie. Use a knife to make slits for venting. (Instead of this, you can also do a lattice top with strip of pie crusts).\nCover the pie crust edges with aluminum foil and place the dish on a baking tray.\nBake at 425 degrees F for 10 minutes on the middle rack.\nThen, lower the temperature to 350 degrees F and bake for another 40-45 minutes or until crust is golden brown.\nAllow this pie to cool down completely (3-5 hours). I like to chill it overnight. Enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cakewhiz.com")
    expect(recipe.canonical_url).to eq("https://cakewhiz.com/blueberry-pie-recipe/")
    expect(recipe.site_name).to eq("CakeWhiz")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Abeer Rizvi")
    expect(recipe.description).to eq("A classic, easy Summer blueberry pie recipe, homemade with simple ingredients: Perfect flaky crust is filled with stable fresh or frozen blueberry filling.")
    expect(recipe.image).to eq("https://cakewhiz.com/wp-content/uploads/2019/06/Easy-Blueberry-Pie-Recipe.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(55)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(45)
    expect(recipe.keywords).to eq(["homemade", "summer dessert", "summer pie"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(8)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "386 kcal",
      "carbohydrateContent" => "61 g",
      "proteinContent" => "4 g",
      "fatContent" => "14 g",
      "saturatedFatContent" => "4 g",
      "sodiumContent" => "226 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "25 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 386.0 },
      { name: "carbohydrateContent", unit: "g", amount: 61.0 },
      { name: "proteinContent", unit: "g", amount: 4.0 },
      { name: "fatContent", unit: "g", amount: 14.0 },
      { name: "saturatedFatContent", unit: "g", amount: 4.0 },
      { name: "sodiumContent", unit: "mg", amount: 226.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 25.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-content")
  end
end
