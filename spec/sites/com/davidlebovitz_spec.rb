# frozen_string_literal: true

RSpec.describe "davidlebovitz.com" do
  subject(:recipe) { scrape_cassette("com/davidlebovitz", url: "https://www.davidlebovitz.com/faux-gras-foie-gras-vegetarian-lentil-mushroom-pate-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Faux Gras")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "12 medium-sized (100g, about 1 cup) button mushrooms",
      "2 tablespoons olive oil",
      "2 tablespoons butter (salted or unsalted)",
      "1 small onion (peeled and diced)",
      "2 cloves garlic (peeled and minced)",
      "2 cups (400g) cooked green lentils",
      "1 cup (140g) toasted walnuts, cashews or pecans",
      "2 tablespoons freshly squeezed lemon juice",
      "1 tablespoon soy sauce or tamari",
      "2 teaspoons minced fresh rosemary",
      "2 teaspoons fresh thyme (minced)",
      "2 tablespoons fresh sage or flat leaf parsley",
      "optional: 2 teaspoons Cognac or brandy",
      "1 teaspoon brown sugar",
      "1/8 teaspoon cayenne pepper",
      "salt and freshly ground black pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 12.0, unit: nil, name: "medium-sized button mushrooms" },
      { amount: 2.0, unit: "tablespoons", name: "olive oil" },
      { amount: 2.0, unit: "tablespoons", name: "butter" },
      { amount: 1.0, unit: nil, name: "small onion" },
      { amount: 2.0, unit: "cloves", name: "garlic" },
      { amount: 2.0, unit: "cups", name: "cooked green lentils" },
      { amount: 1.0, unit: "cup", name: "toasted walnuts, cashews or pecans" },
      { amount: 2.0, unit: "tablespoons", name: "freshly squeezed lemon juice" },
      { amount: 1.0, unit: "tablespoon", name: "soy sauce or tamari" },
      { amount: 2.0, unit: "teaspoons", name: "minced fresh rosemary" },
      { amount: 2.0, unit: "teaspoons", name: "fresh thyme" },
      { amount: 2.0, unit: "tablespoons", name: "fresh sage or flat leaf parsley" },
      { amount: 2.0, unit: "teaspoons", name: "Cognac or brandy" },
      { amount: 1.0, unit: "teaspoon", name: "brown sugar" },
      { amount: 0.13, unit: "teaspoon", name: "cayenne pepper" },
      { amount: nil, unit: nil, name: "salt and freshly ground black pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Wipe the mushrooms clean. Slice off a bit of the stem end (the funky parts) and slice them. Heat the olive oil and butter in a skillet or wide saucepan. Add the onions and garlic, and cook, stirring frequently, until the onions become translucent, 5 to 6 minutes. Add the mushrooms and cook, stirring occasionally, until they’re soft and cooked through, another 5 to 8 minutes. Remove from heat.",
      "In a food processor, combine the cooked lentils, nuts, lemon juice, soy sauce, rosemary, thyme, sage or parsley, Cognac (if using), brown sugar, and cayenne. Scrape in the cooked mushroom mixture and process until completely smooth. Taste, and add salt, pepper, and additional cognac, soy sauce, or lemon juice, if it needs balancing.",
      "Scrape the pâté into a small serving bowl and refrigerate for a few hours, until firm."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Wipe the mushrooms clean. Slice off a bit of the stem end (the funky parts) and slice them. Heat the olive oil and butter in a skillet or wide saucepan. Add the onions and garlic, and cook, stirring frequently, until the onions become translucent, 5 to 6 minutes. Add the mushrooms and cook, stirring occasionally, until they’re soft and cooked through, another 5 to 8 minutes. Remove from heat.\nIn a food processor, combine the cooked lentils, nuts, lemon juice, soy sauce, rosemary, thyme, sage or parsley, Cognac (if using), brown sugar, and cayenne. Scrape in the cooked mushroom mixture and process until completely smooth. Taste, and add salt, pepper, and additional cognac, soy sauce, or lemon juice, if it needs balancing.\nScrape the pâté into a small serving bowl and refrigerate for a few hours, until firm.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("davidlebovitz.com")
    expect(recipe.canonical_url).to eq("https://www.davidlebovitz.com/faux-gras-foie-gras-vegetarian-lentil-mushroom-pate-recipe/")
    expect(recipe.site_name).to eq("David Lebovitz")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("David")
    expect(recipe.description).to eq("Adapted from Très Green, Très Clean, Très Chic by Rebecca LefflerLentils double in volume when cooked, so 1 cup (160g) of dried lentils will yield close to the correct amount. They usually take about 20 to 30 minutes to cook until soft, but check the directions on the package for specific guidelines. If avoiding gluten, use tamari instead of soy sauce. For a vegan version, replace the butter with the same quantity of olive oil, for a total of 1/4 cup (60ml) of olive oil. Feel free to improvise with the fresh herbs, using what you'd like and what's available. The cognac or brandy is optional, but it does give the faux gras a little je ne sais quoi.")
    expect(recipe.image).to eq("https://www.davidlebovitz.com/wp-content/uploads/2015/06/Faux-Gras-Lentil-Pate-8.jpg")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("French")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(%w[lentils mushoom pate vegan])
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
    expect(recipe.links).to include("#body")
  end
end
