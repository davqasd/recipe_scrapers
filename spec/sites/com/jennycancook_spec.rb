# frozen_string_literal: true

RSpec.describe "jennycancook.com" do
  subject(:recipe) { scrape_cassette("com/jennycancook", url: "https://www.jennycancook.com/recipes/no-knead-crusty-rolls/") }

  it "reads the title" do
    expect(recipe.title).to eq("No Knead Crusty Rolls")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 1/2 cups (300-325 g /10 3/4 ounces) bread flour or all-purpose flour (AERATE FLOUR BEFORE MEASURING - See How)",
      "1/4 teaspoon (1 g) RapidRise / instant or dry active yeast",
      "1 teaspoon salt",
      "1 1/4 cups hot water (120° to 130° F)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.5, unit: "cups", name: "bread flour or all-purpose flour" },
      { amount: 0.25, unit: "teaspoon", name: "RapidRise / instant or dry active yeast" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: 1.25, unit: "cups", name: "hot water" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large bowl combine dry ingredients. Stir in water. Mixture will be thick and sticky.",
      "Cover with plastic wrap & let stand on counter top for 3 hours.",
      "After 3 hours (mixture will be puffy and bubbly on top) place dough on a well-floured surface. Using a scraper fold over about 12 times, adding enough flour so it doesn’t stick (about 2 Tbsp).",
      "Using a scraper cut dough into 8 pieces. With floured hands, shape each into a ball by folding and tucking, like making a drawstring bag.",
      "Place on parchment paper-lined baking sheet (not wax paper) & cover with a dish towel. Let stand at room temperature for 35 minutes. They will puff up but will not double in size.",
      "As soon as rolls are covered, start preheating oven to 450° F. Oven must be 450° so use an oven thermometer if possible.",
      "Bake for 25-30 minutes until golden brown. To re-crisp the next day, preheat the oven to 325° F and place the rolls directly on the oven rack for 10-12 minutes."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large bowl combine dry ingredients. Stir in water. Mixture will be thick and sticky.\nCover with plastic wrap & let stand on counter top for 3 hours.\nAfter 3 hours (mixture will be puffy and bubbly on top) place dough on a well-floured surface. Using a scraper fold over about 12 times, adding enough flour so it doesn’t stick (about 2 Tbsp).\nUsing a scraper cut dough into 8 pieces. With floured hands, shape each into a ball by folding and tucking, like making a drawstring bag.\nPlace on parchment paper-lined baking sheet (not wax paper) & cover with a dish towel. Let stand at room temperature for 35 minutes. They will puff up but will not double in size.\nAs soon as rolls are covered, start preheating oven to 450° F. Oven must be 450° so use an oven thermometer if possible.\nBake for 25-30 minutes until golden brown. To re-crisp the next day, preheat the oven to 325° F and place the rolls directly on the oven rack for 10-12 minutes.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("jennycancook.com")
    expect(recipe.canonical_url).to eq("https://www.jennycancook.com/recipes/no-knead-crusty-rolls/")
    expect(recipe.site_name).to eq("Jenny Can Cook | Jenny Can Cook")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("PLEASE SEE MY METRIC CHART ABOUT THE FLOUR. I recommend an oven thermometer to make sure your oven is hot enough (For the original overnight method, simply switch to COOL water and let the dough rest overnight on the counter top for 8 to 24 hours). ALWAYS AERATE (not sift) YOUR FLOUR BEFORE MEASURING.")
    expect(recipe.image).to eq("https://www.jennycancook.com/recipe_images/no-knead-crusty-rolls-recipe.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 items")
    expect(recipe.total_time).to eq(240)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(25)
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
    expect(recipe.links).to include("http://www.youtube.com/user/jennyjonesvideos")
  end
end
