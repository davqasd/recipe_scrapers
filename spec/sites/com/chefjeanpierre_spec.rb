# frozen_string_literal: true

RSpec.describe "chefjeanpierre.com" do
  subject(:recipe) { scrape_cassette("com/chefjeanpierre", url: "https://chefjeanpierre.com/potato-recipes/pommes-boulangere/") }

  it "reads the title" do
    expect(recipe.title).to eq("Pommes Boulangère: aka Baker's Potatoes Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "6 medium Yellow Onions (thinly sliced with the grain and cut into shorter pieces)",
      "2 tbsp clarified butter or olive oil - 30 ml (taken from the 6 tablespoons total)",
      "1 tsp Kosher salt (taken from the 2 teaspoons total)",
      "Ground black pepper or white pepper (taken from the ½ teaspoon total)",
      "4 lbs Yukon Gold potatoes — 1.8 kg",
      "4 tbsp Remaining clarified butter or olive oil - 60 ml",
      "2 tbsp Fresh thyme leaves, divided — 6 g",
      "1 tsp Kosher Salt (taken from the 2 teaspoons total)",
      "ground black pepper or white pepper (as needed)",
      "1½ cups homemade beef stock, chicken stock, or vegetable stock, as needed — 350 ml"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 6.0, unit: nil, name: "medium Yellow Onions" },
      { amount: 2.0, unit: "tbsp", name: "clarified butter or olive oil - 30 ml" },
      { amount: 1.0, unit: "tsp", name: "Kosher salt" },
      { amount: nil, unit: nil, name: "Ground black pepper or white pepper" },
      { amount: 4.0, unit: "lbs", name: "Yukon Gold potatoes — 1.8 kg" },
      { amount: 4.0, unit: "tbsp", name: "Remaining clarified butter or olive oil - 60 ml" },
      { amount: 2.0, unit: "tbsp", name: "Fresh thyme leaves, divided — 6 g" },
      { amount: 1.0, unit: "tsp", name: "Kosher Salt" },
      { amount: nil, unit: nil, name: "ground black pepper or white pepper" },
      { amount: 1.5, unit: "cups", name: "homemade beef stock, chicken stock, or vegetable stock, as needed — 350 ml" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Prepare the Onions",
      "Peel the onions and cut them in half from top to root.",
      "Thinly slice the onions with the grain, from root to stem rather than across the grain. This helps the onions retain some structure as they cook.",
      "Cut the long onion slices in half. If using especially large onions, cut them into thirds. Keeping the pieces shorter will make the finished Pommes Boulangère easier to portion and eat.",
      "Caramelize the Onions",
      "Heat 2 tablespoons clarified butter or olive oil in a wide sauté pan over medium-high heat.",
      "Add the sliced onions and season with some of the salt and pepper.",
      "Spread the onions across the pan in an even layer. A wide pan is important because it allows moisture to escape rather than collecting and steaming the onions.",
      "Cook for approximately 20 to 30 minutes, turning or tossing the onions about every 2 minutes.",
      "Continue cooking until the onions are: * Soft * Sweet * Deeply golden * Reduced considerably in volume",
      "Watch them carefully toward the end of cooking because they can brown quickly once much of their moisture has evaporated.",
      "Transfer the onions to a wide tray or pan and spread them out. Allow the heat and steam to escape until the onions are cool enough to handle comfortably.",
      "Prepare the Potatoes",
      "Peel the potatoes and keep them completely submerged in cold water until you are ready to slice them.",
      "Remove one potato at a time and dry it thoroughly.",
      "Using a mandoline or very sharp knife, slice the potatoes approximately:¹⁄₁₆ inch / 2 mm thick",
      "Do not rinse the potato slices. The natural starch remaining on the potatoes helps the layers hold together during cooking.",
      "Prepare the Baking Dish",
      "Preheat the oven to 275°F / 135°C.",
      "Lightly butter a 10-inch oven-safe pie pan or round baking dish.",
      "Have a piece of parchment paper ready to make a cartouche that will sit directly on top of the potatoes during the first stage of baking.",
      "Build the First Potato Layer",
      "Brush the bottom and sides of the baking dish with melted clarified butter.",
      "Arrange overlapping potato slices across the entire bottom of the dish.",
      "Make sure there are no empty spaces. This first layer forms the base of the Pommes Boulangère.",
      "Season lightly with: * Salt * Pepper * A small amount of fresh thyme",
      "Drizzle in a small amount of stock.",
      "Spread a thin layer of caramelized onions over the potatoes.",
      "Keep most of the onions slightly away from the outside edge of the dish for a cleaner finished appearance.",
      "Continue Building the Layers",
      "Continue layering the ingredients in the following order: 1. Potatoes 2. Light seasoning of salt and pepper 3. Fresh thyme 4. A little clarified butter 5. A little stock 6. Caramelized onionsRepeat until the ingredients are nearly used.",
      "Finish the Top",
      "Finish with an attractive overlapping layer of potato slices.",
      "Press the potatoes down firmly but carefully to compact all of the layers.",
      "Gradually add the remaining stock.",
      "Give the stock time to filter down through the potato layers.The potatoes should be thoroughly moistened but not completely submerged.",
      "Brush the top generously with clarified butter.",
      "Sprinkle with a small amount of fresh thyme.",
      "Cover the Potatoes",
      "Place a parchment-paper cartouche directly against the surface of the potatoes.",
      "Cover the baking dish with a tight-fitting lid.",
      "If you do not have a suitable lid, cover the baking dish tightly with aluminum foil.",
      "First Bake - Covered",
      "Bake at: 275°F / 135°C for 1 hour",
      "After 1 hour, remove the baking dish from the oven.Remove: * The lid or foil * The parchment-paper cartoucheThe potatoes may still feel somewhat firm at this stage.",
      "Second Bake - Uncovered",
      "Return the potatoes to the 275°F / 135°C oven uncovered.Bake for another: 30 to 45 minutes",
      "During this stage: * The top develops color. * Some of the remaining stock evaporates. * The potatoes finish cooking. * The remaining liquid becomes concentrated and is absorbed by the potatoes.",
      "Rest and Absorb the Stock",
      "Remove the finished Pommes Boulangère from the oven and allow it to rest.",
      "Do not be concerned if some liquid remains visible immediately after baking.",
      "As the potatoes cool, they continue absorbing the flavorful stock and onion juices.",
      "The dish can be served the same day after resting, but it will be softer and more difficult to portion cleanly.",
      "Cool and Refrigerate",
      "Allow the potatoes to cool completely.",
      "Cover the baking dish.",
      "Refrigerate overnight.",
      "Reheat the following day:",
      "Preheat the oven to 250°F / 120°C.",
      "Cover the potatoes.",
      "Reheat for approximately 45 minutes, or until the center reaches: 150°F / 65°C",
      "Watch the surface while reheating. If it begins becoming too brown, place another parchment-paper cartouche directly over the top.",
      "Finish and Serve",
      "Brush the warm potatoes lightly with clarified butter.",
      "Garnish with fresh thyme leaves.",
      "Cut into wedges or generous portions.",
      "Serve warm."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["For the Caramelized Onions", 4],
        ["For the Potatoes and Layers", 6]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Prepare the Onions\nPeel the onions and cut them in half from top to root.\nThinly slice the onions with the grain, from root to stem rather than across the grain. This helps the onions retain some structure as they cook.\nCut the long onion slices in half. If using especially large onions, cut them into thirds. Keeping the pieces shorter will make the finished Pommes Boulangère easier to portion and eat.\nCaramelize the Onions\nHeat 2 tablespoons clarified butter or olive oil in a wide sauté pan over medium-high heat.\nAdd the sliced onions and season with some of the salt and pepper.\nSpread the onions across the pan in an even layer. A wide pan is important because it allows moisture to escape rather than collecting and steaming the onions.\nCook for approximately 20 to 30 minutes, turning or tossing the onions about every 2 minutes.\nContinue cooking until the onions are: * Soft * Sweet * Deeply golden * Reduced considerably in volume\nWatch them carefully toward the end of cooking because they can brown quickly once much of their moisture has evaporated.\nTransfer the onions to a wide tray or pan and spread them out. Allow the heat and steam to escape until the onions are cool enough to handle comfortably.\nPrepare the Potatoes\nPeel the potatoes and keep them completely submerged in cold water until you are ready to slice them.\nRemove one potato at a time and dry it thoroughly.\nUsing a mandoline or very sharp knife, slice the potatoes approximately:¹⁄₁₆ inch / 2 mm thick\nDo not rinse the potato slices. The natural starch remaining on the potatoes helps the layers hold together during cooking.\nPrepare the Baking Dish\nPreheat the oven to 275°F / 135°C.\nLightly butter a 10-inch oven-safe pie pan or round baking dish.\nHave a piece of parchment paper ready to make a cartouche that will sit directly on top of the potatoes during the first stage of baking.\nBuild the First Potato Layer\nBrush the bottom and sides of the baking dish with melted clarified butter.\nArrange overlapping potato slices across the entire bottom of the dish.\nMake sure there are no empty spaces. This first layer forms the base of the Pommes Boulangère.\nSeason lightly with: * Salt * Pepper * A small amount of fresh thyme\nDrizzle in a small amount of stock.\nSpread a thin layer of caramelized onions over the potatoes.\nKeep most of the onions slightly away from the outside edge of the dish for a cleaner finished appearance.\nContinue Building the Layers\nContinue layering the ingredients in the following order: 1. Potatoes 2. Light seasoning of salt and pepper 3. Fresh thyme 4. A little clarified butter 5. A little stock 6. Caramelized onionsRepeat until the ingredients are nearly used.\nFinish the Top\nFinish with an attractive overlapping layer of potato slices.\nPress the potatoes down firmly but carefully to compact all of the layers.\nGradually add the remaining stock.\nGive the stock time to filter down through the potato layers.The potatoes should be thoroughly moistened but not completely submerged.\nBrush the top generously with clarified butter.\nSprinkle with a small amount of fresh thyme.\nCover the Potatoes\nPlace a parchment-paper cartouche directly against the surface of the potatoes.\nCover the baking dish with a tight-fitting lid.\nIf you do not have a suitable lid, cover the baking dish tightly with aluminum foil.\nFirst Bake - Covered\nBake at: 275°F / 135°C for 1 hour\nAfter 1 hour, remove the baking dish from the oven.Remove: * The lid or foil * The parchment-paper cartoucheThe potatoes may still feel somewhat firm at this stage.\nSecond Bake - Uncovered\nReturn the potatoes to the 275°F / 135°C oven uncovered.Bake for another: 30 to 45 minutes\nDuring this stage: * The top develops color. * Some of the remaining stock evaporates. * The potatoes finish cooking. * The remaining liquid becomes concentrated and is absorbed by the potatoes.\nRest and Absorb the Stock\nRemove the finished Pommes Boulangère from the oven and allow it to rest.\nDo not be concerned if some liquid remains visible immediately after baking.\nAs the potatoes cool, they continue absorbing the flavorful stock and onion juices.\nThe dish can be served the same day after resting, but it will be softer and more difficult to portion cleanly.\nCool and Refrigerate\nAllow the potatoes to cool completely.\nCover the baking dish.\nRefrigerate overnight.\nReheat the following day:\nPreheat the oven to 250°F / 120°C.\nCover the potatoes.\nReheat for approximately 45 minutes, or until the center reaches: 150°F / 65°C\nWatch the surface while reheating. If it begins becoming too brown, place another parchment-paper cartouche directly over the top.\nFinish and Serve\nBrush the warm potatoes lightly with clarified butter.\nGarnish with fresh thyme leaves.\nCut into wedges or generous portions.\nServe warm.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("chefjeanpierre.com")
    expect(recipe.canonical_url).to eq("https://chefjeanpierre.com/potato-recipes/pommes-boulangere/")
    expect(recipe.site_name).to eq("Chef Jean-Pierre")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Chef Jean-Pierre")
    expect(recipe.description).to eq("Pommes Boulangère is one of those magnificent old-fashioned dishes made from the simplest ingredients: potatoes, caramelized onions, fresh thyme, butter and flavorful stock. The potatoes cook slowly until meltingly tender while the onions add deep sweetness and the top develops a beautiful golden finish. The name means “potatoes in the baker’s style,” recalling the French village tradition of bringing prepared dishes to the baker after the bread was finished so they could cook in the oven’s remaining heat. Simple ingredients—but certainly not simple flavor!")
    expect(recipe.image).to eq("https://eadn-wc02-12309146.nxedge.io/wp-content/uploads/2026/09/Boulangere-Poatoes-Chef-Jean-Pierre.jpg")
    expect(recipe.category).to eq("Side Dish")
    expect(recipe.cuisine).to eq("French")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(210)
    expect(recipe.prep_time).to eq(60)
    expect(recipe.cook_time).to eq(130)
    expect(recipe.keywords).to eq(["baker's potatoes", "French Baker's Wife Potatoes", "French Onion Potato Bake", "Pommes Boulangère"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "313.8 kcal",
      "carbohydrateContent" => "48.29 g",
      "proteinContent" => "6.5 g",
      "fatContent" => "11.55 g",
      "saturatedFatContent" => "7.08 g",
      "cholesterolContent" => "28.8 mg",
      "sodiumContent" => "1850.5 mg",
      "fiberContent" => "6.64 g",
      "sugarContent" => "5.51 g",
      "unsaturatedFatContent" => "3.8 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 313.8 },
      { name: "carbohydrateContent", unit: "g", amount: 48.29 },
      { name: "proteinContent", unit: "g", amount: 6.5 },
      { name: "fatContent", unit: "g", amount: 11.55 },
      { name: "saturatedFatContent", unit: "g", amount: 7.08 },
      { name: "cholesterolContent", unit: "mg", amount: 28.8 },
      { name: "sodiumContent", unit: "mg", amount: 1850.5 },
      { name: "fiberContent", unit: "g", amount: 6.64 },
      { name: "sugarContent", unit: "g", amount: 5.51 },
      { name: "unsaturatedFatContent", unit: "g", amount: 3.8 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#A_Classic_French_Potato_Onion_Bake_the_Most_Delicious_Potatoes_in_the_World")
  end
end
