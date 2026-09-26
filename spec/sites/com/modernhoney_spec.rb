# frozen_string_literal: true

RSpec.describe "modernhoney.com" do
  subject(:recipe) { scrape_cassette("com/modernhoney", url: "https://www.modernhoney.com/sticky-honey-garlic-chicken/") }

  it "reads the title" do
    expect(recipe.title).to eq("Honey Garlic Chicken")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 to 1 1/4 1b. Chicken Breast (about 4 thinly sliced chicken breasts or 2 large sliced in half)",
      "Salt and Pepper ((sprinkle on both sides of chicken)11/)",
      "1/4 cup Flour*",
      "4 Tablespoons Salted Butter",
      "3 Garlic Cloves (minced)",
      "1 Tablespoon Apple Cider Vinegar",
      "1 Tablespoon Soy Sauce",
      "1/3 cup Honey (plus more for drizzling, if desired)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "1b. Chicken Breast" },
      { amount: nil, unit: nil, name: "Salt and Pepper" },
      { amount: 0.25, unit: "cup", name: "Flour*" },
      { amount: 4.0, unit: "Tablespoons", name: "Salted Butter" },
      { amount: 3.0, unit: nil, name: "Garlic Cloves" },
      { amount: 1.0, unit: "Tablespoon", name: "Apple Cider Vinegar" },
      { amount: 1.0, unit: "Tablespoon", name: "Soy Sauce" },
      { amount: 0.33, unit: "cup", name: "Honey" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Generously sprinkle thinly sliced chicken breast with salt and pepper on both sides. Heat a large skillet over medium-high heat. Add 2 Tablespoons of butter to the skillet and let melt.",
      "Dredge both sides of the chicken breast into the flour. Repeat with all breasts. Place in a hot skillet and cook for 3-4 minutes per side.",
      "Add the remaining 2 Tablespoons of butter and garlic. Cook for 1 minute. Add apple cider vinegar, soy sauce, and honey. Let sauce chicken for 3-4 minutes (or longer if needed). Make sure chicken is fully cooked through and no longer pink.",
      "Remove from heat and coat the chicken with the sauce. Serve with rice, potatoes, or vegetables."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Generously sprinkle thinly sliced chicken breast with salt and pepper on both sides. Heat a large skillet over medium-high heat. Add 2 Tablespoons of butter to the skillet and let melt.\nDredge both sides of the chicken breast into the flour. Repeat with all breasts. Place in a hot skillet and cook for 3-4 minutes per side.\nAdd the remaining 2 Tablespoons of butter and garlic. Cook for 1 minute. Add apple cider vinegar, soy sauce, and honey. Let sauce chicken for 3-4 minutes (or longer if needed). Make sure chicken is fully cooked through and no longer pink.\nRemove from heat and coat the chicken with the sauce. Serve with rice, potatoes, or vegetables.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("modernhoney.com")
    expect(recipe.canonical_url).to eq("https://www.modernhoney.com/sticky-honey-garlic-chicken/")
    expect(recipe.site_name).to eq("Modern Honey")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Modern Honey - www.modernhoney.com")
    expect(recipe.description).to eq("Honey Garlic Chicken. Quick and easy skillet honey garlic chicken breast. Seared chicken breast in an Asian honey garlic sauce. Made in less than 15 minutes!")
    expect(recipe.image).to eq("https://www.modernhoney.com/wp-content/uploads/2020/09/Honey-Garlic-Chicken-4-scaled.jpg")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to eq("Asian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(3)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq(["honey garlic chicken", "sticky honey garlic chicken"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.92)
    expect(recipe.ratings_count).to eq(24)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
