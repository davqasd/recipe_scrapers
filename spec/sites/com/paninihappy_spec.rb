# frozen_string_literal: true

RSpec.describe "paninihappy.com" do
  subject(:recipe) { scrape_cassette("com/paninihappy", url: "https://paninihappy.com/classic-reuben-panini/") }

  it "reads the title" do
    expect(recipe.title).to eq("Reuben Panini")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1/2 cup mayonnaise",
      "2 tablespoons ketchup",
      "2 teaspoons sweet pickle relish",
      "2 teaspoons Worcestershire sauce",
      "2 teaspoons minced onion",
      "Coarse salt and freshly ground black pepper",
      "4 tablespoons (1/2 stick) butter, at room temperature",
      "8 slices rye bread, sliced from a dense bakery loaf",
      "4 ounces Swiss cheese, sliced",
      "8 ounces sliced corned beef",
      "1/2 cup sauerkraut"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.5, unit: "cup", name: "mayonnaise" },
      { amount: 2.0, unit: "tablespoons", name: "ketchup" },
      { amount: 2.0, unit: "teaspoons", name: "sweet pickle relish" },
      { amount: 2.0, unit: "teaspoons", name: "Worcestershire sauce" },
      { amount: 2.0, unit: "teaspoons", name: "minced onion" },
      { amount: nil, unit: nil, name: "Coarse salt and freshly ground black pepper" },
      { amount: 4.0, unit: "tablespoons", name: "butter, at room temperature" },
      { amount: 8.0, unit: "slices", name: "rye bread, sliced from a dense bakery loaf" },
      { amount: 4.0, unit: "ounces", name: "Swiss cheese, sliced" },
      { amount: 8.0, unit: "ounces", name: "sliced corned beef" },
      { amount: 0.5, unit: "cup", name: "sauerkraut" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Whisk together the mayonnaise, ketchup, pickle relish, Worcestershire sauce, and onion in a small bowl, and season with salt and pepper to taste. Cover the bowl and refrigerate the dressing until you’re ready to use it.",
      "Heat the panini press to medium-high heat.",
      "For each sandwich: Spread butter on two slices of bread to flavor the outside of the sandwich. Flip over one slice and top the other side with cheese, corned beef, a dollop of Thousand Island dressing, sauerkraut, and more cheese. Close the sandwich with the other slice of bread, buttered side up.",
      "Grill two panini at a time, with the lid closed, until the cheese is melted and the bread is toasted, 4 to 5 minutes."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Whisk together the mayonnaise, ketchup, pickle relish, Worcestershire sauce, and onion in a small bowl, and season with salt and pepper to taste. Cover the bowl and refrigerate the dressing until you’re ready to use it.\nHeat the panini press to medium-high heat.\nFor each sandwich: Spread butter on two slices of bread to flavor the outside of the sandwich. Flip over one slice and top the other side with cheese, corned beef, a dollop of Thousand Island dressing, sauerkraut, and more cheese. Close the sandwich with the other slice of bread, buttered side up.\nGrill two panini at a time, with the lid closed, until the cheese is melted and the bread is toasted, 4 to 5 minutes.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("paninihappy.com")
    expect(recipe.canonical_url).to eq("https://paninihappy.com/classic-reuben-panini/")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en-US")
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
    expect(recipe.links).to include("#content")
  end
end
