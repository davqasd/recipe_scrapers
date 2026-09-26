# frozen_string_literal: true

RSpec.describe "practicalselfreliance.com" do
  subject(:recipe) { scrape_cassette("com/practicalselfreliance", url: "https://creativecanning.com/zucchini-relish/") }

  it "reads the title" do
    expect(recipe.title).to eq("Zucchini Relish Recipe for Canning")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups zucchini (diced (about 3 medium))",
      "1 cup onion (diced (about 1 medium))",
      "1 cup red bell pepper (diced (about 2 small or 1 large))",
      "2 Tbsp salt (pickling and canning salt, or kosher salt)",
      "1 3/4 cup sugar",
      "2 tsp celery seed (whole)",
      "1 tsp mustard seed (whole)",
      "1 cup cider vinegar (5% acidity)",
      "Pickle Crisp Granules (optional, helps veggies stay firm after canning)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "zucchini" },
      { amount: 1.0, unit: "cup", name: "onion" },
      { amount: 1.0, unit: "cup", name: "red bell pepper" },
      { amount: 2.0, unit: "Tbsp", name: "salt" },
      { amount: 1.75, unit: "cup", name: "sugar" },
      { amount: 2.0, unit: "tsp", name: "celery seed" },
      { amount: 1.0, unit: "tsp", name: "mustard seed" },
      { amount: 1.0, unit: "cup", name: "cider vinegar" },
      { amount: nil, unit: nil, name: "Pickle Crisp Granules" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Wash vegetables.",
      "Remove stem and blossom ends from zucchini and dice into 1/4 to 1/2 inch pieces. Measure 2 cups.",
      "Peel and dice onion. Measure 1 cup.",
      "Stem and seed peppers, then dice. Measure 1 cup.",
      "Important, don't skip this step! Combine diced vegetables in a large bowl and sprinkle salt over the top. Stir gently to distribute the salt, then add water until vegetables are completely submerged. Allow the vegetables to soak in the saltwater for 2 hours, then drain completely.",
      "Prepare a water bath canner (optional, only if canning).",
      "In a separate saucepan or stockpot, bring vinegar, sugar, and spices to a gentle simmer (180 degrees F). Do not add salt, the salt is only used to soak veggies before draining.",
      "Add drained vegetables to the simmering vinegar/spices and gently simmer for 10 minutes.",
      "Pack hot relish into prepared half-pint or pint jars, leaving 1/2 inch headspace.",
      "If not canning, just seal jars and allow them to cool on the counter before storing in the refrigerator.",
      "If canning, de-bubble jars, wipe rims, and adjust headspace to ensure 1/2 inch. Seal with 2 part canning lids.",
      "Process in a water bath canner for 10 minutes, then turn off the heat. Allow the jars to sit in the canner for another 5 minutes to cool slightly, then remove the jars to cool on a towel on the counter.",
      "Leave the jars undisturbed for 24 hours, then check seals. Store any unsealed jars in the refrigerator for immediate use. Properly canned and sealed jars should maintain peak quality on the pantry shelf for 12-18 months."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Wash vegetables.\nRemove stem and blossom ends from zucchini and dice into 1/4 to 1/2 inch pieces. Measure 2 cups.\nPeel and dice onion. Measure 1 cup.\nStem and seed peppers, then dice. Measure 1 cup.\nImportant, don't skip this step! Combine diced vegetables in a large bowl and sprinkle salt over the top. Stir gently to distribute the salt, then add water until vegetables are completely submerged. Allow the vegetables to soak in the saltwater for 2 hours, then drain completely.\nPrepare a water bath canner (optional, only if canning).\nIn a separate saucepan or stockpot, bring vinegar, sugar, and spices to a gentle simmer (180 degrees F). Do not add salt, the salt is only used to soak veggies before draining.\nAdd drained vegetables to the simmering vinegar/spices and gently simmer for 10 minutes.\nPack hot relish into prepared half-pint or pint jars, leaving 1/2 inch headspace.\nIf not canning, just seal jars and allow them to cool on the counter before storing in the refrigerator.\nIf canning, de-bubble jars, wipe rims, and adjust headspace to ensure 1/2 inch. Seal with 2 part canning lids.\nProcess in a water bath canner for 10 minutes, then turn off the heat. Allow the jars to sit in the canner for another 5 minutes to cool slightly, then remove the jars to cool on a towel on the counter.\nLeave the jars undisturbed for 24 hours, then check seals. Store any unsealed jars in the refrigerator for immediate use. Properly canned and sealed jars should maintain peak quality on the pantry shelf for 12-18 months.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("creativecanning.com")
    expect(recipe.canonical_url).to eq("https://creativecanning.com/zucchini-relish/")
    expect(recipe.site_name).to eq("Creative Canning")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Ashley Adamant")
    expect(recipe.description).to eq("Zucchini relish is a flavorful topping for summer grilling, and the perfect way to use up extra zucchini from the garden.")
    expect(recipe.image).to eq("https://creativecanning.com/wp-content/uploads/2021/02/Zucchini-Relish-61.jpg")
    expect(recipe.category).to eq("Relish")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("32 servings")
    expect(recipe.total_time).to eq(150)
    expect(recipe.prep_time).to eq(130)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq(["zucchini canning recipes"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.47)
    expect(recipe.ratings_count).to eq(13)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "49 kcal",
      "carbohydrateContent" => "12 g",
      "proteinContent" => "0.2 g",
      "fatContent" => "0.1 g",
      "saturatedFatContent" => "0.02 g",
      "sodiumContent" => "438 mg",
      "fiberContent" => "0.3 g",
      "sugarContent" => "12 g",
      "unsaturatedFatContent" => "0.07 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 49.0 },
      { name: "carbohydrateContent", unit: "g", amount: 12.0 },
      { name: "proteinContent", unit: "g", amount: 0.2 },
      { name: "fatContent", unit: "g", amount: 0.1 },
      { name: "saturatedFatContent", unit: "g", amount: 0.02 },
      { name: "sodiumContent", unit: "mg", amount: 438.0 },
      { name: "fiberContent", unit: "g", amount: 0.3 },
      { name: "sugarContent", unit: "g", amount: 12.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 0.07 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
