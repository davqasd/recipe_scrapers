# frozen_string_literal: true

RSpec.describe "familyfoodonthetable.com" do
  subject(:recipe) { scrape_cassette("com/familyfoodonthetable", url: "https://www.familyfoodonthetable.com/15-minute-honey-garlic-chicken/") }

  it "reads the title" do
    expect(recipe.title).to eq("15-Minute Honey Garlic Chicken")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 teaspoons extra-virgin olive oil (or canola oil)",
      "1 1/2 pounds boneless (skinless chicken breasts, cut into small cubes (about 1/2 inch))",
      "Salt and black pepper",
      "3 tablespoons honey",
      "3 tablespoons low-sodium soy sauce",
      "3 cloves garlic (minced)",
      "1/4 teaspoon red pepper flakes (optional (adjust for heat))",
      "Brown or white rice (sliced green onions, sesame seeds, chopped peanuts, lime wedges to squeeze over chicken)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "teaspoons", name: "extra-virgin olive oil" },
      { amount: 1.5, unit: "pounds", name: "boneless" },
      { amount: nil, unit: nil, name: "Salt and black pepper" },
      { amount: 3.0, unit: "tablespoons", name: "honey" },
      { amount: 3.0, unit: "tablespoons", name: "low-sodium soy sauce" },
      { amount: 3.0, unit: "cloves", name: "garlic" },
      { amount: 0.25, unit: "teaspoon", name: "red pepper flakes" },
      { amount: nil, unit: nil, name: "Brown or white rice" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Heat olive oil in a large skillet over medium-high heat.",
      "Lightly season the cubed chicken with salt and pepper. (Go easy because the soy sauce has plenty of sodium.)",
      "Add the chicken to the skillet and brown on one side, about 3-4 minutes.",
      "Meanwhile, make the glaze. Whisk the honey, soy sauce, garlic and red pepper flakes, if using, in a small bowl until well combined.",
      "Turn the chicken pieces over to begin cooking on the other side. Add the sauce to the pan and toss to coat the chicken pieces. Cook until chicken is cooked through, 4-5 more minutes. (The small pieces cook quickly, which is the point, so be careful not to overcook them.)",
      "Serve with steamed rice and top with green onions, sesame seeds and a squeeze of lime juice, if desired."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 7],
        ["For serving (optional):", 1]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Heat olive oil in a large skillet over medium-high heat.\nLightly season the cubed chicken with salt and pepper. (Go easy because the soy sauce has plenty of sodium.)\nAdd the chicken to the skillet and brown on one side, about 3-4 minutes.\nMeanwhile, make the glaze. Whisk the honey, soy sauce, garlic and red pepper flakes, if using, in a small bowl until well combined.\nTurn the chicken pieces over to begin cooking on the other side. Add the sauce to the pan and toss to coat the chicken pieces. Cook until chicken is cooked through, 4-5 more minutes. (The small pieces cook quickly, which is the point, so be careful not to overcook them.)\nServe with steamed rice and top with green onions, sesame seeds and a squeeze of lime juice, if desired.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("familyfoodonthetable.com")
    expect(recipe.canonical_url).to eq("https://www.familyfoodonthetable.com/15-minute-honey-garlic-chicken/")
    expect(recipe.site_name).to eq("Family Food on the Table")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Kathryn Doherty")
    expect(recipe.description).to eq("This 5-ingredient, 15-minute honey garlic chicken with an addictively delicious sauce makes a perfect quick and easy weeknight dinner recipe!")
    expect(recipe.image).to eq("https://www.familyfoodonthetable.com/wp-content/uploads/2025/06/Honey-garlic-chicken-square-1200.jpg")
    expect(recipe.category).to eq("Chicken")
    expect(recipe.cuisine).to eq("Asian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(15)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq([
      "15 minute chicken dinners",
      "chicken recipes with few ingredients",
      "easy chicken dinners",
      "easy chicken recipes",
      "honey garlic chicken",
      "quick chicken dinners",
      "quick chicken recipes",
      "weeknight chicken dinners"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.47)
    expect(recipe.ratings_count).to eq(3155)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 serving",
      "calories" => "360 kcal",
      "carbohydrateContent" => "15 g",
      "proteinContent" => "54 g",
      "fatContent" => "8 g",
      "saturatedFatContent" => "2 g",
      "cholesterolContent" => "145 mg",
      "sodiumContent" => "665 mg",
      "sugarContent" => "13 g",
      "unsaturatedFatContent" => "5 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "serving", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 360.0 },
      { name: "carbohydrateContent", unit: "g", amount: 15.0 },
      { name: "proteinContent", unit: "g", amount: 54.0 },
      { name: "fatContent", unit: "g", amount: 8.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "cholesterolContent", unit: "mg", amount: 145.0 },
      { name: "sodiumContent", unit: "mg", amount: 665.0 },
      { name: "sugarContent", unit: "g", amount: 13.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 5.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.familyfoodonthetable.com/")
  end
end
