# frozen_string_literal: true

RSpec.describe "nhs.uk" do
  subject(:recipe) { scrape_cassette("uk/nhs", url: "https://www.nhs.uk/healthier-families/recipes/apple-apricot-sultana-squares/") }

  it "reads the title" do
    expect(recipe.title).to eq("Apple, apricot and sultana squares recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "100g lower-fat spread",
      "4 tablespoons golden syrup",
      "250g high-fibre porridge oats",
      "1 apple, cored and chopped into small chunks",
      "50g ready-to-eat apricots, chopped",
      "50g sultanas or raisins (or a mixture)",
      "half a teapsoon ground mixed spice (optional)",
      "1 egg, beaten"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 100.0, unit: "g", name: "lower-fat spread" },
      { amount: 4.0, unit: "tablespoons", name: "golden syrup" },
      { amount: 250.0, unit: "g", name: "high-fibre porridge oats" },
      { amount: 1.0, unit: nil, name: "apple, cored and chopped into small chunks" },
      { amount: 50.0, unit: "g", name: "ready-to-eat apricots, chopped" },
      { amount: 50.0, unit: "g", name: "sultanas or raisins" },
      { amount: 0.5, unit: nil, name: "teapsoon ground mixed spice" },
      { amount: 1.0, unit: nil, name: "egg, beaten" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 180C (fan 160C, gas mark 4). Grease a 23cm (9-inch) shallow square cake tin with a little reduced-fat spread, then line the base with baking parchment or greaseproof paper.",
      "Melt the remaining spread in a large saucepan with the golden syrup. Take care that the mixture doesn't get too hot.",
      "Remove the pan from the heat and add the porridge oats, apple, apricots, sultanas (or raisins) and mixed spice (if using). Stir well.",
      "Add the beaten egg and mix well again.",
      "Tip the mixture into the prepared tin and level the surface. Bake for 20 to 25 minutes until firm.",
      "Cool in the tin for about 20 minutes, then cut into 16 squares."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 180C (fan 160C, gas mark 4). Grease a 23cm (9-inch) shallow square cake tin with a little reduced-fat spread, then line the base with baking parchment or greaseproof paper.\nMelt the remaining spread in a large saucepan with the golden syrup. Take care that the mixture doesn't get too hot.\nRemove the pan from the heat and add the porridge oats, apple, apricots, sultanas (or raisins) and mixed spice (if using). Stir well.\nAdd the beaten egg and mix well again.\nTip the mixture into the prepared tin and level the surface. Bake for 20 to 25 minutes until firm.\nCool in the tin for about 20 minutes, then cut into 16 squares.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("nhs.uk")
    expect(recipe.canonical_url).to eq("https://www.nhs.uk/healthier-families/recipes/apple-apricot-sultana-squares/")
    expect(recipe.site_name).to eq("nhs.uk")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Perfect for packed lunches and picnics, and a tasty treat with a cup of tea too!")
    expect(recipe.image).to eq("https://assets.nhs.uk/campaigns-cms-prod/images/Apple_apricot__sultana_squares_7ubq6ki.width-320.png")
    expect(recipe.category).to eq("Lunchbox")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("16 items")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(%w[GlutenFreeDiet VegetarianDiet])
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "134kcal",
      "carbohydrateContent" => "17.9g",
      "fatContent" => "5.4g",
      "proteinContent" => "2.5g",
      "saturatedFatContent" => "1.9g",
      "sugarContent" => "7.5g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 134.0 },
      { name: "carbohydrateContent", unit: "g", amount: 17.9 },
      { name: "fatContent", unit: "g", amount: 5.4 },
      { name: "proteinContent", unit: "g", amount: 2.5 },
      { name: "saturatedFatContent", unit: "g", amount: 1.9 },
      { name: "sugarContent", unit: "g", amount: 7.5 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#maincontent")
  end
end
