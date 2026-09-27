# frozen_string_literal: true

RSpec.describe "lacucinaitaliana.com" do
  subject(:recipe) { scrape_cassette("com/lacucinaitaliana", url: "https://www.lacucinaitaliana.com/recipe/cakes-and-desserts/sbrisolona") }

  it "reads the title" do
    expect(recipe.title).to eq("Sbrisolona")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 1/4CUP all-purpose flour",
      "1/4LB. almonds, unpeeled",
      "1/2CUP sugar",
      "2/3CUP extra-fine cornmeal",
      "1/2STICK unsalted butter, softened",
      "4TBSP. lard",
      "1 large egg yolk",
      "zest of 1/2 lemon",
      "1/2 vanilla bean pod"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.25, unit: "CUP", name: "all-purpose flour" },
      { amount: 0.25, unit: "LB", name: "almonds, unpeeled" },
      { amount: 0.5, unit: "CUP", name: "sugar" },
      { amount: 0.67, unit: "CUP", name: "extra-fine cornmeal" },
      { amount: 0.5, unit: "STICK", name: "unsalted butter, softened" },
      { amount: 4.0, unit: "TBSP", name: "lard" },
      { amount: 1.0, unit: nil, name: "large egg yolk" },
      { amount: nil, unit: nil, name: "zest of 1/2 lemon" },
      { amount: 0.5, unit: nil, name: "vanilla bean pod" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 320°F. Line a 9\" round cake pan with parchment paper.",
      "Roughly chop the almonds and mix them in a large bowl with the flour, sugar, cornmeal, butter, lard, egg yolk, lemon zest, and the seeds from half a vanilla bean pod; mix well with a spoon.",
      "Crumble the batter into the cake pan and gently press it to form a 1/2\" thick layer. Bake for 25 minutes."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 320°F. Line a 9\" round cake pan with parchment paper.\nRoughly chop the almonds and mix them in a large bowl with the flour, sugar, cornmeal, butter, lard, egg yolk, lemon zest, and the seeds from half a vanilla bean pod; mix well with a spoon.\nCrumble the batter into the cake pan and gently press it to form a 1/2\" thick layer. Bake for 25 minutes.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("lacucinaitaliana.com")
    expect(recipe.canonical_url).to eq("https://www.lacucinaitaliana.com/recipe/cakes-and-desserts/sbrisolona")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Redazione Web")
    expect(recipe.description).to eq("Sbrisolona is a specialty from the city of Mantua, Italy. The large crisp cookie-cake is broken into bite-sized chunks and eaten with your hands. It is simply delicious.")
    expect(recipe.image).to eq("https://rms.condenast.it/rms/public/5d3/f01/744/thumb_42_1200_670_0_0_auto.jpg")
    expect(recipe.category).to eq("cakes and desserts")
    expect(recipe.cuisine).to eq("Italian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.0)
    expect(recipe.ratings_count).to eq(5)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("//www.lacucinaitaliana.it")
  end
end
