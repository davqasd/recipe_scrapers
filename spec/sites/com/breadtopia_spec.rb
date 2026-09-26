# frozen_string_literal: true

RSpec.describe "breadtopia.com" do
  subject(:recipe) { scrape_cassette("com/breadtopia", url: "https://breadtopia.com/kubaneh-jewish-yemeni-bread/") }

  it "reads the title" do
    expect(recipe.title).to eq("Kubaneh (Yemenite Jewish Bread)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "Yeast Version",
      "450g bread flour (scant 3 1/2 cups)",
      "40g sugar (3 Tbsp)",
      "9g instant yeast (1 Tbsp)",
      "8g salt (1 1/2 tsp)",
      "225g water (scant 1 cup)",
      "1 egg and 1 egg white (reserve the yolk for the egg wash)",
      "To pour over the dough after mixing",
      "1 Tbsp of oil",
      "To laminate into the dough after the first rise",
      "57g softened unsalted butter (4 Tbsp)",
      "2 Tbsp of nigella seeds",
      "To brush on the dough before baking",
      "1 egg yolk beaten with 1 Tbsp water",
      "Sourdough Version",
      "Sweet Stiff Starter",
      "100g bread flour (3/4 cup)",
      "60g sourdough starter (1/4 cup)",
      "50g water (3 Tbsp)",
      "30g sugar (2 Tbsp)",
      "Final Dough",
      "400g bread flour (3 cups)",
      "25g sugar (2 Tbsp)",
      "8g salt (1 1/2 tsp)",
      "240g sweet stiff starter (from above)",
      "225g water (scant 1 cup)",
      "1 egg and 1 egg white (reserve the yolk for the egg wash)",
      "To pour over the dough after mixing",
      "1 Tbsp of oil",
      "To laminate into the dough after the first rise",
      "57g unsalted butter (4 Tbsp)",
      "2 Tbsp of nigella seeds",
      "To brush on the dough before baking",
      "1 egg yolk beaten with 1 Tbsp water"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "Yeast Version" },
      { amount: 450.0, unit: "g", name: "bread flour" },
      { amount: 40.0, unit: "g", name: "sugar" },
      { amount: 9.0, unit: "g", name: "instant yeast" },
      { amount: 8.0, unit: "g", name: "salt" },
      { amount: 225.0, unit: "g", name: "water" },
      { amount: 1.0, unit: nil, name: "egg and 1 egg white" },
      { amount: nil, unit: nil, name: "To pour over the dough after mixing" },
      { amount: 1.0, unit: "Tbsp", name: "oil" },
      { amount: nil, unit: nil, name: "To laminate into the dough after the first rise" },
      { amount: 57.0, unit: "g", name: "softened unsalted butter" },
      { amount: 2.0, unit: "Tbsp", name: "nigella seeds" },
      { amount: nil, unit: nil, name: "To brush on the dough before baking" },
      { amount: 1.0, unit: nil, name: "egg yolk beaten with 1 Tbsp water" },
      { amount: nil, unit: nil, name: "Sourdough Version" },
      { amount: nil, unit: nil, name: "Sweet Stiff Starter" },
      { amount: 100.0, unit: "g", name: "bread flour" },
      { amount: 60.0, unit: "g", name: "sourdough starter" },
      { amount: 50.0, unit: "g", name: "water" },
      { amount: 30.0, unit: "g", name: "sugar" },
      { amount: nil, unit: nil, name: "Final Dough" },
      { amount: 400.0, unit: "g", name: "bread flour" },
      { amount: 25.0, unit: "g", name: "sugar" },
      { amount: 8.0, unit: "g", name: "salt" },
      { amount: 240.0, unit: "g", name: "sweet stiff starter" },
      { amount: 225.0, unit: "g", name: "water" },
      { amount: 1.0, unit: nil, name: "egg and 1 egg white" },
      { amount: nil, unit: nil, name: "To pour over the dough after mixing" },
      { amount: 1.0, unit: "Tbsp", name: "oil" },
      { amount: nil, unit: nil, name: "To laminate into the dough after the first rise" },
      { amount: 57.0, unit: "g", name: "unsalted butter" },
      { amount: 2.0, unit: "Tbsp", name: "nigella seeds" },
      { amount: nil, unit: nil, name: "To brush on the dough before baking" },
      { amount: 1.0, unit: nil, name: "egg yolk beaten with 1 Tbsp water" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Sourdough Prep",
      "If you're doing the sourdough version, make the sweet stiff starter the night before you plan to bake. After mixing the ingredients, knead the starter dough a bit on your counter to fully incorporate the ingredients, then place the blob in a jar, press it down with your knuckles and cover loosely. The starter should double (or more) in 8-12 hours, and you can proceed with the rest of the instructions.",
      "Mixing",
      "Pull 57g/half stick of butter from the refrigerator, unwrap it, and place it on a small plate to soften. Fold the wrapper in half and save it to grease your springform pan and countertop. Reminder: The butter doesn't go into the dough during mixing.",
      "Whisk the dry ingredients in a large bowl: flour, sugar, (yeast), and salt.",
      "Add the water, whole egg, egg white, (and sourdough starter broken into pieces). Mix thoroughly until the dough is smooth.",
      "Pour 1 tablespoon of oil on top of the dough, cover, and let the dough rise until it has more than doubled. In a warm summer kitchen, this took 1 hour for the yeast version and 4.5 hours for the sourdough version.",
      "Shaping and Final Proof",
      "Smudge a bit of the softened butter onto your saved butter wrapper and grease a 9-inch springform pan. Use this wrapper to lightly grease your countertop too.",
      "Scrape the dough out of the bowl and de-gas it by pressing your palms into it.",
      "Divide the dough in 12-18 pieces. See the photo galleries for different outcomes with fewer large pieces (yeast) versus more smaller pieces (sourdough).",
      "Working one piece at a time, spread the dough thin with butter-coated fingertips. Don't worry if you tear the dough a bit.",
      "Layer more butter on the thin dough, then sprinkle it with nigella seeds. (Have a paper towel nearby to occasionally de-seed your buttery fingers as the seeds will shred the next dough ball.)",
      "Fold the dough in thirds, and then roll it from a short side.",
      "Place the roll in your pan, working from the center outward. It's okay if the rolls topple over a bit. You can adjust them later, and a little chaos adds to the appeal.",
      "When all the rolls are done, cover your pan and let the dough rise until it has more than doubled. This was 1 hour for the yeast version and 2.5 hours for the sourdough version. See the photo gallery for expansion.",
      "Baking",
      "Preheat your oven to 350F.",
      "Beat the egg yolk with a tablespoon of water and brush the top of the dough. Sprinkle with nigella seeds and bake for 30 minutes uncovered.",
      "Let the dough cool on a rack for about 20 minutes before you remove the outer ring of the pan. Serve on the base."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Sourdough Prep\nIf you're doing the sourdough version, make the sweet stiff starter the night before you plan to bake. After mixing the ingredients, knead the starter dough a bit on your counter to fully incorporate the ingredients, then place the blob in a jar, press it down with your knuckles and cover loosely. The starter should double (or more) in 8-12 hours, and you can proceed with the rest of the instructions.\nMixing\nPull 57g/half stick of butter from the refrigerator, unwrap it, and place it on a small plate to soften. Fold the wrapper in half and save it to grease your springform pan and countertop. Reminder: The butter doesn't go into the dough during mixing.\nWhisk the dry ingredients in a large bowl: flour, sugar, (yeast), and salt.\nAdd the water, whole egg, egg white, (and sourdough starter broken into pieces). Mix thoroughly until the dough is smooth.\nPour 1 tablespoon of oil on top of the dough, cover, and let the dough rise until it has more than doubled. In a warm summer kitchen, this took 1 hour for the yeast version and 4.5 hours for the sourdough version.\nShaping and Final Proof\nSmudge a bit of the softened butter onto your saved butter wrapper and grease a 9-inch springform pan. Use this wrapper to lightly grease your countertop too.\nScrape the dough out of the bowl and de-gas it by pressing your palms into it.\nDivide the dough in 12-18 pieces. See the photo galleries for different outcomes with fewer large pieces (yeast) versus more smaller pieces (sourdough).\nWorking one piece at a time, spread the dough thin with butter-coated fingertips. Don't worry if you tear the dough a bit.\nLayer more butter on the thin dough, then sprinkle it with nigella seeds. (Have a paper towel nearby to occasionally de-seed your buttery fingers as the seeds will shred the next dough ball.)\nFold the dough in thirds, and then roll it from a short side.\nPlace the roll in your pan, working from the center outward. It's okay if the rolls topple over a bit. You can adjust them later, and a little chaos adds to the appeal.\nWhen all the rolls are done, cover your pan and let the dough rise until it has more than doubled. This was 1 hour for the yeast version and 2.5 hours for the sourdough version. See the photo gallery for expansion.\nBaking\nPreheat your oven to 350F.\nBeat the egg yolk with a tablespoon of water and brush the top of the dough. Sprinkle with nigella seeds and bake for 30 minutes uncovered.\nLet the dough cool on a rack for about 20 minutes before you remove the outer ring of the pan. Serve on the base.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("breadtopia.com")
    expect(recipe.canonical_url).to eq("https://breadtopia.com/kubaneh-jewish-yemeni-bread/")
    expect(recipe.site_name).to eq("Breadtopia")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Melissa Johnson")
    expect(recipe.description).to eq("Kubaneh is an amazing Jewish Yemeni pull-apart bread consisting of multilayered rolls laminated with butter and nigella seeds. Both the yeast and sourdough versions are delicious and can be enjoyed at any meal and paired with sweet or savory foods. Traditionally, the bread is baked for Sabbath (Saturday) morning and served with boiled eggs, grated fresh tomatoes, and spicy zhoug sauce.")
    expect(recipe.image).to eq("https://breadtopia.com/wp-content/uploads/2020/08/20200616_173521sq-Copy-250x250.jpg")
    expect(recipe.category).to eq("Recipes")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(90)
    expect(recipe.prep_time).to eq(60)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(%w[Bread Sourdough Yeast])
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
    expect(recipe.links).to include("https://breadtopia.com/")
  end
end
