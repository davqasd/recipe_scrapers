# frozen_string_literal: true

RSpec.describe "epicurious.com" do
  subject(:recipe) { scrape_cassette("com/epicurious", url: "https://www.epicurious.com/recipes/food/views/ba-syn-cheesy-apple-omelet") }

  it "reads the title" do
    expect(recipe.title).to eq("Cheesy Apple Omelet")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 large shallot, thinly sliced",
      "2 Tbsp. extra-virgin olive oil, divided",
      "¼ tsp. freshly ground pepper, plus more",
      "Kosher salt",
      "3 large eggs",
      "¼ cup coarsely grated Fontina cheese or sharp white cheddar",
      "½ small crisp apple (such as Fuji or Gala), very thinly sliced",
      "Dijon mustard (for serving; optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "large shallot, thinly sliced" },
      { amount: 2.0, unit: "Tbsp", name: "extra-virgin olive oil, divided" },
      { amount: 0.25, unit: "tsp", name: "freshly ground pepper, plus more" },
      { amount: nil, unit: nil, name: "Kosher salt" },
      { amount: 3.0, unit: nil, name: "large eggs" },
      { amount: 0.25, unit: "cup", name: "coarsely grated Fontina cheese or sharp white cheddar" },
      { amount: 0.5, unit: nil, name: "small crisp apple, very thinly sliced" },
      { amount: nil, unit: nil, name: "Dijon mustard" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Heat a 10\" carbon steel pan over medium-high 1 minute. (Add a flick of water: If the droplets bead and slide around surface before evaporating, the pan is ready; if they sizzle and immediately evaporate, heat another 30 seconds and try again.) Reduce heat to medium. (Alternatively, heat a 10\" nonstick pan over medium.) Cook 1 large shallot, thinly sliced, 1 Tbsp. extra-virgin olive oil, ¼ tsp. freshly ground pepper, and a pinch of kosher salt in pan, stirring often with a heatproof rubber spatula, until shallots are softened and deeply golden in spots and almost charred in others, 8–10 minutes. Scrape shallot onto a plate and wipe out any solids from pan.",
      "Meanwhile, beat 3 large eggs and a pinch of salt in a small bowl.",
      "Add remaining 1 Tbsp. extra-virgin olive oil to same pan and swirl to coat. Add eggs and immediately stir around with spatula, tilting pan to fill empty areas, 30 seconds. (If cooking in a carbon steel pan, you can use the same whisk or fork you used to beat the eggs if you’d like.) Continue to cook, agitating eggs and occasionally shaking pan and running spatula underneath to ensure eggs aren’t sticking, until surface of eggs looks somewhat set but still slightly shiny, about 30 seconds more. Lightly season with more pepper, then sprinkle ¼ cup coarsely grated Fontina cheese or sharp white cheddar over half of surface. Shingle ½ small crisp apple (such as Fuji or Gala), very thinly sliced, over cheese, then top with shallots. Gently run spatula underneath eggs and shake pan a bit to release, then fold empty side of eggs up and over filled side (use a larger flat spatula if you’re having trouble maneuvering omelet; it’s okay if filling isn’t completely covered). Remove pan from heat and let omelet sit 30 seconds to continue to set.",
      "Slide omelet out onto a plate and serve with Dijon mustard if desired."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Heat a 10\" carbon steel pan over medium-high 1 minute. (Add a flick of water: If the droplets bead and slide around surface before evaporating, the pan is ready; if they sizzle and immediately evaporate, heat another 30 seconds and try again.) Reduce heat to medium. (Alternatively, heat a 10\" nonstick pan over medium.) Cook 1 large shallot, thinly sliced, 1 Tbsp. extra-virgin olive oil, ¼ tsp. freshly ground pepper, and a pinch of kosher salt in pan, stirring often with a heatproof rubber spatula, until shallots are softened and deeply golden in spots and almost charred in others, 8–10 minutes. Scrape shallot onto a plate and wipe out any solids from pan.\nMeanwhile, beat 3 large eggs and a pinch of salt in a small bowl.\nAdd remaining 1 Tbsp. extra-virgin olive oil to same pan and swirl to coat. Add eggs and immediately stir around with spatula, tilting pan to fill empty areas, 30 seconds. (If cooking in a carbon steel pan, you can use the same whisk or fork you used to beat the eggs if you’d like.) Continue to cook, agitating eggs and occasionally shaking pan and running spatula underneath to ensure eggs aren’t sticking, until surface of eggs looks somewhat set but still slightly shiny, about 30 seconds more. Lightly season with more pepper, then sprinkle ¼ cup coarsely grated Fontina cheese or sharp white cheddar over half of surface. Shingle ½ small crisp apple (such as Fuji or Gala), very thinly sliced, over cheese, then top with shallots. Gently run spatula underneath eggs and shake pan a bit to release, then fold empty side of eggs up and over filled side (use a larger flat spatula if you’re having trouble maneuvering omelet; it’s okay if filling isn’t completely covered). Remove pan from heat and let omelet sit 30 seconds to continue to set.\nSlide omelet out onto a plate and serve with Dijon mustard if desired.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("epicurious.com")
    expect(recipe.canonical_url).to eq("https://www.bonappetit.com/recipe/cheesy-apple-omelet")
    expect(recipe.site_name).to eq("Epicurious")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Rebecca Firkser")
    expect(recipe.description).to eq("Fontina and fried shallots make this diner-style omelet perfectly acceptable dinner fare.")
    expect(recipe.image).to eq("https://assets.epicurious.com/photos/6aa06fc64e72e760c2194bf7/16:9/w_4992,h_2808,c_limit/omelette-for-one_RECIPE_V1_080526_14571_VOG_final.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("1 servings")
    expect(recipe.total_time).to eq(15)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["bon appétit", "egg", "omelet", "apple", "shallot", "fontina", "dinner", "breakfast", "lunch", "gluten free", "vegetarian", "nut free", "digital_syndication"])
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
    expect(recipe.links).to include("#main-content")
  end
end
