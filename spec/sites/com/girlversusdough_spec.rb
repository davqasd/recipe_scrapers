# frozen_string_literal: true

RSpec.describe "girlversusdough.com" do
  subject(:recipe) { scrape_cassette("com/girlversusdough", url: "https://www.girlversusdough.com/apple-pie-filling-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Apple Pie Filling Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 lbs apples (a variety of sweet & tart (honeycrisp, braeburn, macoun, Cortland, pink lady, etc.))",
      "1 lemon",
      "¾ cup granulated sugar",
      "½ cup light brown sugar (packed)",
      "1 teaspoon ground cinnamon",
      "1 tablespoon cornstarch",
      "2 tablespoons unsalted butter (cubed)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "lbs", name: "apples" },
      { amount: 1.0, unit: nil, name: "lemon" },
      { amount: 0.75, unit: "cup", name: "granulated sugar" },
      { amount: 0.5, unit: "cup", name: "light brown sugar" },
      { amount: 1.0, unit: "teaspoon", name: "ground cinnamon" },
      { amount: 1.0, unit: "tablespoon", name: "cornstarch" },
      { amount: 2.0, unit: "tablespoons", name: "unsalted butter" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Peel, core, and slice apples to about 1/8th inch thick. Place the apples in a large bowl.",
      "Zest the lemon over the apples and then squeeze the juice into the bowl of apples.",
      "Add the granulated white sugar, light brown sugar, and cinnamon to the apples. Toss together with a spoon until each apple slice has an even coating.",
      "Add the apple mixture and any accumulated juices in a large saucepan or Dutch oven. Cook on medium heat.",
      "Cook until the apples are crisp but tender. They will be softened but not mushy, opaque, and have a little crunch.",
      "In a small bowl, whisk together cornstarch and one tablespoon of water. Pour it into the hot filling while you stir.",
      "After adding the cornstarch, allow the filling to boil for 1 minute. This will immediately thicken the filling. When you add the cornstarch slurry, the filling will turn white, and you will know it’s cooked when it becomes opaque again. Add the butter for a silky finish.",
      "Pour the filling onto a parchment paper-lined deep baking sheet or dish.",
      "Refrigerate until the filling has cooled completely. Once cold, transfer to clean jars or another airtight container, or fill your favorite pie crust and bake that apple pie!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Peel, core, and slice apples to about 1/8th inch thick. Place the apples in a large bowl.\nZest the lemon over the apples and then squeeze the juice into the bowl of apples.\nAdd the granulated white sugar, light brown sugar, and cinnamon to the apples. Toss together with a spoon until each apple slice has an even coating.\nAdd the apple mixture and any accumulated juices in a large saucepan or Dutch oven. Cook on medium heat.\nCook until the apples are crisp but tender. They will be softened but not mushy, opaque, and have a little crunch.\nIn a small bowl, whisk together cornstarch and one tablespoon of water. Pour it into the hot filling while you stir.\nAfter adding the cornstarch, allow the filling to boil for 1 minute. This will immediately thicken the filling. When you add the cornstarch slurry, the filling will turn white, and you will know it’s cooked when it becomes opaque again. Add the butter for a silky finish.\nPour the filling onto a parchment paper-lined deep baking sheet or dish.\nRefrigerate until the filling has cooled completely. Once cold, transfer to clean jars or another airtight container, or fill your favorite pie crust and bake that apple pie!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("girlversusdough.com")
    expect(recipe.canonical_url).to eq("https://www.girlversusdough.com/apple-pie-filling-recipe/")
    expect(recipe.site_name).to eq("Girl Versus Dough")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Lindsey Farr")
    expect(recipe.description).to eq("This Apple Pie Filling is super easy to make and is flavored with cinnamon and light brown sugar for a warm fall flavor. This filing is perfect for pies, tarts, bars, cakes, and more!")
    expect(recipe.image).to eq("https://www.girlversusdough.com/wp-content/uploads/2024/09/apple-pie-filling-open-jar.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["apple dessert", "apple pie", "fruit filling"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(5)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "164 kcal",
      "sugarContent" => "33 g",
      "sodiumContent" => "4 mg",
      "fatContent" => "2 g",
      "saturatedFatContent" => "1 g",
      "transFatContent" => "0.1 g",
      "carbohydrateContent" => "39 g",
      "fiberContent" => "3 g",
      "proteinContent" => "0.4 g",
      "cholesterolContent" => "5 mg",
      "unsaturatedFatContent" => "1.1 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 164.0 },
      { name: "sugarContent", unit: "g", amount: 33.0 },
      { name: "sodiumContent", unit: "mg", amount: 4.0 },
      { name: "fatContent", unit: "g", amount: 2.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "transFatContent", unit: "g", amount: 0.1 },
      { name: "carbohydrateContent", unit: "g", amount: 39.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "proteinContent", unit: "g", amount: 0.4 },
      { name: "cholesterolContent", unit: "mg", amount: 5.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 1.1 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
