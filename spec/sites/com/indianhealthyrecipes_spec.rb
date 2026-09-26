# frozen_string_literal: true

RSpec.describe "indianhealthyrecipes.com" do
  subject(:recipe) { scrape_cassette("com/indianhealthyrecipes", url: "https://www.indianhealthyrecipes.com/banana-cake-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Banana Cake Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups (240 grams) all-purpose flour (or wheat flour (refer notes))",
      "2 ½ teaspoons (12.5 g) baking powder",
      "½ teaspoon salt (or ⅓ teaspoon table salt)",
      "1 cup (200 grams) fine sugar (prefer organic)",
      "100 grams (3.53 oz) unsalted butter ((soft & cold) )",
      "2 eggs",
      "2 teaspoons (10 ml) vanilla extract",
      "160 ml milk",
      "1 cup ripe banana (mashed)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "all-purpose flour" },
      { amount: 2.5, unit: "teaspoons", name: "baking powder" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 1.0, unit: "cup", name: "fine sugar" },
      { amount: 100.0, unit: "grams", name: "unsalted butter" },
      { amount: 2.0, unit: nil, name: "eggs" },
      { amount: 2.0, unit: "teaspoons", name: "vanilla extract" },
      { amount: 160.0, unit: "ml", name: "milk" },
      { amount: 1.0, unit: "cup", name: "ripe banana" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preparation",
      "Bring all the ingredients to room temperature except butter before you begin to prepare the batter.",
      "Butter has to be cold, yet soft and should hold its structure. To check press the block of cold butter with your finger, it should dent slightly yet hold its solid structure and should not be too soft.",
      "Grease a 8 by 8 inch cake tray and line with parchment paper. If you do not have a parchment paper, you may sprinkle flour all over the tray including the sides. Invert and dust off the excess in your kitchen sink.",
      "Preheat the oven to 170 C or 340 F for at least 15 minutes. If you have a fan forced oven then preheat to 160 C or 320 F.",
      "Fluff up the flour in the jar/ pack with a fork. Then spoon it to the measuring cup and level it with a knife or a straight edged spoon. Sieve flour, baking powder and salt. Set aside.",
      "How To Make Banana Cake",
      "Make sure butter is soft but still cold before this step. Add butter and sugar to a mixing bowl. Using a whisk, beat together until light, pale & fluffy.",
      "Pour vanilla extract and add 1 egg at a time and beat just until creamy.",
      "Add the other egg and beat again just until creamy.",
      "Next add the sieved flour, salt and baking powder. Mix it gently.",
      "Adding milk in 2 batches, mix the flour on a medium speed until smooth. Do not over mix it.",
      "Add banana puree and mix until just combined. Avoid over mixing.",
      "Pour the batter to a lined cake tray and knock it against the counter a few times. Bake for 25 to 30 mins if using a 8 by 8 square pan. If using a different size pan, then the timing varies.",
      "A skewer/ tester inserted in the center of the cake comes out clean when the cake is done.",
      "Place the cake pan on a wired rack and cool for 10 minutes. Then invert the banana cake on the wire rack.",
      "Cool completely before slicing. Serve banana cake plain with milk or tea."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preparation\nBring all the ingredients to room temperature except butter before you begin to prepare the batter.\nButter has to be cold, yet soft and should hold its structure. To check press the block of cold butter with your finger, it should dent slightly yet hold its solid structure and should not be too soft.\nGrease a 8 by 8 inch cake tray and line with parchment paper. If you do not have a parchment paper, you may sprinkle flour all over the tray including the sides. Invert and dust off the excess in your kitchen sink.\nPreheat the oven to 170 C or 340 F for at least 15 minutes. If you have a fan forced oven then preheat to 160 C or 320 F.\nFluff up the flour in the jar/ pack with a fork. Then spoon it to the measuring cup and level it with a knife or a straight edged spoon. Sieve flour, baking powder and salt. Set aside.\nHow To Make Banana Cake\nMake sure butter is soft but still cold before this step. Add butter and sugar to a mixing bowl. Using a whisk, beat together until light, pale & fluffy.\nPour vanilla extract and add 1 egg at a time and beat just until creamy.\nAdd the other egg and beat again just until creamy.\nNext add the sieved flour, salt and baking powder. Mix it gently.\nAdding milk in 2 batches, mix the flour on a medium speed until smooth. Do not over mix it.\nAdd banana puree and mix until just combined. Avoid over mixing.\nPour the batter to a lined cake tray and knock it against the counter a few times. Bake for 25 to 30 mins if using a 8 by 8 square pan. If using a different size pan, then the timing varies.\nA skewer/ tester inserted in the center of the cake comes out clean when the cake is done.\nPlace the cake pan on a wired rack and cool for 10 minutes. Then invert the banana cake on the wire rack.\nCool completely before slicing. Serve banana cake plain with milk or tea.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("indianhealthyrecipes.com")
    expect(recipe.canonical_url).to eq("https://www.indianhealthyrecipes.com/banana-cake-recipe/")
    expect(recipe.site_name).to eq("Swasthi's Recipes")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("swasthi")
    expect(recipe.description).to eq("Soft, moist & fluffy banana cake - Easy to make and tastes delicious. Serve it with milk or as a snack with some melted chocolate drizzled over it.")
    expect(recipe.image).to eq("https://www.indianhealthyrecipes.com/wp-content/uploads/2021/01/banana-cake-recipe.jpg")
    expect(recipe.category).to eq("Dessert / Sweet")
    expect(recipe.cuisine).to eq("world")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("16 servings")
    expect(recipe.total_time).to eq(50)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(40)
    expect(recipe.keywords).to eq(["Banana cake", "banana cake recipe"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.98)
    expect(recipe.ratings_count).to eq(419)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "123 kcal",
      "carbohydrateContent" => "14 g",
      "proteinContent" => "3 g",
      "fatContent" => "6 g",
      "saturatedFatContent" => "3 g",
      "cholesterolContent" => "34 mg",
      "sodiumContent" => "129 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "2 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 123.0 },
      { name: "carbohydrateContent", unit: "g", amount: 14.0 },
      { name: "proteinContent", unit: "g", amount: 3.0 },
      { name: "fatContent", unit: "g", amount: 6.0 },
      { name: "saturatedFatContent", unit: "g", amount: 3.0 },
      { name: "cholesterolContent", unit: "mg", amount: 34.0 },
      { name: "sodiumContent", unit: "mg", amount: 129.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
