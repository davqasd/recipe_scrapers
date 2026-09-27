# frozen_string_literal: true

RSpec.describe "carriesexperimentalkitchen.com" do
  subject(:recipe) { scrape_cassette("com/carriesexperimentalkitchen", url: "https://www.carriesexperimentalkitchen.com/chicken-thighs-horseradish-cream-sauce/") }

  it "reads the title" do
    expect(recipe.title).to eq("Baked Chicken Thighs in a Horseradish Cream Sauce")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "6 Bone-In Chicken Thighs",
      "2 tbsp. Butter",
      "2 tbsp. All Purpose Flour",
      "1 c. Milk",
      "3 tbsp. Prepared Horseradish",
      "2 tbsp. Sour Cream",
      "1 tsp. Dijon Mustard",
      "Salt & Pepper, to taste"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 6.0, unit: nil, name: "Bone-In Chicken Thighs" },
      { amount: 2.0, unit: "tbsp", name: "Butter" },
      { amount: 2.0, unit: "tbsp", name: "All Purpose Flour" },
      { amount: 1.0, unit: "c", name: "Milk" },
      { amount: 3.0, unit: "tbsp", name: "Prepared Horseradish" },
      { amount: 2.0, unit: "tbsp", name: "Sour Cream" },
      { amount: 1.0, unit: "tsp", name: "Dijon Mustard" },
      { amount: nil, unit: nil, name: "Salt & Pepper, to taste" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 375 degrees F.",
      "In a medium size saucepan melt the butter over medium heat. Stir in the flour forming a roux; then whisk in the milk and bring to a boil. When the milk has thickened (about 3 minutes), add the horseradish, sour cream, and mustard; then add salt and pepper to your liking.",
      "Place the chicken thighs in an oven safe baking dish (skin sides up); then pour the sauce over the chicken and bake for 50-55 minutes until the chicken is tender and no longer pink."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 375 degrees F.\nIn a medium size saucepan melt the butter over medium heat. Stir in the flour forming a roux; then whisk in the milk and bring to a boil. When the milk has thickened (about 3 minutes), add the horseradish, sour cream, and mustard; then add salt and pepper to your liking.\nPlace the chicken thighs in an oven safe baking dish (skin sides up); then pour the sauce over the chicken and bake for 50-55 minutes until the chicken is tender and no longer pink.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("carriesexperimentalkitchen.com")
    expect(recipe.canonical_url).to eq("https://www.carriesexperimentalkitchen.com/chicken-thighs-horseradish-cream-sauce/")
    expect(recipe.site_name).to eq("Carrie’s Experimental Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Carrie's Experimental Kitchen")
    expect(recipe.description).to eq("Bone-in chicken thighs topped with a horseradish cream sauce made with horseradish, milk, butter, sour cream and Dijon mustard; then baked until crispy.")
    expect(recipe.image).to eq("https://www.carriesexperimentalkitchen.com/wp-content/uploads/2018/09/Baked.-Chicken-Thighs-in-a-Horseradish-Cream-Sauce2.jpg")
    expect(recipe.category).to eq("Main Entree")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(60)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(55)
    expect(recipe.keywords).to eq(["chicken"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "351 kcal",
      "carbohydrateContent" => "7 g",
      "proteinContent" => "22 g",
      "fatContent" => "26 g",
      "saturatedFatContent" => "9 g",
      "transFatContent" => "0.3 g",
      "cholesterolContent" => "135 mg",
      "sodiumContent" => "185 mg",
      "fiberContent" => "0.4 g",
      "sugarContent" => "3 g",
      "unsaturatedFatContent" => "14 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 351.0 },
      { name: "carbohydrateContent", unit: "g", amount: 7.0 },
      { name: "proteinContent", unit: "g", amount: 22.0 },
      { name: "fatContent", unit: "g", amount: 26.0 },
      { name: "saturatedFatContent", unit: "g", amount: 9.0 },
      { name: "transFatContent", unit: "g", amount: 0.3 },
      { name: "cholesterolContent", unit: "mg", amount: 135.0 },
      { name: "sodiumContent", unit: "mg", amount: 185.0 },
      { name: "fiberContent", unit: "g", amount: 0.4 },
      { name: "sugarContent", unit: "g", amount: 3.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 14.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#feastmobilemenu")
  end
end
