# frozen_string_literal: true

RSpec.describe "lidiasitaly.com" do
  subject(:recipe) { scrape_cassette("com/lidiasitaly", url: "https://lidiasitaly.com/recipes/four-cheese-baked-macaroni/") }

  it "reads the title" do
    expect(recipe.title).to eq("Four-Cheese Baked Macaroni")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "6 tablespoons unsalted butter, plus more for the baking dish",
      "Kosher salt",
      "2-to-3-ounce chunk of day-old country bread, crust removed",
      "1/2 cup freshly grated Grana Padano",
      "1/4 cup all-purpose flour",
      "3 1/2 cups whole milk",
      "2 fresh bay leaves",
      "8 ounces Italian Fontina, grated",
      "8 ounces mild provola, grated",
      "4 ounces Taleggio, rind removed, cut into pieces",
      "1 pound penne",
      "1 small bunch thick asparagus spears, tough ends removed, lower stalks peeled, stalks cut into 1-inch segments",
      "1 cup frozen peas"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 6.0, unit: "tablespoons", name: "unsalted butter, plus more for the baking dish" },
      { amount: nil, unit: nil, name: "Kosher salt" },
      { amount: 2.0, unit: nil, name: "-to-3-ounce chunk of day-old country bread, crust removed" },
      { amount: 0.5, unit: "cup", name: "freshly grated Grana Padano" },
      { amount: 0.25, unit: "cup", name: "all-purpose flour" },
      { amount: 3.5, unit: "cups", name: "whole milk" },
      { amount: 2.0, unit: nil, name: "fresh bay leaves" },
      { amount: 8.0, unit: "ounces", name: "Italian Fontina, grated" },
      { amount: 8.0, unit: "ounces", name: "mild provola, grated" },
      { amount: 4.0, unit: "ounces", name: "Taleggio, rind removed, cut into pieces" },
      { amount: 1.0, unit: "pound", name: "penne" },
      { amount: 1.0, unit: "bunch", name: "thick asparagus spears, tough ends removed, lower stalks peeled, stalks cut into 1-inch segments" },
      { amount: 1.0, unit: "cup", name: "frozen peas" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 400 degrees. Butter a 9-by-13-inch baking dish, and set it aside. Bring a large pot of salted water to a boil for the pasta.",
      "Grate (on the large holes of a box grater) the bread into small crumbs; you should have about 1 cup. Melt 2 tablespoons of the butter in a small skillet over medium-low heat. Scatter in the crumbs, and cook, tossing frequently, until they’re light golden and crisp, about 3 minutes. Set them aside, and when they’re cool, stir in the Grana Padano.",
      "To make the sauce: Melt the remaining 4 tablespoons butter in a large Dutch oven over medium heat. Once the butter is melted, whisk in the flour, and cook to toast it a bit, 1 to 2 minutes. Gradually whisk in the milk until the mixture is smooth. Add the bay leaves and 1 teaspoon salt. Bring to a simmer, and cook, stirring occasionally, until it’s thickened, 6 to 8 minutes. Reduce the heat to low, and stir in the Fontina, provola, and Taleggio, a few handfuls at a time, stirring until it’s smooth.",
      "Meanwhile, add the pasta to the boiling water. Once the pasta is halfway cooked and still quite al dente, add the asparagus and peas, and cook until the pasta is al dente. Drain the pasta and vegetables, and add them directly to the sauce. Stir to coat the pasta thoroughly, and transfer the entire mixture to the prepared baking dish. Sprinkle with the crumbs. Bake until the edges are bubbly and the top is golden brown, 40 to 45 minutes."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 400 degrees. Butter a 9-by-13-inch baking dish, and set it aside. Bring a large pot of salted water to a boil for the pasta.\nGrate (on the large holes of a box grater) the bread into small crumbs; you should have about 1 cup. Melt 2 tablespoons of the butter in a small skillet over medium-low heat. Scatter in the crumbs, and cook, tossing frequently, until they’re light golden and crisp, about 3 minutes. Set them aside, and when they’re cool, stir in the Grana Padano.\nTo make the sauce: Melt the remaining 4 tablespoons butter in a large Dutch oven over medium heat. Once the butter is melted, whisk in the flour, and cook to toast it a bit, 1 to 2 minutes. Gradually whisk in the milk until the mixture is smooth. Add the bay leaves and 1 teaspoon salt. Bring to a simmer, and cook, stirring occasionally, until it’s thickened, 6 to 8 minutes. Reduce the heat to low, and stir in the Fontina, provola, and Taleggio, a few handfuls at a time, stirring until it’s smooth.\nMeanwhile, add the pasta to the boiling water. Once the pasta is halfway cooked and still quite al dente, add the asparagus and peas, and cook until the pasta is al dente. Drain the pasta and vegetables, and add them directly to the sauce. Stir to coat the pasta thoroughly, and transfer the entire mixture to the prepared baking dish. Sprinkle with the crumbs. Bake until the edges are bubbly and the top is golden brown, 40 to 45 minutes.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("lidiasitaly.com")
    expect(recipe.canonical_url).to eq("https://lidiasitaly.com/recipes/four-cheese-baked-macaroni/")
    expect(recipe.site_name).to eq("Lidia")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Just wanted to share this delicious recipe from Lidia Bastianich with you - Buon Gusto!")
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
    expect(recipe.links).to include("https://www.facebook.com/LidiaBastianich")
  end
end
