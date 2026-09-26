# frozen_string_literal: true

RSpec.describe "cookwithdana.com" do
  subject(:recipe) { scrape_cassette("com/cookwithdana", url: "https://cookwithdana.com/korean-spicy-marinated-tofu/") }

  it "reads the title" do
    expect(recipe.title).to eq("Korean Spicy Marinated Tofu")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 silken tofu",
      "1 green onion",
      "2 garlic (grated)",
      "1.5 tablespoon gochugaru (korean red pepper flakes)",
      "1 tablespoon honey",
      "1.5 tablespoon fish sauce (or sub with soy sauce)",
      "1 tablespoon sesame oil",
      "sesame seeds"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "silken tofu" },
      { amount: 1.0, unit: nil, name: "green onion" },
      { amount: 2.0, unit: nil, name: "garlic" },
      { amount: 1.5, unit: "tablespoon", name: "gochugaru" },
      { amount: 1.0, unit: "tablespoon", name: "honey" },
      { amount: 1.5, unit: "tablespoon", name: "fish sauce" },
      { amount: 1.0, unit: "tablespoon", name: "sesame oil" },
      { amount: nil, unit: nil, name: "sesame seeds" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Slice green onions and grate garlic.",
      "To make the sauce, combine gochugaru, honey, fish sauce (or soy sauce), sesame oil, sesame seeds, sliced green onions, and grated garlic until well combined.",
      "Boil silken tofu for in boiling water for 2 minutes.",
      "Strain the tofu well so the water doesn’t get into the sauce.",
      "In a airtight container, add tofu and your sauce on top. Marinate for at least 1 hour to overnight for the best flavor. Enjoy with hot rice!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Slice green onions and grate garlic.\nTo make the sauce, combine gochugaru, honey, fish sauce (or soy sauce), sesame oil, sesame seeds, sliced green onions, and grated garlic until well combined.\nBoil silken tofu for in boiling water for 2 minutes.\nStrain the tofu well so the water doesn’t get into the sauce.\nIn a airtight container, add tofu and your sauce on top. Marinate for at least 1 hour to overnight for the best flavor. Enjoy with hot rice!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cookwithdana.com")
    expect(recipe.canonical_url).to eq("https://cookwithdana.com/korean-spicy-marinated-tofu/")
    expect(recipe.site_name).to eq("Cook With Dana")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Dana Rao")
    expect(recipe.description).to eq("Korean Spicy Marinated Tofu is tofu marinated in a Korean sweet and spicy sauce inspired by the popular Yangnyeom (means spicy sauce) flavor. This recipe is made under 10 minutes and is perfect for vegetarians!")
    expect(recipe.image).to eq("https://cookwithdana.com/wp-content/uploads/2026/01/korean-spicy-marinated-tofu-firstphoto.jpg")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("korean")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(5)
    expect(recipe.keywords).to eq([
      "10 minute tofu",
      "easy Korean tofu recipe",
      "Korean marinated tofu",
      "Korean tofu meal prep",
      "spicy Korean tofu",
      "tofu marinated in Korean sauce",
      "Vegan Korean recipes",
      "weeknight Korean tofu recipe"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "122 kcal",
      "carbohydrateContent" => "14 g",
      "proteinContent" => "2 g",
      "fatContent" => "8 g",
      "saturatedFatContent" => "1 g",
      "sodiumContent" => "1160 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "10 g",
      "unsaturatedFatContent" => "6 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 122.0 },
      { name: "carbohydrateContent", unit: "g", amount: 14.0 },
      { name: "proteinContent", unit: "g", amount: 2.0 },
      { name: "fatContent", unit: "g", amount: 8.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 1160.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 10.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 6.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
