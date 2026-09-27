# frozen_string_literal: true

RSpec.describe "ameessavorydish.com" do
  subject(:recipe) { scrape_cassette("com/ameessavorydish", url: "https://ameessavorydish.com/grilled-chicken-asparagus-salad-with-lemon-balsamic-vinaigrette-reciperedux/") }

  it "reads the title" do
    expect(recipe.title).to eq("Grilled Chicken Salad With Roasted Asparagus and Lemon Balsamic Vinaigrette")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "16 oz leftover grilled chicken (4- 4 oz boneless breasts)",
      "1 bunch of asparagus (about 20 spears)",
      "1 tbsp extra virgin olive oil",
      "5 oz mixed baby greens",
      "1/4 cup pine nuts (toasted)",
      "1 tbsp fresh lemon juice",
      "1 tsp fresh lemon zest (and extra for garnish)",
      "1 garlic clove (minced)",
      "2 tbsp white balsamic vinegar (*use a good quality gourmet balsamic)",
      "1/3 cup extra virgin olive oil",
      "1 tsp dijon mustard",
      "1 tsp honey",
      "salt and pepper (to taste)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 16.0, unit: "oz", name: "leftover grilled chicken" },
      { amount: 1.0, unit: "bunch", name: "asparagus" },
      { amount: 1.0, unit: "tbsp", name: "extra virgin olive oil" },
      { amount: 5.0, unit: "oz", name: "mixed baby greens" },
      { amount: 0.25, unit: "cup", name: "pine nuts" },
      { amount: 1.0, unit: "tbsp", name: "fresh lemon juice" },
      { amount: 1.0, unit: "tsp", name: "fresh lemon zest" },
      { amount: 1.0, unit: nil, name: "garlic clove" },
      { amount: 2.0, unit: "tbsp", name: "white balsamic vinegar" },
      { amount: 0.33, unit: "cup", name: "extra virgin olive oil" },
      { amount: 1.0, unit: "tsp", name: "dijon mustard" },
      { amount: 1.0, unit: "tsp", name: "honey" },
      { amount: nil, unit: nil, name: "salt and pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 425 degrees F.",
      "Rinse asparagus, pat dry and remove the ends.",
      "Place asparagus on a shallow roasting pan and toss with 1-2 tbsp EVOO, then sprinkle with coarse salt",
      "Roast for 10-15 min until lightly golden (cook time will depend on the thickness of the asparagus, so check them after the first 10 mins. I usually pull them out at 10-12 minutes.",
      "Heat a saute pan over medium heat and toast pine nuts, stirring constantly, until fragrant and lightly golden, this usually takes less than a minute. Set aside.",
      "Whisk together lemon juice, lemon zest, white balsamic vinegar, olive oil, garlic, honey, dijon and salt and pepper and set aside.",
      "Fill a large salad bowl, or 4 individual bowls with mixed greens.",
      "Chop roasted asparagus into thirds and place on top of greens.",
      "Add sliced grilled chicken (one breast each), then sprinkle pine nuts over top.",
      "Drizzle lemon vinaigrette dressing on top, garnish with extra lemon zest and serve immediately."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 5],
        ["For The Dressing", 8]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 425 degrees F.\nRinse asparagus, pat dry and remove the ends.\nPlace asparagus on a shallow roasting pan and toss with 1-2 tbsp EVOO, then sprinkle with coarse salt\nRoast for 10-15 min until lightly golden (cook time will depend on the thickness of the asparagus, so check them after the first 10 mins. I usually pull them out at 10-12 minutes.\nHeat a saute pan over medium heat and toast pine nuts, stirring constantly, until fragrant and lightly golden, this usually takes less than a minute. Set aside.\nWhisk together lemon juice, lemon zest, white balsamic vinegar, olive oil, garlic, honey, dijon and salt and pepper and set aside.\nFill a large salad bowl, or 4 individual bowls with mixed greens.\nChop roasted asparagus into thirds and place on top of greens.\nAdd sliced grilled chicken (one breast each), then sprinkle pine nuts over top.\nDrizzle lemon vinaigrette dressing on top, garnish with extra lemon zest and serve immediately.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("ameessavorydish.com")
    expect(recipe.canonical_url).to eq("https://ameessavorydish.com/grilled-chicken-asparagus-salad-with-lemon-balsamic-vinaigrette-reciperedux/")
    expect(recipe.site_name).to eq("Amee's Savory Dish")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Amee Livingston")
    expect(recipe.description).to eq("An easy and flavorful grilled chicken salad recipe made with roasted fresh asparagus, toasted pine nuts, and a delicious lemon balsamic vinaigrette dressing.")
    expect(recipe.image).to eq("https://ameessavorydish.com/wp-content/uploads/2015/03/Grilled-Chicken-Asparagus-Salad-4-e1588179825959.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(%w[chicken Salad])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 g",
      "calories" => "256 kcal",
      "carbohydrateContent" => "7 g",
      "proteinContent" => "32 g",
      "fatContent" => "11 g",
      "sodiumContent" => "63 mg",
      "fiberContent" => "6 g",
      "sugarContent" => "5 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "g", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 256.0 },
      { name: "carbohydrateContent", unit: "g", amount: 7.0 },
      { name: "proteinContent", unit: "g", amount: 32.0 },
      { name: "fatContent", unit: "g", amount: 11.0 },
      { name: "sodiumContent", unit: "mg", amount: 63.0 },
      { name: "fiberContent", unit: "g", amount: 6.0 },
      { name: "sugarContent", unit: "g", amount: 5.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
