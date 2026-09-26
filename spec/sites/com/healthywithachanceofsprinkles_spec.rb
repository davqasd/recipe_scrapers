# frozen_string_literal: true

RSpec.describe "healthywithachanceofsprinkles.com" do
  subject(:recipe) { scrape_cassette("com/healthywithachanceofsprinkles", url: "https://healthywithachanceofsprinkles.com/protein-green-smoothie/") }

  it "reads the title" do
    expect(recipe.title).to eq("Protein Green Smoothie")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cups Spinach",
      "1 cups Kale",
      "1 /2 Banana (peeled)",
      "1/2 Apple (cored and sliced)",
      "1 cups water (with ice)",
      "1 lemon (juiced)",
      "1 tbsp orange juice",
      "1 scoop vanilla whey protein (or preferred protein powder)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cups", name: "Spinach" },
      { amount: 1.0, unit: "cups", name: "Kale" },
      { amount: 0.5, unit: nil, name: "Banana" },
      { amount: 0.5, unit: nil, name: "Apple" },
      { amount: 1.0, unit: "cups", name: "water" },
      { amount: 1.0, unit: nil, name: "lemon" },
      { amount: 1.0, unit: "tbsp", name: "orange juice" },
      { amount: 1.0, unit: "scoop", name: "vanilla whey protein" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Put all ingredients into the blender in order listed above.Blend",
      "Start blending at low speed. Increase speed to high once the spinach and kale start blending. Blend for 1 minute or until smooth.",
      "Pour and enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Put all ingredients into the blender in order listed above.Blend\nStart blending at low speed. Increase speed to high once the spinach and kale start blending. Blend for 1 minute or until smooth.\nPour and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("healthywithachanceofsprinkles.com")
    expect(recipe.canonical_url).to eq("https://healthywithachanceofsprinkles.com/protein-green-smoothie/")
    expect(recipe.site_name).to eq("Healthy With a Chance of Sprinkles")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jessica Stroup")
    expect(recipe.description).to eq("This Green Smoothie with Protein Powder is a great addition to your morning breakfast routine. This healthy drink is packed with healthy whole food ingredients, ready in less than 5 minutes, and is nutritionally balanced enough to keep you full all morning! Plus a meal prep freezer option!")
    expect(recipe.image).to eq("https://healthywithachanceofsprinkles.com/wp-content/uploads/2020/10/IMG_4222.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("1 servings")
    expect(recipe.total_time).to eq(5)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Green Smoothie", "Protein Smoothie"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(7)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 Smoothie",
      "calories" => "326 kcal",
      "carbohydrateContent" => "53 g",
      "proteinContent" => "30 g",
      "fatContent" => "3 g",
      "saturatedFatContent" => "1 g",
      "cholesterolContent" => "50 mg",
      "sodiumContent" => "109 mg",
      "fiberContent" => "6 g",
      "sugarContent" => "28 g",
      "unsaturatedFatContent" => "2 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "Smoothie", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 326.0 },
      { name: "carbohydrateContent", unit: "g", amount: 53.0 },
      { name: "proteinContent", unit: "g", amount: 30.0 },
      { name: "fatContent", unit: "g", amount: 3.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 50.0 },
      { name: "sodiumContent", unit: "mg", amount: 109.0 },
      { name: "fiberContent", unit: "g", amount: 6.0 },
      { name: "sugarContent", unit: "g", amount: 28.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 2.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
