# frozen_string_literal: true

RSpec.describe "allnutritious.com" do
  subject(:recipe) { scrape_cassette("com/allnutritious", url: "https://allnutritious.com/crockpot-tortellini-chicken-soup/") }

  it "reads the title" do
    expect(recipe.title).to eq("Crockpot Tortellini Chicken Soup")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 medium chicken breasts (skinless and boneless)",
      "1 tbsp extra virgin olive oil",
      "1/2 large white onion (chopped)",
      "2 medium carrots (finely diced)",
      "4 cloves garlic (minced)",
      "2 sticks celery (chopped)",
      "1 28 oz can crushed tomatoes",
      "1 14 oz can diced tomatoes with juices",
      "1 tbsp Italian seasoning",
      "1 tbsp dried basil",
      "4 cups chicken broth",
      "2 9 oz packages refrigerated cheese tortellini",
      "2 cups fresh baby spinach",
      "3/4 cup heavy cream",
      "1/2 cup Parmesan cheese (grated)",
      "Salt and black pepper (to taste)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: nil, name: "medium chicken breasts" },
      { amount: 1.0, unit: "tbsp", name: "extra virgin olive oil" },
      { amount: 0.5, unit: nil, name: "large white onion" },
      { amount: 2.0, unit: nil, name: "medium carrots" },
      { amount: 4.0, unit: "cloves", name: "garlic" },
      { amount: 2.0, unit: "sticks", name: "celery" },
      { amount: 1.0, unit: "can", name: "crushed tomatoes" },
      { amount: 1.0, unit: "can", name: "diced tomatoes with juices" },
      { amount: 1.0, unit: "tbsp", name: "Italian seasoning" },
      { amount: 1.0, unit: "tbsp", name: "dried basil" },
      { amount: 4.0, unit: "cups", name: "chicken broth" },
      { amount: 2.0, unit: "packages", name: "refrigerated cheese tortellini" },
      { amount: 2.0, unit: "cups", name: "fresh baby spinach" },
      { amount: 0.75, unit: "cup", name: "heavy cream" },
      { amount: 0.5, unit: "cup", name: "Parmesan cheese" },
      { amount: nil, unit: nil, name: "Salt and black pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Place a skillet over medium-high heat and add olive oil, white onion, and saute for 5 minutes until the onion is translucent.",
      "Add in the carrots and cook for another 3-4 minutes. Then add garlic and saute for another 30 seconds.",
      "Transfer the cooked onion mixture into the crockpot. Add in the celery, chicken, crushed tomatoes, diced tomatoes, Italian seasoning, dried basil, and chicken broth. Give it a stir.",
      "Cook on high for 3-4 hours or on low for 6-8 hours.",
      "About 30 minutes prior to serving, remove the chicken breasts and shred them with two forks.",
      "Then, return the chicken to the crockpot, add in the packaged tortellini, baby spinach, heavy cream, and Parmesan. Turn the crockpot to high. Give it a stir occasionally for the last 30 minutes of cooking.",
      "Salt and pepper before serving according to your taste."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Place a skillet over medium-high heat and add olive oil, white onion, and saute for 5 minutes until the onion is translucent.\nAdd in the carrots and cook for another 3-4 minutes. Then add garlic and saute for another 30 seconds.\nTransfer the cooked onion mixture into the crockpot. Add in the celery, chicken, crushed tomatoes, diced tomatoes, Italian seasoning, dried basil, and chicken broth. Give it a stir.\nCook on high for 3-4 hours or on low for 6-8 hours.\nAbout 30 minutes prior to serving, remove the chicken breasts and shred them with two forks.\nThen, return the chicken to the crockpot, add in the packaged tortellini, baby spinach, heavy cream, and Parmesan. Turn the crockpot to high. Give it a stir occasionally for the last 30 minutes of cooking.\nSalt and pepper before serving according to your taste.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("allnutritious.com")
    expect(recipe.canonical_url).to eq("https://allnutritious.com/crockpot-tortellini-chicken-soup/")
    expect(recipe.site_name).to eq("All Nutritious")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Karolina Miles")
    expect(recipe.description).to eq("Cozy crockpot soup with tender chicken, cheesy tortellini, and rich tomato broth loaded with vegetables. A satisfying one-pot meal perfect for busy weeknights or lazy weekends when you need comfort food!")
    expect(recipe.image).to eq("https://allnutritious.com/wp-content/uploads/2025/12/Crockpot-Tortellini-Chicken-Soup-featured.jpg")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(405)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(390)
    expect(recipe.keywords).to eq(["Crockpot Tortellini Chicken Soup"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 bowl (18 oz)",
      "calories" => "495 kcal",
      "fatContent" => "19 g",
      "saturatedFatContent" => "9.3 g",
      "transFatContent" => "0.3 g",
      "cholesterolContent" => "129 mg",
      "sodiumContent" => "1234 mg",
      "carbohydrateContent" => "46 g",
      "fiberContent" => "5.7 g",
      "sugarContent" => "9 g",
      "proteinContent" => "36 g",
      "unsaturatedFatContent" => "7.4 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "bowl", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 495.0 },
      { name: "fatContent", unit: "g", amount: 19.0 },
      { name: "saturatedFatContent", unit: "g", amount: 9.3 },
      { name: "transFatContent", unit: "g", amount: 0.3 },
      { name: "cholesterolContent", unit: "mg", amount: 129.0 },
      { name: "sodiumContent", unit: "mg", amount: 1234.0 },
      { name: "carbohydrateContent", unit: "g", amount: 46.0 },
      { name: "fiberContent", unit: "g", amount: 5.7 },
      { name: "sugarContent", unit: "g", amount: 9.0 },
      { name: "proteinContent", unit: "g", amount: 36.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 7.4 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
