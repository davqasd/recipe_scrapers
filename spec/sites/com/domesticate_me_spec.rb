# frozen_string_literal: true

RSpec.describe "domesticate-me.com" do
  subject(:recipe) { scrape_cassette("com/domesticate_me", url: "https://domesticate-me.com/dude-diet-buffalo-chicken-quinoa-bake/") }

  it "reads the title" do
    expect(recipe.title).to eq("The Dude Diet: Buffalo Chicken Quinoa Bake")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup quinoa",
      "1½ cups low-sodium chicken broth",
      "1 tablespoon extra-virgin olive oil",
      "1½ cups cauliflower “rice” (aka very finely chopped cauliflower florets)",
      "½ medium yellow onion (minced)",
      "½ cup finely chopped carrots",
      "½ cup finely chopped celery",
      "2 cups diced or shredded chicken breast",
      "½ cup Frank’s Red Hot Buffalo Wing Sauce (plus extra for serving)",
      "¾ cup grated sharp cheddar cheese",
      "¾ cup grated provolone cheese (Gouda is also great!)",
      "¼ cup whole-wheat panko breadcrumbs",
      "3 scallions (thinly sliced (optional))",
      "1½ cups nonfat plain Greek yogurt",
      "1 teaspoon dried parsley (crushed (Just use your fingers to crush the flakes.))",
      "½ teaspoon dried dill weed",
      "½ teaspoon kosher salt",
      "¼ teaspoon garlic powder",
      "¼ teaspoon black pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "quinoa" },
      { amount: 1.5, unit: "cups", name: "low-sodium chicken broth" },
      { amount: 1.0, unit: "tablespoon", name: "extra-virgin olive oil" },
      { amount: 1.5, unit: "cups", name: "cauliflower “rice”" },
      { amount: 0.5, unit: nil, name: "medium yellow onion" },
      { amount: 0.5, unit: "cup", name: "finely chopped carrots" },
      { amount: 0.5, unit: "cup", name: "finely chopped celery" },
      { amount: 2.0, unit: "cups", name: "diced or shredded chicken breast" },
      { amount: 0.5, unit: "cup", name: "Frank’s Red Hot Buffalo Wing Sauce" },
      { amount: 0.75, unit: "cup", name: "grated sharp cheddar cheese" },
      { amount: 0.75, unit: "cup", name: "grated provolone cheese" },
      { amount: 0.25, unit: "cup", name: "whole-wheat panko breadcrumbs" },
      { amount: 3.0, unit: nil, name: "scallions" },
      { amount: 1.5, unit: "cups", name: "nonfat plain Greek yogurt" },
      { amount: 1.0, unit: "teaspoon", name: "dried parsley" },
      { amount: 0.5, unit: "teaspoon", name: "dried dill weed" },
      { amount: 0.5, unit: "teaspoon", name: "kosher salt" },
      { amount: 0.25, unit: "teaspoon", name: "garlic powder" },
      { amount: 0.25, unit: "teaspoon", name: "black pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Combine the quinoa and chicken broth in a small saucepan and bring to a boil. Lower to a simmer, cover the saucepan with a lid, and cook for 14 minutes, or until all of the liquid has been absorbed. Let the quinoa rest, covered, for 5 minutes, then fluff with a fork.",
      "Meanwhile, whip up the yogurt ranch! In a medium bowl, whisk all the ingredients for the ranch. Briefly set that deliciousness aside.",
      "Pre-heat the oven to 375 degrees.",
      "Heat the olive oil in a large ovenproof skillet or shallow Dutch oven over medium heat. When the oil is hot and shimmering, add the cauliflower, onion, carrot, and celery. Cook for 5 minutes until the onion is translucent and the vegetables are tender. Add the cooked quinoa, chicken, and Frank’s to the pan and fold everything together. Turn off the heat and fold in 1 cup of the yogurt ranch and half of the cheddar and provolone. Taste the filling. Add a little extra Frank’s if you deem it necessary.",
      "Smooth the top of the filling with a spatula. Add the remaining cheese in an even layer and sprinkle with the panko.",
      "Bake for 25 minutes until the cheese is melted and bubbling. If you want to brown the top of the bake (I DO!!), pop the casserole under the broiler for 1 to 2 minutes until the bread crumbs turn golden brown.",
      "Whisk a tablespoon or so of water into the remaining yogurt ranch just until it has a drizzle-able consistency. Serve the quinoa bake drizzled with as much extra ranch and Frank’s as you like and garnish with scallions."
    ])
  end

  it "splits the ingredients under the heading the list carries" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([[nil, 13], ["For the Yogurt Ranch", 6]])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Combine the quinoa and chicken broth in a small saucepan and bring to a boil. Lower to a simmer, cover the saucepan with a lid, and cook for 14 minutes, or until all of the liquid has been absorbed. Let the quinoa rest, covered, for 5 minutes, then fluff with a fork.\nMeanwhile, whip up the yogurt ranch! In a medium bowl, whisk all the ingredients for the ranch. Briefly set that deliciousness aside.\nPre-heat the oven to 375 degrees.\nHeat the olive oil in a large ovenproof skillet or shallow Dutch oven over medium heat. When the oil is hot and shimmering, add the cauliflower, onion, carrot, and celery. Cook for 5 minutes until the onion is translucent and the vegetables are tender. Add the cooked quinoa, chicken, and Frank’s to the pan and fold everything together. Turn off the heat and fold in 1 cup of the yogurt ranch and half of the cheddar and provolone. Taste the filling. Add a little extra Frank’s if you deem it necessary.\nSmooth the top of the filling with a spatula. Add the remaining cheese in an even layer and sprinkle with the panko.\nBake for 25 minutes until the cheese is melted and bubbling. If you want to brown the top of the bake (I DO!!), pop the casserole under the broiler for 1 to 2 minutes until the bread crumbs turn golden brown.\nWhisk a tablespoon or so of water into the remaining yogurt ranch just until it has a drizzle-able consistency. Serve the quinoa bake drizzled with as much extra ranch and Frank’s as you like and garnish with scallions.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("domesticate-me.com")
    expect(recipe.canonical_url).to eq("https://domesticate-me.com/dude-diet-buffalo-chicken-quinoa-bake/")
    expect(recipe.site_name).to eq("Recipes by Serena")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("serenawolf")
    expect(recipe.description).to eq("Buffalo chicken, veggies, quinoa, two cheeses, and lightened up ranch dressing create flavor fireworks in this healthy(ish) whole-grain casserole.")
    expect(recipe.image).to eq("https://domesticate-me.com/wp-content/uploads/2018/03/Buffalo-Chicken-Quinoa-Bake-2.jpg")
    expect(recipe.category).to eq("Recipes")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(45)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.94)
    expect(recipe.ratings_count).to eq(32)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
