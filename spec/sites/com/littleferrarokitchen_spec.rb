# frozen_string_literal: true

RSpec.describe "littleferrarokitchen.com" do
  subject(:recipe) { scrape_cassette("com/littleferrarokitchen", url: "https://littleferrarokitchen.com/easy-apple-strudel/") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy Apple Strudel")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 apples (peeled and chopped into 1/2 inch cubes (I used Pink Lady's))",
      "1 vanilla bean (split and seeds removed)",
      "1 lemon (zest and juiced (or small orange))",
      "1 tsp cinnamon",
      "1/4 tsp freshly grated nutmeg",
      "1/4 tsp cardamom (optional)",
      "1/4 cup sugar (more for tart apples)",
      "Pinch of salt",
      "1/2 cup cream cheese (softened)",
      "1 sheet Puff Pastry (thawed)",
      "Flour for rolling",
      "1 egg (for egg-wash)",
      "Powdered sugar (for garnish)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: nil, name: "apples" },
      { amount: 1.0, unit: nil, name: "vanilla bean" },
      { amount: 1.0, unit: nil, name: "lemon" },
      { amount: 1.0, unit: "tsp", name: "cinnamon" },
      { amount: 0.25, unit: "tsp", name: "freshly grated nutmeg" },
      { amount: 0.25, unit: "tsp", name: "cardamom" },
      { amount: 0.25, unit: "cup", name: "sugar" },
      { amount: 1.0, unit: "Pinch", name: "salt" },
      { amount: 0.5, unit: "cup", name: "cream cheese" },
      { amount: 1.0, unit: "sheet", name: "Puff Pastry" },
      { amount: nil, unit: nil, name: "Flour for rolling" },
      { amount: 1.0, unit: nil, name: "egg" },
      { amount: nil, unit: nil, name: "Powdered sugar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "First, pre-heat oven to 375 degrees F.",
      "In a large bowl, add the apples, sugar, cinnamon, vanilla, spices, salt, lemon juice and zest. Toss together and taste for seasoning. Set aside.",
      "On a lightly floured surface, unfold puff pastry and use a rolling pill to gently roll it out a bit thinner. Lay the puff pastry horizontally in front of you and spread the softened cream cheese towards the bottom 2/3 in an even thin layer.",
      "Gently pour the apples over the cream cheese, making sure no apples are poking out and any liquid is left in the bowl.",
      "Fold the top off of the puff pastry over the apples making a tight seal and place seam side down. Pinch and tuck the ends of the puff pastry under the strudel. Place on non-stick baking sheet.",
      "Lightly whisk the egg with a splash of water and brush egg-wash all over the strudel. Use a knife to cut small slits into the puff pastry.",
      "Bake at 375 degrees F for 35-40 minutes. Check strudel at 30 minutes and if it is browning on the top too quickly, cover with foil and continue baking.",
      "When done, remove from oven and allow to cool for 10 minutes, then dust with powdered sugar."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("First, pre-heat oven to 375 degrees F.\nIn a large bowl, add the apples, sugar, cinnamon, vanilla, spices, salt, lemon juice and zest. Toss together and taste for seasoning. Set aside.\nOn a lightly floured surface, unfold puff pastry and use a rolling pill to gently roll it out a bit thinner. Lay the puff pastry horizontally in front of you and spread the softened cream cheese towards the bottom 2/3 in an even thin layer.\nGently pour the apples over the cream cheese, making sure no apples are poking out and any liquid is left in the bowl.\nFold the top off of the puff pastry over the apples making a tight seal and place seam side down. Pinch and tuck the ends of the puff pastry under the strudel. Place on non-stick baking sheet.\nLightly whisk the egg with a splash of water and brush egg-wash all over the strudel. Use a knife to cut small slits into the puff pastry.\nBake at 375 degrees F for 35-40 minutes. Check strudel at 30 minutes and if it is browning on the top too quickly, cover with foil and continue baking.\nWhen done, remove from oven and allow to cool for 10 minutes, then dust with powdered sugar.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("littleferrarokitchen.com")
    expect(recipe.canonical_url).to eq("https://littleferrarokitchen.com/easy-apple-strudel/")
    expect(recipe.site_name).to eq("The Little Ferraro Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Samantha Ferraro")
    expect(recipe.description).to eq("Easy apple strudel is made with puff pastry and a thin layer of cream cheese for a touch of creaminess.")
    expect(recipe.image).to eq("https://littleferrarokitchen.com/wp-content/uploads/2014/11/AppleStrudel-2.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(70)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(40)
    expect(recipe.keywords).to eq(["easy apple strudel"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(13)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "291 kcal",
      "carbohydrateContent" => "32 g",
      "proteinContent" => "4 g",
      "fatContent" => "17 g",
      "saturatedFatContent" => "6 g",
      "transFatContent" => "1 g",
      "cholesterolContent" => "36 mg",
      "sodiumContent" => "131 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "14 g",
      "unsaturatedFatContent" => "10 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 291.0 },
      { name: "carbohydrateContent", unit: "g", amount: 32.0 },
      { name: "proteinContent", unit: "g", amount: 4.0 },
      { name: "fatContent", unit: "g", amount: 17.0 },
      { name: "saturatedFatContent", unit: "g", amount: 6.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 36.0 },
      { name: "sodiumContent", unit: "mg", amount: 131.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 14.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 10.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-content")
  end
end
