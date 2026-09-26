# frozen_string_literal: true

RSpec.describe "jocooks.com" do
  subject(:recipe) { scrape_cassette("com/jocooks", url: "https://www.jocooks.com/recipes/korean-fried-chicken/") }

  it "reads the title" do
    expect(recipe.title).to eq("Korean Fried Chicken")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 pounds chicken breasts (boneless and skinless, cut into 1 inch pieces)",
      "1 large egg (beaten)",
      "½ cup cornstarch",
      "vegetable oil (for frying)",
      "3 tablespoons butter (unsalted)",
      "4 cloves garlic (minced)",
      "1 tablespoon fresh ginger (minced)",
      "¼ cup honey",
      "¼ cup brown sugar",
      "2 tablespoons soy sauce (low sodium)",
      "1 tablespoon rice vinegar",
      "1 tablespoon sesame oil",
      "2 tablespoons gochujang",
      "green onions",
      "toasted sesame seeds",
      "red chilis (sliced)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "pounds", name: "chicken breasts" },
      { amount: 1.0, unit: nil, name: "large egg" },
      { amount: 0.5, unit: "cup", name: "cornstarch" },
      { amount: nil, unit: nil, name: "vegetable oil" },
      { amount: 3.0, unit: "tablespoons", name: "butter" },
      { amount: 4.0, unit: "cloves", name: "garlic" },
      { amount: 1.0, unit: "tablespoon", name: "fresh ginger" },
      { amount: 0.25, unit: "cup", name: "honey" },
      { amount: 0.25, unit: "cup", name: "brown sugar" },
      { amount: 2.0, unit: "tablespoons", name: "soy sauce" },
      { amount: 1.0, unit: "tablespoon", name: "rice vinegar" },
      { amount: 1.0, unit: "tablespoon", name: "sesame oil" },
      { amount: 2.0, unit: "tablespoons", name: "gochujang" },
      { amount: nil, unit: nil, name: "green onions" },
      { amount: nil, unit: nil, name: "toasted sesame seeds" },
      { amount: nil, unit: nil, name: "red chilis" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Prep the chicken",
      "Toss the chicken pieces through the egg first, then dredge through cornstarch.",
      "Heat the oil",
      "Add about 3 inches of oil to a heavy bottom pan and heat to 375°F.",
      "Fry the chicken",
      "Add chicken to the pan and fry in batches about 3 to 4 minutes per batch. Transfer the chicken to a paper towel lined plate and repeat with remaining chicken.",
      "Make the sauce and toss with chicken",
      "Melt the butter in a skillet over medium heat. Add the garlic and ginger and cook for 30 seconds or until aromatic. Stir in the brown sugar and honey and cook for about 1 minute until the brown butter dissolves. Add the soy sauce, rice vinegar, sesame oil and gochujang sauce to the skillet and stir. Cook for 30 seconds then add the chicken to the skillet and toss well with the sauce.",
      "Garnish and serve",
      "Serve garnished with green onions, toasted sesame seeds and red chilis."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 4],
        ["Korean Sauce", 9],
        ["Garnish", 3]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Prep the chicken\nToss the chicken pieces through the egg first, then dredge through cornstarch.\nHeat the oil\nAdd about 3 inches of oil to a heavy bottom pan and heat to 375°F.\nFry the chicken\nAdd chicken to the pan and fry in batches about 3 to 4 minutes per batch. Transfer the chicken to a paper towel lined plate and repeat with remaining chicken.\nMake the sauce and toss with chicken\nMelt the butter in a skillet over medium heat. Add the garlic and ginger and cook for 30 seconds or until aromatic. Stir in the brown sugar and honey and cook for about 1 minute until the brown butter dissolves. Add the soy sauce, rice vinegar, sesame oil and gochujang sauce to the skillet and stir. Cook for 30 seconds then add the chicken to the skillet and toss well with the sauce.\nGarnish and serve\nServe garnished with green onions, toasted sesame seeds and red chilis.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("jocooks.com")
    expect(recipe.canonical_url).to eq("https://www.jocooks.com/recipes/korean-fried-chicken/")
    expect(recipe.site_name).to eq("Jo Cooks")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Joanna Cismaru")
    expect(recipe.description).to eq("This Korean Fried Chicken is crispy, juicy, and coated in a bold, sweet-spicy sauce made with gochujang, garlic, and honey. Ready in just 30 minutes, it's the perfect appetizer or main dish that’s even better than takeout!")
    expect(recipe.image).to eq("https://www.jocooks.com/wp-content/uploads/2020/02/korean-fried-chicken-1-3.jpg")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to eq("Korean")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["fried chicken", "korean fried chicken"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.64)
    expect(recipe.ratings_count).to eq(91)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 serving",
      "calories" => "386 kcal",
      "carbohydrateContent" => "33 g",
      "proteinContent" => "34 g",
      "fatContent" => "13 g",
      "saturatedFatContent" => "5 g",
      "transFatContent" => "0.3 g",
      "cholesterolContent" => "143 mg",
      "sodiumContent" => "386 mg",
      "fiberContent" => "0.3 g",
      "sugarContent" => "21 g",
      "unsaturatedFatContent" => "6 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "serving", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 386.0 },
      { name: "carbohydrateContent", unit: "g", amount: 33.0 },
      { name: "proteinContent", unit: "g", amount: 34.0 },
      { name: "fatContent", unit: "g", amount: 13.0 },
      { name: "saturatedFatContent", unit: "g", amount: 5.0 },
      { name: "transFatContent", unit: "g", amount: 0.3 },
      { name: "cholesterolContent", unit: "mg", amount: 143.0 },
      { name: "sodiumContent", unit: "mg", amount: 386.0 },
      { name: "fiberContent", unit: "g", amount: 0.3 },
      { name: "sugarContent", unit: "g", amount: 21.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 6.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
