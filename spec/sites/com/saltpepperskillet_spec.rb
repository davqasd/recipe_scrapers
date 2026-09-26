# frozen_string_literal: true

RSpec.describe "saltpepperskillet.com" do
  subject(:recipe) { scrape_cassette("com/saltpepperskillet", url: "https://saltpepperskillet.com/picanha/") }

  it "reads the title" do
    expect(recipe.title).to eq("Smoked Picanha")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 whole picanha steak with fat cap intact",
      "kosher salt or coarse rock salt",
      "2 tsp neutral oil"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "whole picanha steak with fat cap intact" },
      { amount: nil, unit: nil, name: "kosher salt or coarse rock salt" },
      { amount: 2.0, unit: "tsp", name: "neutral oil" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Prep the picanha by trimming any silver skin from the bottom side. Use a sharp knife to score the fat cap in a 1/2-inch crosshatch pattern to help render the fat. Drizzle lightly with oil and generously season all over with kosher salt. Allow to sit for at least 1 hour at room temperature, or ideally refrigerate overnight.",
      "Preheat your smoker to 250°-275°F (120°-135°C), setting up for indirect low and slow cooking. Add preferred wood chunks, chips, or pellets such as oak or hickory.",
      "Smoke the meat by placing the picanha on the cooler side of the smoker with a remote probe thermometer inserted into the thickest part. Close the lid and cook until the internal temperature reaches 115°F (46°C), approximately 60-90 minutes.",
      "Remove the picanha from the smoker once it reaches 115°F internal temperature. Increase the grill's temperature to high heat for searing, or alternatively, heat a heavy cast iron skillet over high heat on the stove.",
      "Sear the picanha for about 2 minutes per side until a beautiful crust forms and the internal temperature reaches 130°-135°F (54°-57°C) for medium-rare doneness.",
      "Rest the steak for 10 minutes before slicing against the grain. Sprinkle with a finishing touch of salt before serving. Enjoy with chimichurri sauce or your favorite accompaniments."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Prep the picanha by trimming any silver skin from the bottom side. Use a sharp knife to score the fat cap in a 1/2-inch crosshatch pattern to help render the fat. Drizzle lightly with oil and generously season all over with kosher salt. Allow to sit for at least 1 hour at room temperature, or ideally refrigerate overnight.\nPreheat your smoker to 250°-275°F (120°-135°C), setting up for indirect low and slow cooking. Add preferred wood chunks, chips, or pellets such as oak or hickory.\nSmoke the meat by placing the picanha on the cooler side of the smoker with a remote probe thermometer inserted into the thickest part. Close the lid and cook until the internal temperature reaches 115°F (46°C), approximately 60-90 minutes.\nRemove the picanha from the smoker once it reaches 115°F internal temperature. Increase the grill's temperature to high heat for searing, or alternatively, heat a heavy cast iron skillet over high heat on the stove.\nSear the picanha for about 2 minutes per side until a beautiful crust forms and the internal temperature reaches 130°-135°F (54°-57°C) for medium-rare doneness.\nRest the steak for 10 minutes before slicing against the grain. Sprinkle with a finishing touch of salt before serving. Enjoy with chimichurri sauce or your favorite accompaniments.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("saltpepperskillet.com")
    expect(recipe.canonical_url).to eq("https://saltpepperskillet.com/picanha/")
    expect(recipe.site_name).to eq("Salt Pepper Skillet")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Justin McChesney-Wachs")
    expect(recipe.description).to eq("Picanha delivers exceptional flavor and tenderness without the premium price. Gentle smoking followed by a quick sear creates the perfect crust while the signature fat cap bastes the meat. Brazilian steakhouse quality, made simple at home.")
    expect(recipe.image).to eq("https://saltpepperskillet.com/wp-content/uploads/picanha-steak-with-chimichurri-overhead-horizontal.jpg")
    expect(recipe.category).to eq("Main")
    expect(recipe.cuisine).to eq("Brazilian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(80)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(75)
    expect(recipe.keywords).to eq(["flap steak", "picanha", "sirloin cap"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
