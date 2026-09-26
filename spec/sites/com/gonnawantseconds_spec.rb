# frozen_string_literal: true

RSpec.describe "gonnawantseconds.com" do
  subject(:recipe) { scrape_cassette("com/gonnawantseconds", url: "https://www.gonnawantseconds.com/white-chicken-enchiladas/") }

  it "reads the title" do
    expect(recipe.title).to eq("White Chicken Enchiladas")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "8-10 small flour tortillas",
      "3 cups cooked chicken (shredded or chopped)",
      "3 cups Monterey jack cheese (shredded-divided)",
      "3 tablespoons unsalted butter",
      "3 tablespoons flour",
      "2 cups chicken broth",
      "1 cup sour cream",
      "1 (4-ounce) can diced green chilies mild",
      "2-3 tablespoons green onions (sliced)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 8.0, unit: nil, name: "small flour tortillas" },
      { amount: 3.0, unit: "cups", name: "cooked chicken" },
      { amount: 3.0, unit: "cups", name: "Monterey jack cheese" },
      { amount: 3.0, unit: "tablespoons", name: "unsalted butter" },
      { amount: 3.0, unit: "tablespoons", name: "flour" },
      { amount: 2.0, unit: "cups", name: "chicken broth" },
      { amount: 1.0, unit: "cup", name: "sour cream" },
      { amount: 1.0, unit: "can", name: "diced green chilies mild" },
      { amount: 2.0, unit: "tablespoons", name: "green onions" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Spray a 9x13-inch baking dish with cooking spray and set aside. Preheat oven to 350ºF (177ºC).",
      "In a small bowl, combine chicken (3 cups) and 1 cup of Monterey Jack cheese. Fill tortillas (8-10) with this mixture and roll each one up then place seam side down in the prepared pan.",
      "Melt the butter (3 tablespoons) in a skillet. Sprinkle flour (3 tablespoons) over melted butter and whisk to combine. Cook for 1 minute to remove the flour taste. Remove the skillet from heat and whisk in broth (2 cups). Place back on the heat and cook until the mixture has thickened and is bubbly. Cool sauce for 3-5 minutes. (Don't skip this step- if the sauce is too hot and you add the sour cream it will curdle it-yuck!). Add sour cream (1 cup) and chilies (1 can) and stir until the sauce is smooth and the sour cream is completely dissolved.",
      "Pour sauce over enchiladas and add remaining cheese over top. Bake in the preheated oven for 20-25 minutes or until the enchiladas are heated through and the sauce is bubbly. Turn on the broiler and broil until the top is nicely golden. Top with chopped green onions (2-3 tablespoons) and serve."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Spray a 9x13-inch baking dish with cooking spray and set aside. Preheat oven to 350ºF (177ºC).\nIn a small bowl, combine chicken (3 cups) and 1 cup of Monterey Jack cheese. Fill tortillas (8-10) with this mixture and roll each one up then place seam side down in the prepared pan.\nMelt the butter (3 tablespoons) in a skillet. Sprinkle flour (3 tablespoons) over melted butter and whisk to combine. Cook for 1 minute to remove the flour taste. Remove the skillet from heat and whisk in broth (2 cups). Place back on the heat and cook until the mixture has thickened and is bubbly. Cool sauce for 3-5 minutes. (Don't skip this step- if the sauce is too hot and you add the sour cream it will curdle it-yuck!). Add sour cream (1 cup) and chilies (1 can) and stir until the sauce is smooth and the sour cream is completely dissolved.\nPour sauce over enchiladas and add remaining cheese over top. Bake in the preheated oven for 20-25 minutes or until the enchiladas are heated through and the sauce is bubbly. Turn on the broiler and broil until the top is nicely golden. Top with chopped green onions (2-3 tablespoons) and serve.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("gonnawantseconds.com")
    expect(recipe.canonical_url).to eq("https://www.gonnawantseconds.com/white-chicken-enchiladas/")
    expect(recipe.site_name).to eq("Gonna Want Seconds")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Kathleen")
    expect(recipe.description).to eq("Whip up the cheesiest, dreamiest dinner you've ever had with my sensational White Chicken Enchiladas! Guaranteed to please even the pickiest eaters!")
    expect(recipe.image).to eq("https://www.gonnawantseconds.com/wp-content/uploads/2020/08/White-Chicken-Enchiladas-01.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("Mexican")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq([
      "How DO I Make White Chicken Enchiladas Recipe",
      "How To Make White Chicken Enchiladas Recipe",
      "White Chicken Enchiladas",
      "White Chicken Enchiladas Recipe"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(137)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 g",
      "calories" => "897 kcal",
      "carbohydrateContent" => "39 g",
      "proteinContent" => "45 g",
      "fatContent" => "63 g",
      "saturatedFatContent" => "33 g",
      "cholesterolContent" => "191 mg",
      "sodiumContent" => "1472 mg",
      "fiberContent" => "1.5 g",
      "sugarContent" => "5.5 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "g", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 897.0 },
      { name: "carbohydrateContent", unit: "g", amount: 39.0 },
      { name: "proteinContent", unit: "g", amount: 45.0 },
      { name: "fatContent", unit: "g", amount: 63.0 },
      { name: "saturatedFatContent", unit: "g", amount: 33.0 },
      { name: "cholesterolContent", unit: "mg", amount: 191.0 },
      { name: "sodiumContent", unit: "mg", amount: 1472.0 },
      { name: "fiberContent", unit: "g", amount: 1.5 },
      { name: "sugarContent", unit: "g", amount: 5.5 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
