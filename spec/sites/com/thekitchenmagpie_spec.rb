# frozen_string_literal: true

RSpec.describe "thekitchenmagpie.com" do
  subject(:recipe) { scrape_cassette("com/thekitchenmagpie", url: "https://www.thekitchenmagpie.com/salmon-loaf/") }

  it "reads the title" do
    expect(recipe.title).to eq("Salmon Loaf")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "16 ounces of canned salmon (drained)",
      "1 cup seasoned fine breadcrumbs",
      "½ cup onion (finely chopped)",
      "1 tsp dill weed",
      "1/2 cup milk",
      "2 large eggs (beaten)",
      "1 tablespoon lemon juice",
      "½ tsp salt",
      "¼ tsp black pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 16.0, unit: "ounces", name: "canned salmon" },
      { amount: 1.0, unit: "cup", name: "seasoned fine breadcrumbs" },
      { amount: 0.5, unit: "cup", name: "onion" },
      { amount: 1.0, unit: "tsp", name: "dill weed" },
      { amount: 0.5, unit: "cup", name: "milk" },
      { amount: 2.0, unit: nil, name: "large eggs" },
      { amount: 1.0, unit: "tablespoon", name: "lemon juice" },
      { amount: 0.5, unit: "tsp", name: "salt" },
      { amount: 0.25, unit: "tsp", name: "black pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat your oven to 375 °F. Grease a baking sheet and set aside.",
      "Drain the salmon well and if desired, remove any skin and bones from the salmon. You can leave them in, some people love those the best! They will bake right in, don't worry.",
      "Flake the salmon with a fork and then mix with the breadcrumbs, onion, milk, dill, eggs, lemon juice, salt and pepper.",
      "With clean hands, shape into a loaf on the greased baking sheet.",
      "Bake for 40-50 minutes OR until nicely browned AND reaches an internal temperature of at least 165 °F.",
      "Let cool for 5 minutes, then slice and serve. Garnish with fresh parsley and lemon wedges. This is excellent with lemon juice squeezed on top!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat your oven to 375 °F. Grease a baking sheet and set aside.\nDrain the salmon well and if desired, remove any skin and bones from the salmon. You can leave them in, some people love those the best! They will bake right in, don't worry.\nFlake the salmon with a fork and then mix with the breadcrumbs, onion, milk, dill, eggs, lemon juice, salt and pepper.\nWith clean hands, shape into a loaf on the greased baking sheet.\nBake for 40-50 minutes OR until nicely browned AND reaches an internal temperature of at least 165 °F.\nLet cool for 5 minutes, then slice and serve. Garnish with fresh parsley and lemon wedges. This is excellent with lemon juice squeezed on top!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thekitchenmagpie.com")
    expect(recipe.canonical_url).to eq("https://www.thekitchenmagpie.com/salmon-loaf/")
    expect(recipe.site_name).to eq("The Kitchen Magpie")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Karlynn Johnston")
    expect(recipe.description).to eq("Skip the salmon cakes and make this great salmon loaf for dinner instead!")
    expect(recipe.image).to eq("https://www.thekitchenmagpie.com/wp-content/uploads/images/2021/02/salmonloafonplate.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(60)
    expect(recipe.keywords).to eq(["salmon loaf"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.72)
    expect(recipe.ratings_count).to eq(7)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "158 kcal",
      "carbohydrateContent" => "11 g",
      "proteinContent" => "17 g",
      "fatContent" => "5 g",
      "saturatedFatContent" => "1 g",
      "transFatContent" => "1 g",
      "cholesterolContent" => "94 mg",
      "sodiumContent" => "580 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "1 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 158.0 },
      { name: "carbohydrateContent", unit: "g", amount: 11.0 },
      { name: "proteinContent", unit: "g", amount: 17.0 },
      { name: "fatContent", unit: "g", amount: 5.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 94.0 },
      { name: "sodiumContent", unit: "mg", amount: 580.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
