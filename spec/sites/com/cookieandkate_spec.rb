# frozen_string_literal: true

RSpec.describe "cookieandkate.com" do
  subject(:recipe) { scrape_cassette("com/cookieandkate", url: "https://cookieandkate.com/broccoli-cheddar-spinach-frittata/") }

  it "reads the title" do
    expect(recipe.title).to eq("Broccoli, Cheddar & Spinach Frittata")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "8 SimplyNature Organic Cage Free Eggs",
      "½ cup milk of choice",
      "2 small-to-medium cloves garlic, pressed or minced",
      "½ teaspoon sea salt, divided",
      "Freshly ground black pepper",
      "1 cup freshly grated cheddar cheese, divided",
      "1 tablespoon SimplyNature Organic Extra Virgin Olive Oil, more as needed",
      "1 small yellow onion, chopped",
      "⅓ cup water",
      "2 cups thinly sliced broccoli florets",
      "2 cups SimplyNature Organic Baby Spinach, roughly chopped",
      "⅓ cup thinly sliced green onions"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 8.0, unit: nil, name: "SimplyNature Organic Cage Free Eggs" },
      { amount: 0.5, unit: "cup", name: "milk of choice" },
      { amount: 2.0, unit: "cloves", name: "garlic, pressed or minced" },
      { amount: 0.5, unit: "teaspoon", name: "sea salt, divided" },
      { amount: nil, unit: nil, name: "Freshly ground black pepper" },
      { amount: 1.0, unit: "cup", name: "freshly grated cheddar cheese, divided" },
      { amount: 1.0, unit: "tablespoon", name: "SimplyNature Organic Extra Virgin Olive Oil, more as needed" },
      { amount: 1.0, unit: nil, name: "small yellow onion, chopped" },
      { amount: 0.33, unit: "cup", name: "water" },
      { amount: 2.0, unit: "cups", name: "thinly sliced broccoli florets" },
      { amount: 2.0, unit: "cups", name: "SimplyNature Organic Baby Spinach, roughly chopped" },
      { amount: 0.33, unit: "cup", name: "thinly sliced green onions" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 425 °F. In a large bowl, whisk together the eggs, milk, garlic, ¼ teaspoon of the salt and about 5 twists of freshly ground black pepper until well blended. Then whisk in about half of the cheese, reserving the other half for later.",
      "In a 10-inch, well-seasoned cast iron skillet or oven-safe sauté pan, warm the olive oil over medium heat until shimmering. Add the onion and the remaining ¼ teaspoon salt. Cook, stirring frequently, until the onion is tender and translucent, about 3 to 5 minutes.",
      "Add the broccoli and water to the pan, then cover it with a lid (or a baking sheet) and steam the mixture until the broccoli is brighter green and easily pierced by a fork, about 2 to 3 minutes. Uncover, and add the spinach and green onions. Cook, stirring constantly, until the spinach has wilted, about 30 to 60 seconds.",
      "Arrange the mixture in an even layer across the skillet. Whisk the egg mixture one last time and pour it into the pan. Sprinkle the frittata with the remaining cheese. Put the pan in the oven and bake until you can shimmy the pan by the handle (careful, it’s hot!) and see that the middle is just barely set, about 12 to 15 minutes.",
      "Once the frittata is done baking, let it rest for 5 to 10 minutes before slicing it into 6 large or 8 smaller wedges. Serve immediately. Leftover frittata will keep well, covered and refrigerated, for up to 3 days. Enjoy chilled or gently reheat."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 425 °F. In a large bowl, whisk together the eggs, milk, garlic, ¼ teaspoon of the salt and about 5 twists of freshly ground black pepper until well blended. Then whisk in about half of the cheese, reserving the other half for later.\nIn a 10-inch, well-seasoned cast iron skillet or oven-safe sauté pan, warm the olive oil over medium heat until shimmering. Add the onion and the remaining ¼ teaspoon salt. Cook, stirring frequently, until the onion is tender and translucent, about 3 to 5 minutes.\nAdd the broccoli and water to the pan, then cover it with a lid (or a baking sheet) and steam the mixture until the broccoli is brighter green and easily pierced by a fork, about 2 to 3 minutes. Uncover, and add the spinach and green onions. Cook, stirring constantly, until the spinach has wilted, about 30 to 60 seconds.\nArrange the mixture in an even layer across the skillet. Whisk the egg mixture one last time and pour it into the pan. Sprinkle the frittata with the remaining cheese. Put the pan in the oven and bake until you can shimmy the pan by the handle (careful, it’s hot!) and see that the middle is just barely set, about 12 to 15 minutes.\nOnce the frittata is done baking, let it rest for 5 to 10 minutes before slicing it into 6 large or 8 smaller wedges. Serve immediately. Leftover frittata will keep well, covered and refrigerated, for up to 3 days. Enjoy chilled or gently reheat.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cookieandkate.com")
    expect(recipe.canonical_url).to eq("https://cookieandkate.com/broccoli-cheddar-spinach-frittata/")
    expect(recipe.site_name).to eq("Cookie and Kate")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Cookie and Kate")
    expect(recipe.description).to eq("This spinach, broccoli and cheddar frittata recipe is a simple breakfast, brunch or dinner! It's vegetarian and gluten free. Recipe yields 6 large or 8 more modest slices.")
    expect(recipe.image).to eq("https://cookieandkate.com/images/2017/02/broccoli-cheddar-frittata-225x225.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to eq("Stovetop and Baked")
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to eq(["Broccoli Cheddar Frittata"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.9)
    expect(recipe.ratings_count).to eq(71)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 slice",
      "calories" => "153 calories",
      "sugarContent" => "1.1 g",
      "sodiumContent" => "316 mg",
      "fatContent" => "10.9 g",
      "saturatedFatContent" => "4.6 g",
      "transFatContent" => "0 g",
      "carbohydrateContent" => "3.7 g",
      "fiberContent" => "1 g",
      "proteinContent" => "6.7 g",
      "cholesterolContent" => "178.6 mg"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "slice", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 153.0 },
      { name: "sugarContent", unit: "g", amount: 1.1 },
      { name: "sodiumContent", unit: "mg", amount: 316.0 },
      { name: "fatContent", unit: "g", amount: 10.9 },
      { name: "saturatedFatContent", unit: "g", amount: 4.6 },
      { name: "transFatContent", unit: "g", amount: 0.0 },
      { name: "carbohydrateContent", unit: "g", amount: 3.7 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "proteinContent", unit: "g", amount: 6.7 },
      { name: "cholesterolContent", unit: "mg", amount: 178.6 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
