# frozen_string_literal: true

RSpec.describe "aldi.com.au" do
  subject(:recipe) { scrape_cassette("au/aldi", url: "https://www.aldi.com.au/recipes/starters-sides-salad-recipes/beetroot-and-smoke-salmon-eggs") }

  it "reads the title" do
    expect(recipe.title).to eq("Beetroot and Smoked Salmon Eggs")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "8 Lodge Farms large free range eggs",
      "100g Deli Originals Fresh beetroot hommus",
      "100g The Fishmonger smoked salmon",
      "¼ small red onion, very finely sliced",
      "½ Lebanese cucumber, halved and thinly sliced",
      "1 tbsp fresh dill, chopped"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 8.0, unit: nil, name: "Lodge Farms large free range eggs" },
      { amount: 100.0, unit: "g", name: "Deli Originals Fresh beetroot hommus" },
      { amount: 100.0, unit: "g", name: "The Fishmonger smoked salmon" },
      { amount: 0.25, unit: nil, name: "small red onion, very finely sliced" },
      { amount: 0.5, unit: nil, name: "Lebanese cucumber, halved and thinly sliced" },
      { amount: 1.0, unit: "tbsp", name: "fresh dill, chopped" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Cook the eggs in a saucepan of boiling water for 12 minutes or until hard boiled. Cool under running cold water. Remove shells, cover and chill in fridge.",
      "Slice eggs in halves and remove the yolks. Place the yolks in a mixing bowl and add the beetroot hommus. Mash together, with a fork, until combined.",
      "Spoon a generous amount of the mixture onto the egg whites, filling the indentation left by the yolk. Top with pieces of smoked salmon, red onion and cucumber.",
      "Garnish each piece with small dill fronds. Refrigerate until ready to serve."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Cook the eggs in a saucepan of boiling water for 12 minutes or until hard boiled. Cool under running cold water. Remove shells, cover and chill in fridge.\nSlice eggs in halves and remove the yolks. Place the yolks in a mixing bowl and add the beetroot hommus. Mash together, with a fork, until combined.\nSpoon a generous amount of the mixture onto the egg whites, filling the indentation left by the yolk. Top with pieces of smoked salmon, red onion and cucumber.\nGarnish each piece with small dill fronds. Refrigerate until ready to serve.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("aldi.com.au")
    expect(recipe.canonical_url).to eq("https://www.aldi.com.au/recipes/starters-sides-salad-recipes/beetroot-and-smoke-salmon-eggs")
    expect(recipe.site_name).to eq("ALDI Australia")
    expect(recipe.language).to eq("en-AU")
    expect(recipe.author).to eq("ALDI")
    expect(recipe.description).to eq("Vibrant devilled eggs filled with beetroot hommus and topped with smoked salmon and dill.")
    expect(recipe.image).to eq("https://dm.apac.cms.aldi.cx/is/image/aldiprodapac/BeetrootSmokedSalmon_Banner_3056_1024-1%3A3-1?wid=3042&fit=constrain&fmt=png-alpha")
    expect(recipe.category).to eq("Starter")
    expect(recipe.cuisine).to eq("Australian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("16 servings")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to be_nil
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
    expect(recipe.links).to include("#main")
  end
end
