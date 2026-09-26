# frozen_string_literal: true

RSpec.describe "juliasalbum.com" do
  subject(:recipe) { scrape_cassette("com/juliasalbum", url: "https://juliasalbum.com/spinach-eggplant-and-feta-quinoa/") }

  it "reads the title" do
    expect(recipe.title).to eq("Roasted Eggplant, Spinach, Quinoa, and Feta Salad")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 eggplant (large, cut into 1 inch cubes)",
      "2 tablespoons olive oil",
      "salt and pepper",
      "1 tablespoon olive oil",
      "2 cloves garlic",
      "10 ounces spinach (fresh)",
      "1 1/2 cups cooked quinoa",
      "1/4 cup Feta cheese"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "eggplant" },
      { amount: 2.0, unit: "tablespoons", name: "olive oil" },
      { amount: nil, unit: nil, name: "salt and pepper" },
      { amount: 1.0, unit: "tablespoon", name: "olive oil" },
      { amount: 2.0, unit: "cloves", name: "garlic" },
      { amount: 10.0, unit: "ounces", name: "spinach" },
      { amount: 1.5, unit: "cups", name: "cooked quinoa" },
      { amount: 0.25, unit: "cup", name: "Feta cheese" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 420 F. Line a baking sheet with foil. Grease the sheet lightly with olive oil.",
      "In a large bowl, mix cubed eggplant with 2 tablespoons olive oil, and season with salt and pepper. Spread chopped eggplant over the lightly greased baking sheet. Roast for 20-25 minutes (or more, depends on your oven) until eggplant softens. Midway through roasting, take out the sheet and flip over eggplant cubes to the other side using spatula - that will help even out the roasting.",
      "While eggplant is being roasted, heat 1 tablespoon of olive oil in a large skillet, add spinach and 1 minced garlic clove and cook for a couple of minutes, constantly stirring, just until spinach wilts. Remove from heat.",
      "Once eggplant is done, immediately remove it from the baking sheet into the same skillet with spinach, off heat. Immediately add quinoa and second clove of minced garlic. This will allow cooked eggplant to release some juices when mixed in with quinoa. Mix everything well, off heat, and season with more salt if needed. Don't add too much salt or omit it altogether as you will be using Feta cheese too. Top with Feta cheese."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 420 F. Line a baking sheet with foil. Grease the sheet lightly with olive oil.\nIn a large bowl, mix cubed eggplant with 2 tablespoons olive oil, and season with salt and pepper. Spread chopped eggplant over the lightly greased baking sheet. Roast for 20-25 minutes (or more, depends on your oven) until eggplant softens. Midway through roasting, take out the sheet and flip over eggplant cubes to the other side using spatula - that will help even out the roasting.\nWhile eggplant is being roasted, heat 1 tablespoon of olive oil in a large skillet, add spinach and 1 minced garlic clove and cook for a couple of minutes, constantly stirring, just until spinach wilts. Remove from heat.\nOnce eggplant is done, immediately remove it from the baking sheet into the same skillet with spinach, off heat. Immediately add quinoa and second clove of minced garlic. This will allow cooked eggplant to release some juices when mixed in with quinoa. Mix everything well, off heat, and season with more salt if needed. Don't add too much salt or omit it altogether as you will be using Feta cheese too. Top with Feta cheese.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("juliasalbum.com")
    expect(recipe.canonical_url).to eq("https://juliasalbum.com/spinach-eggplant-and-feta-quinoa/")
    expect(recipe.site_name).to eq("Julia's Album")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Julia")
    expect(recipe.description).to eq("Roasted Eggplant, Spinach, Quinoa, and Feta Salad - healthy, Mediterranean-style, gluten free recipe. It's also vegetarian, paleo, low calorie, low carb and low cholesterol, high in fiber and protein (from quinoa). Even though it's a salad, it also makes a great main dish.")
    expect(recipe.image).to eq("https://juliasalbum.com/wp-content/uploads/2014/10/15448393006_467afa9038_c-1.jpg")
    expect(recipe.category).to eq("Salad")
    expect(recipe.cuisine).to eq("Mediterranean")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.79)
    expect(recipe.ratings_count).to eq(69)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "247 kcal",
      "carbohydrateContent" => "24 g",
      "proteinContent" => "7 g",
      "fatContent" => "14 g",
      "saturatedFatContent" => "3 g",
      "cholesterolContent" => "8 mg",
      "sodiumContent" => "168 mg",
      "fiberContent" => "6 g",
      "sugarContent" => "5 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 247.0 },
      { name: "carbohydrateContent", unit: "g", amount: 24.0 },
      { name: "proteinContent", unit: "g", amount: 7.0 },
      { name: "fatContent", unit: "g", amount: 14.0 },
      { name: "saturatedFatContent", unit: "g", amount: 3.0 },
      { name: "cholesterolContent", unit: "mg", amount: 8.0 },
      { name: "sodiumContent", unit: "mg", amount: 168.0 },
      { name: "fiberContent", unit: "g", amount: 6.0 },
      { name: "sugarContent", unit: "g", amount: 5.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-content")
  end
end
