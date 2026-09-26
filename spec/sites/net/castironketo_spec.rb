# frozen_string_literal: true

RSpec.describe "castironketo.net" do
  subject(:recipe) { scrape_cassette("net/castironketo", url: "https://www.castironketo.net/blog/keto-jalapeno-popper-casserole-with-chicken/") }

  it "reads the title" do
    expect(recipe.title).to eq("Keto Jalapeño Popper Casserole with Chicken")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 ½ pounds cooked shredded chicken breast",
      "4 green onions (chopped)",
      "1 teaspoon garlic salt",
      "½ teaspoon onion powder",
      "½ teaspoon paprika",
      "8 ounces cream cheese (softened)",
      "½ cup heavy cream",
      "¼ cup chicken broth",
      "5 jalapeno peppers (halved (ribs removed if you like less spice))",
      "1 cup shredded sharp cheddar cheese",
      "6 slices bacon (cooked and crumbled)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.5, unit: "pounds", name: "cooked shredded chicken breast" },
      { amount: 4.0, unit: nil, name: "green onions" },
      { amount: 1.0, unit: "teaspoon", name: "garlic salt" },
      { amount: 0.5, unit: "teaspoon", name: "onion powder" },
      { amount: 0.5, unit: "teaspoon", name: "paprika" },
      { amount: 8.0, unit: "ounces", name: "cream cheese" },
      { amount: 0.5, unit: "cup", name: "heavy cream" },
      { amount: 0.25, unit: "cup", name: "chicken broth" },
      { amount: 5.0, unit: nil, name: "jalapeno peppers" },
      { amount: 1.0, unit: "cup", name: "shredded sharp cheddar cheese" },
      { amount: 6.0, unit: "slices", name: "bacon" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 425° F.",
      "Place the chicken in the bottom of a 10” or larger cast iron skillet. Top with green onions.",
      "Combine the garlic salt, onion powder, paprika, cream cheese, heavy cream, and chicken bone broth in a small bowl. Mix until combined.",
      "Pour the cream cheese mixture over the chicken then top with the slices of jalapeno. Sprinkle the cheddar cheese over the top then top with the crumbled bacon.",
      "Transfer the skillet to the oven and bake for 15 minutes until the cheese is bubbly. Serve immediately."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 425° F.\nPlace the chicken in the bottom of a 10” or larger cast iron skillet. Top with green onions.\nCombine the garlic salt, onion powder, paprika, cream cheese, heavy cream, and chicken bone broth in a small bowl. Mix until combined.\nPour the cream cheese mixture over the chicken then top with the slices of jalapeno. Sprinkle the cheddar cheese over the top then top with the crumbled bacon.\nTransfer the skillet to the oven and bake for 15 minutes until the cheese is bubbly. Serve immediately.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("castironketo.net")
    expect(recipe.canonical_url).to eq("https://www.castironketo.net/blog/keto-jalapeno-popper-casserole-with-chicken/")
    expect(recipe.site_name).to eq("Cast Iron Keto")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Cast Iron Keto")
    expect(recipe.description).to eq("Keto Jalapeño Popper Casserole with Chicken: A deliciously creamy and spicy low-carb dish with shredded chicken, cream cheese, jalapenos, and bacon.")
    expect(recipe.image).to eq("https://www.castironketo.net/wp-content/uploads/2021/01/Keto-Jalapeño-Popper-Casserole.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["keto", "keto casserole", "low carb"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.78)
    expect(recipe.ratings_count).to eq(9)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "563 kcal",
      "carbohydrateContent" => "4 g",
      "proteinContent" => "39 g",
      "fatContent" => "43 g",
      "saturatedFatContent" => "21 g",
      "transFatContent" => "1 g",
      "cholesterolContent" => "188 mg",
      "sodiumContent" => "869 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "2 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 563.0 },
      { name: "carbohydrateContent", unit: "g", amount: 4.0 },
      { name: "proteinContent", unit: "g", amount: 39.0 },
      { name: "fatContent", unit: "g", amount: 43.0 },
      { name: "saturatedFatContent", unit: "g", amount: 21.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 188.0 },
      { name: "sodiumContent", unit: "mg", amount: 869.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
