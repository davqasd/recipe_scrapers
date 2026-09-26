# frozen_string_literal: true

RSpec.describe "lovingitvegan.com" do
  subject(:recipe) { scrape_cassette("com/lovingitvegan", url: "https://lovingitvegan.com/kale-smoothie/") }

  it "reads the title" do
    expect(recipe.title).to eq("Kale Smoothie")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 1/4 cups Soy Milk ((300ml) or Almond Milk)",
      "2 Frozen Bananas ((200g) previously peeled, broken into quarters and frozen for at least 12 hours)",
      "1/2 cup Raw Cashews (75g)",
      "2 cups Kale ((56g) Torn up, packed)",
      "4 Medjool Dates (Pitted)",
      "1 tsp Minced Ginger",
      "1/8 tsp Cinnamon",
      "1 Tbsp Lime Juice (freshly squeezed)",
      "1 cup Ice Cubes"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.25, unit: "cups", name: "Soy Milk" },
      { amount: 2.0, unit: nil, name: "Frozen Bananas" },
      { amount: 0.5, unit: "cup", name: "Raw Cashews" },
      { amount: 2.0, unit: "cups", name: "Kale" },
      { amount: 4.0, unit: nil, name: "Medjool Dates" },
      { amount: 1.0, unit: "tsp", name: "Minced Ginger" },
      { amount: 0.13, unit: "tsp", name: "Cinnamon" },
      { amount: 1.0, unit: "Tbsp", name: "Lime Juice" },
      { amount: 1.0, unit: "cup", name: "Ice Cubes" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Add the soy milk to your blender jug and then the frozen bananas, cashews, kale, dates, minced ginger, cinnamon and fresh lime juice. Top with ice cubes.",
      "Blend until very smooth.",
      "Pour out into glasses and serve immediately."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Add the soy milk to your blender jug and then the frozen bananas, cashews, kale, dates, minced ginger, cinnamon and fresh lime juice. Top with ice cubes.\nBlend until very smooth.\nPour out into glasses and serve immediately.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("lovingitvegan.com")
    expect(recipe.canonical_url).to eq("https://lovingitvegan.com/kale-smoothie/")
    expect(recipe.site_name).to eq("Loving It Vegan")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Alison Andrews")
    expect(recipe.description).to eq("Creamy and smooth kale smoothie with a gorgeous pale green color that tastes like a delicious ice-cold milkshake! Even if you hate greens you will love this smoothie!")
    expect(recipe.image).to eq("https://lovingitvegan.com/wp-content/uploads/2018/08/Kale-Smoothie-8.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["kale smoothie", "smoothies", "vegan kale smoothie"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["VeganDiet"])
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(17)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 Smoothie",
      "calories" => "373 kcal",
      "sugarContent" => "15.2 g",
      "sodiumContent" => "180 mg",
      "fatContent" => "19.5 g",
      "saturatedFatContent" => "3.7 g",
      "carbohydrateContent" => "42.6 g",
      "fiberContent" => "4.9 g",
      "proteinContent" => "13.8 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "Smoothie", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 373.0 },
      { name: "sugarContent", unit: "g", amount: 15.2 },
      { name: "sodiumContent", unit: "mg", amount: 180.0 },
      { name: "fatContent", unit: "g", amount: 19.5 },
      { name: "saturatedFatContent", unit: "g", amount: 3.7 },
      { name: "carbohydrateContent", unit: "g", amount: 42.6 },
      { name: "fiberContent", unit: "g", amount: 4.9 },
      { name: "proteinContent", unit: "g", amount: 13.8 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
