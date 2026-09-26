# frozen_string_literal: true

RSpec.describe "crazyforcrust.com" do
  subject(:recipe) { scrape_cassette("com/crazyforcrust", url: "https://www.crazyforcrust.com/classic-pound-cake-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy Pound Cake Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 ½ cups (339g) unsalted butter (softened)",
      "2 ¾ cups (550g) granulated sugar",
      "6 large eggs (room temperature)",
      "½ teaspoon baking powder",
      "1 teaspoon vanilla extract",
      "1 teaspoon salt",
      "¾ cup (184g) sour cream (room temperature)",
      "3 cups (372g) all purpose flour",
      "2 tablespoons (16g) cornstarch"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.5, unit: "cups", name: "unsalted butter" },
      { amount: 2.75, unit: "cups", name: "granulated sugar" },
      { amount: 6.0, unit: nil, name: "large eggs" },
      { amount: 0.5, unit: "teaspoon", name: "baking powder" },
      { amount: 1.0, unit: "teaspoon", name: "vanilla extract" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: 0.75, unit: "cup", name: "sour cream" },
      { amount: 3.0, unit: "cups", name: "all purpose flour" },
      { amount: 2.0, unit: "tablespoons", name: "cornstarch" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 350°F. Grease and flour a 10-inch fluted bundt pan (or spray well with the nonstick cooking spray that has flour in it).",
      "Place butter and sugar in the bowl of a stand mixer fitted with the paddle attachment. Cream the mixture for a few minutes, or until it’s light and fluffy and light in color.",
      "Mix in the eggs, one at a time, beating just until the egg is mixed in before adding the next one.",
      "Add baking powder, vanilla extract, and salt and stir, then add the sour cream, cornstarch and flour. Mix just until combined.",
      "Pour mixture into prepared pan. Bake for about 55-65 minutes or until a toothpick comes out clean from close to the middle of the cake.",
      "Let cool 15 minutes then turn out onto serving plate and cool completely. (The cake will come out easier when it’s warm.)",
      "Dust cooled cake with powdered sugar for serving. Store in an airtight container for up to 4 days."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 350°F. Grease and flour a 10-inch fluted bundt pan (or spray well with the nonstick cooking spray that has flour in it).\nPlace butter and sugar in the bowl of a stand mixer fitted with the paddle attachment. Cream the mixture for a few minutes, or until it’s light and fluffy and light in color.\nMix in the eggs, one at a time, beating just until the egg is mixed in before adding the next one.\nAdd baking powder, vanilla extract, and salt and stir, then add the sour cream, cornstarch and flour. Mix just until combined.\nPour mixture into prepared pan. Bake for about 55-65 minutes or until a toothpick comes out clean from close to the middle of the cake.\nLet cool 15 minutes then turn out onto serving plate and cool completely. (The cake will come out easier when it’s warm.)\nDust cooled cake with powdered sugar for serving. Store in an airtight container for up to 4 days.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("crazyforcrust.com")
    expect(recipe.canonical_url).to eq("https://www.crazyforcrust.com/classic-pound-cake-recipe/")
    expect(recipe.site_name).to eq("Crazy for Crust")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Dorothy Kern")
    expect(recipe.description).to eq("Moist and tender sour cream pound cake- it's a classic pound cake recipe, perfect with a dusting of powdered sugar.")
    expect(recipe.image).to eq("https://www.crazyforcrust.com/wp-content/uploads/2024/01/classic-pound-cake-recipe-4.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(95)
    expect(recipe.prep_time).to eq(25)
    expect(recipe.cook_time).to eq(70)
    expect(recipe.keywords).to eq(["cake"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.97)
    expect(recipe.ratings_count).to eq(58)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 serving",
      "calories" => "560 kcal",
      "carbohydrateContent" => "72 g",
      "proteinContent" => "7 g",
      "fatContent" => "28 g",
      "saturatedFatContent" => "17 g",
      "cholesterolContent" => "150 mg",
      "sodiumContent" => "241 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "46 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "serving", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 560.0 },
      { name: "carbohydrateContent", unit: "g", amount: 72.0 },
      { name: "proteinContent", unit: "g", amount: 7.0 },
      { name: "fatContent", unit: "g", amount: 28.0 },
      { name: "saturatedFatContent", unit: "g", amount: 17.0 },
      { name: "cholesterolContent", unit: "mg", amount: 150.0 },
      { name: "sodiumContent", unit: "mg", amount: 241.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 46.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
