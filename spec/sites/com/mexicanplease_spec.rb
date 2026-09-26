# frozen_string_literal: true

RSpec.describe "mexicanplease.com" do
  subject(:recipe) { scrape_cassette("com/mexicanplease", url: "https://www.mexicanplease.com/homemade-corn-tortillas/") }

  it "reads the title" do
    expect(recipe.title).to eq("Homemade Corn Tortillas")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups Masa Harina",
      "1/2 teaspoon salt",
      "1.5 cups warm water"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "Masa Harina" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 1.5, unit: "cups", name: "warm water" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Add 2 cups Masa Harina and 1/2 teaspoon salt to a mixing bowl. Add 1 cup of the warm water and stir until the water is absorbed. Add the rest of the water incrementally until the flour melds into a dough. Use your hands to knead the dough into a cohesive ball.",
      "If the dough is sticking to your hands simply add a few sprinklings of Masa Harina to dry it out. Conversely, if the dough is still crumbly then you can add splashes of water until it becomes cohesive.",
      "Separate the dough into golf ball sized chunks, this will make tortillas approximately 4 inches across.",
      "Flatten the dough balls using a flat bottomed pan or a tortilla press. Be sure to line each side of the dough ball with plastic or Ziploc pieces. I usually just cut off the top of a gallon sized Ziploc bag and then make slits down the sides, leaving it connected at the bottom.",
      "Heat a skillet or comal to medium-high heat. (Lately I use a tad over medium heat on my stove and this will have brown spots forming in about 60 seconds.)",
      "Add a tortilla to the skillet and flip it after 10 seconds. Then cook each side for about a minute or until light brown spots are forming on the underside.",
      "Continue cooking the rest of the tortillas. I usually put one in the skillet and flatten the next one to expedite the process. Once cooked you can keep them warm by wrapping them in a tea towel or using a dedicated tortilla warmer. Serve immediately.",
      "Store leftovers tortillas in an airtight container in the fridge. To reheat, cook them in a dry skillet over medium heat until warm and crispy."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Add 2 cups Masa Harina and 1/2 teaspoon salt to a mixing bowl. Add 1 cup of the warm water and stir until the water is absorbed. Add the rest of the water incrementally until the flour melds into a dough. Use your hands to knead the dough into a cohesive ball.\nIf the dough is sticking to your hands simply add a few sprinklings of Masa Harina to dry it out. Conversely, if the dough is still crumbly then you can add splashes of water until it becomes cohesive.\nSeparate the dough into golf ball sized chunks, this will make tortillas approximately 4 inches across.\nFlatten the dough balls using a flat bottomed pan or a tortilla press. Be sure to line each side of the dough ball with plastic or Ziploc pieces. I usually just cut off the top of a gallon sized Ziploc bag and then make slits down the sides, leaving it connected at the bottom.\nHeat a skillet or comal to medium-high heat. (Lately I use a tad over medium heat on my stove and this will have brown spots forming in about 60 seconds.)\nAdd a tortilla to the skillet and flip it after 10 seconds. Then cook each side for about a minute or until light brown spots are forming on the underside.\nContinue cooking the rest of the tortillas. I usually put one in the skillet and flatten the next one to expedite the process. Once cooked you can keep them warm by wrapping them in a tea towel or using a dedicated tortilla warmer. Serve immediately.\nStore leftovers tortillas in an airtight container in the fridge. To reheat, cook them in a dry skillet over medium heat until warm and crispy.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("mexicanplease.com")
    expect(recipe.canonical_url).to eq("https://www.mexicanplease.com/homemade-corn-tortillas/")
    expect(recipe.site_name).to eq("Mexican Please")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Mexican Please")
    expect(recipe.description).to eq("Keep some Masa Harina in the cupboard and you'll always have the option of making a quick batch of warm, delicious corn tortillas!")
    expect(recipe.image).to eq("https://www.mexicanplease.com/wp-content/uploads/2016/03/homemade-corn-tortillas-stacked-after-cooking-angled.jpg")
    expect(recipe.category).to eq("Side Dish")
    expect(recipe.cuisine).to eq("Mexican")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.13)
    expect(recipe.ratings_count).to eq(286)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "208 kcal",
      "carbohydrateContent" => "43 g",
      "proteinContent" => "5 g",
      "fatContent" => "2 g",
      "saturatedFatContent" => "1 g",
      "sodiumContent" => "294 mg",
      "fiberContent" => "4 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 208.0 },
      { name: "carbohydrateContent", unit: "g", amount: 43.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "fatContent", unit: "g", amount: 2.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 294.0 },
      { name: "fiberContent", unit: "g", amount: 4.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
