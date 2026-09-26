# frozen_string_literal: true

RSpec.describe "kristineskitchenblog.com" do
  subject(:recipe) { scrape_cassette("com/kristineskitchenblog", url: "https://kristineskitchenblog.com/berry-smoothie/") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy Berry Smoothie")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup frozen strawberries",
      "½ cup frozen raspberries",
      "½ cup frozen blueberries",
      "½ medium banana*",
      "¼ cup plain Greek yogurt*",
      "¾ cup unsweetened almond milk (or other nondairy or dairy milk)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "frozen strawberries" },
      { amount: 0.5, unit: "cup", name: "frozen raspberries" },
      { amount: 0.5, unit: "cup", name: "frozen blueberries" },
      { amount: 0.5, unit: nil, name: "medium banana*" },
      { amount: 0.25, unit: "cup", name: "plain Greek yogurt*" },
      { amount: 0.75, unit: "cup", name: "unsweetened almond milk" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Place all ingredients in a blender and blend until smooth, starting with the blender on low speed and then gradually increasing the speed to fully blend the smoothie. If the smoothie is too thick, blend in a little bit more almond milk. Serve immediately."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Place all ingredients in a blender and blend until smooth, starting with the blender on low speed and then gradually increasing the speed to fully blend the smoothie. If the smoothie is too thick, blend in a little bit more almond milk. Serve immediately.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("kristineskitchenblog.com")
    expect(recipe.canonical_url).to eq("https://kristineskitchenblog.com/berry-smoothie/")
    expect(recipe.site_name).to eq("Kristine's Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Kristine Rosenblatt")
    expect(recipe.description).to eq("This refreshing berry smoothie is bursting with sweet berry flavor! It's made with three kinds of berries, or you can use a package of frozen mixed berries. Enjoy it for breakfast or a snack!")
    expect(recipe.image).to eq("https://kristineskitchenblog.com/wp-content/uploads/2022/02/best-berry-smoothie-recipe-06.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("1 servings")
    expect(recipe.total_time).to eq(5)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["berry smoothie"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.75)
    expect(recipe.ratings_count).to eq(4)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "2 cups",
      "calories" => "228 kcal",
      "carbohydrateContent" => "45 g",
      "proteinContent" => "9 g",
      "fatContent" => "4 g",
      "saturatedFatContent" => "1 g",
      "cholesterolContent" => "3 mg",
      "sodiumContent" => "265 mg",
      "fiberContent" => "11 g",
      "sugarContent" => "26 g",
      "unsaturatedFatContent" => "3 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "cups", amount: 2.0 },
      { name: "calories", unit: "kcal", amount: 228.0 },
      { name: "carbohydrateContent", unit: "g", amount: 45.0 },
      { name: "proteinContent", unit: "g", amount: 9.0 },
      { name: "fatContent", unit: "g", amount: 4.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 3.0 },
      { name: "sodiumContent", unit: "mg", amount: 265.0 },
      { name: "fiberContent", unit: "g", amount: 11.0 },
      { name: "sugarContent", unit: "g", amount: 26.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 3.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
