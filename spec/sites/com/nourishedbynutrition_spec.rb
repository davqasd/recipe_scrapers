# frozen_string_literal: true

RSpec.describe "nourishedbynutrition.com" do
  subject(:recipe) { scrape_cassette("com/nourishedbynutrition", url: "https://nourishedbynutrition.com/healthy-salsa-verde-chicken-enchiladas-dairy-free/") }

  it "reads the title" do
    expect(recipe.title).to eq("Salsa Verde Chicken Enchiladas")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups shredded cooked chicken breast",
      "2 cups salsa verde, divided",
      "5 ounces spinach",
      "½ teaspoon garlic powder",
      "½ teaspoon ground cumin",
      "salt and pepper to taste",
      "8 tortillas (cassava flour or corn, flour, wheat, etc)",
      "½ cup Siete queso blanco (see notes for substitutions)",
      "½ avocado, thinly sliced",
      "¼ cilantro leaves",
      "2 tablespoons finely diced red onion",
      "1 lime, cut into wedges",
      "2-3 thinly sliced radishes"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "shredded cooked chicken breast" },
      { amount: 2.0, unit: "cups", name: "salsa verde, divided" },
      { amount: 5.0, unit: "ounces", name: "spinach" },
      { amount: 0.5, unit: "teaspoon", name: "garlic powder" },
      { amount: 0.5, unit: "teaspoon", name: "ground cumin" },
      { amount: nil, unit: nil, name: "salt and pepper to taste" },
      { amount: 8.0, unit: nil, name: "tortillas" },
      { amount: 0.5, unit: "cup", name: "Siete queso blanco" },
      { amount: 0.5, unit: nil, name: "avocado, thinly sliced" },
      { amount: 0.25, unit: nil, name: "cilantro leaves" },
      { amount: 2.0, unit: "tablespoons", name: "finely diced red onion" },
      { amount: 1.0, unit: nil, name: "lime, cut into wedges" },
      { amount: 2.0, unit: nil, name: "thinly sliced radishes" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 375F degrees.",
      "Heat a medium skillet over medium heat. Add the spinach and cover with a lid. Let spinach wilt. This should only take about 2-3 minutes. Remove from the heat and set aside.",
      "In a bowl, combine the shredded chicken with the garlic powder, cumin, ½ cup of the salsa verde, and wilted spinach. Toss to coat.",
      "Wrap them in a damp paper towel and microwave for 20-40 seconds to loosen them up so that they are easier to roll. You can also heat them directly the gas burner or in a saute pan one at a time. Pour ½ cup of the salsa verde on the bottom of a 9×13 baking dish, spread to coat the bottom.",
      "To assemble the enchiladas, place about ¼ cup of chicken mixture on a tortilla. Gently roll the tortilla and place it seam side down into the prepared baking dish. Repeat with the remaining tortillas and chicken.",
      "Pour the remaining 1 cup of salsa over the top of the enchiladas so they’re completely covered. Add the vegan queso blanco or shredded cheese of choice on top, if desired. Cover with foil. Bake for 25 minutes. Remove from oven and let sit for 5-10 minutes before topping with garnishes. Enjoy warm."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 375F degrees.\nHeat a medium skillet over medium heat. Add the spinach and cover with a lid. Let spinach wilt. This should only take about 2-3 minutes. Remove from the heat and set aside.\nIn a bowl, combine the shredded chicken with the garlic powder, cumin, ½ cup of the salsa verde, and wilted spinach. Toss to coat.\nWrap them in a damp paper towel and microwave for 20-40 seconds to loosen them up so that they are easier to roll. You can also heat them directly the gas burner or in a saute pan one at a time. Pour ½ cup of the salsa verde on the bottom of a 9×13 baking dish, spread to coat the bottom.\nTo assemble the enchiladas, place about ¼ cup of chicken mixture on a tortilla. Gently roll the tortilla and place it seam side down into the prepared baking dish. Repeat with the remaining tortillas and chicken.\nPour the remaining 1 cup of salsa over the top of the enchiladas so they’re completely covered. Add the vegan queso blanco or shredded cheese of choice on top, if desired. Cover with foil. Bake for 25 minutes. Remove from oven and let sit for 5-10 minutes before topping with garnishes. Enjoy warm.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("nourishedbynutrition.com")
    expect(recipe.canonical_url).to eq("https://nourishedbynutrition.com/healthy-salsa-verde-chicken-enchiladas-dairy-free/")
    expect(recipe.site_name).to eq("Nourished By Nutrition")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Jessica Bippen")
    expect(recipe.description).to eq("Healthy salsa verde chicken enchiladas made grain-free and dairy-free with cassava flour tortillas and vegan cashew queso. This enchilada recipe uses store-bought salsa verde and cooked shredded chicken for an easy weeknight dinner!")
    expect(recipe.image).to eq("https://nourishedbynutrition.com/wp-content/uploads/2020/08/Salsa-Verde-Chicken-Enchiladas-8.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://nourishedbynutrition.com")
  end
end
