# frozen_string_literal: true

RSpec.describe "eatthismuch.com" do
  subject(:recipe) { scrape_cassette("com/eatthismuch", url: "https://www.eatthismuch.com/calories/easy-garlic-chicken,33501") }

  it "reads the title" do
    expect(recipe.title).to eq("Easy Garlic Chicken")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "¾ tbsp Butter",
      "1 breast fillet Chicken breast",
      "½ tsp Garlic powder",
      "¼ tsp Salt",
      "¼ tsp Onion powder"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.75, unit: "tbsp", name: "Butter" },
      { amount: 1.0, unit: nil, name: "breast fillet Chicken breast" },
      { amount: 0.5, unit: "tsp", name: "Garlic powder" },
      { amount: 0.25, unit: "tsp", name: "Salt" },
      { amount: 0.25, unit: "tsp", name: "Onion powder" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Melt butter in a large skillet over medium-high heat.",
      "Add chicken to the skillet and sprinkle with garlic powder, salt, and onion powder.",
      "Sauté for about 10 to 15 minutes per side, or until chicken is cooked through and juices run clear."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Melt butter in a large skillet over medium-high heat.\nAdd chicken to the skillet and sprinkle with garlic powder, salt, and onion powder.\nSauté for about 10 to 15 minutes per side, or until chicken is cooked through and juices run clear.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("eatthismuch.com")
    expect(recipe.canonical_url).to eq("https://www.eatthismuch.com/calories/easy-garlic-chicken-33501")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en")
    expect(recipe.author).to be_nil
    expect(recipe.description).to be_nil
    expect(recipe.image).to eq("https://images.eatthismuch.com/img/33501_elm333_4bb41603-56fd-43db-8de6-af0ee43b8c16.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "name" => "Easy Garlic Chicken",
      "calories" => "225.1",
      "carbohydrateContent" => "1.6",
      "cholesterolContent" => "109",
      "fatContent" => "11.7",
      "fiberContent" => "0.2",
      "proteinContent" => "27",
      "saturatedFatContent" => "6.1",
      "servingSize" => "132.3 grams",
      "sodiumContent" => "637",
      "sugarContent" => "0.1",
      "transFatContent" => "0.4"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: nil, amount: 225.1 },
      { name: "carbohydrateContent", unit: nil, amount: 1.6 },
      { name: "cholesterolContent", unit: nil, amount: 109.0 },
      { name: "fatContent", unit: nil, amount: 11.7 },
      { name: "fiberContent", unit: nil, amount: 0.2 },
      { name: "proteinContent", unit: nil, amount: 27.0 },
      { name: "saturatedFatContent", unit: nil, amount: 6.1 },
      { name: "servingSize", unit: "g", amount: 132.3 },
      { name: "sodiumContent", unit: nil, amount: 637.0 },
      { name: "sugarContent", unit: nil, amount: 0.1 },
      { name: "transFatContent", unit: nil, amount: 0.4 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
