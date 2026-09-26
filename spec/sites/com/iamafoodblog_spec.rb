# frozen_string_literal: true

RSpec.describe "iamafoodblog.com" do
  subject(:recipe) { scrape_cassette("com/iamafoodblog", url: "https://iamafoodblog.com/dan-dan-noodles/") }

  it "reads the title" do
    expect(recipe.title).to eq("Dan Dan Noodles")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 tbsp Chinese sesame paste",
      "2 tbsp chili oil (or to taste)",
      "2 tbsp soy sauce",
      "2 tsp black vinegar",
      "2 tsp sugar",
      "1-2 cloves garlic (finely minced)",
      "2 servings noodles (of choice)",
      "toasted sesame seeds (if desired)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "tbsp", name: "Chinese sesame paste" },
      { amount: 2.0, unit: "tbsp", name: "chili oil" },
      { amount: 2.0, unit: "tbsp", name: "soy sauce" },
      { amount: 2.0, unit: "tsp", name: "black vinegar" },
      { amount: 2.0, unit: "tsp", name: "sugar" },
      { amount: 1.0, unit: "cloves", name: "garlic" },
      { amount: 2.0, unit: "servings", name: "noodles" },
      { amount: nil, unit: nil, name: "toasted sesame seeds" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large bowl, mix together the sesame paste with the the chili oil, soy sauce, vinegar, sugar, and garlic.",
      "Cook the noodles according to the package instructions. Save 1/4 cup of the cooking water, then drain well.",
      "Toss the noodles with the sauce, loosening with hot noodle water if too thick.",
      "Enjoy topped with toasted sesame seeds and extra chili oil."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large bowl, mix together the sesame paste with the the chili oil, soy sauce, vinegar, sugar, and garlic.\nCook the noodles according to the package instructions. Save 1/4 cup of the cooking water, then drain well.\nToss the noodles with the sauce, loosening with hot noodle water if too thick.\nEnjoy topped with toasted sesame seeds and extra chili oil.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("iamafoodblog.com")
    expect(recipe.canonical_url).to eq("https://iamafoodblog.com/dan-dan-noodles/")
    expect(recipe.site_name).to eq("i am a food blog")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Stephanie")
    expect(recipe.description).to eq("When you want a fast, easy, flavorful meal that takes just under ten minutes.")
    expect(recipe.image).to eq("https://iamafoodblog.com/wp-content/uploads/2019/12/spicy-noodles-1014w.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("Chinese")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(5)
    expect(recipe.prep_time).to eq(1)
    expect(recipe.cook_time).to eq(4)
    expect(recipe.keywords).to eq(["noodles"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.8)
    expect(recipe.ratings_count).to eq(25)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "297 kcal",
      "carbohydrateContent" => "8 g",
      "proteinContent" => "5.6 g",
      "fatContent" => "27.5 g",
      "saturatedFatContent" => "5 g",
      "cholesterolContent" => "45 mg",
      "sodiumContent" => "985 mg",
      "fiberContent" => "1.7 g",
      "sugarContent" => "5.1 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 297.0 },
      { name: "carbohydrateContent", unit: "g", amount: 8.0 },
      { name: "proteinContent", unit: "g", amount: 5.6 },
      { name: "fatContent", unit: "g", amount: 27.5 },
      { name: "saturatedFatContent", unit: "g", amount: 5.0 },
      { name: "cholesterolContent", unit: "mg", amount: 45.0 },
      { name: "sodiumContent", unit: "mg", amount: 985.0 },
      { name: "fiberContent", unit: "g", amount: 1.7 },
      { name: "sugarContent", unit: "g", amount: 5.1 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
