# frozen_string_literal: true

RSpec.describe "magimix.com" do
  subject(:recipe) { scrape_cassette("com/magimix", url: "https://www.magimix.com/en/recipes/chocolate-and-hazelnut-cookies_c2") }

  it "reads the title" do
    expect(recipe.title).to eq("Chocolate and hazelnut cookies")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "100 g of milk chocolate",
      "100 ml of liquid cream",
      "40 g of hazelnut powder",
      "200 g of flour",
      "140 g of soft semi-salted butter",
      "100 g of icing sugar",
      "1 egg",
      "30 g of almond powder"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 100.0, unit: "g", name: "milk chocolate" },
      { amount: 100.0, unit: "ml", name: "liquid cream" },
      { amount: 40.0, unit: "g", name: "hazelnut powder" },
      { amount: 200.0, unit: "g", name: "flour" },
      { amount: 140.0, unit: "g", name: "soft semi-salted butter" },
      { amount: 100.0, unit: "g", name: "icing sugar" },
      { amount: 1.0, unit: nil, name: "egg" },
      { amount: 30.0, unit: "g", name: "almond powder" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Place the chocolate, the liquid cream and the hazelnuts in the metal bowl then run the program.",
      "Pour into a container then cover with cling film. Chill for at least 2 hours.",
      "Rinse your bowl.",
      "Put all the ingredients in the metal bowl and run the program.",
      "Once you have a nice, smooth ball of dough, wrap it in cling film and set it aside in a cool place for 1 hour.",
      "Preheat your oven to 180 °C.",
      "Roll out the dough thinly on a floured work surface. Using a coffee cup (or a small cookie cutter), cut out rounds of dough and place them on a sheet of baking paper.",
      "Bake for 10 to 12 minutes. Let it cool.",
      "Using a piping bag or a teaspoon, place a dollop of ganache on one of the two biscuits then cover with the second to form your little sandwiches."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Place the chocolate, the liquid cream and the hazelnuts in the metal bowl then run the program.\nPour into a container then cover with cling film. Chill for at least 2 hours.\nRinse your bowl.\nPut all the ingredients in the metal bowl and run the program.\nOnce you have a nice, smooth ball of dough, wrap it in cling film and set it aside in a cool place for 1 hour.\nPreheat your oven to 180 °C.\nRoll out the dough thinly on a floured work surface. Using a coffee cup (or a small cookie cutter), cut out rounds of dough and place them on a sheet of baking paper.\nBake for 10 to 12 minutes. Let it cool.\nUsing a piping bag or a teaspoon, place a dollop of ganache on one of the two biscuits then cover with the second to form your little sandwiches.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("magimix.com")
    expect(recipe.canonical_url).to eq("https://www.magimix.com/en/recipes/chocolate-and-hazelnut-cookies_c2")
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
    expect(recipe.links).to include("https://www.magimix.com/en/my-account")
  end
end
