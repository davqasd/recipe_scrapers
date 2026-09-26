# frozen_string_literal: true

RSpec.describe "pilipinasrecipes.com" do
  subject(:recipe) { scrape_cassette("com/pilipinasrecipes", url: "https://pilipinasrecipes.com/banana-cue-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Banana Cue Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "10 pcs. semi-ripe or ripe Saba Banana",
      "1/4 cup brown sugar",
      "2 cups Vegetable cooking oil",
      "10 pcs bamboo skewers"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 10.0, unit: "pcs", name: "semi-ripe or ripe Saba Banana" },
      { amount: 0.25, unit: "cup", name: "brown sugar" },
      { amount: 2.0, unit: "cups", name: "Vegetable cooking oil" },
      { amount: 10.0, unit: "pcs", name: "bamboo skewers" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large wok at high flame heat cooking oil, when hot, drop the bananas and fry for about 2 minutes or until they start to slightly brown.",
      "Sprinkle the brown sugar and let it stand without stirring.",
      "When the sugar starts to caramelize, start stirring the bananas to have it coated with caramelized sugar.",
      "Continue frying, stirring several times to have the bananas fully coated with caramelized sugar. Turn the heat off once the bananas are cook through, do not overcook.",
      "Drain in Fry Skimmer Strainer or Colander or deep bowl with paper towel to remove excess oil.",
      "Skewer two bananas in a bamboo stick while they slightly cool down.",
      "Serve."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large wok at high flame heat cooking oil, when hot, drop the bananas and fry for about 2 minutes or until they start to slightly brown.\nSprinkle the brown sugar and let it stand without stirring.\nWhen the sugar starts to caramelize, start stirring the bananas to have it coated with caramelized sugar.\nContinue frying, stirring several times to have the bananas fully coated with caramelized sugar. Turn the heat off once the bananas are cook through, do not overcook.\nDrain in Fry Skimmer Strainer or Colander or deep bowl with paper towel to remove excess oil.\nSkewer two bananas in a bamboo stick while they slightly cool down.\nServe.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("pilipinasrecipes.com")
    expect(recipe.canonical_url).to eq("https://pilipinasrecipes.com/banana-cue-recipe/")
    expect(recipe.site_name).to eq("Pilipinas Recipes")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Pilipinas Recipes")
    expect(recipe.description).to eq("Banana Cue is one of the most loved street food in the Philippines. “Saba” banana is only key element of this dish.")
    expect(recipe.image).to eq("https://pilipinasrecipes.com/wp-content/uploads/2017/06/Banana-Cue-Final-225x225.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("Filipino")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["street food", "snack food", "caramel banana", "traditional"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.facebook.com/pilipinasrecipes/")
  end
end
