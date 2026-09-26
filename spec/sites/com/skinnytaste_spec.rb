# frozen_string_literal: true

RSpec.describe "skinnytaste.com" do
  subject(:recipe) { scrape_cassette("com/skinnytaste", url: "https://www.skinnytaste.com/grilled-chicken-with-spinach-and-melted/") }

  it "reads the title" do
    expect(recipe.title).to eq("Grilled Chicken with Spinach and Mozzarella")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "24 oz chicken breasts sliced in half lengthwise to make 6 (from 3 large )",
      "kosher salt ( and black pepper to taste)",
      "1 tsp olive oil",
      "3 cloves garlic (crushed)",
      "10 ounces frozen spinach (drained)",
      "3 ounces shredded part skim mozzarella",
      "1/2 cup roasted red pepper (sliced in strips (packed in water))",
      "olive oil spray"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 24.0, unit: "oz", name: "chicken breasts sliced in half lengthwise to make 6" },
      { amount: nil, unit: nil, name: "kosher salt" },
      { amount: 1.0, unit: "tsp", name: "olive oil" },
      { amount: 3.0, unit: "cloves", name: "garlic" },
      { amount: 10.0, unit: "ounces", name: "frozen spinach" },
      { amount: 3.0, unit: "ounces", name: "shredded part skim mozzarella" },
      { amount: 0.5, unit: "cup", name: "roasted red pepper" },
      { amount: nil, unit: nil, name: "olive oil spray" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 400°F. Season chicken with salt and pepper. Lightly spray a grill or grill pan with oil. Cook chicken until no longer pink, about 2 to 3 minutes per side.",
      "Heat a skillet over medium heat. Add oil and garlic, sauté a 30 seconds, add spinach, salt and pepper. Cook until heated through, 2 to 3 minutes.",
      "Place chicken on a baking sheet, divide spinach evenly between the 6 pieces and place on top. Top each with 1/2 oz mozzarella, roasted peppers and bake until melted, about 3 minutes."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 400°F. Season chicken with salt and pepper. Lightly spray a grill or grill pan with oil. Cook chicken until no longer pink, about 2 to 3 minutes per side.\nHeat a skillet over medium heat. Add oil and garlic, sauté a 30 seconds, add spinach, salt and pepper. Cook until heated through, 2 to 3 minutes.\nPlace chicken on a baking sheet, divide spinach evenly between the 6 pieces and place on top. Top each with 1/2 oz mozzarella, roasted peppers and bake until melted, about 3 minutes.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("skinnytaste.com")
    expect(recipe.canonical_url).to eq("https://www.skinnytaste.com/grilled-chicken-with-spinach-and-melted/")
    expect(recipe.site_name).to eq("Skinnytaste")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Gina Homolka")
    expect(recipe.description).to eq("Easy Grilled chicken topped with sauteed garlicky spinach, mozzarella and roasted peppers – a quick and easy, high-protein chicken dish your family will love!")
    expect(recipe.image).to eq("https://www.skinnytaste.com/wp-content/uploads/2011/03/Grilled-Chicken-with-Spinach-and-Melted-Mozzarella-10.jpg")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to eq("Italian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(17)
    expect(recipe.prep_time).to eq(2)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq([
      "chicken breast recipes",
      "grilled chicken",
      "grilled chicken breast",
      "grilled chicken recipe",
      "Grilled Chicken with Spinach and Melted Mozzarella"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.82)
    expect(recipe.ratings_count).to eq(27)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 piece",
      "calories" => "195 kcal",
      "carbohydrateContent" => "3.5 g",
      "proteinContent" => "31 g",
      "fatContent" => "6 g",
      "saturatedFatContent" => "2 g",
      "cholesterolContent" => "91 mg",
      "sodiumContent" => "183 mg",
      "fiberContent" => "1.5 g",
      "sugarContent" => "0.5 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "piece", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 195.0 },
      { name: "carbohydrateContent", unit: "g", amount: 3.5 },
      { name: "proteinContent", unit: "g", amount: 31.0 },
      { name: "fatContent", unit: "g", amount: 6.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "cholesterolContent", unit: "mg", amount: 91.0 },
      { name: "sodiumContent", unit: "mg", amount: 183.0 },
      { name: "fiberContent", unit: "g", amount: 1.5 },
      { name: "sugarContent", unit: "g", amount: 0.5 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
