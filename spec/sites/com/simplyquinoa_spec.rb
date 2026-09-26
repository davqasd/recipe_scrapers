# frozen_string_literal: true

RSpec.describe "simplyquinoa.com" do
  subject(:recipe) { scrape_cassette("com/simplyquinoa", url: "https://www.simplyquinoa.com/dairy-free-hot-chocolate/") }

  it "reads the title" do
    expect(recipe.title).to eq("Vegan Hot Chocolate")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups almond milk",
      "3 tablespoons unsweetened cocoa powder (or raw cacao)",
      "2 tablespoons coconut butter",
      "Pinch of ground cinnamon (optional)",
      "Stevia or monk fruit extract to taste"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "almond milk" },
      { amount: 3.0, unit: "tablespoons", name: "unsweetened cocoa powder" },
      { amount: 2.0, unit: "tablespoons", name: "coconut butter" },
      { amount: 1.0, unit: "Pinch", name: "ground cinnamon" },
      { amount: nil, unit: nil, name: "Stevia or monk fruit extract to taste" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Head the almond milk in a small saucepan.",
      "Once warm, whisk in unsweetened cocoa powder and coconut butter. Sprinkle in some cinnamon and stevia/monk fruit extract, based on your taste.",
      "Serve immediately and enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Head the almond milk in a small saucepan.\nOnce warm, whisk in unsweetened cocoa powder and coconut butter. Sprinkle in some cinnamon and stevia/monk fruit extract, based on your taste.\nServe immediately and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("simplyquinoa.com")
    expect(recipe.canonical_url).to eq("https://www.simplyquinoa.com/dairy-free-hot-chocolate/")
    expect(recipe.site_name).to eq("Simply Quinoa")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Alyssa")
    expect(recipe.description).to eq("Rich, chocolatey, and made from scratch, this vegan hot chocolate recipe is the perfect cure to the winter blues! It's dairy-free, refined sugar-free, and ultra-creamy thanks to coconut butter.")
    expect(recipe.image).to eq("https://www.simplyquinoa.com/wp-content/uploads/2012/12/dairy-free-hot-chocolate-10.jpg")
    expect(recipe.category).to eq("Beverage")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(5)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(5)
    expect(recipe.keywords).to eq(["vegan hot chocolate"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "145 kcal",
      "carbohydrateContent" => "8 g",
      "proteinContent" => "3 g",
      "fatContent" => "12 g",
      "saturatedFatContent" => "3 g",
      "sodiumContent" => "331 mg",
      "fiberContent" => "5 g",
      "sugarContent" => "1 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 145.0 },
      { name: "carbohydrateContent", unit: "g", amount: 8.0 },
      { name: "proteinContent", unit: "g", amount: 3.0 },
      { name: "fatContent", unit: "g", amount: 12.0 },
      { name: "saturatedFatContent", unit: "g", amount: 3.0 },
      { name: "sodiumContent", unit: "mg", amount: 331.0 },
      { name: "fiberContent", unit: "g", amount: 5.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
