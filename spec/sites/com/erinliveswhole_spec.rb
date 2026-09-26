# frozen_string_literal: true

RSpec.describe "erinliveswhole.com" do
  subject(:recipe) { scrape_cassette("com/erinliveswhole", url: "https://www.erinliveswhole.com/green-protein-smoothie/") }

  it "reads the title" do
    expect(recipe.title).to eq("Green Protein Smoothie")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup ice",
      "1 frozen banana",
      "1 tbsp peanut butter",
      "3/4 cup frozen spinach or 1 cup fresh spinach",
      "1 scoop vanilla protein powder",
      "1 tbsp chia seeds",
      "1 - 1.5 cup almond milk (depending on desired thickness)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "ice" },
      { amount: 1.0, unit: nil, name: "frozen banana" },
      { amount: 1.0, unit: "tbsp", name: "peanut butter" },
      { amount: 0.75, unit: "cup", name: "frozen spinach or 1 cup fresh spinach" },
      { amount: 1.0, unit: "scoop", name: "vanilla protein powder" },
      { amount: 1.0, unit: "tbsp", name: "chia seeds" },
      { amount: 1.0, unit: "cup", name: "almond milk" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a high powered blender, add all ingredients in order as they are listed.",
      "Blend until completely smooth, you may need to add more almond milk as you go.",
      "Enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a high powered blender, add all ingredients in order as they are listed.\nBlend until completely smooth, you may need to add more almond milk as you go.\nEnjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("erinliveswhole.com")
    expect(recipe.canonical_url).to eq("https://www.erinliveswhole.com/green-protein-smoothie/")
    expect(recipe.site_name).to eq("Erin Lives Whole")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Erin Antoniak")
    expect(recipe.description).to eq("Start your day or refresh and cool down with a Green Protein Smoothie. Made with a banana, peanut butter, and chia seeds, it's the perfect breakfast or post-workout snack!")
    expect(recipe.image).to eq("https://www.erinliveswhole.com/wp-content/uploads/2022/02/greensmoothie-5.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("1 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(5)
    expect(recipe.keywords).to eq(["Green Protein Smoothie"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(8)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "414 kcal",
      "sugarContent" => "18 g",
      "sodiumContent" => "503 mg",
      "fatContent" => "17 g",
      "saturatedFatContent" => "3 g",
      "transFatContent" => "0.02 g",
      "carbohydrateContent" => "43 g",
      "fiberContent" => "9 g",
      "proteinContent" => "28 g",
      "cholesterolContent" => "62 mg",
      "unsaturatedFatContent" => "12 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 414.0 },
      { name: "sugarContent", unit: "g", amount: 18.0 },
      { name: "sodiumContent", unit: "mg", amount: 503.0 },
      { name: "fatContent", unit: "g", amount: 17.0 },
      { name: "saturatedFatContent", unit: "g", amount: 3.0 },
      { name: "transFatContent", unit: "g", amount: 0.02 },
      { name: "carbohydrateContent", unit: "g", amount: 43.0 },
      { name: "fiberContent", unit: "g", amount: 9.0 },
      { name: "proteinContent", unit: "g", amount: 28.0 },
      { name: "cholesterolContent", unit: "mg", amount: 62.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 12.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.erinliveswhole.com/")
  end
end
