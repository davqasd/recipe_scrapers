# frozen_string_literal: true

RSpec.describe "bbc.co.uk" do
  subject(:recipe) { scrape_cassette("uk/bbc", url: "https://www.bbc.co.uk/food/recipes/toad_in_the_hole_with_86283") }

  it "reads the title" do
    expect(recipe.title).to eq("Toad in the hole")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "175g/6oz plain flour",
      "salt and black pepper",
      "3 free-range eggs",
      "300ml/10fl oz milk",
      "2 tbsp olive oil",
      "8 sausages",
      "1 tbsp olive oil",
      "2 onions, finely sliced",
      "½ tsp English mustard",
      "500ml/18fl oz stock (from a stock cube, ideally beef although chicken or vegetable is fine)",
      "1 Savoy cabbage, shredded, core discarded",
      "½ tbsp olive oil",
      "2 garlic cloves, peeled and finely chopped"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 175.0, unit: "g", name: "plain flour" },
      { amount: nil, unit: nil, name: "salt and black pepper" },
      { amount: 3.0, unit: nil, name: "free-range eggs" },
      { amount: 300.0, unit: "ml", name: "milk" },
      { amount: 2.0, unit: "tbsp", name: "olive oil" },
      { amount: 8.0, unit: nil, name: "sausages" },
      { amount: 1.0, unit: "tbsp", name: "olive oil" },
      { amount: 2.0, unit: nil, name: "onions, finely sliced" },
      { amount: 0.5, unit: "tsp", name: "English mustard" },
      { amount: 500.0, unit: "ml", name: "stock" },
      { amount: 1.0, unit: nil, name: "Savoy cabbage, shredded, core discarded" },
      { amount: 0.5, unit: "tbsp", name: "olive oil" },
      { amount: 2.0, unit: nil, name: "garlic cloves, peeled and finely chopped" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "For the batter, sieve the flour into a bowl and season with salt and pepper. Make a well in the middle and break in the eggs.",
      "Whisk the eggs slowly into the flour. Once combined, pour in the milk while you whisk so that you have a smooth, lump-free batter the consistency of double cream (if the batter is too thick then add a little water). Cover the batter and rest in the fridge for one hour.",
      "Preheat the oven to 200C/180C Fan/Gas 6.",
      "For the onion gravy, heat a heavy-based frying pan over a low heat. Add the oil, onions and a pinch of salt. Cook gently for 15–20 minutes, or until completely collapsed and dark golden-brown in colour. If the onions are cooking too quickly, then cover with a lid while they cook.",
      "Once the onions are completely softened and dark golden-brown, stir in the mustard and a pinch of pepper and then add the stock. Bring the mixture to the boil, reduce to a simmer and simmer for 10–15 minutes, or until the volume of liquid has reduced by half. Taste and adjust the seasoning as necessary.",
      "Put a roasting tray (about 30x20x6cm/12x8x2½in) into the preheated oven. Once really hot, add the olive oil and the sausages. Brown the sausages in the hot oven, turning now and again until coloured on all sides (they don’t need to be cooked through).",
      "Whisk the rested batter and pour it into the hot tin over the browned sausages. Return to the oven and cook for a further 30–35 minutes, or until the batter is risen and golden-brown all over.",
      "While the toad in the hole is cooking, prepare the cabbage. Wilt the shredded cabbage in a high sided frying pan or shallow saucepan with 3–4 tablespoons of water over a medium high heat for 6–8 minutes, stirring occasionally. Once the cabbage is tender pour off any excess water (or add it to the gravy).",
      "Add the oil to the pan along with the garlic. Fry over a medium high heat for 2–3 minutes, or until the garlic is softened and aromatic. Season the cabbage with salt and pepper and keep warm.",
      "Reheat the onion gravy and serve the cooked toad in the hole in wedges with the cabbage alongside."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("For the batter, sieve the flour into a bowl and season with salt and pepper. Make a well in the middle and break in the eggs.\nWhisk the eggs slowly into the flour. Once combined, pour in the milk while you whisk so that you have a smooth, lump-free batter the consistency of double cream (if the batter is too thick then add a little water). Cover the batter and rest in the fridge for one hour.\nPreheat the oven to 200C/180C Fan/Gas 6.\nFor the onion gravy, heat a heavy-based frying pan over a low heat. Add the oil, onions and a pinch of salt. Cook gently for 15–20 minutes, or until completely collapsed and dark golden-brown in colour. If the onions are cooking too quickly, then cover with a lid while they cook.\nOnce the onions are completely softened and dark golden-brown, stir in the mustard and a pinch of pepper and then add the stock. Bring the mixture to the boil, reduce to a simmer and simmer for 10–15 minutes, or until the volume of liquid has reduced by half. Taste and adjust the seasoning as necessary.\nPut a roasting tray (about 30x20x6cm/12x8x2½in) into the preheated oven. Once really hot, add the olive oil and the sausages. Brown the sausages in the hot oven, turning now and again until coloured on all sides (they don’t need to be cooked through).\nWhisk the rested batter and pour it into the hot tin over the browned sausages. Return to the oven and cook for a further 30–35 minutes, or until the batter is risen and golden-brown all over.\nWhile the toad in the hole is cooking, prepare the cabbage. Wilt the shredded cabbage in a high sided frying pan or shallow saucepan with 3–4 tablespoons of water over a medium high heat for 6–8 minutes, stirring occasionally. Once the cabbage is tender pour off any excess water (or add it to the gravy).\nAdd the oil to the pan along with the garlic. Fry over a medium high heat for 2–3 minutes, or until the garlic is softened and aromatic. Season the cabbage with salt and pepper and keep warm.\nReheat the onion gravy and serve the cooked toad in the hole in wedges with the cabbage alongside.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("bbc.co.uk")
    expect(recipe.canonical_url).to eq("https://www.bbc.co.uk/food/recipes/toad_in_the_hole_with_86283")
    expect(recipe.site_name).to eq("BBC Food")
    expect(recipe.language).to eq("en-GB")
    expect(recipe.author).to eq("Galton Blackiston")
    expect(recipe.description).to eq("You've got to love a warming toad-in-the-hole recipe when there's a nip in the air. Skip the garlic cabbage if you like and serve with another green vegetable of your choice. This is designed to be a low cost recipe. Each serving provides 665 kcal, 27.6g protein, 53.3g carbohydrate (of which 13g sugars), 36g fat (of which 11.1g saturates), 8.6g fibre and 2.47g salt.")
    expect(recipe.image).to eq("https://ichef.bbci.co.uk/food/ic/food_16x9_1600/recipes/toad_in_the_hole_with_86283_16x9.jpg")
    expect(recipe.category).to eq("Main course")
    expect(recipe.cuisine).to eq("British")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(120)
    expect(recipe.cook_time).to eq(60)
    expect(recipe.keywords).to eq(["absolute classics", "our best family favourites", "absolute bangers", "back to basics", "cheap sausage", "budget", "cheap family meals", "cheap", "easy british", "easy classics", "easy crowd-pleasers", "easy family meals", "england's finest", "family-friendly dinners", "family budget dinners under £1.50", "go retro", "retro british", "sausage suppers", "the best sausage", "winter warmers", "autumn", "bonfire night", "easy family dinners", "student food", "st george's day", "winter", "toad in the hole", "sausage", "nut free", "pregnancy friendly", "spring", "Great British Budget Menu"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(3.927710843373494)
    expect(recipe.ratings_count).to eq(166)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "665kcal",
      "proteinContent" => "27.6g",
      "carbohydrateContent" => "53.3g",
      "fatContent" => "36g",
      "fiberContent" => "8.6g",
      "saturatedFatContent" => "11.1g",
      "sugarContent" => "13g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 665.0 },
      { name: "proteinContent", unit: "g", amount: 27.6 },
      { name: "carbohydrateContent", unit: "g", amount: 53.3 },
      { name: "fatContent", unit: "g", amount: 36.0 },
      { name: "fiberContent", unit: "g", amount: 8.6 },
      { name: "saturatedFatContent", unit: "g", amount: 11.1 },
      { name: "sugarContent", unit: "g", amount: 13.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-heading")
  end
end
