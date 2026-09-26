# frozen_string_literal: true

RSpec.describe "recipegirl.com" do
  subject(:recipe) { scrape_cassette("com/recipegirl", url: "https://www.recipegirl.com/pioneer-womans-linguine-with-clam-sauce/") }

  it "reads the title" do
    expect(recipe.title).to eq("Pioneer Woman's Linguine with Clam Sauce")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "16 ounces linguine",
      "1 tablespoon extra virgin olive oil",
      "2 tablespoons butter (divided)",
      "3 medium garlic cloves, (minced)",
      "Three 6.5-ounce cans chopped clams, (drained (save the juice))",
      "¾ cup white wine",
      "½ medium lemon, (juiced)",
      "2 tablespoons chopped fresh Italian parsley",
      "¾ cup whipping cream",
      "salt and freshly ground black pepper, (to taste)",
      "grated Parmesan cheese for topping, (if desired)",
      "½ medium lemon, (sliced for garnish (optional))"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 16.0, unit: "ounces", name: "linguine" },
      { amount: 1.0, unit: "tablespoon", name: "extra virgin olive oil" },
      { amount: 2.0, unit: "tablespoons", name: "butter" },
      { amount: 3.0, unit: nil, name: "medium garlic cloves" },
      { amount: 3.0, unit: "cans", name: "chopped clams" },
      { amount: 0.75, unit: "cup", name: "white wine" },
      { amount: 0.5, unit: nil, name: "medium lemon" },
      { amount: 2.0, unit: "tablespoons", name: "chopped fresh Italian parsley" },
      { amount: 0.75, unit: "cup", name: "whipping cream" },
      { amount: nil, unit: nil, name: "salt and freshly ground black pepper" },
      { amount: nil, unit: nil, name: "grated Parmesan cheese for topping" },
      { amount: 0.5, unit: nil, name: "medium lemon" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Cook the pasta according to package directions. Make the sauce while the pasta is cooking.",
      "In a large skillet over medium-high heat, add the olive oil and 1 tablespoon butter. Add the garlic and then the clams; stir together. Cook for 3 minutes. Pour in the white wine, scraping the bottom of the pan with the spoon. Cook for 3 to 4 minutes, until the sauce is reduced and less watery. Add in 1 more tablespoon of butter and stir to melt. Reduce heat and add the lemon juice. Add parsley and cream. Add salt and pepper. Stir well and taste for seasonings, adding a splash of clam juice if the sauce needs thinning.",
      "Cook over low heat for 3 additional minutes, or until heated through.",
      "Drain the pasta and put the hot pasta in a large bowl. Pour the sauce from the skillet onto the hot linguine. Toss to combine.",
      "Serve in individual bowls; sprinkle with Parmesan (if desired) and serve with lemon wedge for garnish."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Cook the pasta according to package directions. Make the sauce while the pasta is cooking.\nIn a large skillet over medium-high heat, add the olive oil and 1 tablespoon butter. Add the garlic and then the clams; stir together. Cook for 3 minutes. Pour in the white wine, scraping the bottom of the pan with the spoon. Cook for 3 to 4 minutes, until the sauce is reduced and less watery. Add in 1 more tablespoon of butter and stir to melt. Reduce heat and add the lemon juice. Add parsley and cream. Add salt and pepper. Stir well and taste for seasonings, adding a splash of clam juice if the sauce needs thinning.\nCook over low heat for 3 additional minutes, or until heated through.\nDrain the pasta and put the hot pasta in a large bowl. Pour the sauce from the skillet onto the hot linguine. Toss to combine.\nServe in individual bowls; sprinkle with Parmesan (if desired) and serve with lemon wedge for garnish.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("recipegirl.com")
    expect(recipe.canonical_url).to eq("https://www.recipegirl.com/pioneer-womans-linguine-with-clam-sauce/")
    expect(recipe.site_name).to eq("Recipe Girl®")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Lori Lange")
    expect(recipe.description).to eq("A totally delicious version of this classic pasta dish!")
    expect(recipe.image).to eq("https://www.recipegirl.com/wp-content/uploads/2007/12/PW-Clam-Linguine-1.jpeg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["clam linguine", "linguine with clam sauce", "pioneer woman"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.67)
    expect(recipe.ratings_count).to eq(6)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 serving",
      "calories" => "770 kcal",
      "carbohydrateContent" => "98 g",
      "proteinContent" => "24 g",
      "fatContent" => "28 g",
      "saturatedFatContent" => "15 g",
      "cholesterolContent" => "82 mg",
      "sodiumContent" => "203 mg",
      "fiberContent" => "4 g",
      "sugarContent" => "4 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "serving", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 770.0 },
      { name: "carbohydrateContent", unit: "g", amount: 98.0 },
      { name: "proteinContent", unit: "g", amount: 24.0 },
      { name: "fatContent", unit: "g", amount: 28.0 },
      { name: "saturatedFatContent", unit: "g", amount: 15.0 },
      { name: "cholesterolContent", unit: "mg", amount: 82.0 },
      { name: "sodiumContent", unit: "mg", amount: 203.0 },
      { name: "fiberContent", unit: "g", amount: 4.0 },
      { name: "sugarContent", unit: "g", amount: 4.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
