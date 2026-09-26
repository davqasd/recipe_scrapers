# frozen_string_literal: true

RSpec.describe "sudachirecipes.com" do
  subject(:recipe) { scrape_cassette("com/sudachirecipes", url: "https://sudachirecipes.com/japanese-curry-hotpot/") }

  it "reads the title" do
    expect(recipe.title).to eq("Kare Nabe (Japanese Curry Hot Pot)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "600 ml water",
      "5 g dried kelp (kombu)",
      "4 chicken drumsticks",
      "1 carrot (peeled, cut into thick rounds)",
      "4 slices kabocha squash ((or butternut squash) skin-on)",
      "1 tbsp curry powder",
      "1 tbsp Japanese dark soy sauce (koikuchi shoyu)",
      "1 tbsp sake",
      "1 tbsp mirin",
      "½ tbsp Chinese-style chicken bouillon powder (based on 1 tsp = 200ml soup ratio, scale to your brand's strength)",
      "1 tsp chili bean sauce (toban djan)",
      "6 black tiger shrimp (shells and veins removed, tail left on)",
      "50 g shimeji mushrooms (or mushrooms of choice)",
      "2 leaves Napa cabbage (roughly cut)",
      "1 Japanese leek (naganegi) (diagonally sliced)",
      "1 green bell pepper (or 2-3 piman, cut into bitesize pieces)",
      "4 tbsp preferred shredded melting cheese",
      "1 tomato (with a cross scored on the top)",
      "2 ptns cooked ramen noodles"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 600.0, unit: "ml", name: "water" },
      { amount: 5.0, unit: "g", name: "dried kelp" },
      { amount: 4.0, unit: nil, name: "chicken drumsticks" },
      { amount: 1.0, unit: nil, name: "carrot" },
      { amount: 4.0, unit: "slices", name: "kabocha squash" },
      { amount: 1.0, unit: "tbsp", name: "curry powder" },
      { amount: 1.0, unit: "tbsp", name: "Japanese dark soy sauce" },
      { amount: 1.0, unit: "tbsp", name: "sake" },
      { amount: 1.0, unit: "tbsp", name: "mirin" },
      { amount: 0.5, unit: "tbsp", name: "Chinese-style chicken bouillon powder" },
      { amount: 1.0, unit: "tsp", name: "chili bean sauce" },
      { amount: 6.0, unit: nil, name: "black tiger shrimp" },
      { amount: 50.0, unit: "g", name: "shimeji mushrooms" },
      { amount: 2.0, unit: "leaves", name: "Napa cabbage" },
      { amount: 1.0, unit: nil, name: "Japanese leek" },
      { amount: 1.0, unit: nil, name: "green bell pepper" },
      { amount: 4.0, unit: "tbsp", name: "preferred shredded melting cheese" },
      { amount: 1.0, unit: nil, name: "tomato" },
      { amount: 2.0, unit: "ptns", name: "cooked ramen noodles" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Take your cooking pot and add 600 ml water and 5 g dried kelp (kombu). Leave to soak at room temperature for 30 minutes.",
      "Place the pot on the stove and add 4 chicken drumsticks. Heat until almost boiling, then remove and discard the kombu. Scoop out any scum that floats to the surface of the broth.",
      "Add 1 carrot and 4 slices kabocha squash. Simmer over medium-low heat for 5 minutes with the lid on. If using additional hardy root vegetables, add them in this step.",
      "Season the broth with 1 tbsp curry powder, 1 tbsp dark soy sauce (koikuchi shoyu), 1 tbsp sake (preferably drinking), 1 tbsp mirin, ½ tbsp Chinese-style chicken bouillon powder and 1 tsp chili bean sauce (toban djan). Mix until combined.",
      "Place 6 black tiger shrimp, 50 g shimeji mushrooms, 2 leaves napa cabbage, 1 Japanese leek (naganegi) and 1 green bell pepper in the broth. Sprinkle the top with 4 tbsp preferred shredded melting cheese and place 1 tomato in the center.",
      "Cover with a lid and continue to simmer for 5 minutes or until the chicken and shrimp are cooked through and the vegetables are softened to your liking.",
      "Serve and eat up all of the ingredients in the broth.",
      "Add 2 ptns cooked ramen noodles to the leftover soup. Enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Take your cooking pot and add 600 ml water and 5 g dried kelp (kombu). Leave to soak at room temperature for 30 minutes.\nPlace the pot on the stove and add 4 chicken drumsticks. Heat until almost boiling, then remove and discard the kombu. Scoop out any scum that floats to the surface of the broth.\nAdd 1 carrot and 4 slices kabocha squash. Simmer over medium-low heat for 5 minutes with the lid on. If using additional hardy root vegetables, add them in this step.\nSeason the broth with 1 tbsp curry powder, 1 tbsp dark soy sauce (koikuchi shoyu), 1 tbsp sake (preferably drinking), 1 tbsp mirin, ½ tbsp Chinese-style chicken bouillon powder and 1 tsp chili bean sauce (toban djan). Mix until combined.\nPlace 6 black tiger shrimp, 50 g shimeji mushrooms, 2 leaves napa cabbage, 1 Japanese leek (naganegi) and 1 green bell pepper in the broth. Sprinkle the top with 4 tbsp preferred shredded melting cheese and place 1 tomato in the center.\nCover with a lid and continue to simmer for 5 minutes or until the chicken and shrimp are cooked through and the vegetables are softened to your liking.\nServe and eat up all of the ingredients in the broth.\nAdd 2 ptns cooked ramen noodles to the leftover soup. Enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("sudachirecipes.com")
    expect(recipe.canonical_url).to eq("https://sudachirecipes.com/japanese-curry-hotpot/")
    expect(recipe.site_name).to eq("Sudachi")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Yuto Omura")
    expect(recipe.description).to eq("This Japanese Curry Hot Pot is a hearty dish packed with chicken, shrimp, and vegetables simmered in a spicy curry-infused broth. It's the perfect comfort dish for a cold evening!")
    expect(recipe.image).to eq("https://sudachirecipes.com/wp-content/uploads/2025/01/curry-hot-pot-thumb-1.png")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to eq("Japanese")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(60)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq(%w[Curry Nabe])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "547 kcal",
      "carbohydrateContent" => "28 g",
      "proteinContent" => "58 g",
      "fatContent" => "21 g",
      "saturatedFatContent" => "6 g",
      "transFatContent" => "0.1 g",
      "cholesterolContent" => "367 mg",
      "sodiumContent" => "2295 mg",
      "fiberContent" => "8 g",
      "sugarContent" => "12 g",
      "unsaturatedFatContent" => "11 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 547.0 },
      { name: "carbohydrateContent", unit: "g", amount: 28.0 },
      { name: "proteinContent", unit: "g", amount: 58.0 },
      { name: "fatContent", unit: "g", amount: 21.0 },
      { name: "saturatedFatContent", unit: "g", amount: 6.0 },
      { name: "transFatContent", unit: "g", amount: 0.1 },
      { name: "cholesterolContent", unit: "mg", amount: 367.0 },
      { name: "sodiumContent", unit: "mg", amount: 2295.0 },
      { name: "fiberContent", unit: "g", amount: 8.0 },
      { name: "sugarContent", unit: "g", amount: 12.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 11.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://sudachirecipes.com/")
  end
end
