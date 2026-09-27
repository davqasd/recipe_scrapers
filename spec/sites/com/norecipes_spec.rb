# frozen_string_literal: true

RSpec.describe "norecipes.com" do
  subject(:recipe) { scrape_cassette("com/norecipes", url: "https://norecipes.com/burnt-basque-cheesecake/") }

  it "reads the title" do
    expect(recipe.title).to eq("Best Burnt Basque Cheesecake")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "226 grams cream cheese (cold)",
      "1 cup heavy cream (cold)",
      "100 grams granulated sugar",
      "2 large eggs (cold)",
      "15 grams cake flour",
      "1/2 teaspoon vanilla extract"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 226.0, unit: "grams", name: "cream cheese" },
      { amount: 1.0, unit: "cup", name: "heavy cream" },
      { amount: 100.0, unit: "grams", name: "granulated sugar" },
      { amount: 2.0, unit: nil, name: "large eggs" },
      { amount: 15.0, unit: "grams", name: "cake flour" },
      { amount: 0.5, unit: "teaspoon", name: "vanilla extract" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven",
      "Preheat the oven to the 450°F (230°C).",
      "Line pan with parchment paper",
      "Line a 6-inch cake pan with 2.5-inch sides with parchment paper. If the pan has a removable bottom, you can use the bottom to press the paper into the pan. Then you can use your hands to crease the sides to hold its shape. Once the paper is molded to the pan, you can remove the bottom and the paper and then reattach the bottom to the pan, placing the paper on top.",
      "Mix cheesecake batter",
      "Add 226 grams cream cheese, 1 cup heavy cream, 100 grams granulated sugar, 2 large eggs, 15 grams cake flour, and 1/2 teaspoon vanilla extract to a blender and blend until smooth. I usually let this mixture rest for about 20 minutes to give the air bubbles in the batter a chance to settle, but you can bake it right away if you're in a rush.",
      "Transfer batter to pan",
      "Pour the mixture into the prepared pan and then drop the pan a few times onto a kitchen towel to coax any remaining bubbles out of the batter.",
      "Bake Basque Cheesecake",
      "Bake the cheesecake until the top is just shy of turning black. This takes 22 minutes in my oven but this will vary on your oven (see headnotes above for more information). The cake should still be very jiggly in the center when you remove it from the oven.",
      "Cool and rest",
      "Let the burnt cheesecake cool on a cooling rack and then place it in a sealable bag and refrigerate overnight.",
      "Slice Basque Cheesecake",
      "To slice the Basque Cheesecake, prepare a long sharp knife along with a pot of boiling water. Clean and heat the knife with the hot water between each slice. This ensures you get nice clean slices."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven\nPreheat the oven to the 450°F (230°C).\nLine pan with parchment paper\nLine a 6-inch cake pan with 2.5-inch sides with parchment paper. If the pan has a removable bottom, you can use the bottom to press the paper into the pan. Then you can use your hands to crease the sides to hold its shape. Once the paper is molded to the pan, you can remove the bottom and the paper and then reattach the bottom to the pan, placing the paper on top.\nMix cheesecake batter\nAdd 226 grams cream cheese, 1 cup heavy cream, 100 grams granulated sugar, 2 large eggs, 15 grams cake flour, and 1/2 teaspoon vanilla extract to a blender and blend until smooth. I usually let this mixture rest for about 20 minutes to give the air bubbles in the batter a chance to settle, but you can bake it right away if you're in a rush.\nTransfer batter to pan\nPour the mixture into the prepared pan and then drop the pan a few times onto a kitchen towel to coax any remaining bubbles out of the batter.\nBake Basque Cheesecake\nBake the cheesecake until the top is just shy of turning black. This takes 22 minutes in my oven but this will vary on your oven (see headnotes above for more information). The cake should still be very jiggly in the center when you remove it from the oven.\nCool and rest\nLet the burnt cheesecake cool on a cooling rack and then place it in a sealable bag and refrigerate overnight.\nSlice Basque Cheesecake\nTo slice the Basque Cheesecake, prepare a long sharp knife along with a pot of boiling water. Clean and heat the knife with the hot water between each slice. This ensures you get nice clean slices.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("norecipes.com")
    expect(recipe.canonical_url).to eq("https://norecipes.com/burnt-basque-cheesecake/")
    expect(recipe.site_name).to eq("Norecipes - Elevating Everyday Meals")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Marc Matsumoto")
    expect(recipe.description).to eq("With a caramelized top that borders on burnt and a rich and creamy center, Burnt Basque Cheesecake (Tarta de Queso) is a mind-blowingly delicious combination of textures and tastes that comes together with little effort from just a handful of ingredients.")
    expect(recipe.image).to eq("https://norecipes.com/wp-content/uploads/2024/01/burnt-basque-cheesecake-001.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("Best")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(27)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(22)
    expect(recipe.keywords).to eq(["cake", "cheesecake", "party food", "sweets"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.5)
    expect(recipe.ratings_count).to eq(288)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "362 kcal",
      "carbohydrateContent" => "22 g",
      "proteinContent" => "6 g",
      "fatContent" => "29 g",
      "saturatedFatContent" => "17 g",
      "transFatContent" => "0.01 g",
      "cholesterolContent" => "137 mg",
      "sodiumContent" => "150 mg",
      "fiberContent" => "0.1 g",
      "sugarContent" => "19 g",
      "unsaturatedFatContent" => "9 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 362.0 },
      { name: "carbohydrateContent", unit: "g", amount: 22.0 },
      { name: "proteinContent", unit: "g", amount: 6.0 },
      { name: "fatContent", unit: "g", amount: 29.0 },
      { name: "saturatedFatContent", unit: "g", amount: 17.0 },
      { name: "transFatContent", unit: "g", amount: 0.01 },
      { name: "cholesterolContent", unit: "mg", amount: 137.0 },
      { name: "sodiumContent", unit: "mg", amount: 150.0 },
      { name: "fiberContent", unit: "g", amount: 0.1 },
      { name: "sugarContent", unit: "g", amount: 19.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 9.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://norecipes.com/")
  end
end
