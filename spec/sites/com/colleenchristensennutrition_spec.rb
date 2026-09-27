# frozen_string_literal: true

RSpec.describe "colleenchristensennutrition.com" do
  subject(:recipe) { scrape_cassette("com/colleenchristensennutrition", url: "https://colleenchristensennutrition.com/peanut-butter-cup-perfect-bar-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Peanut Butter Cup Perfect Bar Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1/2 cup chocolate chips",
      "2 tsp coconut oil",
      "1/4 cup Inspired Organics peanut butter",
      "1 scoop protein powder (~1/3 cup)",
      "1 tbsp honey"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.5, unit: "cup", name: "chocolate chips" },
      { amount: 2.0, unit: "tsp", name: "coconut oil" },
      { amount: 0.25, unit: "cup", name: "Inspired Organics peanut butter" },
      { amount: 1.0, unit: "scoop", name: "protein powder" },
      { amount: 1.0, unit: "tbsp", name: "honey" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Combine peanut butter, protein powder and honey, mixing well. You should be able to shape this mixture into a ball.",
      "Melt together the chocolate and coconut oil in the microwave cooking for ~60 seconding, stopping to stir every ~15-20 seconds.",
      "Take a muffin liner ( I recommend the silicone ones!) and cover the bottom with chocolate.",
      "Then, take 1/7th of your peanut butter mixture (roughly 1 tbsp), roll into a ball and flatten slightly. Place on top of the melted chocolate in the muffin liner.",
      "Top peanut butter mixture with more chocolate until covered.",
      "Repeat with remaining chocolate and peanut butter mixture (about 7 in total)",
      "Pop your assembled peanut butter cups in the fridge for about 20 minutes to harden.",
      "Once hardened, sink your teeth into one and enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Combine peanut butter, protein powder and honey, mixing well. You should be able to shape this mixture into a ball.\nMelt together the chocolate and coconut oil in the microwave cooking for ~60 seconding, stopping to stir every ~15-20 seconds.\nTake a muffin liner ( I recommend the silicone ones!) and cover the bottom with chocolate.\nThen, take 1/7th of your peanut butter mixture (roughly 1 tbsp), roll into a ball and flatten slightly. Place on top of the melted chocolate in the muffin liner.\nTop peanut butter mixture with more chocolate until covered.\nRepeat with remaining chocolate and peanut butter mixture (about 7 in total)\nPop your assembled peanut butter cups in the fridge for about 20 minutes to harden.\nOnce hardened, sink your teeth into one and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("colleenchristensennutrition.com")
    expect(recipe.canonical_url).to eq("https://colleenchristensennutrition.com/peanut-butter-cup-perfect-bar-recipe/")
    expect(recipe.site_name).to eq("Colleen Christensen Nutrition")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Colleen Christensen")
    expect(recipe.description).to eq("These creamy peanut butter cups are a total Perfect Bar copycat! The delicious peanut butter cups you love with an added protein boost!")
    expect(recipe.image).to eq("https://colleenchristensennutrition.com/wp-content/uploads/2020/07/bitten-homemade-perfect-bar-peaunut-butter-cups.jpg")
    expect(recipe.category).to eq("Cookies, Cakes & Desserts")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("7 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["homemade perfect bar recipe"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 g",
      "calories" => "151 kcal",
      "carbohydrateContent" => "13 g",
      "proteinContent" => "6 g",
      "fatContent" => "10 g",
      "saturatedFatContent" => "4 g",
      "cholesterolContent" => "1 mg",
      "sodiumContent" => "52 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "10 g",
      "unsaturatedFatContent" => "4 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "g", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 151.0 },
      { name: "carbohydrateContent", unit: "g", amount: 13.0 },
      { name: "proteinContent", unit: "g", amount: 6.0 },
      { name: "fatContent", unit: "g", amount: 10.0 },
      { name: "saturatedFatContent", unit: "g", amount: 4.0 },
      { name: "cholesterolContent", unit: "mg", amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 52.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 10.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 4.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#recipe")
  end
end
