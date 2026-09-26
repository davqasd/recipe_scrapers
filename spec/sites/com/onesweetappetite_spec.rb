# frozen_string_literal: true

RSpec.describe "onesweetappetite.com" do
  subject(:recipe) { scrape_cassette("com/onesweetappetite", url: "https://onesweetappetite.com/ranch-chicken/") }

  it "reads the title" do
    expect(recipe.title).to eq("Baked Ranch Chicken")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 chicken breast halves",
      "1/2 teaspoon salt",
      "1/2 teaspoon garlic powder",
      "1/4 teaspoon pepper",
      "1/4 cup ranch dressing",
      "1/2 cup breadcrumbs",
      "3 tablespoons butter (melted)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: nil, name: "chicken breast halves" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 0.5, unit: "teaspoon", name: "garlic powder" },
      { amount: 0.25, unit: "teaspoon", name: "pepper" },
      { amount: 0.25, unit: "cup", name: "ranch dressing" },
      { amount: 0.5, unit: "cup", name: "breadcrumbs" },
      { amount: 3.0, unit: "tablespoons", name: "butter" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 425°F (220°C) and lightly grease a baking dish or sheet pan with cooking spray.",
      "Place each chicken breast between two pieces of plastic wrap or inside a zip-top bag. Gently pound with a meat mallet or rolling pin until about ½ inch thick so they cook evenly.",
      "Place the chicken on the prepared pan. Sprinkle both sides with salt, pepper, and garlic powder.",
      "Brush about one tablespoon of ranch dressing over the top of each chicken breast. This helps the breadcrumbs stick and adds flavor.",
      "In a small bowl, mix the breadcrumbs and melted butter together until combined. Spoon the mixture evenly over the top of each piece of chicken.",
      "Bake for 15 to 20 minutes, or until the chicken reaches an internal temperature of 165°F and the breadcrumb topping is golden brown.",
      "Let the chicken rest for a few minutes before serving. This keeps it juicy and helps the crust stay crisp. Drizzle with extra ranch dressing if you’d like and serve with a favorite side such as roasted green beans or mashed potatoes."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 425°F (220°C) and lightly grease a baking dish or sheet pan with cooking spray.\nPlace each chicken breast between two pieces of plastic wrap or inside a zip-top bag. Gently pound with a meat mallet or rolling pin until about ½ inch thick so they cook evenly.\nPlace the chicken on the prepared pan. Sprinkle both sides with salt, pepper, and garlic powder.\nBrush about one tablespoon of ranch dressing over the top of each chicken breast. This helps the breadcrumbs stick and adds flavor.\nIn a small bowl, mix the breadcrumbs and melted butter together until combined. Spoon the mixture evenly over the top of each piece of chicken.\nBake for 15 to 20 minutes, or until the chicken reaches an internal temperature of 165°F and the breadcrumb topping is golden brown.\nLet the chicken rest for a few minutes before serving. This keeps it juicy and helps the crust stay crisp. Drizzle with extra ranch dressing if you’d like and serve with a favorite side such as roasted green beans or mashed potatoes.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("onesweetappetite.com")
    expect(recipe.canonical_url).to eq("https://onesweetappetite.com/ranch-chicken/")
    expect(recipe.site_name).to eq("One Sweet Appetite")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jesseca")
    expect(recipe.description).to eq("This crispy ranch chicken is crispy on the outside, juicy inside, and bursting with classic ranch flavor. It’s a beginner-friendly recipe that comes together quickly with just a few simple ingredients.")
    expect(recipe.image).to eq("https://onesweetappetite.com/wp-content/uploads/2021/07/ranch-chicken-recipe-6.jpg")
    expect(recipe.category).to eq("Dinner Recipes")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.84)
    expect(recipe.ratings_count).to eq(25)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 g",
      "calories" => "394 kcal",
      "carbohydrateContent" => "11 g",
      "proteinContent" => "39 g",
      "fatContent" => "20 g",
      "saturatedFatContent" => "8 g",
      "cholesterolContent" => "129 mg",
      "sodiumContent" => "656 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "2 g",
      "unsaturatedFatContent" => "11 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "g", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 394.0 },
      { name: "carbohydrateContent", unit: "g", amount: 11.0 },
      { name: "proteinContent", unit: "g", amount: 39.0 },
      { name: "fatContent", unit: "g", amount: 20.0 },
      { name: "saturatedFatContent", unit: "g", amount: 8.0 },
      { name: "cholesterolContent", unit: "mg", amount: 129.0 },
      { name: "sodiumContent", unit: "mg", amount: 656.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 11.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
