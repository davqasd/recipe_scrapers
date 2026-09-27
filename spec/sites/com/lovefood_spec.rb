# frozen_string_literal: true

RSpec.describe "lovefood.com" do
  subject(:recipe) { scrape_cassette("com/lovefood", url: "https://www.lovefood.com/recipes/83641/easter-biscuits-recipe") }

  it "reads the title" do
    expect(recipe.title).to eq("Easter biscuits")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "50 g golden caster sugar",
      "50 g icing sugar",
      "1 medium free range egg",
      "0.5 tsp ground mixed spice",
      "300 g plain flour, plus extra for rolling",
      "175 g Stork, diced"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 50.0, unit: "g", name: "golden caster sugar" },
      { amount: 50.0, unit: "g", name: "icing sugar" },
      { amount: 1.0, unit: nil, name: "medium free range egg" },
      { amount: 0.5, unit: "tsp", name: "ground mixed spice" },
      { amount: 300.0, unit: "g", name: "plain flour, plus extra for rolling" },
      { amount: 175.0, unit: "g", name: "Stork, diced" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 180°C/350°F/gas mark 4.",
      "Beat the Stork and both sugars together until creamy, then mix in the egg. Add the spice and flour, and mix to make a firm dough.",
      "Roll out the dough on a lightly floured surface to a thickness of 2-3 mm (1/16in - 3/32in) and stamp out biscuits using Easter cookie cutters.",
      "Transfer to baking sheets that have been lined with non-stick parchment and bake for 8–10 minutes until pale golden. Leave to cool on the tray for 1-2 minutes, then transfer to a wire rack and leave to cool completely.",
      "Decorate the biscuits with coloured icing and dust with a few sprinkles. Leave to set, then store in an airtight container until ready to eat."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 180°C/350°F/gas mark 4.\nBeat the Stork and both sugars together until creamy, then mix in the egg. Add the spice and flour, and mix to make a firm dough.\nRoll out the dough on a lightly floured surface to a thickness of 2-3 mm (1/16in - 3/32in) and stamp out biscuits using Easter cookie cutters.\nTransfer to baking sheets that have been lined with non-stick parchment and bake for 8–10 minutes until pale golden. Leave to cool on the tray for 1-2 minutes, then transfer to a wire rack and leave to cool completely.\nDecorate the biscuits with coloured icing and dust with a few sprinkles. Leave to set, then store in an airtight container until ready to eat.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("lovefood.com")
    expect(recipe.canonical_url).to eq("https://www.lovefood.com/recipes/83641/easter-biscuits-recipe")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en")
    expect(recipe.author).to be_nil
    expect(recipe.description).to be_nil
    expect(recipe.image).to be_nil
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
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
    expect(recipe.links).to include("#accordion-1")
  end
end
