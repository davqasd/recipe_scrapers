# frozen_string_literal: true

RSpec.describe "barefootcontessa.com" do
  subject(:recipe) { scrape_cassette("com/barefootcontessa", url: "https://barefootcontessa.com/recipes/slow-roasted-filet-of-beef-with-basil-parmesan-mayonnaise") }

  it "reads the title" do
    expect(recipe.title).to eq("Slow-Roasted Filet of Beef with Basil Parmesan Mayonnaise")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 whole filet of beef tenderloin, trimmed and tied (4½ pounds)",
      "3 tablespoons good olive oil",
      "4 teaspoons kosher salt",
      "2 teaspoons coarsely ground black pepper",
      "10 to 15 branches fresh tarragon",
      "Basil Parmesan Mayonnaise, for serving (see recipe)",
      "2 extra-large egg yolks, at room temperature",
      "3 tablespoons freshly squeezed lemon juice",
      "1/2 cup freshly grated Parmesan cheese",
      "1 tablespoon Dijon mustard",
      "1/2 cup chopped fresh basil leaves, lightly packed",
      "1/2 teaspoon minced garlic",
      "Kosher salt and freshly ground black pepper",
      "1 cup vegetable oil, at room temperature",
      "1/2 cup good olive oil, at room temperature"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "whole filet of beef tenderloin, trimmed and tied" },
      { amount: 3.0, unit: "tablespoons", name: "good olive oil" },
      { amount: 4.0, unit: "teaspoons", name: "kosher salt" },
      { amount: 2.0, unit: "teaspoons", name: "coarsely ground black pepper" },
      { amount: 10.0, unit: nil, name: "branches fresh tarragon" },
      { amount: nil, unit: nil, name: "Basil Parmesan Mayonnaise, for serving" },
      { amount: 2.0, unit: nil, name: "extra-large egg yolks, at room temperature" },
      { amount: 3.0, unit: "tablespoons", name: "freshly squeezed lemon juice" },
      { amount: 0.5, unit: "cup", name: "freshly grated Parmesan cheese" },
      { amount: 1.0, unit: "tablespoon", name: "Dijon mustard" },
      { amount: 0.5, unit: "cup", name: "chopped fresh basil leaves, lightly packed" },
      { amount: 0.5, unit: "teaspoon", name: "minced garlic" },
      { amount: nil, unit: nil, name: "Kosher salt and freshly ground black pepper" },
      { amount: 1.0, unit: "cup", name: "vegetable oil, at room temperature" },
      { amount: 0.5, unit: "cup", name: "good olive oil, at room temperature" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 275 degrees. Use an oven thermometer to be sure your oven temperature is accurate.",
      "Place the filet on a sheet pan and pat it dry with paper towels. Brush the filet all over with the oil, reserving about half a tablespoon. Sprinkle it all over with the salt and pepper (it will seem like a lot but believe me, it makes a difference). Place the tarragon branches around the beef, tying them in 4 or 5 places with kitchen string to keep them in place, and then brush the tarragon with the reserved oil.",
      "Roast the filet of beef for 1¼ to 1½ hours, until the temperature registers 125 degrees in the center for rare and 135 degrees for medium-rare. I place the thermometer horizontally through the end of the beef. Cover the filet with aluminum foil and allow to rest for 20 minutes. Slice thickly and serve warm or at room temperature with Basil Parmesan Mayonnaise.",
      "Place the egg yolks, lemon juice, Parmesan, mustard, basil, garlic, 1 tablespoon salt, and 1 teaspoon pepper in a food processor fitted with the steel blade. Process for 20 seconds, until smooth. Combine the vegetable oil and olive oil in a 2-cup liquid measuring cup. With the processor running, slowly pour the oil mixture through the feed tube to make a thick emulsion. Taste for seasonings—the mayonnaise is a sauce so it should be highly seasoned. Store in the refrigerator until ready to use; it will keep for up to a week."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 275 degrees. Use an oven thermometer to be sure your oven temperature is accurate.\nPlace the filet on a sheet pan and pat it dry with paper towels. Brush the filet all over with the oil, reserving about half a tablespoon. Sprinkle it all over with the salt and pepper (it will seem like a lot but believe me, it makes a difference). Place the tarragon branches around the beef, tying them in 4 or 5 places with kitchen string to keep them in place, and then brush the tarragon with the reserved oil.\nRoast the filet of beef for 1¼ to 1½ hours, until the temperature registers 125 degrees in the center for rare and 135 degrees for medium-rare. I place the thermometer horizontally through the end of the beef. Cover the filet with aluminum foil and allow to rest for 20 minutes. Slice thickly and serve warm or at room temperature with Basil Parmesan Mayonnaise.\nPlace the egg yolks, lemon juice, Parmesan, mustard, basil, garlic, 1 tablespoon salt, and 1 teaspoon pepper in a food processor fitted with the steel blade. Process for 20 seconds, until smooth. Combine the vegetable oil and olive oil in a 2-cup liquid measuring cup. With the processor running, slowly pour the oil mixture through the feed tube to make a thick emulsion. Taste for seasonings—the mayonnaise is a sauce so it should be highly seasoned. Store in the refrigerator until ready to use; it will keep for up to a week.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("barefootcontessa.com")
    expect(recipe.canonical_url).to eq("https://barefootcontessa.com/recipes/slow-roasted-filet-of-beef-with-basil-parmesan-mayonnaise")
    expect(recipe.site_name).to eq("Barefoot Contessa")
    expect(recipe.language).to eq("en-us")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Slow-Roasted Filet of Beef with Basil Parmesan Mayonnaise from Barefoot Contessa. Preheat the oven to 275 degrees. Use an oven thermometer to be sure your oven temperature is accurate. Place the filet on a sheet pan and pat it dry with paper towels. Brush the filet all over with the oil, reserving about half a tablespoon. Sprinkle it all over with the salt and pepper (it will seem like a lot but believe me, it makes a difference). Place the tarragon branches around the beef, tying them in 4 or 5 places with kitchen string to keep them in place, and then brush the tarragon with the reserved oil. Roast the filet of beef for 1¼ to 1½ hours, until the temperature registers 125 degrees in the center for rare and 135 degrees for medium-rare. I place the thermometer horizontally through the end of the beef. Cover the filet with aluminum foil and allow to rest for 20 minutes. Slice thickly and serve warm or at room temperature with Basil Parmesan Mayonnaise.")
    expect(recipe.image).to eq("https://d14iv1hjmfkv57.cloudfront.net/assets/recipes/slow-roasted-filet-of-beef-with-basil-parmesan-mayonnaise/_1200x630_crop_center-center_82_none/Page-123-web-horizon.jpg?v=1779909741")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
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
    expect(recipe.links).to include("https://barefootcontessa.com/")
  end
end
