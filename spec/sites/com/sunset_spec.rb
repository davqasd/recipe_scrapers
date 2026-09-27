# frozen_string_literal: true

RSpec.describe "sunset.com" do
  subject(:recipe) { scrape_cassette("com/sunset", url: "https://www.sunset.com/recipe/crisp-top-sourdough-stuffing") }

  it "reads the title" do
    expect(recipe.title).to eq("Crisp-Top Sourdough Stuffing")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 1-pound loaf sourdough, at least 1 day old",
      "1/4 cup salted butter",
      "2 cups chopped onion (1 large)",
      "1 cup chopped celery (2 or 3 stalks)",
      "1/4 cup chopped flat-leaf parsley",
      "1 tablespoon finely chopped fresh sage",
      "About 1/2 tsp. kosher salt",
      "About 1/2 tsp. pepper",
      "About 3 cups turkey broth, reduced-sodium chicken broth, or mushroom or other vegetable broth"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "loaf", name: "sourdough, at least 1 day old" },
      { amount: 0.25, unit: "cup", name: "salted butter" },
      { amount: 2.0, unit: "cups", name: "chopped onion" },
      { amount: 1.0, unit: "cup", name: "chopped celery" },
      { amount: 0.25, unit: "cup", name: "chopped flat-leaf parsley" },
      { amount: 1.0, unit: "tablespoon", name: "finely chopped fresh sage" },
      { amount: 0.5, unit: "tsp", name: "kosher salt" },
      { amount: 0.5, unit: "tsp", name: "pepper" },
      { amount: 3.0, unit: "cups", name: "turkey broth, reduced-sodium chicken broth, or mushroom or other vegetable broth" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Slice bread into 1 1/2-in.-thick slices and tear into irregular 1- to 2-in. pieces. Spread on a rimmed baking sheet and leave to dry at room temperature until needed (up to 2 days). For the best stuffing, the bread should be very dry.",
      "Preheat oven to 350°. Melt butter in a large frying pan over medium heat. Pour out 2 tbsp. butter and set aside.",
      "Add onion, celery, herbs, and 1/2 tsp. each salt and pepper to hot pan. Cook until onions are translucent and celery is tender-crisp, about 15 minutes. Transfer to a large bowl.",
      "Add torn bread and broth to vegetables and mix in until bread is soaked. Add salt and pepper to taste.",
      "Generously coat a 9- by 13-in. glass baking pan with 1 tsp. reserved melted butter. Pour stuffing into pan and drizzle with remaining melted butter.",
      "Cover with foil; bake 25 minutes. Remove foil and bake until starting to brown on top, about 30 minutes more.",
      "Make ahead: Up to 2 days, chilled. Reheat at 350°, covered, until hot (about 30 minutes). Remove foil and cook 10 more minutes for a crunchy top layer.",
      "VARIATIONS",
      "Crisp-Top Sourdough Stuffing with Sausage and Greens: Add 8 oz. sautéed crumbled Italian ­sausage and 1 lb. briefly sautéed fresh spinach leaves to stuffing before baking.",
      "Scandinavian Stuffing: Replace sourdough with a 1-lb. loaf of crusty rye bread, then add 1 cup chopped fresh dill and 8 oz. diced smoked pork chops to stuffing before baking. Top with 2 tbsp. fresh dill sprigs before serving."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Slice bread into 1 1/2-in.-thick slices and tear into irregular 1- to 2-in. pieces. Spread on a rimmed baking sheet and leave to dry at room temperature until needed (up to 2 days). For the best stuffing, the bread should be very dry.\nPreheat oven to 350°. Melt butter in a large frying pan over medium heat. Pour out 2 tbsp. butter and set aside.\nAdd onion, celery, herbs, and 1/2 tsp. each salt and pepper to hot pan. Cook until onions are translucent and celery is tender-crisp, about 15 minutes. Transfer to a large bowl.\nAdd torn bread and broth to vegetables and mix in until bread is soaked. Add salt and pepper to taste.\nGenerously coat a 9- by 13-in. glass baking pan with 1 tsp. reserved melted butter. Pour stuffing into pan and drizzle with remaining melted butter.\nCover with foil; bake 25 minutes. Remove foil and bake until starting to brown on top, about 30 minutes more.\nMake ahead: Up to 2 days, chilled. Reheat at 350°, covered, until hot (about 30 minutes). Remove foil and cook 10 more minutes for a crunchy top layer.\nVARIATIONS\nCrisp-Top Sourdough Stuffing with Sausage and Greens: Add 8 oz. sautéed crumbled Italian ­sausage and 1 lb. briefly sautéed fresh spinach leaves to stuffing before baking.\nScandinavian Stuffing: Replace sourdough with a 1-lb. loaf of crusty rye bread, then add 1 cup chopped fresh dill and 8 oz. diced smoked pork chops to stuffing before baking. Top with 2 tbsp. fresh dill sprigs before serving.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("sunset.com")
    expect(recipe.canonical_url).to eq("https://sunset.com/recipe/crisp-top-sourdough-stuffing")
    expect(recipe.site_name).to eq("Sunset Magazine")
    expect(recipe.language).to be_nil
    expect(recipe.author).to eq("Angela Brassinga")
    expect(recipe.description).to eq("Although it's nearly as quick to make as boxed stuffing, this homemade version--soft in the middle and a little crunchy on the top--is prettier and certainly tastier.")
    expect(recipe.image).to eq("https://img.sunset02.com/sites/default/files/crisp-top-sourdough-stuffing-su.jpg?w=1285")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(90)
    expect(recipe.prep_time).to eq(90)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(3.0)
    expect(recipe.ratings_count).to eq(30)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "164 calories",
      "carbohydrateContent" => "25 g",
      "cholesterolContent" => "16 mg",
      "fatContent" => "4.3 g",
      "fiberContent" => "1.4 g",
      "proteinContent" => "5.6 g",
      "saturatedFatContent" => "2.6 g",
      "sodiumContent" => "363 mg"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 164.0 },
      { name: "carbohydrateContent", unit: "g", amount: 25.0 },
      { name: "cholesterolContent", unit: "mg", amount: 16.0 },
      { name: "fatContent", unit: "g", amount: 4.3 },
      { name: "fiberContent", unit: "g", amount: 1.4 },
      { name: "proteinContent", unit: "g", amount: 5.6 },
      { name: "saturatedFatContent", unit: "g", amount: 2.6 },
      { name: "sodiumContent", unit: "mg", amount: 363.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
