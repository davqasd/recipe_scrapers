# frozen_string_literal: true

RSpec.describe "notenoughcinnamon.com" do
  subject(:recipe) { scrape_cassette("com/notenoughcinnamon", url: "https://www.notenoughcinnamon.com/pina-colada-chia-pudding/") }

  it "reads the title" do
    expect(recipe.title).to eq("Pina Colada Chia Puddings")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup coconut milk (the kind in a can - full fat or light)",
      "1/4 cup chia seeds",
      "1 tablespoon maple syrup",
      "1 pinch salt",
      "1 teaspoon vanilla extract (ideally transparent to keep the mixture white)",
      "½ teaspoon coconut extract",
      "1 1/2 cups pineapple (chopped (see notes))",
      "2 tablespoons unsweetened coconut flakes"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "coconut milk" },
      { amount: 0.25, unit: "cup", name: "chia seeds" },
      { amount: 1.0, unit: "tablespoon", name: "maple syrup" },
      { amount: 1.0, unit: "pinch", name: "salt" },
      { amount: 1.0, unit: "teaspoon", name: "vanilla extract" },
      { amount: 0.5, unit: "teaspoon", name: "coconut extract" },
      { amount: 1.5, unit: "cups", name: "pineapple" },
      { amount: 2.0, unit: "tablespoons", name: "unsweetened coconut flakes" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "tart by whisking together coconut milk, chia seeds, maple syrup, salt, vanilla, and coconut extracts in a medium-sized bowl or container until combined. Cover and refrigerate overnight or at least 6 hours.",
      "Just before serving, blend pineapple chunks in a food processor or blender and puree until a very smooth smoothie-like consistency is reached (see notes for).",
      "To serve, stir coconut chia pudding and divide the chia pudding and pineapple mixture evenly in alternating layers. Top with shredded coconut."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("tart by whisking together coconut milk, chia seeds, maple syrup, salt, vanilla, and coconut extracts in a medium-sized bowl or container until combined. Cover and refrigerate overnight or at least 6 hours.\nJust before serving, blend pineapple chunks in a food processor or blender and puree until a very smooth smoothie-like consistency is reached (see notes for).\nTo serve, stir coconut chia pudding and divide the chia pudding and pineapple mixture evenly in alternating layers. Top with shredded coconut.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("notenoughcinnamon.com")
    expect(recipe.canonical_url).to eq("https://www.notenoughcinnamon.com/pina-colada-chia-pudding/")
    expect(recipe.site_name).to eq("Not Enough Cinnamon")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Marie")
    expect(recipe.description).to eq("Pina Colada Chia Puddings are an easy, healthy make-ahead breakfast or dessert that is perfect for lovers of tropical cocktails! Made with simple healthy ingredients including chia seeds, fresh pineapple, and coconut milk. Vegan and refined sugar-free!")
    expect(recipe.image).to eq("https://www.notenoughcinnamon.com/wp-content/uploads/2020/10/Pina-Colada-Chia-Pudding-2.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("3 servings")
    expect(recipe.total_time).to eq(485)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["coconut milk chia pudding", "vegan chia pudding"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(5)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "305 kcal",
      "carbohydrateContent" => "24 g",
      "proteinContent" => "5 g",
      "fatContent" => "23 g",
      "saturatedFatContent" => "17 g",
      "transFatContent" => "1 g",
      "sodiumContent" => "28 mg",
      "fiberContent" => "7 g",
      "sugarContent" => "13 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 305.0 },
      { name: "carbohydrateContent", unit: "g", amount: 24.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "fatContent", unit: "g", amount: 23.0 },
      { name: "saturatedFatContent", unit: "g", amount: 17.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 28.0 },
      { name: "fiberContent", unit: "g", amount: 7.0 },
      { name: "sugarContent", unit: "g", amount: 13.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
