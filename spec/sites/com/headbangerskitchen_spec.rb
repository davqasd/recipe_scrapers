# frozen_string_literal: true

RSpec.describe "headbangerskitchen.com" do
  subject(:recipe) { scrape_cassette("com/headbangerskitchen", url: "https://headbangerskitchen.com/keto-omelet-indian-style/") }

  it "reads the title" do
    expect(recipe.title).to eq("Indian Style Omelet")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 eggs",
      "20 g cheddar cheese (grated (2 tbsp))",
      "¼ red onion (finely diced)",
      "15 ml heavy cream (1 tbsp)",
      "½ tsp turmeric",
      "½ tsp Kashmiri red chili powder",
      "15 g ghee (1 tbsp)",
      "1 g cilantro (chopped (½ tsp))",
      "Salt and black pepper (to taste)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: nil, name: "eggs" },
      { amount: 20.0, unit: "g", name: "cheddar cheese" },
      { amount: 0.25, unit: nil, name: "red onion" },
      { amount: 15.0, unit: "ml", name: "heavy cream" },
      { amount: 0.5, unit: "tsp", name: "turmeric" },
      { amount: 0.5, unit: "tsp", name: "Kashmiri red chili powder" },
      { amount: 15.0, unit: "g", name: "ghee" },
      { amount: 1.0, unit: "g", name: "cilantro" },
      { amount: nil, unit: nil, name: "Salt and black pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Crack the eggs into a mixing bowl. Add the diced red onion, chopped cilantro, turmeric, Kashmiri chili powder, heavy cream, salt, and black pepper. Whisk until fully combined.",
      "Heat the ghee in a nonstick frying pan over medium heat. Once melted and hot, pour in the egg mixture and spread it evenly across the pan.",
      "Sprinkle the grated cheddar evenly over the omelet. Cover with a lid and cook for about 4 minutes, until the eggs are mostly set.",
      "Fold the omelet and cook for another 30 to 60 seconds, until fully cooked through but still tender.",
      "Remove from the pan and serve immediately."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Crack the eggs into a mixing bowl. Add the diced red onion, chopped cilantro, turmeric, Kashmiri chili powder, heavy cream, salt, and black pepper. Whisk until fully combined.\nHeat the ghee in a nonstick frying pan over medium heat. Once melted and hot, pour in the egg mixture and spread it evenly across the pan.\nSprinkle the grated cheddar evenly over the omelet. Cover with a lid and cook for about 4 minutes, until the eggs are mostly set.\nFold the omelet and cook for another 30 to 60 seconds, until fully cooked through but still tender.\nRemove from the pan and serve immediately.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("headbangerskitchen.com")
    expect(recipe.canonical_url).to eq("https://headbangerskitchen.com/keto-omelet-indian-style/")
    expect(recipe.site_name).to eq("Headbangerskitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Sahil Makhija")
    expect(recipe.description).to eq("This Indian-style omelet is packed with spices, cheddar cheese, and red onion. It makes a quick and flavorful breakfast served with a simple side salad.")
    expect(recipe.image).to eq("https://headbangerskitchen.com/wp-content/uploads/2020/11/KETOMASALAOMELET-Vertical.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("Indian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("1 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(5)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.41)
    expect(recipe.ratings_count).to eq(10)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "468 kcal",
      "carbohydrateContent" => "5 g",
      "proteinContent" => "22 g",
      "fatContent" => "40 g",
      "saturatedFatContent" => "21 g",
      "transFatContent" => "0.1 g",
      "cholesterolContent" => "566 mg",
      "sodiumContent" => "325 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "2 g",
      "unsaturatedFatContent" => "16 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 468.0 },
      { name: "carbohydrateContent", unit: "g", amount: 5.0 },
      { name: "proteinContent", unit: "g", amount: 22.0 },
      { name: "fatContent", unit: "g", amount: 40.0 },
      { name: "saturatedFatContent", unit: "g", amount: 21.0 },
      { name: "transFatContent", unit: "g", amount: 0.1 },
      { name: "cholesterolContent", unit: "mg", amount: 566.0 },
      { name: "sodiumContent", unit: "mg", amount: 325.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 16.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
