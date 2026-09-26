# frozen_string_literal: true

RSpec.describe "daringgourmet.com" do
  subject(:recipe) { scrape_cassette("com/daringgourmet", url: "https://www.daringgourmet.com/tri-tip-roast-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Tri Tip Roast Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 pound beef tri tip roast",
      "1 tablespoon oil (I use avocado oil for high heat cooking)",
      "1 tablespoon butter",
      "1/4 pound pancetta or bacon (, diced (optional but contributes a ton of flavor))",
      "1 large yellow onion (, chopped)",
      "3 cloves garlic (, minced)",
      "2 carrots (, peeled and chopped)",
      "2 celery ribs (, chopped)",
      "3 tablespoons all-purpose flour",
      "1 cup dry red wine (, e.g. cabernet sauvignon, pinot noir, merlot)",
      "2 cups good chicken broth",
      "2 tablespoons tomato paste",
      "4 sprigs thyme, or 1 teaspoon dried",
      "3 sprigs rosemary, or 1 teaspoon dried",
      "2 bay leaves",
      "1 teaspoon kosher salt",
      "1/2 teaspoon freshly ground black pepper",
      "2 tablespoons butter"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "pound", name: "beef tri tip roast" },
      { amount: 1.0, unit: "tablespoon", name: "oil" },
      { amount: 1.0, unit: "tablespoon", name: "butter" },
      { amount: 0.25, unit: "pound", name: "pancetta or bacon" },
      { amount: 1.0, unit: nil, name: "large yellow onion" },
      { amount: 3.0, unit: "cloves", name: "garlic" },
      { amount: 2.0, unit: nil, name: "carrots" },
      { amount: 2.0, unit: nil, name: "celery ribs" },
      { amount: 3.0, unit: "tablespoons", name: "all-purpose flour" },
      { amount: 1.0, unit: "cup", name: "dry red wine" },
      { amount: 2.0, unit: "cups", name: "good chicken broth" },
      { amount: 2.0, unit: "tablespoons", name: "tomato paste" },
      { amount: 4.0, unit: "sprigs", name: "thyme, or 1 teaspoon dried" },
      { amount: 3.0, unit: "sprigs", name: "rosemary, or 1 teaspoon dried" },
      { amount: 2.0, unit: nil, name: "bay leaves" },
      { amount: 1.0, unit: "teaspoon", name: "kosher salt" },
      { amount: 0.5, unit: "teaspoon", name: "freshly ground black pepper" },
      { amount: 2.0, unit: "tablespoons", name: "butter" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Generously salt and pepper each side of the roast. Heat the oil and butter in a Dutch oven or medium pot and brown the shanks on both sides and transfer to a plate.",
      "Add the pancetta or bacon the Dutch oven and cook until browned, then add the onions and cook for 5-7 minutes until soft and translucent. Add the carrots, celery, and garlic and cook another 3-4 minutes until softened. Add the flour and stir until combined and cook for another minute. Add the wine and boil until reduced by half, deglazing the bottom of the pan to loosen any bits. Add the chicken broth, seasonings, and tomato paste. Return the tri tip roast to the pot, bring to a boil.Stovetop Method: Reduce the heat to a very low simmer, cover and simmer for 1 1/2 to 2 hours or until the meat is fork tender. Oven Method: Preheat the oven to 325 F / 165 C. Place the oven-save Dutch oven in the middle of the oven and cook for 2 1/2 to 3 hours or until tender.Remove the roast from the pot and place it on a cutting board covered with aluminum foil while you prepare the gravy. Discard the bay leaves.",
      "To Make the Gravy:You have a couple of options for the gravy: You can strain it to produce a \"lighter\", more transparent brown gravy, or you can use an immersion blender (or transfer it to an upright blender), to puree the vegetables as part of the gravy. It is entirely a matter of personal preference. Or, if you prefer a chunky sauce, just leave it as is and spoon it over the roast. If your gravy is too thin, you can dissolve a couple of teaspoons of cornstarch in a tablespoon of water and stir it into the gravy, letting it simmer while whisking until thickened. Stir in the butter at the very end until dissolved. Add salt and pepper to taste.Slice the tri tip roast and serve drizzled with some gravy with extra gravy at the table."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Generously salt and pepper each side of the roast. Heat the oil and butter in a Dutch oven or medium pot and brown the shanks on both sides and transfer to a plate.\nAdd the pancetta or bacon the Dutch oven and cook until browned, then add the onions and cook for 5-7 minutes until soft and translucent. Add the carrots, celery, and garlic and cook another 3-4 minutes until softened. Add the flour and stir until combined and cook for another minute. Add the wine and boil until reduced by half, deglazing the bottom of the pan to loosen any bits. Add the chicken broth, seasonings, and tomato paste. Return the tri tip roast to the pot, bring to a boil.Stovetop Method: Reduce the heat to a very low simmer, cover and simmer for 1 1/2 to 2 hours or until the meat is fork tender. Oven Method: Preheat the oven to 325 F / 165 C. Place the oven-save Dutch oven in the middle of the oven and cook for 2 1/2 to 3 hours or until tender.Remove the roast from the pot and place it on a cutting board covered with aluminum foil while you prepare the gravy. Discard the bay leaves.\nTo Make the Gravy:You have a couple of options for the gravy: You can strain it to produce a \"lighter\", more transparent brown gravy, or you can use an immersion blender (or transfer it to an upright blender), to puree the vegetables as part of the gravy. It is entirely a matter of personal preference. Or, if you prefer a chunky sauce, just leave it as is and spoon it over the roast. If your gravy is too thin, you can dissolve a couple of teaspoons of cornstarch in a tablespoon of water and stir it into the gravy, letting it simmer while whisking until thickened. Stir in the butter at the very end until dissolved. Add salt and pepper to taste.Slice the tri tip roast and serve drizzled with some gravy with extra gravy at the table.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("daringgourmet.com")
    expect(recipe.canonical_url).to eq("https://www.daringgourmet.com/tri-tip-roast-recipe/")
    expect(recipe.site_name).to eq("The Daring Gourmet")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Kimberly Killebrew")
    expect(recipe.description).to eq("Tender, flavorful beef served with the most exquisitely flavorful gravy, this Tri Tip Roast is perfect for every occasion!")
    expect(recipe.image).to eq("https://www.daringgourmet.com/wp-content/uploads/2025/03/Tri-Tip-Roast-Recipe-7.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(200)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(180)
    expect(recipe.keywords).to eq(["Tri Tip Roast"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(7)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "582 kcal",
      "carbohydrateContent" => "10 g",
      "proteinContent" => "51 g",
      "fatContent" => "33 g",
      "saturatedFatContent" => "13 g",
      "cholesterolContent" => "177 mg",
      "sodiumContent" => "1027 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "3 g",
      "unsaturatedFatContent" => "18 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 582.0 },
      { name: "carbohydrateContent", unit: "g", amount: 10.0 },
      { name: "proteinContent", unit: "g", amount: 51.0 },
      { name: "fatContent", unit: "g", amount: 33.0 },
      { name: "saturatedFatContent", unit: "g", amount: 13.0 },
      { name: "cholesterolContent", unit: "mg", amount: 177.0 },
      { name: "sodiumContent", unit: "mg", amount: 1027.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 3.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 18.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
