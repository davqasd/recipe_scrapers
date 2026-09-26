# frozen_string_literal: true

RSpec.describe "meganvskitchen.com" do
  subject(:recipe) { scrape_cassette("com/meganvskitchen", url: "https://meganvskitchen.com/crispy-ground-beef-tacos/") }

  it "reads the title" do
    expect(recipe.title).to eq("Crispy Beef Tacos (35 Minutes, 6 Ingredients!)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 pound lean ground beef (90%)",
      "1 packet of taco seasoning",
      "3/4 cup red enchilada sauce",
      "2 1/2 cups Oaxaca cheese or Mexican cheese or Monterey Jack",
      "10 corn tortillas",
      "1 tbs olive oil"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "pound", name: "lean ground beef" },
      { amount: 1.0, unit: "packet", name: "taco seasoning" },
      { amount: 0.75, unit: "cup", name: "red enchilada sauce" },
      { amount: 2.5, unit: "cups", name: "Oaxaca cheese or Mexican cheese or Monterey Jack" },
      { amount: 10.0, unit: nil, name: "corn tortillas" },
      { amount: 1.0, unit: "tbs", name: "olive oil" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 450F.",
      "Heat a skillet over medium-high heat. Brown the ground beef, breaking it up as it cooks. Stir in the taco seasoning and enchilada sauce. Bring to a simmer, then remove from heat.",
      "Wrap tortillas in a damp paper towel and microwave for 30–60 seconds until pliable.",
      "Brush one side of each tortilla with olive oil. Place the tortilla on a baking sheet, oiled side down. Add 2 tablespoons of cheese to half of the tortilla, top with ¼ cup of beef, then add 2 more tablespoons of cheese. Fold the tortilla over the filling.",
      "Repeat with the remaining tortillas and range the tacos in a single layer on your baking sheet.",
      "Bake for 16 minutes, or until tortillas are crispy and cheese is melted. Let tacos cool for 3 minutes before serving."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 450F.\nHeat a skillet over medium-high heat. Brown the ground beef, breaking it up as it cooks. Stir in the taco seasoning and enchilada sauce. Bring to a simmer, then remove from heat.\nWrap tortillas in a damp paper towel and microwave for 30–60 seconds until pliable.\nBrush one side of each tortilla with olive oil. Place the tortilla on a baking sheet, oiled side down. Add 2 tablespoons of cheese to half of the tortilla, top with ¼ cup of beef, then add 2 more tablespoons of cheese. Fold the tortilla over the filling.\nRepeat with the remaining tortillas and range the tacos in a single layer on your baking sheet.\nBake for 16 minutes, or until tortillas are crispy and cheese is melted. Let tacos cool for 3 minutes before serving.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("meganvskitchen.com")
    expect(recipe.canonical_url).to eq("https://meganvskitchen.com/crispy-ground-beef-tacos/")
    expect(recipe.site_name).to eq("Megan vs Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Megan Torres")
    expect(recipe.description).to eq("These Crispy Ground Beef Tacos are an easy weeknight win. They only take 35 minutes to make, and everyone will love dipping them in salsa, queso, or guacamole!")
    expect(recipe.image).to eq("https://meganvskitchen.com/wp-content/uploads/2023/07/Crispy-Beef-Tacos-Sheet-Pan.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("Mexican")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(35)
    expect(recipe.keywords).to eq(["Crispy Beef Tacos"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.55)
    expect(recipe.ratings_count).to eq(20)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "2 taco",
      "calories" => "524 kcal",
      "carbohydrateContent" => "28 g",
      "proteinContent" => "36 g",
      "fatContent" => "30 g",
      "saturatedFatContent" => "16 g",
      "transFatContent" => "0.6 g",
      "fiberContent" => "4 g",
      "sugarContent" => "4 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "taco", amount: 2.0 },
      { name: "calories", unit: "kcal", amount: 524.0 },
      { name: "carbohydrateContent", unit: "g", amount: 28.0 },
      { name: "proteinContent", unit: "g", amount: 36.0 },
      { name: "fatContent", unit: "g", amount: 30.0 },
      { name: "saturatedFatContent", unit: "g", amount: 16.0 },
      { name: "transFatContent", unit: "g", amount: 0.6 },
      { name: "fiberContent", unit: "g", amount: 4.0 },
      { name: "sugarContent", unit: "g", amount: 4.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://meganvskitchen.com/")
  end
end
