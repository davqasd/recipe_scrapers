# frozen_string_literal: true

RSpec.describe "vegrecipesofindia.com" do
  subject(:recipe) { scrape_cassette("com/vegrecipesofindia", url: "https://www.vegrecipesofindia.com/eggless-pineapple-cream-cake/") }

  it "reads the title" do
    expect(recipe.title).to eq("Eggless Pineapple Cake | Pineapple Pastry Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 Vanilla Cake (or sponge cake - small to medium-sized, homemade or store-brought)",
      "200 ml whipping cream (or heavy cream)",
      "¼ teaspoon vanilla extract (or pineapple essence)",
      "4 to 5 tablespoons icing sugar (or as required)",
      "2 to 3 pineapple slices (tinned or canned, finely chopped)",
      "3 to 4 pineapple slices (tinned or canned, for decoration)",
      "5 to 6 glazed cherries ( for decoration or chocolate chips, optional)",
      "2 to 3 teaspoons Pineapple Juice ( for brushing on the cake, homemade or canned, optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "Vanilla Cake" },
      { amount: 200.0, unit: "ml", name: "whipping cream" },
      { amount: 0.25, unit: "teaspoon", name: "vanilla extract" },
      { amount: 4.0, unit: "tablespoons", name: "icing sugar" },
      { amount: 2.0, unit: nil, name: "pineapple slices" },
      { amount: 3.0, unit: nil, name: "pineapple slices" },
      { amount: 5.0, unit: nil, name: "glazed cherries" },
      { amount: 2.0, unit: "teaspoons", name: "Pineapple Juice" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preparation",
      "Remove the 2 to 3 pineapple slices from the can draining the syrup in the can itself. Finely chop the pineapple slices and set aside.",
      "Slice the cake with a serrated knife from the center carefully into two equal halves.",
      "Brush the base slice of the cake with some pineapple juice. This is an optional step. If you do not have pineapple juice, brush with some sugar water. To make sugar water, simply dissolve a 2 to 3 teaspoons of sugar in 2 to 3 tablespoons of water. Mix well and use.",
      "Make Cream Frosting",
      "In a stand mixer fitted with the wired whip blade, whip the cream and icing sugar along with vanilla extract or pineapple essence, at high speed till you get stiff peaks in the cream.",
      "You can also use a hand held electric beater to whip the cream.",
      "Taste the whipped cream and add more icing sugar if needed.",
      "The cream should have stiff peaks – meaning on turning the bowl the cream should not fall.",
      "Mix the finely chopped pineapple with ¼ or ⅓ portion of the whipped cream in a separate bowl.",
      "Make Pineapple Cake",
      "Spread the pineapple cream frosting on the base slice evenly..",
      "Keep the other cake half over on top.",
      "Now spread the remaining whipped cream all over the cake on the top as well as the sides, with a palette knife or spatula evenly.",
      "Decorate the top of the cake with a few more pineapple slices.",
      "Keep the Pineapple Pastry in the refrigerator for 2 to 3 hours so that the cream icing sets.",
      "Serve the Eggless Pineapple Cake immediately.",
      "Or you can keep it covered in the fridge and then serve later.",
      "It is advisable to finish this Pineapple Cake in a day or two."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preparation\nRemove the 2 to 3 pineapple slices from the can draining the syrup in the can itself. Finely chop the pineapple slices and set aside.\nSlice the cake with a serrated knife from the center carefully into two equal halves.\nBrush the base slice of the cake with some pineapple juice. This is an optional step. If you do not have pineapple juice, brush with some sugar water. To make sugar water, simply dissolve a 2 to 3 teaspoons of sugar in 2 to 3 tablespoons of water. Mix well and use.\nMake Cream Frosting\nIn a stand mixer fitted with the wired whip blade, whip the cream and icing sugar along with vanilla extract or pineapple essence, at high speed till you get stiff peaks in the cream.\nYou can also use a hand held electric beater to whip the cream.\nTaste the whipped cream and add more icing sugar if needed.\nThe cream should have stiff peaks – meaning on turning the bowl the cream should not fall.\nMix the finely chopped pineapple with ¼ or ⅓ portion of the whipped cream in a separate bowl.\nMake Pineapple Cake\nSpread the pineapple cream frosting on the base slice evenly..\nKeep the other cake half over on top.\nNow spread the remaining whipped cream all over the cake on the top as well as the sides, with a palette knife or spatula evenly.\nDecorate the top of the cake with a few more pineapple slices.\nKeep the Pineapple Pastry in the refrigerator for 2 to 3 hours so that the cream icing sets.\nServe the Eggless Pineapple Cake immediately.\nOr you can keep it covered in the fridge and then serve later.\nIt is advisable to finish this Pineapple Cake in a day or two.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("vegrecipesofindia.com")
    expect(recipe.canonical_url).to eq("https://www.vegrecipesofindia.com/eggless-pineapple-cream-cake/")
    expect(recipe.site_name).to eq("Dassana's Veg Recipes")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Dassana Amit")
    expect(recipe.description).to eq("Pineapple Pastry is a delightful dessert bursting with sweet, tart, and tangy flavors. Fluffy and tender cake is layered with a creamy whipped frosting, and the bright taste of pineapple is in every bite.")
    expect(recipe.image).to eq("https://www.vegrecipesofindia.com/wp-content/uploads/2014/01/eggless-pineapple-cream-cake-recipe-1.jpg")
    expect(recipe.category).to eq("Desserts")
    expect(recipe.cuisine).to eq("World")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(90)
    expect(recipe.prep_time).to eq(50)
    expect(recipe.cook_time).to eq(40)
    expect(recipe.keywords).to eq(["Pineapple Cake"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["VegetarianDiet"])
    expect(recipe.ratings).to eq(4.7)
    expect(recipe.ratings_count).to eq(13)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "495 kcal",
      "carbohydrateContent" => "87 g",
      "proteinContent" => "5 g",
      "fatContent" => "15 g",
      "saturatedFatContent" => "9 g",
      "transFatContent" => "0.4 g",
      "cholesterolContent" => "38 mg",
      "sodiumContent" => "607 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "51 g",
      "unsaturatedFatContent" => "5 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 495.0 },
      { name: "carbohydrateContent", unit: "g", amount: 87.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "fatContent", unit: "g", amount: 15.0 },
      { name: "saturatedFatContent", unit: "g", amount: 9.0 },
      { name: "transFatContent", unit: "g", amount: 0.4 },
      { name: "cholesterolContent", unit: "mg", amount: 38.0 },
      { name: "sodiumContent", unit: "mg", amount: 607.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 51.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 5.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
