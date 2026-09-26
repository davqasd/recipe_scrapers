# frozen_string_literal: true

RSpec.describe "garlicandzest.com" do
  subject(:recipe) { scrape_cassette("com/garlicandzest", url: "https://www.garlicandzest.com/easy-banana-cake-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy Banana Cake Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup granulated sugar",
      "½ cup unsalted butter (at room temperature)",
      "2 large eggs",
      "1 cup mashed overripe bananas",
      "1 teaspoon vanilla extract",
      "2 cups all purpose flour",
      "1 teaspoon salt",
      "1½ teaspoons baking powder",
      "½ teaspoon baking soda",
      "1 teaspoon cinnamon",
      "1 cup greek yogurt"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "granulated sugar" },
      { amount: 0.5, unit: "cup", name: "unsalted butter" },
      { amount: 2.0, unit: nil, name: "large eggs" },
      { amount: 1.0, unit: "cup", name: "mashed overripe bananas" },
      { amount: 1.0, unit: "teaspoon", name: "vanilla extract" },
      { amount: 2.0, unit: "cups", name: "all purpose flour" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: 1.5, unit: "teaspoons", name: "baking powder" },
      { amount: 0.5, unit: "teaspoon", name: "baking soda" },
      { amount: 1.0, unit: "teaspoon", name: "cinnamon" },
      { amount: 1.0, unit: "cup", name: "greek yogurt" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 350° F. Spray a 9\" round baking pan or 8\" square baking pan liberally with vegetable spray.",
      "Cut a piece of parchment paper to rest evenly in the bottom of the pan with about 6\" of overhang on each side (this creates a sling which makes it easy to remove the cake when baked). Place the parchment into the prepared pan and press it lightly to the bottom and sides. Set aside.",
      "In a medium bowl, combine the flour, salt, baking powder, baking soda and cinnamon. Whisk until blended and set aside.",
      "In a large bowl, combine the butter and sugar. Use a hand mixer on medium high speed to beat until the mixture is very light and fluffy, about 2 minutes.",
      "Add the eggs and beat to combine. Add the mashed bananas and vanilla and mix well.",
      "In two additions, alternate adding half of the flour mixture followed by half of the greek. yogurt, mixing on medium speed just until combined. Finish with the remaining dry ingredients followed by the remainder of the greek yogurt.",
      "Spread the cake batter evenly into the prepared cake pan.",
      "Bake for 45-55 minutes or until a toothpick inserted into the center of the cake comes out clean.",
      "Let the cake cool for 10 minutes in the pan. Run a sharp knife around the sides to loosen the banana cake from the pan and lift the two overhanging pieces of parchment paper to transfer the banana cake to a wire rack to cool completely.",
      "Sprinkle the banana cake with powdered sugar or serve with a dollop of whipped cream.",
      "You can also frost the cake with either cream cheese frosting or whipped ermine frosting. Be sure the cake is completely cooled before frosting."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 350° F. Spray a 9\" round baking pan or 8\" square baking pan liberally with vegetable spray.\nCut a piece of parchment paper to rest evenly in the bottom of the pan with about 6\" of overhang on each side (this creates a sling which makes it easy to remove the cake when baked). Place the parchment into the prepared pan and press it lightly to the bottom and sides. Set aside.\nIn a medium bowl, combine the flour, salt, baking powder, baking soda and cinnamon. Whisk until blended and set aside.\nIn a large bowl, combine the butter and sugar. Use a hand mixer on medium high speed to beat until the mixture is very light and fluffy, about 2 minutes.\nAdd the eggs and beat to combine. Add the mashed bananas and vanilla and mix well.\nIn two additions, alternate adding half of the flour mixture followed by half of the greek. yogurt, mixing on medium speed just until combined. Finish with the remaining dry ingredients followed by the remainder of the greek yogurt.\nSpread the cake batter evenly into the prepared cake pan.\nBake for 45-55 minutes or until a toothpick inserted into the center of the cake comes out clean.\nLet the cake cool for 10 minutes in the pan. Run a sharp knife around the sides to loosen the banana cake from the pan and lift the two overhanging pieces of parchment paper to transfer the banana cake to a wire rack to cool completely.\nSprinkle the banana cake with powdered sugar or serve with a dollop of whipped cream.\nYou can also frost the cake with either cream cheese frosting or whipped ermine frosting. Be sure the cake is completely cooled before frosting.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("garlicandzest.com")
    expect(recipe.canonical_url).to eq("https://www.garlicandzest.com/easy-banana-cake-recipe/")
    expect(recipe.site_name).to eq("Garlic & Zest")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Lisa Lotts")
    expect(recipe.description).to eq("Use up those spotty brown bananas in this easy banana cake recipe. Makes one 8\" banana snack cake that's soft, moist and delicious. Garnish with a sprinkle of powdered sugar, a puff of whipped cream or a decadent cream cheese frosting. It's gonna be good, any way you slice it!")
    expect(recipe.image).to eq("https://www.garlicandzest.com/wp-content/uploads/2023/01/banana-snack-cake-15.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(65)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(50)
    expect(recipe.keywords).to eq(["overripe bananas", "snack cake"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "248 kcal",
      "carbohydrateContent" => "38 g",
      "proteinContent" => "5 g",
      "fatContent" => "9 g",
      "saturatedFatContent" => "5 g",
      "transFatContent" => "0.3 g",
      "cholesterolContent" => "52 mg",
      "sodiumContent" => "260 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "20 g",
      "unsaturatedFatContent" => "3 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 248.0 },
      { name: "carbohydrateContent", unit: "g", amount: 38.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "fatContent", unit: "g", amount: 9.0 },
      { name: "saturatedFatContent", unit: "g", amount: 5.0 },
      { name: "transFatContent", unit: "g", amount: 0.3 },
      { name: "cholesterolContent", unit: "mg", amount: 52.0 },
      { name: "sodiumContent", unit: "mg", amount: 260.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 20.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 3.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
