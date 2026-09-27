# frozen_string_literal: true

RSpec.describe "howtofeedaloon.com" do
  subject(:recipe) { scrape_cassette("com/howtofeedaloon", url: "https://howtofeedaloon.com/swedish-meatballs/") }

  it "reads the title" do
    expect(recipe.title).to eq("Swedish Meatballs")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 tbsp butter",
      "½ cup onion (finely chopped)",
      "1 cup breadcrumbs (fresh, from 2 white slices with crusts removed)",
      "¼ cup heavy cream",
      "1 lb ground beef (85% lean)",
      "½ lb ground pork",
      "1 large egg",
      "¼ cup parsley (fresh, chopped, plus more for garnish)",
      "1 tsp Kosher salt",
      "½ tsp black pepper",
      "½ tsp nutmeg (ground)",
      "¼ tsp ginger (ground)",
      "2 tbsp olive oil (more, as needed)",
      "3 tbsp unsalted butter",
      "3 tbsp all-purpose flour",
      "1½ cup beef broth",
      "⅓ cup coffee (strongly brewed)",
      "½ cup heavy cream",
      "½ tsp Kosher salt",
      "¼ tsp black pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "tbsp", name: "butter" },
      { amount: 0.5, unit: "cup", name: "onion" },
      { amount: 1.0, unit: "cup", name: "breadcrumbs" },
      { amount: 0.25, unit: "cup", name: "heavy cream" },
      { amount: 1.0, unit: "lb", name: "ground beef" },
      { amount: 0.5, unit: "lb", name: "ground pork" },
      { amount: 1.0, unit: nil, name: "large egg" },
      { amount: 0.25, unit: "cup", name: "parsley" },
      { amount: 1.0, unit: "tsp", name: "Kosher salt" },
      { amount: 0.5, unit: "tsp", name: "black pepper" },
      { amount: 0.5, unit: "tsp", name: "nutmeg" },
      { amount: 0.25, unit: "tsp", name: "ginger" },
      { amount: 2.0, unit: "tbsp", name: "olive oil" },
      { amount: 3.0, unit: "tbsp", name: "unsalted butter" },
      { amount: 3.0, unit: "tbsp", name: "all-purpose flour" },
      { amount: 1.5, unit: "cup", name: "beef broth" },
      { amount: 0.33, unit: "cup", name: "coffee" },
      { amount: 0.5, unit: "cup", name: "heavy cream" },
      { amount: 0.5, unit: "tsp", name: "Kosher salt" },
      { amount: 0.25, unit: "tsp", name: "black pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Start the Meatballs",
      "Heat the butter in a large non-stick skillet over medium heat. Add the onions and cook until soft, about 5 minutes. Let cool for about 10 minutes.",
      "Meanwhile, place the breadcrumbs in a bowl and pour the cream over them. Use your fingers to work the cream into the bread. Let it sit for 15 minutes (you can do this while you're sautéing and then cooling the onions).",
      "In a large bowl, add the beef, pork, egg, parsley, salt, pepper, nutmeg, ginger, sautéed onions, and soaked breadcrumbs. Use two wooden spoons (or your hands) to mix it. Make sure there are no large chunks of the soaked bread.",
      "Use a heaping tablespoon or a small ice cream scoop to form 1 oz balls. Place them on a baking sheet until all the balls have been formed. You have about 30 meatballs",
      "Heat a couple of tablespoons of olive oil over medium heat in your large skillet. Working in batches, add the meatballs to the hot skillet and use a couple of spoons to move them around so they brown all over but don't stick to the skillet. Once browned, transfer them to a platter (they won't be fully cooked at this point). Repeat with the remaining meatballs, adding more oil as needed.",
      "Make the Sauce and Finish the Dish",
      "Discard excess oil in the skillet. Melt the butter in the skillet over medium heat, using a spatula to scrape up any bits stuck to the pan. Add the flour and stir to combine; it should resemble wet sand. Cook, stirring often, for 1 to 2 minutes.",
      "Carefully whisk in the beef broth, coffee, and heavy cream. Stir in the salt and pepper. Continue stirring until slightly thickened, about 3 to 4 minutes. Allow the sauce to simmer for 10 minutes.",
      "Add the meatballs to the sauce and simmer on low for another 25 minutes. Either transfer to a platter or serve directly from the skillet. Sprinkle the extra chopped parsley over the top."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["For the Meatballs", 13],
        ["For the Sauce", 7]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Start the Meatballs\nHeat the butter in a large non-stick skillet over medium heat. Add the onions and cook until soft, about 5 minutes. Let cool for about 10 minutes.\nMeanwhile, place the breadcrumbs in a bowl and pour the cream over them. Use your fingers to work the cream into the bread. Let it sit for 15 minutes (you can do this while you're sautéing and then cooling the onions).\nIn a large bowl, add the beef, pork, egg, parsley, salt, pepper, nutmeg, ginger, sautéed onions, and soaked breadcrumbs. Use two wooden spoons (or your hands) to mix it. Make sure there are no large chunks of the soaked bread.\nUse a heaping tablespoon or a small ice cream scoop to form 1 oz balls. Place them on a baking sheet until all the balls have been formed. You have about 30 meatballs\nHeat a couple of tablespoons of olive oil over medium heat in your large skillet. Working in batches, add the meatballs to the hot skillet and use a couple of spoons to move them around so they brown all over but don't stick to the skillet. Once browned, transfer them to a platter (they won't be fully cooked at this point). Repeat with the remaining meatballs, adding more oil as needed.\nMake the Sauce and Finish the Dish\nDiscard excess oil in the skillet. Melt the butter in the skillet over medium heat, using a spatula to scrape up any bits stuck to the pan. Add the flour and stir to combine; it should resemble wet sand. Cook, stirring often, for 1 to 2 minutes.\nCarefully whisk in the beef broth, coffee, and heavy cream. Stir in the salt and pepper. Continue stirring until slightly thickened, about 3 to 4 minutes. Allow the sauce to simmer for 10 minutes.\nAdd the meatballs to the sauce and simmer on low for another 25 minutes. Either transfer to a platter or serve directly from the skillet. Sprinkle the extra chopped parsley over the top.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("howtofeedaloon.com")
    expect(recipe.canonical_url).to eq("https://howtofeedaloon.com/swedish-meatballs/")
    expect(recipe.site_name).to eq("How To Feed A Loon")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Kris Longwell")
    expect(recipe.description).to eq("Swedish Meatballs are always a crowd favorite. These meatballs are incredibly juicy and moist, and the sauce is deeply flavorful. You can make these several hours in advance and then keep them warm in a slow-cooker, if desired. They are great for parties, but also for a weeknight dinner with a side of mashed potatoes.")
    expect(recipe.image).to eq("https://howtofeedaloon.com/wp-content/uploads/2021/12/swedish-meatballsa-IG.jpg")
    expect(recipe.category).to eq("Appetizer or Entree")
    expect(recipe.cuisine).to eq("Swedish")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(55)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(40)
    expect(recipe.keywords).to eq(["how to make Swedish meatballs", "party food recipes", "Swedish meatbalss recipe"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "368 kcal",
      "carbohydrateContent" => "14 g",
      "proteinContent" => "19 g",
      "fatContent" => "24 g",
      "saturatedFatContent" => "8 g",
      "transFatContent" => "1 g",
      "cholesterolContent" => "133 mg",
      "sodiumContent" => "801 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "1 g",
      "unsaturatedFatContent" => "17 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 368.0 },
      { name: "carbohydrateContent", unit: "g", amount: 14.0 },
      { name: "proteinContent", unit: "g", amount: 19.0 },
      { name: "fatContent", unit: "g", amount: 24.0 },
      { name: "saturatedFatContent", unit: "g", amount: 8.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 133.0 },
      { name: "sodiumContent", unit: "mg", amount: 801.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 17.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#feastmobilemenu")
  end
end
