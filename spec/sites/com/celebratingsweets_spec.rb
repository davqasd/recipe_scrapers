# frozen_string_literal: true

RSpec.describe "celebratingsweets.com" do
  subject(:recipe) { scrape_cassette("com/celebratingsweets", url: "https://celebratingsweets.com/berries-and-cream-trifle/") }

  it "reads the title" do
    expect(recipe.title).to eq("Berry Trifle Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 1/2 cups cold heavy cream",
      "1/2 cup powdered sugar",
      "1 1/2 teaspoons pure vanilla extract",
      "1/4 teaspoon almond extract",
      "8 - 10 cups cubed pound cake or angel food cake (see note)",
      "16 ounces strawberries (sliced)",
      "6 ounces raspberries",
      "6 ounces blackberries",
      "6 ounces blueberries",
      "1/2 cup raspberry or strawberry jam (heated just enough to make it pourable (not hot))"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.5, unit: "cups", name: "cold heavy cream" },
      { amount: 0.5, unit: "cup", name: "powdered sugar" },
      { amount: 1.5, unit: "teaspoons", name: "pure vanilla extract" },
      { amount: 0.25, unit: "teaspoon", name: "almond extract" },
      { amount: 8.0, unit: "cups", name: "cubed pound cake or angel food cake" },
      { amount: 16.0, unit: "ounces", name: "strawberries" },
      { amount: 6.0, unit: "ounces", name: "raspberries" },
      { amount: 6.0, unit: "ounces", name: "blackberries" },
      { amount: 6.0, unit: "ounces", name: "blueberries" },
      { amount: 0.5, unit: "cup", name: "raspberry or strawberry jam" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "With a hand mixer or stand mixer fitted with a whisk attachment, beat heavy cream*, powdered sugar, vanilla and almond extract until soft peaks form, this will take several minutes. Keep the whipped cream refrigerated while you assemble the other components of the recipe.",
      "In a large trifle dish (or individual glasses), layer the cake, whipped cream, berries, and jam. You can layer it anyway you like. I did the following (from the bottom up): whipped cream, cake, berries, whipped cream, cake, jam, whipped cream, berries."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("With a hand mixer or stand mixer fitted with a whisk attachment, beat heavy cream*, powdered sugar, vanilla and almond extract until soft peaks form, this will take several minutes. Keep the whipped cream refrigerated while you assemble the other components of the recipe.\nIn a large trifle dish (or individual glasses), layer the cake, whipped cream, berries, and jam. You can layer it anyway you like. I did the following (from the bottom up): whipped cream, cake, berries, whipped cream, cake, jam, whipped cream, berries.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("celebratingsweets.com")
    expect(recipe.canonical_url).to eq("https://celebratingsweets.com/berries-and-cream-trifle/")
    expect(recipe.site_name).to eq("Celebrating Sweets")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Allison Mattina")
    expect(recipe.description).to eq("This easy trifle includes layers of cake, fresh berries, and whipped cream. Take a shortcut with store bought pound cake or angel food cake, or make your own. You'll love this simple and beautiful red, white, and blue dessert!")
    expect(recipe.image).to eq("https://celebratingsweets.com/wp-content/uploads/2015/06/Berries-Cream-Trifle-2.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("Dessert")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to eq(25)
    expect(recipe.cook_time).to eq(5)
    expect(recipe.keywords).to eq(["Trifle"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(9)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "399 kcal",
      "carbohydrateContent" => "46 g",
      "proteinContent" => "5 g",
      "fatContent" => "22 g",
      "saturatedFatContent" => "13 g",
      "cholesterolContent" => "81 mg",
      "sodiumContent" => "279 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "26 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 399.0 },
      { name: "carbohydrateContent", unit: "g", amount: 46.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "fatContent", unit: "g", amount: 22.0 },
      { name: "saturatedFatContent", unit: "g", amount: 13.0 },
      { name: "cholesterolContent", unit: "mg", amount: 81.0 },
      { name: "sodiumContent", unit: "mg", amount: 279.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 26.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://celebratingsweets.com/")
  end
end
