# frozen_string_literal: true

RSpec.describe "abuelascounter.com" do
  subject(:recipe) { scrape_cassette("com/abuelascounter", url: "https://abuelascounter.com/alita-olivas-roast-chicken/") }

  it "reads the title" do
    expect(recipe.title).to eq("Alita Oliva’s Roast Chicken")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 - 3 pound whole roaster chicken",
      "4 yellow onions, peeled and sliced thinly",
      "1 onion, left whole",
      "2 teaspoons of garlic powder",
      "1/4 cup of soy sauce or dale’s marinade seasoning",
      "Juice of 1 lime",
      "Juice of 1 orange",
      "1/3 cup olive oil",
      "1/2 teaspoon of ground mustard",
      "1 teaspoon of onion powder",
      "1 teaspoon of paprika",
      "salt and black pepper",
      "2 teaspoons of apple cider vinegar"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "pound", name: "whole roaster chicken" },
      { amount: 4.0, unit: nil, name: "yellow onions, peeled and sliced thinly" },
      { amount: 1.0, unit: nil, name: "onion, left whole" },
      { amount: 2.0, unit: "teaspoons", name: "garlic powder" },
      { amount: 0.25, unit: "cup", name: "soy sauce or dale’s marinade seasoning" },
      { amount: nil, unit: nil, name: "Juice of 1 lime" },
      { amount: nil, unit: nil, name: "Juice of 1 orange" },
      { amount: 0.33, unit: "cup", name: "olive oil" },
      { amount: 0.5, unit: "teaspoon", name: "ground mustard" },
      { amount: 1.0, unit: "teaspoon", name: "onion powder" },
      { amount: 1.0, unit: "teaspoon", name: "paprika" },
      { amount: nil, unit: nil, name: "salt and black pepper" },
      { amount: 2.0, unit: "teaspoons", name: "apple cider vinegar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 425 degrees.",
      "Spread the bottom of your roasting pan with the sliced onions. Season the onions with 2 tablespoons of oil and salt and pepper.",
      "Time to Prep the Chicken: Remove the chicken giblets. Rinse the chicken inside and out under cold water. Pat the outside dry and put it in a roasting pan.",
      "Whisk all the ingredients into the olive oil until emulsified.",
      "Sprinkle the chicken with a generous amount of salt and pepper on all sides. Season liberally. You even want to add some salt to the cavity of the chicken. Don’t be afraid.",
      "Add the whole onion to the inside of the cavity. You can also add fresh herbs or bay leaves to the cavity.",
      "Pour the marinade over the chicken. Marinate it overnight in the fridge or just for a few minutes.",
      "Roast the chicken for 30 minutes at 425 degrees then add ¼ cup of water to the bottom of the pan to be sure the onions don’t get too much color and drop the temperature to 350 degrees.",
      "Roast for another 50-60 minutes. The chicken will roast for a about 90 minutes total.",
      "The chicken is ready once the skin is golden brown and the juices run completely clear when you cut with a knife. If you are using a meat thermometer it should read 160 degrees between the breast and thigh area. Once you pull the chicken out of the oven let it rest for 15 minutes then carve and serve."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 425 degrees.\nSpread the bottom of your roasting pan with the sliced onions. Season the onions with 2 tablespoons of oil and salt and pepper.\nTime to Prep the Chicken: Remove the chicken giblets. Rinse the chicken inside and out under cold water. Pat the outside dry and put it in a roasting pan.\nWhisk all the ingredients into the olive oil until emulsified.\nSprinkle the chicken with a generous amount of salt and pepper on all sides. Season liberally. You even want to add some salt to the cavity of the chicken. Don’t be afraid.\nAdd the whole onion to the inside of the cavity. You can also add fresh herbs or bay leaves to the cavity.\nPour the marinade over the chicken. Marinate it overnight in the fridge or just for a few minutes.\nRoast the chicken for 30 minutes at 425 degrees then add ¼ cup of water to the bottom of the pan to be sure the onions don’t get too much color and drop the temperature to 350 degrees.\nRoast for another 50-60 minutes. The chicken will roast for a about 90 minutes total.\nThe chicken is ready once the skin is golden brown and the juices run completely clear when you cut with a knife. If you are using a meat thermometer it should read 160 degrees between the breast and thigh area. Once you pull the chicken out of the oven let it rest for 15 minutes then carve and serve.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("abuelascounter.com")
    expect(recipe.canonical_url).to eq("https://abuelascounter.com/alita-olivas-roast-chicken/")
    expect(recipe.site_name).to eq("Abuela's Cuban Counter")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Ani Mezerhane")
    expect(recipe.description).to eq("Alita Oliva's Roast Chicken Recipe takes you step by step, so that you can make one of the world's greatest comfort foods.")
    expect(recipe.image).to eq("https://abuelascounter.com/wp-content/uploads/2023/01/Roast-Chicken-Recipe.jpeg")
    expect(recipe.category).to eq("Entree")
    expect(recipe.cuisine).to eq("Cuban")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(105)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(90)
    expect(recipe.keywords).to eq([
      "abuela's",
      "abuelas counter",
      "alita oliva",
      "cuban",
      "cuban tradition",
      "entree",
      "hosting",
      "roasted chicken",
      "sunday dinner",
      "tradition",
      "traditional",
      "abuelau0026#039;s",
      "abuelau0026#039;s counter",
      "alita oliva",
      "cuban",
      "cuban tradition",
      "entree",
      "hosting",
      "roasted chicken",
      "sunday dinner",
      "tradition",
      "traditional"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "calories" => "300 cal" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 300.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://instagram.com/abuelascounter")
  end
end
