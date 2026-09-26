# frozen_string_literal: true

RSpec.describe "thealmondeater.com" do
  subject(:recipe) { scrape_cassette("com/thealmondeater", url: "https://thealmondeater.com/grandmas-polish-pierogi-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Grandma's Polish Pierogi Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2.5 lb. russet potatoes (peeled and diced into large chunks)",
      "8 oz. shredded sharp cheddar cheese (preferably freshly grated)",
      "1 small onion (minced)",
      "1/2 cup butter (plus more for frying)",
      "4 1/2 cups all purpose flour",
      "1 tsp salt",
      "1/2 tsp baking powder",
      "1 egg",
      "2 tsp olive oil",
      "2 cups warm water"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.5, unit: "lb", name: "russet potatoes" },
      { amount: 8.0, unit: "oz", name: "shredded sharp cheddar cheese" },
      { amount: 1.0, unit: nil, name: "small onion" },
      { amount: 0.5, unit: "cup", name: "butter" },
      { amount: 4.5, unit: "cups", name: "all purpose flour" },
      { amount: 1.0, unit: "tsp", name: "salt" },
      { amount: 0.5, unit: "tsp", name: "baking powder" },
      { amount: 1.0, unit: nil, name: "egg" },
      { amount: 2.0, unit: "tsp", name: "olive oil" },
      { amount: 2.0, unit: "cups", name: "warm water" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Cook the potatoes in a pot of boiling water until form tender. Drain, then place them in a large bowl.",
      "While the potatoes are cooking, melt the butter in a large skillet, then add the onion and sauté until soft, 5-6 minutes. Pour the butter/onion mixture into the bowl with the potatoes, then add the cheese and use a potato masher to mash everything together until the cheese is melted. The mixture will be thick! Add salt and pepper to taste. Allow the potatoes to cool before using them.",
      "While the potatoes are cooling, make the dough: stir the flour, salt and baking powder together in a large bowl. Then, whisk the eggs and olive oil together then pour them into the bowl and stir to combine. Pour the water in 1 cup at a time, using your hands to mix everything together. The dough will be very sticky at first, but after you knead it for 2-3 minutes, it should pull away from your hands.",
      "Next, flour a clean surface or silpat mat, then pour the dough out onto it and divide it into two balls. Sett the one ball of dough aside and keep the other one on the mat. Use a rolling pin to roll the dough out so that it's 1/4\" thick, then use a 3\" circle cookie cutter to cut out round circles of dough and place them on a clean dish towel. Re-roll the dough until it's finished, then repeat the same process with the second ball of dough. You should end up with around 24 circles.",
      "To make a pierogi: use your hands to slightly stretch one of the dough circles out a bit, then add a spoonful of the cheesy potatoes in the middle. Fold up the two ends like a taco and pinch them together. Add a little more potato filling into both sides, then use your fingers to seal the pierogi shut on all sides. Use the back of a spoon to scallop the dough, which will ensure none of the potato filling comes out when they're cooking. Repeat this step for all of the dough circles. You may have a little bit of the cheesy potatoes leftover and that's ok!",
      "While you're making the pierogies, bring a large pot of salted water to a boil. Then, drop 6 pierogies into the water and cook them until they rise to the top, approx. 5 minutes. Use a slotted spoon to remove them and place them on a clean kitchen towel, then cover them with another towel so they don't dry out.",
      "The final step is to fry them: melt 2 tablespoons of butter in a large skillet over medium heat, then add the pierogies and cook them for 2-3 minutes on the first side, then flip them over and cook for 1-2 minutes on the second side until they're golden brown. NOTE: you'll need to add more butter as you go and possibly wipe out the skillet in between batches to ensure they brown properly.",
      "Serve pierogies with drizzled melted butter, sour cream and/or chopped chives and enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Cook the potatoes in a pot of boiling water until form tender. Drain, then place them in a large bowl.\nWhile the potatoes are cooking, melt the butter in a large skillet, then add the onion and sauté until soft, 5-6 minutes. Pour the butter/onion mixture into the bowl with the potatoes, then add the cheese and use a potato masher to mash everything together until the cheese is melted. The mixture will be thick! Add salt and pepper to taste. Allow the potatoes to cool before using them.\nWhile the potatoes are cooling, make the dough: stir the flour, salt and baking powder together in a large bowl. Then, whisk the eggs and olive oil together then pour them into the bowl and stir to combine. Pour the water in 1 cup at a time, using your hands to mix everything together. The dough will be very sticky at first, but after you knead it for 2-3 minutes, it should pull away from your hands.\nNext, flour a clean surface or silpat mat, then pour the dough out onto it and divide it into two balls. Sett the one ball of dough aside and keep the other one on the mat. Use a rolling pin to roll the dough out so that it's 1/4\" thick, then use a 3\" circle cookie cutter to cut out round circles of dough and place them on a clean dish towel. Re-roll the dough until it's finished, then repeat the same process with the second ball of dough. You should end up with around 24 circles.\nTo make a pierogi: use your hands to slightly stretch one of the dough circles out a bit, then add a spoonful of the cheesy potatoes in the middle. Fold up the two ends like a taco and pinch them together. Add a little more potato filling into both sides, then use your fingers to seal the pierogi shut on all sides. Use the back of a spoon to scallop the dough, which will ensure none of the potato filling comes out when they're cooking. Repeat this step for all of the dough circles. You may have a little bit of the cheesy potatoes leftover and that's ok!\nWhile you're making the pierogies, bring a large pot of salted water to a boil. Then, drop 6 pierogies into the water and cook them until they rise to the top, approx. 5 minutes. Use a slotted spoon to remove them and place them on a clean kitchen towel, then cover them with another towel so they don't dry out.\nThe final step is to fry them: melt 2 tablespoons of butter in a large skillet over medium heat, then add the pierogies and cook them for 2-3 minutes on the first side, then flip them over and cook for 1-2 minutes on the second side until they're golden brown. NOTE: you'll need to add more butter as you go and possibly wipe out the skillet in between batches to ensure they brown properly.\nServe pierogies with drizzled melted butter, sour cream and/or chopped chives and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thealmondeater.com")
    expect(recipe.canonical_url).to eq("https://thealmondeater.com/grandmas-polish-pierogi-recipe/")
    expect(recipe.site_name).to eq("The Almond Eater")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Erin Alvarez")
    expect(recipe.description).to eq("Learn how to make traditional Pierogi Ruskie following my grandma's polish Pierogi Recipe! Dough is filled with potatoes and cheese, then pan-seared in butter, making them the perfect recipe for the holidays or year-round.")
    expect(recipe.image).to eq("https://thealmondeater.com/wp-content/uploads/2022/12/pierogi-recipe_web-15.jpg")
    expect(recipe.category).to eq("dinner")
    expect(recipe.cuisine).to eq("Polish")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("24 servings")
    expect(recipe.total_time).to eq(120)
    expect(recipe.prep_time).to eq(60)
    expect(recipe.cook_time).to eq(60)
    expect(recipe.keywords).to eq(["pierogi recipe", "pierogies", "polish pierogi"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["VegetarianDiet"])
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(15)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "202 kcal",
      "carbohydrateContent" => "27 g",
      "proteinContent" => "6 g",
      "fatContent" => "8 g",
      "saturatedFatContent" => "4 g",
      "transFatContent" => "0.2 g",
      "cholesterolContent" => "26 mg",
      "sodiumContent" => "203 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "1 g",
      "unsaturatedFatContent" => "2.4 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 202.0 },
      { name: "carbohydrateContent", unit: "g", amount: 27.0 },
      { name: "proteinContent", unit: "g", amount: 6.0 },
      { name: "fatContent", unit: "g", amount: 8.0 },
      { name: "saturatedFatContent", unit: "g", amount: 4.0 },
      { name: "transFatContent", unit: "g", amount: 0.2 },
      { name: "cholesterolContent", unit: "mg", amount: 26.0 },
      { name: "sodiumContent", unit: "mg", amount: 203.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 2.4 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
