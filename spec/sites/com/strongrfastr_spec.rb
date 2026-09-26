# frozen_string_literal: true

RSpec.describe "strongrfastr.com" do
  subject(:recipe) { scrape_cassette("com/strongrfastr", url: "https://www.strongrfastr.com/recipes/96-latininspired_creamy_chicken_stew") }

  it "reads the title" do
    expect(recipe.title).to eq("Latin-inspired creamy chicken stew")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 dash ground cumin",
      "1/3 lbs boneless skinless chicken breast, raw",
      "1/2 can(s) diced tomatoes",
      "1/6 jar (~16 oz) green salsa",
      "1/6 packet taco seasoning mix",
      "1/6 15oz can whole kernel corn",
      "1/3 tsp cayenne pepper",
      "1/6 can (~16 oz) pinto beans",
      "4 tsp cream cheese",
      "1/6 can(s) black beans"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: "dash", name: "ground cumin" },
      { amount: 0.33, unit: "lbs", name: "boneless skinless chicken breast, raw" },
      { amount: 0.5, unit: "can", name: "diced tomatoes" },
      { amount: 0.17, unit: "jar", name: "green salsa" },
      { amount: 0.17, unit: "packet", name: "taco seasoning mix" },
      { amount: 0.17, unit: "can", name: "whole kernel corn" },
      { amount: 0.33, unit: "tsp", name: "cayenne pepper" },
      { amount: 0.17, unit: "can", name: "pinto beans" },
      { amount: 4.0, unit: "tsp", name: "cream cheese" },
      { amount: 0.17, unit: "can", name: "black beans" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Note: a slow cooker is recommended for extra juicy chicken, but to save time, you can also cook the stew in a large pot on the stove and keep it at a simmer until the chicken breasts are fully cooked, about 10-15 minutes, before taking them out to shred.",
      "Place the chicken breasts into the bottom of a slow cooker, and pour tomatoes, green salsa, black beans, pinto beans, and corn over the chicken. Sprinkle taco seasoning, cayenne, cumin, and some salt over the mixture, and stir to combine. Cover the cooker, set on Low, and cook until chicken is very tender and the mixture has thickened, 8 to 10 hours.",
      "After its finished cooking, remove the chicken breasts and shred them with two forks. Return the shredded chicken to the stew and stir.",
      "Mix a few tablespoons of stew liquid with cream cheese in a bowl, stir until smooth, and mix the cream cheese into the cooker to make a creamy sauce. Continue to cook for 15 minutes, then serve."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Note: a slow cooker is recommended for extra juicy chicken, but to save time, you can also cook the stew in a large pot on the stove and keep it at a simmer until the chicken breasts are fully cooked, about 10-15 minutes, before taking them out to shred.\nPlace the chicken breasts into the bottom of a slow cooker, and pour tomatoes, green salsa, black beans, pinto beans, and corn over the chicken. Sprinkle taco seasoning, cayenne, cumin, and some salt over the mixture, and stir to combine. Cover the cooker, set on Low, and cook until chicken is very tender and the mixture has thickened, 8 to 10 hours.\nAfter its finished cooking, remove the chicken breasts and shred them with two forks. Return the shredded chicken to the stew and stir.\nMix a few tablespoons of stew liquid with cream cheese in a bowl, stir until smooth, and mix the cream cheese into the cooker to make a creamy sauce. Continue to cook for 15 minutes, then serve.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("strongrfastr.com")
    expect(recipe.canonical_url).to eq("https://www.strongrfastr.com/recipes/96-latininspired_creamy_chicken_stew")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Mary Weidner")
    expect(recipe.description).to eq("crock pot, slow cooker")
    expect(recipe.image).to eq("https://d2jbk7d41q2u2w.cloudfront.net/uploads/recipe/image/96/8cb585a8f5494c07bb946cb1a1e72bf8-1680903300.jpg")
    expect(recipe.category).to eq("dinner")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to eq(550)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "490 calories",
      "fatContent" => "12 g",
      "carbohydrateContent" => "36 g",
      "proteinContent" => "47 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 490.0 },
      { name: "fatContent", unit: "g", amount: 12.0 },
      { name: "carbohydrateContent", unit: "g", amount: 36.0 },
      { name: "proteinContent", unit: "g", amount: 47.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
