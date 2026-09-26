# frozen_string_literal: true

RSpec.describe "everydaypie.com" do
  subject(:recipe) { scrape_cassette("com/everydaypie", url: "https://everydaypie.com/caramelized-onion-tarts/") }

  it "reads the title" do
    expect(recipe.title).to eq("Caramelized Onion Tarts")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "½ batch rough puff pastry or classic puff pastry (or store-bought, see notes)",
      "3 large onions, sliced thin",
      "2 tablespoons olive oil",
      "¼ teaspoon salt",
      "1 tablespoon balsamic vinegar",
      "3 ounces crumbled feta (about ¾ cup)",
      "egg wash (1 egg whisked with a teaspoon of water)",
      "1 small bunch of chives, sliced fine"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.5, unit: "batch", name: "rough puff pastry or classic puff pastry" },
      { amount: 3.0, unit: nil, name: "large onions, sliced thin" },
      { amount: 2.0, unit: "tablespoons", name: "olive oil" },
      { amount: 0.25, unit: "teaspoon", name: "salt" },
      { amount: 1.0, unit: "tablespoon", name: "balsamic vinegar" },
      { amount: 3.0, unit: "ounces", name: "crumbled feta" },
      { amount: nil, unit: nil, name: "egg wash" },
      { amount: 1.0, unit: "bunch", name: "chives, sliced fine" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Prepare rough puff pastry or defrost frozen puff pastry. If you make it, you will only need half a batch. The remaining half can be frozen. Or you can double the filling for this recipe, and make 24 tarts.",
      "Make the caramelized onions",
      "Heat oil in a wide, heavy-bottomed pan on medium heat. Add onions and cook for 10 minutes, stirring a few times to make sure all of the onions get contact with the pan and start to soften. Add pinch of salt and stir to combine. Lower the heat to medium low and let onions sit undisturbed for 20 minutes. Continue to cook for 15 more minutes at this point, stirring the pan every 5 minutes for a total of 3 times. Stir in balsamic vinegar and cook for about 5 more minutes. This is the point where the onions have the optimum texture and taste. If you’d like your onions to be completely reduced and jammy, cook for another 10-15 minutes, but this is optional! Let the onions cool to room temperature.",
      "In a small bowl mix together the onions and feta and set aside.",
      "Line a 13x18” sheet pan with a piece of parchment and preheat the oven to 400ºF.",
      "Roll out the puff pastry on a floured surface (remember, you are only using half of the batch if you've made this rough puff recipe) to about ⅛” thickness, or about a 10” by 14” rectangle. Or if you are using store-bought, then simply remove it from the package according to the instructions and lay it out on a lightly floured surface so the puff doesn’t stick to the counter.",
      "Using a 3-inch circle cutter (or similar), stamp out the pastry. You should be able to stamp out at least 12 circles or more. I don't recommend re-rolling the scraps for this purpose, but you can save them for something else.",
      "Now dock the pastry: Using a 2” cutter (or similar) make an indentation in the center of the circle of pastry, but make sure not to press all the way through. Repeat with all of the pastry. And finally, take a fork and dock the middle of the pastry to prevent the dough from rising too much during baking.",
      "Place the pastry on the sheet pan evenly spaced apart. Brush the edges with an egg wash.",
      "Place a heaping tablespoon of onion and feta mixture in the center circle.",
      "Bake on the middle rack for 15-18 minutes, or until the pastry is puffed and lightly golden.",
      "Remove the tarts from the oven, and let them cool slightly before transferring to a cooling rack.",
      "Sprinkle with sliced chives and serve warm or room temperature."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Prepare rough puff pastry or defrost frozen puff pastry. If you make it, you will only need half a batch. The remaining half can be frozen. Or you can double the filling for this recipe, and make 24 tarts.\nMake the caramelized onions\nHeat oil in a wide, heavy-bottomed pan on medium heat. Add onions and cook for 10 minutes, stirring a few times to make sure all of the onions get contact with the pan and start to soften. Add pinch of salt and stir to combine. Lower the heat to medium low and let onions sit undisturbed for 20 minutes. Continue to cook for 15 more minutes at this point, stirring the pan every 5 minutes for a total of 3 times. Stir in balsamic vinegar and cook for about 5 more minutes. This is the point where the onions have the optimum texture and taste. If you’d like your onions to be completely reduced and jammy, cook for another 10-15 minutes, but this is optional! Let the onions cool to room temperature.\nIn a small bowl mix together the onions and feta and set aside.\nLine a 13x18” sheet pan with a piece of parchment and preheat the oven to 400ºF.\nRoll out the puff pastry on a floured surface (remember, you are only using half of the batch if you've made this rough puff recipe) to about ⅛” thickness, or about a 10” by 14” rectangle. Or if you are using store-bought, then simply remove it from the package according to the instructions and lay it out on a lightly floured surface so the puff doesn’t stick to the counter.\nUsing a 3-inch circle cutter (or similar), stamp out the pastry. You should be able to stamp out at least 12 circles or more. I don't recommend re-rolling the scraps for this purpose, but you can save them for something else.\nNow dock the pastry: Using a 2” cutter (or similar) make an indentation in the center of the circle of pastry, but make sure not to press all the way through. Repeat with all of the pastry. And finally, take a fork and dock the middle of the pastry to prevent the dough from rising too much during baking.\nPlace the pastry on the sheet pan evenly spaced apart. Brush the edges with an egg wash.\nPlace a heaping tablespoon of onion and feta mixture in the center circle.\nBake on the middle rack for 15-18 minutes, or until the pastry is puffed and lightly golden.\nRemove the tarts from the oven, and let them cool slightly before transferring to a cooling rack.\nSprinkle with sliced chives and serve warm or room temperature.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("everydaypie.com")
    expect(recipe.canonical_url).to eq("https://everydaypie.com/caramelized-onion-tarts/")
    expect(recipe.site_name).to eq("Everyday Pie")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Kelli Avila")
    expect(recipe.description).to eq("Salty, sweet, crunchy, and so delicious, these Caramelized Onion Tarts made with puff pastry are the perfect celebratory appetizer or snack.")
    expect(recipe.image).to eq("https://everydaypie.com/wp-content/uploads/2022/06/Caramelized-Onion-Tarts-14-225x225.jpg")
    expect(recipe.category).to eq("Pastry")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to eq("Bake")
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(80)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(60)
    expect(recipe.keywords).to eq(["Caramelized Onions Tarts"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
