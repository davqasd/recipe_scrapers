# frozen_string_literal: true

RSpec.describe "bestrecipes.com.au" do
  subject(:recipe) { scrape_cassette("au/bestrecipes", url: "https://www.bestrecipes.com.au/recipes/aussie-meat-pie-recipe-2/34l4qr5q") }

  it "reads the title" do
    expect(recipe.title).to eq("Aussie meat pie recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 onion finely chopped",
      "500g Beef Mince",
      "1 cup water",
      "2 beef stock cubes",
      "1/4 cup tomato sauce",
      "2 tsp Worcestershire sauce",
      "1 pinch salt and pepper *to taste",
      "3 tbs plain flour",
      "1 sheet shortcrust pastry",
      "1 sheet puff pastry",
      "1 egg to glaze"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "onion finely chopped" },
      { amount: 500.0, unit: "g", name: "Beef Mince" },
      { amount: 1.0, unit: "cup", name: "water" },
      { amount: 2.0, unit: nil, name: "beef stock cubes" },
      { amount: 0.25, unit: "cup", name: "tomato sauce" },
      { amount: 2.0, unit: "tsp", name: "Worcestershire sauce" },
      { amount: 1.0, unit: "pinch", name: "salt and pepper *to taste" },
      { amount: 3.0, unit: "tbs", name: "plain flour" },
      { amount: 1.0, unit: "sheet", name: "shortcrust pastry" },
      { amount: 1.0, unit: "sheet", name: "puff pastry" },
      { amount: 1.0, unit: nil, name: "egg to glaze" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Cook meat and onion until meat is well browned.",
      "Add ¾ cup water, stock cubes, sauces and seasonings.",
      "Bring to the boil and simmer for 15 minutes.",
      "Blend flour and the remaining water, add to meat, bring to the boil and simmer for 5 minutes. Cool.",
      "Line a pie plate with the shortcrust pastry.",
      "Spoon in the cooled meat mixture. Moisten edges of pastry with water.",
      "Top with puff pastry, pressing down to seal the edges, trim and glaze with egg.",
      "Bake at 230C for 15 minutes. Reduce heat to 190C and bake for a futher 25 minutes until golden."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Cook meat and onion until meat is well browned.\nAdd ¾ cup water, stock cubes, sauces and seasonings.\nBring to the boil and simmer for 15 minutes.\nBlend flour and the remaining water, add to meat, bring to the boil and simmer for 5 minutes. Cool.\nLine a pie plate with the shortcrust pastry.\nSpoon in the cooled meat mixture. Moisten edges of pastry with water.\nTop with puff pastry, pressing down to seal the edges, trim and glaze with egg.\nBake at 230C for 15 minutes. Reduce heat to 190C and bake for a futher 25 minutes until golden.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("bestrecipes.com.au")
    expect(recipe.canonical_url).to eq("https://www.bestrecipes.com.au/recipes/aussie-meat-pie-recipe-2/34l4qr5q")
    expect(recipe.site_name).to eq("www.bestrecipes.com.au")
    expect(recipe.language).to be_nil
    expect(recipe.author).to eq("Best Recipes Team")
    expect(recipe.description).to eq("https://www.bestrecipes.com.au/recipes/aussie-meat-pie-recipe-2/34l4qr5q")
    expect(recipe.image).to eq("https://img.bestrecipes.com.au/6b8XD4S0/w1200-h675-cfill-q80/br/2014/06/1980-aussie-meat-pie-952369-1.jpg")
    expect(recipe.category).to eq("dinner, lunch, main")
    expect(recipe.cuisine).to eq("australian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(55)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(40)
    expect(recipe.keywords).to eq([
      "meat pie",
      "pie",
      "aussie",
      "australian",
      "mince",
      "pastry",
      "baking",
      "australia day",
      "autumn",
      "beef mince",
      "beef stock",
      "dinner",
      "egg",
      "family friendly",
      "freezer friendly",
      "kid friendly",
      "lunch",
      "main",
      "onion",
      "plain flour",
      "puff pastry",
      "savoury",
      "shortcrust pastry",
      "spring",
      "stock",
      "summer",
      "tomato sauce",
      "winter",
      "worcestershire sauce",
      "budget club"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.8)
    expect(recipe.ratings_count).to eq(188)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
