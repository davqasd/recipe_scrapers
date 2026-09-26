# frozen_string_literal: true

RSpec.describe "tasty.co" do
  subject(:recipe) { scrape_cassette("co/tasty", url: "https://tasty.co/recipe/red-wine-braised-short-ribs-with-cashew-cauliflower-mash") }

  it "reads the title" do
    expect(recipe.title).to eq("Red Wine-Braised Short Ribs With Cashew Cauliflower Mash Recipe by Tasty")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 lb bone in beef short ribs, cut into 2-inch pieces",
      "1 tablespoon kosher salt",
      "2 teaspoons kosher salt",
      "1 ½ teaspoons freshly ground black pepper",
      "2 tablespoons avocado oil, divided",
      "1 large white onion, cut into 1 inch (2.5 cm) pieces",
      "4 celery stalks, cut into 1/2 inch (1 1/4 cm) diagonal pieces",
      "2 tablespoons tomato paste",
      "2 tablespoons all purpose flour",
      "2 cups dry red wine, such as cabernet sauvignon",
      "1 head garlic, halved crosswise",
      "6 small rainbow carrots, peeled and ends trimmed",
      "10 sprigs fresh thyme",
      "2 cups low sodium beef broth",
      "2 lb cauliflower, cut into florets",
      "1 cup raw cashews",
      "1 teaspoon garlic",
      "¼ cup fresh parsley, chopped, for garnish"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "lb", name: "bone in beef short ribs, cut into 2-inch pieces" },
      { amount: 1.0, unit: "tablespoon", name: "kosher salt" },
      { amount: 2.0, unit: "teaspoons", name: "kosher salt" },
      { amount: 1.5, unit: "teaspoons", name: "freshly ground black pepper" },
      { amount: 2.0, unit: "tablespoons", name: "avocado oil, divided" },
      { amount: 1.0, unit: nil, name: "large white onion, cut into 1 inch pieces" },
      { amount: 4.0, unit: nil, name: "celery stalks, cut into 1/2 inch diagonal pieces" },
      { amount: 2.0, unit: "tablespoons", name: "tomato paste" },
      { amount: 2.0, unit: "tablespoons", name: "all purpose flour" },
      { amount: 2.0, unit: "cups", name: "dry red wine, such as cabernet sauvignon" },
      { amount: 1.0, unit: "head", name: "garlic, halved crosswise" },
      { amount: 6.0, unit: nil, name: "small rainbow carrots, peeled and ends trimmed" },
      { amount: 10.0, unit: "sprigs", name: "fresh thyme" },
      { amount: 2.0, unit: "cups", name: "low sodium beef broth" },
      { amount: 2.0, unit: "lb", name: "cauliflower, cut into florets" },
      { amount: 1.0, unit: "cup", name: "raw cashews" },
      { amount: 1.0, unit: "teaspoon", name: "garlic" },
      { amount: 0.25, unit: "cup", name: "fresh parsley, chopped, for garnish" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Liberally season the short ribs on all sides with 1 tablespoon of salt and the pepper.",
      "Heat 2 tablespoons of avocado oil in a 5-quart (5 liter) ceramic pot over medium-high heat until shimmering. Working in batches, add 6-7 pieces of short rib at a time to the pot and sear without disturbing for 2-3 minutes, until a golden brown crust forms. Turn the pieces and continue cooking until seared well on all sides. Remove the short ribs from the pan and set aside, adding another tablespoon of avocado oil to the pot if needed, and repeat with the remaining short ribs.",
      "Reduce the heat to medium and add the onion, celery, and the remaining ½ teaspoon of salt. Sauté for 3-4 minutes, until the vegetables begin to soften and release moisture.",
      "Add the tomato paste and stir to coat the vegetables, then cook for 2 minutes. Add the flour and stir to coat the vegetables, then cook for 2-3 minutes more, until deep red in color. Pour in the wine and stir to release any browned bits from the bottom of the pot.",
      "Nestle the short ribs on top of the vegetables in the pot. Bring to a boil, then reduce the heat to medium-low and simmer until the liquid is reduced by about half, 15-20 minutes.",
      "Preheat the oven to 350˚F (180°C).",
      "Nestle the garlic between the short ribs, then place the carrots and thyme sprigs on top. Pour in the beef stock.",
      "Cover the pot and transfer to the oven. Bake for 2½ hours, until the meat is falling off the bone and fork tender.",
      "While the short ribs are in the oven, make the cauliflower mash: Fill a medium pot with about an inch of water and set a steamer basket inside. Cover and bring the water to a simmer over medium-high heat. Add the cauliflower to the basket and steam for 12-15 minutes, until mashable with the back of a fork, but not overcooked.",
      "Working in batches, transfer the steamed cauliflower to a fine-mesh strainer set over a bowl. Using another bowl that is slightly smaller than the strainer, press the bowl into the cauliflower to press excess liquid from the cauliflower. Repeat with remaining cauliflower. Discard the liquid and set the cauliflower aside.",
      "Add the cashews to the bowl of a food processor. Blend on high speed for 2-3 minutes, until the cashews are completely broken down and can be mashed into a paste between your fingers, scraping down the sides of the bowl as necessary.",
      "Add the strained cauliflower, garlic powder, and salt. Blend until smooth and well combined with the cashew paste.",
      "Transfer to a serving bowl and serve warm.",
      "Serve the braised short ribs and carrots with the cauliflower mash and garnish with parsley.",
      "Enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Liberally season the short ribs on all sides with 1 tablespoon of salt and the pepper.\nHeat 2 tablespoons of avocado oil in a 5-quart (5 liter) ceramic pot over medium-high heat until shimmering. Working in batches, add 6-7 pieces of short rib at a time to the pot and sear without disturbing for 2-3 minutes, until a golden brown crust forms. Turn the pieces and continue cooking until seared well on all sides. Remove the short ribs from the pan and set aside, adding another tablespoon of avocado oil to the pot if needed, and repeat with the remaining short ribs.\nReduce the heat to medium and add the onion, celery, and the remaining ½ teaspoon of salt. Sauté for 3-4 minutes, until the vegetables begin to soften and release moisture.\nAdd the tomato paste and stir to coat the vegetables, then cook for 2 minutes. Add the flour and stir to coat the vegetables, then cook for 2-3 minutes more, until deep red in color. Pour in the wine and stir to release any browned bits from the bottom of the pot.\nNestle the short ribs on top of the vegetables in the pot. Bring to a boil, then reduce the heat to medium-low and simmer until the liquid is reduced by about half, 15-20 minutes.\nPreheat the oven to 350˚F (180°C).\nNestle the garlic between the short ribs, then place the carrots and thyme sprigs on top. Pour in the beef stock.\nCover the pot and transfer to the oven. Bake for 2½ hours, until the meat is falling off the bone and fork tender.\nWhile the short ribs are in the oven, make the cauliflower mash: Fill a medium pot with about an inch of water and set a steamer basket inside. Cover and bring the water to a simmer over medium-high heat. Add the cauliflower to the basket and steam for 12-15 minutes, until mashable with the back of a fork, but not overcooked.\nWorking in batches, transfer the steamed cauliflower to a fine-mesh strainer set over a bowl. Using another bowl that is slightly smaller than the strainer, press the bowl into the cauliflower to press excess liquid from the cauliflower. Repeat with remaining cauliflower. Discard the liquid and set the cauliflower aside.\nAdd the cashews to the bowl of a food processor. Blend on high speed for 2-3 minutes, until the cashews are completely broken down and can be mashed into a paste between your fingers, scraping down the sides of the bowl as necessary.\nAdd the strained cauliflower, garlic powder, and salt. Blend until smooth and well combined with the cashew paste.\nTransfer to a serving bowl and serve warm.\nServe the braised short ribs and carrots with the cauliflower mash and garnish with parsley.\nEnjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("tasty.co")
    expect(recipe.canonical_url).to eq("https://tasty.co/recipe/red-wine-braised-short-ribs-with-cashew-cauliflower-mash")
    expect(recipe.site_name).to eq("tasty.co")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Crystal Hatch, Karlee Rotoly")
    expect(recipe.description).to eq("These fall-off-the-bone tender short ribs are slow-cooked in a flavorful red wine sauce and served with a creamy cashew cauliflower mash. It's a rich and satisfying dish that's perfect for a cozy night in.")
    expect(recipe.image).to eq("https://img.buzzfeed.com/thumbnailer-prod-us-east-1/video-api/assets/236025.jpg?resize=1200:*")
    expect(recipe.category).to eq("Meal")
    expect(recipe.cuisine).to eq("North American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(230)
    expect(recipe.prep_time).to eq(60)
    expect(recipe.cook_time).to eq(170)
    expect(recipe.keywords).to eq([
      "braised short ribs",
      "cashew cauliflower mash",
      "cauliflower mash",
      "creamy cauliflower mash",
      "dinner recipe",
      "gluten free",
      "gluten free recipe",
      "goodful - recipe",
      "healthy - goodful",
      "healthy recipe",
      "low carb cauliflower mash",
      "low carb mash",
      "low-carb",
      "red wine",
      "red wine braised short ribs",
      "red wine braiser recipe",
      "short ribs",
      "short ribs recipe",
      "tasty - recipe"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.7)
    expect(recipe.ratings_count).to eq(187)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "1257 calories",
      "carbohydrateContent" => "98 grams",
      "fatContent" => "56 grams",
      "fiberContent" => "18 grams",
      "proteinContent" => "78 grams",
      "sugarContent" => "27 grams"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 1257.0 },
      { name: "carbohydrateContent", unit: "g", amount: 98.0 },
      { name: "fatContent", unit: "g", amount: 56.0 },
      { name: "fiberContent", unit: "g", amount: 18.0 },
      { name: "proteinContent", unit: "g", amount: 78.0 },
      { name: "sugarContent", unit: "g", amount: 27.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
