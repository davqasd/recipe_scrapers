# frozen_string_literal: true

RSpec.describe "hellofresh.ca" do
  subject(:recipe) { scrape_cassette("ca/hellofresh", url: "https://www.hellofresh.ca/recipes/nutritionists-pick-pan-fried-salmon-with-roasted-carrots-and-parsnips-69e1088a6bb16e39e1b8f4b3") }

  it "reads the title" do
    expect(recipe.title).to eq("Nutritionist's Pick: Pan-Fried Salmon with Roasted Carrots and Parsnips and Toasted Pepitas")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "250 g Salmon Fillets, skin-on",
      "2 unit(s) Carrot",
      "2 unit(s) Parsnip",
      "28 g Pepitas",
      "7 g Parsley",
      "1 unit(s) Lemon",
      "6 g Smoked Paprika-Garlic Blend",
      "1 unit(s) Red Onion",
      "1 unit(s) Honey",
      "4 tbsp Plant-Based Mayonnaise",
      "3.5 g Zesty Garlic Blend",
      "2 tbsp Oil*",
      "¼ tsp Salt*",
      "0.13 tsp Pepper*"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 250.0, unit: "g", name: "Salmon Fillets, skin-on" },
      { amount: 2.0, unit: nil, name: "unit Carrot" },
      { amount: 2.0, unit: nil, name: "unit Parsnip" },
      { amount: 28.0, unit: "g", name: "Pepitas" },
      { amount: 7.0, unit: "g", name: "Parsley" },
      { amount: 1.0, unit: nil, name: "unit Lemon" },
      { amount: 6.0, unit: "g", name: "Smoked Paprika-Garlic Blend" },
      { amount: 1.0, unit: nil, name: "unit Red Onion" },
      { amount: 1.0, unit: nil, name: "unit Honey" },
      { amount: 4.0, unit: "tbsp", name: "Plant-Based Mayonnaise" },
      { amount: 3.5, unit: "g", name: "Zesty Garlic Blend" },
      { amount: 2.0, unit: "tbsp", name: "Oil*" },
      { amount: 0.25, unit: "tsp", name: "Salt*" },
      { amount: 0.13, unit: "tsp", name: "Pepper*" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Before starting, preheat the oven to 450°F. Wash and dry all produce. Peel, then halve carrot lengthwise. Cut into 1/2-inch half-moons. Peel, then cut parsnips into 1/2-inch rounds. Peel, then cut onion into 2-inch pieces. To a parchment-lined baking sheet, add carrots, onions, parsnips, honey and 1 tbsp (2 tbsp) olive oil. Season with salt and pepper, then toss to combine. Roast in the middle of the oven for 20-22 min, stirring halfway through, until golden.",
      "Meanwhile, zest, then juice half the lemon. Cut the remaining lemon into wedges. Roughly chop parsley.",
      "Heat a large non-stick pan over medium. When hot, add pepitas to the dry pan. Toast for 3-4 min, stirring often, until golden. (TIP: Keep your eye on them so they don't burn!) Transfer to a plate.",
      "Pat salmon dry with paper towels. Season with Smoked Paprika-Garlic Blend, salt and pepper. Reheat the large non-stick pan over medium-high. When hot, add 1 tbsp (2 tbsp) olive oil, then salmon. Pan-fry for 2-3 min per side, until salmon is cooked through.**",
      "To a small bowl, add plant-based mayo, half the Zesty Garlic Blend (use all for 4 servings), half the parsley, lemon zest and lemon juice. Season with salt and pepper, then stir to combine.",
      "Divide salmon between plates. Serve roasted veggies alongside. Sprinkle pepitas and remaining parsley over top of veggies. Dollop some lemon aioli and squeeze lemon wedge over salmon.",
      "If you've opted to get salmon, pat salmon dry with paper towels and season in the same way the recipe instructs you to season tilapia. Decrease pan-frying time to 2-3 min per side.**"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Before starting, preheat the oven to 450°F. Wash and dry all produce. Peel, then halve carrot lengthwise. Cut into 1/2-inch half-moons. Peel, then cut parsnips into 1/2-inch rounds. Peel, then cut onion into 2-inch pieces. To a parchment-lined baking sheet, add carrots, onions, parsnips, honey and 1 tbsp (2 tbsp) olive oil. Season with salt and pepper, then toss to combine. Roast in the middle of the oven for 20-22 min, stirring halfway through, until golden.\nMeanwhile, zest, then juice half the lemon. Cut the remaining lemon into wedges. Roughly chop parsley.\nHeat a large non-stick pan over medium. When hot, add pepitas to the dry pan. Toast for 3-4 min, stirring often, until golden. (TIP: Keep your eye on them so they don't burn!) Transfer to a plate.\nPat salmon dry with paper towels. Season with Smoked Paprika-Garlic Blend, salt and pepper. Reheat the large non-stick pan over medium-high. When hot, add 1 tbsp (2 tbsp) olive oil, then salmon. Pan-fry for 2-3 min per side, until salmon is cooked through.**\nTo a small bowl, add plant-based mayo, half the Zesty Garlic Blend (use all for 4 servings), half the parsley, lemon zest and lemon juice. Season with salt and pepper, then stir to combine.\nDivide salmon between plates. Serve roasted veggies alongside. Sprinkle pepitas and remaining parsley over top of veggies. Dollop some lemon aioli and squeeze lemon wedge over salmon.\nIf you've opted to get salmon, pat salmon dry with paper towels and season in the same way the recipe instructs you to season tilapia. Decrease pan-frying time to 2-3 min per side.**")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hellofresh.ca")
    expect(recipe.canonical_url).to eq("https://www.hellofresh.ca/recipes/nutritionists-pick-pan-fried-salmon-with-roasted-carrots-and-parsnips-6980d53acb2a0d32532a5785")
    expect(recipe.site_name).to eq("HelloFresh")
    expect(recipe.language).to eq("en-CA")
    expect(recipe.author).to eq("HelloFresh")
    expect(recipe.description).to eq("Ingredients: Parsnip • Carrot • Tilapia fillets • Red onion • Lemon • Plant-based mayonnaise (mustard) (canola and/or soya oil, water, sugar, modified corn starch, salt, white vinegar, mustard flour, concentrated lemon juice, cellulose gum, xanthan gum, citric acid, calcium disodium EDTA, turmeric extract) • Pepitas • Honey • Parsley • Zesty garlic blend (sulphites) (granulated garlic, cornmeal, salt, dehydrated red bell pepper flakes, spices, sugar, herbs, canola oil, silicon dioxide, citric acid) • Smoked paprika-garlic blend (sulphites) (smoked paprika, garlic powder, silicon dioxide).")
    expect(recipe.image).to eq("https://img.hellofresh.com/f_auto,fl_lossy,h_640,q_auto,w_1200/hellofresh_s3/image/HFCARC_RF49435-1_Hero_PanFriedTilapiaWithRoastedCarrotsAndParsnipsAndToastedPumpkinSeeds_W01_1087_2026_low_Web-5e49b291.jpg")
    expect(recipe.category).to eq("main course")
    expect(recipe.cuisine).to eq("Canadian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.374999973509047)
    expect(recipe.ratings_count).to eq(36)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "890 kcal",
      "fatContent" => "55 g",
      "saturatedFatContent" => "8 g",
      "carbohydrateContent" => "69 g",
      "sugarContent" => "27 g",
      "proteinContent" => "35 g",
      "fiberContent" => "15 g",
      "cholesterolContent" => "75 mg",
      "sodiumContent" => "670 mg",
      "servingSize" => "640"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 890.0 },
      { name: "fatContent", unit: "g", amount: 55.0 },
      { name: "saturatedFatContent", unit: "g", amount: 8.0 },
      { name: "carbohydrateContent", unit: "g", amount: 69.0 },
      { name: "sugarContent", unit: "g", amount: 27.0 },
      { name: "proteinContent", unit: "g", amount: 35.0 },
      { name: "fiberContent", unit: "g", amount: 15.0 },
      { name: "cholesterolContent", unit: "mg", amount: 75.0 },
      { name: "sodiumContent", unit: "mg", amount: 670.0 },
      { name: "servingSize", unit: nil, amount: 640.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#page")
  end
end
