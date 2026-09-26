# frozen_string_literal: true

RSpec.describe "chefjackovens.com" do
  subject(:recipe) { scrape_cassette("com/chefjackovens", url: "https://chefjackovens.com/high-protein-marry-me-chicken/") }

  it "reads the title" do
    expect(recipe.title).to eq("High Protein Marry Me Chicken")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "500 g Pasta of Choice",
      "15 ml Sun-Dried Tomato Oil",
      "800 g Chicken Breast, Boneless & Skinless (Diced)",
      "6 g Dried Italian Herbs",
      "400 g High Protein Cottage Cheese",
      "180 ml Chicken Stock",
      "4 g Onion Powder",
      "4 g Garlic Powder",
      "4 g Smoked Paprika",
      "50 g Parmigiano Reggiano (Grated)",
      "100 g Sun-Dried Tomatoes",
      "200 g Baby Spinach (Washed)",
      "Parmigiano Reggiano (To Taste)",
      "Salt & Pepper (To Taste)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 500.0, unit: "g", name: "Pasta of Choice" },
      { amount: 15.0, unit: "ml", name: "Sun-Dried Tomato Oil" },
      { amount: 800.0, unit: "g", name: "Chicken Breast, Boneless & Skinless" },
      { amount: 6.0, unit: "g", name: "Dried Italian Herbs" },
      { amount: 400.0, unit: "g", name: "High Protein Cottage Cheese" },
      { amount: 180.0, unit: "ml", name: "Chicken Stock" },
      { amount: 4.0, unit: "g", name: "Onion Powder" },
      { amount: 4.0, unit: "g", name: "Garlic Powder" },
      { amount: 4.0, unit: "g", name: "Smoked Paprika" },
      { amount: 50.0, unit: "g", name: "Parmigiano Reggiano" },
      { amount: 100.0, unit: "g", name: "Sun-Dried Tomatoes" },
      { amount: 200.0, unit: "g", name: "Baby Spinach" },
      { amount: nil, unit: nil, name: "Parmigiano Reggiano" },
      { amount: nil, unit: nil, name: "Salt & Pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Bring a pot of water to a boil, season generously with salt, and cook the pasta for 3 minutes less than the packet instructions. Drain and set aside.",
      "Add the chicken to a bowl and mix with the dried Italian herbs, salt, and pepper.",
      "In a blender, add the cottage cheese, chicken stock, onion powder, garlic powder, smoked paprika, parmesan, sun-dried tomatoes, and salt and pepper. Blend on high for 2–3 minutes, until smooth and no longer grainy.",
      "Place a large, high-rimmed pan or pot over high heat. Add the sun-dried tomato oil and seasoned chicken, and cook for 3–4 minutes, mixing occasionally. Work in batches if your pan isn't large enough.",
      "Reduce the heat to medium-low. Add the drained pasta to the chicken, then pour over the cottage cheese sauce. Mix well and cook for 1–2 minutes, until fully combined. Add the spinach and cook for a further minute, until wilted. Remove from the heat.",
      "Portion into 5 meal prep containers. Garnish with fresh basil, extra parmigiano reggiano, and cracked black pepper."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Bring a pot of water to a boil, season generously with salt, and cook the pasta for 3 minutes less than the packet instructions. Drain and set aside.\nAdd the chicken to a bowl and mix with the dried Italian herbs, salt, and pepper.\nIn a blender, add the cottage cheese, chicken stock, onion powder, garlic powder, smoked paprika, parmesan, sun-dried tomatoes, and salt and pepper. Blend on high for 2–3 minutes, until smooth and no longer grainy.\nPlace a large, high-rimmed pan or pot over high heat. Add the sun-dried tomato oil and seasoned chicken, and cook for 3–4 minutes, mixing occasionally. Work in batches if your pan isn't large enough.\nReduce the heat to medium-low. Add the drained pasta to the chicken, then pour over the cottage cheese sauce. Mix well and cook for 1–2 minutes, until fully combined. Add the spinach and cook for a further minute, until wilted. Remove from the heat.\nPortion into 5 meal prep containers. Garnish with fresh basil, extra parmigiano reggiano, and cracked black pepper.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("chefjackovens.com")
    expect(recipe.canonical_url).to eq("https://chefjackovens.com/high-protein-marry-me-chicken/")
    expect(recipe.site_name).to eq("Chef Jack Ovens")
    expect(recipe.language).to eq("en-AU")
    expect(recipe.author).to eq("Chef Jack Ovens")
    expect(recipe.description).to eq("A high-protein twist on Marry Me Chicken, built around a blended cottage cheese and sun-dried tomato sauce instead of cream. Seared chicken, pasta shells, and wilted spinach come together in one pan, finished with parmesan and fresh basil. Rich, creamy, and freezer-friendly for the week ahead.")
    expect(recipe.image).to eq("https://chefjackovens.com/wp-content/uploads/2025/04/Marry-Me-Chicken-2.png")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("5 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq([
      "Creamy chicken meal prep",
      "Easy chicken meal prep",
      "Healthy meal prep ideas",
      "High protein chicken recipes",
      "High-Protein Meal Prep",
      "Marry Me Chicken recipe",
      "Meal prep for muscle gain",
      "Meal prep for weight loss"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(3)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "450 g",
      "calories" => "650 kcal",
      "fatContent" => "11 g",
      "saturatedFatContent" => "4 g",
      "proteinContent" => "64 g",
      "carbohydrateContent" => "68 g",
      "cholesterolContent" => "126 mg",
      "sodiumContent" => "652 mg",
      "fiberContent" => "4 g",
      "sugarContent" => "7 g",
      "unsaturatedFatContent" => "3 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "g", amount: 450.0 },
      { name: "calories", unit: "kcal", amount: 650.0 },
      { name: "fatContent", unit: "g", amount: 11.0 },
      { name: "saturatedFatContent", unit: "g", amount: 4.0 },
      { name: "proteinContent", unit: "g", amount: 64.0 },
      { name: "carbohydrateContent", unit: "g", amount: 68.0 },
      { name: "cholesterolContent", unit: "mg", amount: 126.0 },
      { name: "sodiumContent", unit: "mg", amount: 652.0 },
      { name: "fiberContent", unit: "g", amount: 4.0 },
      { name: "sugarContent", unit: "g", amount: 7.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 3.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
