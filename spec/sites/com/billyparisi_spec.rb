# frozen_string_literal: true

RSpec.describe "billyparisi.com" do
  subject(:recipe) { scrape_cassette("com/billyparisi", url: "https://www.billyparisi.com/homemade-dill-pickle-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Dill Pickle Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "12 pickling cucumbers",
      "8 sprigs fresh dill",
      "3 cups water",
      "1 cup white vinegar",
      "12 finely minced cloves of garlic",
      "½ teaspoon crushed red pepper flakes",
      "¼ cup sea salt"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 12.0, unit: nil, name: "pickling cucumbers" },
      { amount: 8.0, unit: "sprigs", name: "fresh dill" },
      { amount: 3.0, unit: "cups", name: "water" },
      { amount: 1.0, unit: "cup", name: "white vinegar" },
      { amount: 12.0, unit: nil, name: "finely minced cloves of garlic" },
      { amount: 0.5, unit: "teaspoon", name: "crushed red pepper flakes" },
      { amount: 0.25, unit: "cup", name: "sea salt" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Slice your pickles to your desired slice and pack them into 4, 16-ounce sterilized mason jars.",
      "Place 2 sprigs of fresh dill into each jar alongside the cucumbers. Set aside.",
      "In a large pot, add the water, vinegar, garlic, red pepper flakes, and salt, and bring to a boil or until the salt is dissolved.",
      "Evenly pour the brine liquid over the cucumbers in the jar until they are completely covered.",
      "Cool to room temperature, add a lid, label, and date, and store in the refrigerator for 4-6 weeks."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Slice your pickles to your desired slice and pack them into 4, 16-ounce sterilized mason jars.\nPlace 2 sprigs of fresh dill into each jar alongside the cucumbers. Set aside.\nIn a large pot, add the water, vinegar, garlic, red pepper flakes, and salt, and bring to a boil or until the salt is dissolved.\nEvenly pour the brine liquid over the cucumbers in the jar until they are completely covered.\nCool to room temperature, add a lid, label, and date, and store in the refrigerator for 4-6 weeks.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("billyparisi.com")
    expect(recipe.canonical_url).to eq("https://www.billyparisi.com/homemade-dill-pickle-recipe/")
    expect(recipe.site_name).to eq("Chef Billy Parisi")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Chef Billy Parisi")
    expect(recipe.description).to eq("Learn how to make dill pickles right from your kitchen in under 90 minutes that are more delicious than store-bought.")
    expect(recipe.image).to eq("https://www.billyparisi.com/wp-content/uploads/2020/01/dill-pickles-2-1.jpg")
    expect(recipe.category).to eq("condiment")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("48 servings")
    expect(recipe.total_time).to eq(70)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(5)
    expect(recipe.keywords).to eq(["dill pickles"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(22)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "5 kcal",
      "carbohydrateContent" => "1 g",
      "proteinContent" => "1 g",
      "fatContent" => "1 g",
      "saturatedFatContent" => "1 g",
      "sodiumContent" => "119 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "1 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 5.0 },
      { name: "carbohydrateContent", unit: "g", amount: 1.0 },
      { name: "proteinContent", unit: "g", amount: 1.0 },
      { name: "fatContent", unit: "g", amount: 1.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 119.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#body")
  end
end
