# frozen_string_literal: true

RSpec.describe "hungryhappens.net" do
  subject(:recipe) { scrape_cassette("net/hungryhappens", url: "https://hungryhappens.net/one-pot-vegetable-tortellini-soup/") }

  it "reads the title" do
    expect(recipe.title).to eq("One Pot Vegetable Tortellini Soup")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1/4 cup olive oil",
      "1 medium sweet onion (diced)",
      "4 medium carrots (diced)",
      "12 oz mushrooms (diced)",
      "4 celery ribs (diced)",
      "4 cloves garlic (minced)",
      "1 tsp paprika",
      "1 tbs Italian herb seasoning",
      "salt and pepper (to taste)",
      "2 tbs tomato paste",
      "1/2 cup dry white wine",
      "7 cups low sodium vegetable (or chicken broth)",
      "1½ lb cheese tortellini",
      "1/2 cup grated parmesan cheese",
      "1/2 cup heavy cream",
      "3 handfuls kale (chopped)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.25, unit: "cup", name: "olive oil" },
      { amount: 1.0, unit: nil, name: "medium sweet onion" },
      { amount: 4.0, unit: nil, name: "medium carrots" },
      { amount: 12.0, unit: "oz", name: "mushrooms" },
      { amount: 4.0, unit: nil, name: "celery ribs" },
      { amount: 4.0, unit: "cloves", name: "garlic" },
      { amount: 1.0, unit: "tsp", name: "paprika" },
      { amount: 1.0, unit: "tbs", name: "Italian herb seasoning" },
      { amount: nil, unit: nil, name: "salt and pepper" },
      { amount: 2.0, unit: "tbs", name: "tomato paste" },
      { amount: 0.5, unit: "cup", name: "dry white wine" },
      { amount: 7.0, unit: "cups", name: "low sodium vegetable" },
      { amount: 1.5, unit: "lb", name: "cheese tortellini" },
      { amount: 0.5, unit: "cup", name: "grated parmesan cheese" },
      { amount: 0.5, unit: "cup", name: "heavy cream" },
      { amount: 3.0, unit: "handfuls", name: "kale" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large pot, heat your oil on high. Once hot, add in the carrots and onion to saute for 3 minutes. Add in the mushrooms and celery and mix to combine and saute all for another few minutes. Next stir in the garlic for 30 seconds.",
      "Add in the paprika, Italian herb seasonings, salt and pepper to taste and tomato paste and stir to coat all. Next add in the wine and broth and bring to a boil. Simmer covered for 20 minutes or until the carrots are tender.",
      "Add in the tortellini and grated parmesan and boil for 5 minutes. Lastly stir in the heavy cream and kale - gently.",
      "Optional: Top with freshly grated parmesan, a light drizzle of olive oil and enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large pot, heat your oil on high. Once hot, add in the carrots and onion to saute for 3 minutes. Add in the mushrooms and celery and mix to combine and saute all for another few minutes. Next stir in the garlic for 30 seconds.\nAdd in the paprika, Italian herb seasonings, salt and pepper to taste and tomato paste and stir to coat all. Next add in the wine and broth and bring to a boil. Simmer covered for 20 minutes or until the carrots are tender.\nAdd in the tortellini and grated parmesan and boil for 5 minutes. Lastly stir in the heavy cream and kale - gently.\nOptional: Top with freshly grated parmesan, a light drizzle of olive oil and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hungryhappens.net")
    expect(recipe.canonical_url).to eq("https://hungryhappens.net/one-pot-vegetable-tortellini-soup/")
    expect(recipe.site_name).to eq("Hungry Happens")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Stella Drivas")
    expect(recipe.description).to eq("My one pot vegetable tortellini soup is a perfectly flavored and cozy soup that will nourish and comfort your loved ones.")
    expect(recipe.image).to eq("https://hungryhappens.net/wp-content/uploads/2022/12/IMG_2810-scaled.jpeg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.97)
    expect(recipe.ratings_count).to eq(90)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "944 kcal",
      "carbohydrateContent" => "101 g",
      "proteinContent" => "37 g",
      "fatContent" => "43 g",
      "saturatedFatContent" => "16 g",
      "cholesterolContent" => "109 mg",
      "sodiumContent" => "1100 mg",
      "fiberContent" => "13 g",
      "sugarContent" => "18 g",
      "unsaturatedFatContent" => "15 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 944.0 },
      { name: "carbohydrateContent", unit: "g", amount: 101.0 },
      { name: "proteinContent", unit: "g", amount: 37.0 },
      { name: "fatContent", unit: "g", amount: 43.0 },
      { name: "saturatedFatContent", unit: "g", amount: 16.0 },
      { name: "cholesterolContent", unit: "mg", amount: 109.0 },
      { name: "sodiumContent", unit: "mg", amount: 1100.0 },
      { name: "fiberContent", unit: "g", amount: 13.0 },
      { name: "sugarContent", unit: "g", amount: 18.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 15.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
