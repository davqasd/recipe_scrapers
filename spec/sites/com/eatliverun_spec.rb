# frozen_string_literal: true

RSpec.describe "eatliverun.com" do
  subject(:recipe) { scrape_cassette("com/eatliverun", url: "https://www.eatliverun.com/honey-miso-glazed-salmon/") }

  it "reads the title" do
    expect(recipe.title).to eq("Miso Honey Glazed Salmon")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 whole salmon fillet (or 4 5-oz portions)",
      "2 tbsp yellow or white miso paste",
      "1 tbsp raw honey",
      "2 tbsp olive oil",
      "kosher salt",
      "sesame seeds for serving",
      "minced fresh chives for serving"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "whole salmon fillet" },
      { amount: 2.0, unit: "tbsp", name: "yellow or white miso paste" },
      { amount: 1.0, unit: "tbsp", name: "raw honey" },
      { amount: 2.0, unit: "tbsp", name: "olive oil" },
      { amount: nil, unit: nil, name: "kosher salt" },
      { amount: nil, unit: nil, name: "sesame seeds for serving" },
      { amount: nil, unit: nil, name: "minced fresh chives for serving" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 425 degrees.",
      "In a small saucepot over medium heat, combine the miso paste, honey and olive oil. Cook until honey dissolves and you have a thick glaze.",
      "Sprinkle sea salt on your fish. Then, pour over glaze.",
      "Roast fish for 6 minutes (for about a 1\" sockeye fillet. If you have a thicker piece of salmon, you will need to roast longer)",
      "Right when fish comes out of the oven, sprinkle with the chives and the sesame seeds and serve!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 425 degrees.\nIn a small saucepot over medium heat, combine the miso paste, honey and olive oil. Cook until honey dissolves and you have a thick glaze.\nSprinkle sea salt on your fish. Then, pour over glaze.\nRoast fish for 6 minutes (for about a 1\" sockeye fillet. If you have a thicker piece of salmon, you will need to roast longer)\nRight when fish comes out of the oven, sprinkle with the chives and the sesame seeds and serve!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("eatliverun.com")
    expect(recipe.canonical_url).to eq("https://www.eatliverun.com/honey-miso-glazed-salmon/")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("jenna")
    expect(recipe.description).to be_nil
    expect(recipe.image).to eq("https://www.eatliverun.com/wp-content/uploads/2017/10/salmon-1-1-of-1.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
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
    expect(recipe.links).to include("http://facebook.com/eatliverun")
  end
end
