# frozen_string_literal: true

RSpec.describe "aubreyskitchen.com" do
  subject(:recipe) { scrape_cassette("com/aubreyskitchen", url: "https://aubreyskitchen.com/pistachio-coquito/") }

  it "reads the title" do
    expect(recipe.title).to eq("Pistachio Coquito")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1.5 cup Light or dark rum",
      "14 oz can sweetened condensed milk (Note: Reserve 1 tablespoons for optional shredded coconut rim.)",
      "1 cup coconut milk (regular or reduced fat)",
      "1 cup heavy cream",
      "½ cup evaporated milk",
      "1 cup pistachio ice cream",
      "2 tsp pistachio extract",
      "1 tsp vanilla extract",
      "¼ tsp cinnamon",
      "¼ tsp nutmeg",
      "¼ tsp clove",
      "1 Optional Garnish: Shredded coconut or crusted pistachios"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.5, unit: "cup", name: "Light or dark rum" },
      { amount: 14.0, unit: "oz", name: "can sweetened condensed milk" },
      { amount: 1.0, unit: "cup", name: "coconut milk" },
      { amount: 1.0, unit: "cup", name: "heavy cream" },
      { amount: 0.5, unit: "cup", name: "evaporated milk" },
      { amount: 1.0, unit: "cup", name: "pistachio ice cream" },
      { amount: 2.0, unit: "tsp", name: "pistachio extract" },
      { amount: 1.0, unit: "tsp", name: "vanilla extract" },
      { amount: 0.25, unit: "tsp", name: "cinnamon" },
      { amount: 0.25, unit: "tsp", name: "nutmeg" },
      { amount: 0.25, unit: "tsp", name: "clove" },
      { amount: 1.0, unit: nil, name: "Optional Garnish: Shredded coconut or crusted pistachios" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In large bowl, combine all ingredients. Mix until thoroughly combined.",
      "When ready to serve, place desired amount in cocktail shaker with ice.",
      "Shake vigorously, pour into rocks or martini glass. Ice is optional.",
      "Optional: For shredded coconut or pistachio rim: Dip glass rim in sweetened condensed milk and shredded coconut or crushed pistachios.",
      "Optional: Garnish with whipped cream, a sprinkle of cinnamon, nutmeg and clove or a cinnamon stick."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In large bowl, combine all ingredients. Mix until thoroughly combined.\nWhen ready to serve, place desired amount in cocktail shaker with ice.\nShake vigorously, pour into rocks or martini glass. Ice is optional.\nOptional: For shredded coconut or pistachio rim: Dip glass rim in sweetened condensed milk and shredded coconut or crushed pistachios.\nOptional: Garnish with whipped cream, a sprinkle of cinnamon, nutmeg and clove or a cinnamon stick.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("aubreyskitchen.com")
    expect(recipe.canonical_url).to eq("https://aubreyskitchen.com/pistachio-coquito/")
    expect(recipe.site_name).to eq("Aubrey's Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Aubrey")
    expect(recipe.description).to eq("Pistachio Coquito is the perfect holiday cocktail! A decadent, boozy Puerto Rican eggnog, full of creamy coconut, pistachio and rum that you will be enjoying for holidays to come!")
    expect(recipe.image).to eq("https://aubreyskitchen.com/wp-content/uploads/2023/10/pistachio-coquito-recipe.jpg")
    expect(recipe.category).to eq("cocktail")
    expect(recipe.cuisine).to eq("puerto rican")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(5)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq([
      "Coquito de Pistachio",
      "Pistachio Coquito",
      "Pistachio Coquito recipe",
      "Pistachios Coquito"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(18)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "885 kcal",
      "carbohydrateContent" => "69 g",
      "proteinContent" => "13 g",
      "fatContent" => "40 g",
      "saturatedFatContent" => "26 g",
      "cholesterolContent" => "125 mg",
      "sodiumContent" => "245 mg",
      "fiberContent" => "0.3 g",
      "sugarContent" => "66 g",
      "unsaturatedFatContent" => "11 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 885.0 },
      { name: "carbohydrateContent", unit: "g", amount: 69.0 },
      { name: "proteinContent", unit: "g", amount: 13.0 },
      { name: "fatContent", unit: "g", amount: 40.0 },
      { name: "saturatedFatContent", unit: "g", amount: 26.0 },
      { name: "cholesterolContent", unit: "mg", amount: 125.0 },
      { name: "sodiumContent", unit: "mg", amount: 245.0 },
      { name: "fiberContent", unit: "g", amount: 0.3 },
      { name: "sugarContent", unit: "g", amount: 66.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 11.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
