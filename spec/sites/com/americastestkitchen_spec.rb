# frozen_string_literal: true

RSpec.describe "americastestkitchen.com" do
  subject(:recipe) { scrape_cassette("com/americastestkitchen", url: "https://www.americastestkitchen.com/recipes/430-the-best-pound-cake") }

  it "reads the title" do
    expect(recipe.title).to eq("The Best Pound Cake")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup unsalted butter (2 sticks), softened (8 ounces/227 grams)",
      "1 1/3 cups granulated sugar (9 ounces/255 grams)",
      "3 large eggs (5.25 ounces, without the shells)",
      "3 large egg yolks (2 ounces)",
      "1 1/2 teaspoons vanilla extract",
      "1 1/2 teaspoons water",
      "1/2 teaspoon table salt",
      "1 1/2 cups cake flour (7 ounces/198 grams)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "unsalted butter, softened" },
      { amount: 1.33, unit: "cups", name: "granulated sugar" },
      { amount: 3.0, unit: nil, name: "large eggs" },
      { amount: 3.0, unit: nil, name: "large egg yolks" },
      { amount: 1.5, unit: "teaspoons", name: "vanilla extract" },
      { amount: 1.5, unit: "teaspoons", name: "water" },
      { amount: 0.5, unit: "teaspoon", name: "table salt" },
      { amount: 1.5, unit: "cups", name: "cake flour" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Adjust oven rack to center position and heat oven to 325 degrees. Grease a 9-by-5-by-3 1/2-inch loaf pan (7 1/2-cup capacity) with vegetable shortening or spray. Line the bottom and sides of pan with parchment paper (see “Lining the Pan”).",
      "Beat butter in bowl of electric mixer set at medium-high speed until smooth and shiny, about 15 seconds. With machine still on, take about 30 seconds to sprinkle in sugar. Beat mixture until light, fluffy and almost white, 4 to 5 minutes, stopping mixer once or twice to scrape down sides of bowl.",
      "Mix eggs, yolks, vanilla and water in a 2 cup glass measure with a pour spout, set in a pan of tepid water until mixture is about 70 degrees. With mixer set at medium-high speed, take 3 to 5 minutes to add egg mixture to butter/sugar mixture in a very slow, thin stream. Finally, beat in salt.",
      "Remove bowl from mixer stand. Turn 1/2 cup flour into sieve or shaker; sprinkle it over batter. Fold gently with rubber spatula, scraping up from bottom of the bowl, until flour is incorporated. Repeat twice more, adding flour in 1/2-cup increments.",
      "Scrape batter into prepared pan, smoothing top with a spatula or wooden spoon. Bake until cake needle or tester inserted into crack running along top comes out clean, 70 to 80 minutes. Let cake rest in pan for 5 minutes, then invert onto wire rack. Place second wire rack on cake bottom, then turn cake top side up. Cool to room temperature, remove and discard parchment, wrap cake in plastic, then in foil. Store cake at room temperature."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Adjust oven rack to center position and heat oven to 325 degrees. Grease a 9-by-5-by-3 1/2-inch loaf pan (7 1/2-cup capacity) with vegetable shortening or spray. Line the bottom and sides of pan with parchment paper (see “Lining the Pan”).\nBeat butter in bowl of electric mixer set at medium-high speed until smooth and shiny, about 15 seconds. With machine still on, take about 30 seconds to sprinkle in sugar. Beat mixture until light, fluffy and almost white, 4 to 5 minutes, stopping mixer once or twice to scrape down sides of bowl.\nMix eggs, yolks, vanilla and water in a 2 cup glass measure with a pour spout, set in a pan of tepid water until mixture is about 70 degrees. With mixer set at medium-high speed, take 3 to 5 minutes to add egg mixture to butter/sugar mixture in a very slow, thin stream. Finally, beat in salt.\nRemove bowl from mixer stand. Turn 1/2 cup flour into sieve or shaker; sprinkle it over batter. Fold gently with rubber spatula, scraping up from bottom of the bowl, until flour is incorporated. Repeat twice more, adding flour in 1/2-cup increments.\nScrape batter into prepared pan, smoothing top with a spatula or wooden spoon. Bake until cake needle or tester inserted into crack running along top comes out clean, 70 to 80 minutes. Let cake rest in pan for 5 minutes, then invert onto wire rack. Place second wire rack on cake bottom, then turn cake top side up. Cool to room temperature, remove and discard parchment, wrap cake in plastic, then in foil. Store cake at room temperature.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("americastestkitchen.com")
    expect(recipe.canonical_url).to eq("https://www.americastestkitchen.com/recipes/430-the-best-pound-cake")
    expect(recipe.site_name).to eq("America's Test Kitchen")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("After trying 31 pound cakes, we found that the perfect version varies the \"pound-of-each\" formula and relies on an unusual mixing method.")
    expect(recipe.image).to eq("https://res.cloudinary.com/hksqkdlah/image/upload/c_fill,dpr_2.0,f_auto,fl_lossy.progressive.strip_profile,g_faces:auto,q_auto:low/28369_sfs-the-best-pound-cake-21")
    expect(recipe.category).to eq("Desserts or Baked Goods")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(240)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Cakes"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.0)
    expect(recipe.ratings_count).to eq(90)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "375",
      "carbohydrateContent" => "41 g",
      "cholesterolContent" => "166 mg",
      "proteinContent" => "5 g",
      "sodiumContent" => "144 mg"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: nil, amount: 375.0 },
      { name: "carbohydrateContent", unit: "g", amount: 41.0 },
      { name: "cholesterolContent", unit: "mg", amount: 166.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "sodiumContent", unit: "mg", amount: 144.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#ratings-section")
  end
end
