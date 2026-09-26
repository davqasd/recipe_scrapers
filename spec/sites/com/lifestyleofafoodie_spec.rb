# frozen_string_literal: true

RSpec.describe "lifestyleofafoodie.com" do
  subject(:recipe) { scrape_cassette("com/lifestyleofafoodie", url: "https://lifestyleofafoodie.com/frozen-strawberry-margarita/") }

  it "reads the title" do
    expect(recipe.title).to eq("Frozen strawberry margaritas")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 cup frozen strawberries",
      "4 ounces tequila (add more if you'd like)",
      "1/4 cup Lime juice",
      "2 tablespoon agave syrup (taste and add more if needed. )",
      "1/2-1 cup ice cubes (as needed)",
      "Lime wedges for garnish (optional)",
      "Salt or sugar for rimming the glass (optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "cup", name: "frozen strawberries" },
      { amount: 4.0, unit: "ounces", name: "tequila" },
      { amount: 0.25, unit: "cup", name: "Lime juice" },
      { amount: 2.0, unit: "tablespoon", name: "agave syrup" },
      { amount: 0.5, unit: "cup", name: "ice cubes" },
      { amount: nil, unit: nil, name: "Lime wedges for garnish" },
      { amount: nil, unit: nil, name: "Salt or sugar for rimming the glass" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Rim the glass with salt if desired. Rub a lime wedge around the rim of the glass, then dip it into a plate with salt, rotating to coat the rim evenly. Set the glass aside.",
      "In a blender, combine the frozen strawberries, ice, tequila, lime juice, and agave syrup and blend until smooth. If needed, add a splash of water or more lime juice to adjust the consistency. Want it thicker, add some ice.",
      "Taste the margarita and adjust the sweetness or tartness by adding more agave syrup or lime juice, if desired.",
      "Once the frozen mango margarita is ready, pour it into the rimmed glass. Garnish with a lime wedge, mint, slices, or mango if desired. Serve immediately and enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Rim the glass with salt if desired. Rub a lime wedge around the rim of the glass, then dip it into a plate with salt, rotating to coat the rim evenly. Set the glass aside.\nIn a blender, combine the frozen strawberries, ice, tequila, lime juice, and agave syrup and blend until smooth. If needed, add a splash of water or more lime juice to adjust the consistency. Want it thicker, add some ice.\nTaste the margarita and adjust the sweetness or tartness by adding more agave syrup or lime juice, if desired.\nOnce the frozen mango margarita is ready, pour it into the rimmed glass. Garnish with a lime wedge, mint, slices, or mango if desired. Serve immediately and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("lifestyleofafoodie.com")
    expect(recipe.canonical_url).to eq("https://lifestyleofafoodie.com/frozen-strawberry-margarita/")
    expect(recipe.site_name).to eq("Lifestyle of a Foodie")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Chahinez Tabet Aoul")
    expect(recipe.description).to eq("These delicious frozen strawberry margaritas are the perfect drink to add to your summer drink rotation.")
    expect(recipe.image).to eq("https://lifestyleofafoodie.com/wp-content/uploads/2023/06/Frozen-strawberry-margarita-5.jpg")
    expect(recipe.category).to eq("Drinks")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(5)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq([
      "blended srawberry margaritas",
      "blended strawberry margarita",
      "frozen strawberry margarita",
      "frozen strawberry margaritas"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "136 kcal",
      "carbohydrateContent" => "18 g",
      "proteinContent" => "1 g",
      "fatContent" => "0.4 g",
      "saturatedFatContent" => "0.01 g",
      "sodiumContent" => "5 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "13 g",
      "unsaturatedFatContent" => "0.25 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 136.0 },
      { name: "carbohydrateContent", unit: "g", amount: 18.0 },
      { name: "proteinContent", unit: "g", amount: 1.0 },
      { name: "fatContent", unit: "g", amount: 0.4 },
      { name: "saturatedFatContent", unit: "g", amount: 0.01 },
      { name: "sodiumContent", unit: "mg", amount: 5.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 13.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 0.25 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
