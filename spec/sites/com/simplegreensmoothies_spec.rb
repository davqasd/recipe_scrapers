# frozen_string_literal: true

RSpec.describe "simplegreensmoothies.com" do
  subject(:recipe) { scrape_cassette("com/simplegreensmoothies", url: "https://simplegreensmoothies.com/rice-krispie-treats-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Healthy Rice Krispie Treats")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup brown rice syrup",
      "2 tbsp coconut oil, unrefined (plus more for greasing the pan)",
      "2 tsp pure vanilla extract",
      "1/2 tsp sea salt",
      "1 cup almond butter (creamy)",
      "2 tsp ground cinnamon",
      "7 cup brown rice crisp cereal"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "brown rice syrup" },
      { amount: 2.0, unit: "tbsp", name: "coconut oil, unrefined" },
      { amount: 2.0, unit: "tsp", name: "pure vanilla extract" },
      { amount: 0.5, unit: "tsp", name: "sea salt" },
      { amount: 1.0, unit: "cup", name: "almond butter" },
      { amount: 2.0, unit: "tsp", name: "ground cinnamon" },
      { amount: 7.0, unit: "cup", name: "brown rice crisp cereal" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Line a 13 × 9-inch baking pan with parchment paper.",
      "In a medium saucepan over medium-high heat, combine the rice syrup, oil, vanilla, and salt. Bring to a rolling boil. Boil for 1 minute, then remove from the heat. Stir in the almond butter and cinnamon.",
      "Place the cereal in a large mixing bowl. Pour the almond butter mixture over the cereal and stir until well coated. Transfer the mixture to the prepared pan.",
      "Using oiled hands, press the mixture evenly into the pan. Let cool completely before cutting into bars."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Line a 13 × 9-inch baking pan with parchment paper.\nIn a medium saucepan over medium-high heat, combine the rice syrup, oil, vanilla, and salt. Bring to a rolling boil. Boil for 1 minute, then remove from the heat. Stir in the almond butter and cinnamon.\nPlace the cereal in a large mixing bowl. Pour the almond butter mixture over the cereal and stir until well coated. Transfer the mixture to the prepared pan.\nUsing oiled hands, press the mixture evenly into the pan. Let cool completely before cutting into bars.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("simplegreensmoothies.com")
    expect(recipe.canonical_url).to eq("https://simplegreensmoothies.com/rice-krispie-treats-recipe/")
    expect(recipe.site_name).to eq("Simple Green Smoothies")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jen Hansard")
    expect(recipe.description).to eq("These Healthy Rice Krispie Treats are made with almond butter, brown rice syrup (or raw honey!), and whole grain cereal. No corn syrup, no marshmallows—just chewy, satisfying, crispy bars you’ll feel good about sharing with the whole family.")
    expect(recipe.image).to eq("https://simplegreensmoothies.com/wp-content/uploads/healthy-rice-krispie-treats-bars-recipe-thumbnail.jpg")
    expect(recipe.category).to eq("dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("16 servings")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["easy treat recipe", "krispie treat", "rice treat"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["Gluten Free", "Vegan"])
    expect(recipe.ratings).to eq(4.95)
    expect(recipe.ratings_count).to eq(19)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 bar",
      "calories" => "216 kcal",
      "sugarContent" => "15 g",
      "sodiumContent" => "154 mg",
      "fatContent" => "11 g",
      "saturatedFatContent" => "2 g",
      "transFatContent" => "1 g",
      "carbohydrateContent" => "29 g",
      "fiberContent" => "2 g",
      "proteinContent" => "5 g",
      "unsaturatedFatContent" => "7 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "bar", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 216.0 },
      { name: "sugarContent", unit: "g", amount: 15.0 },
      { name: "sodiumContent", unit: "mg", amount: 154.0 },
      { name: "fatContent", unit: "g", amount: 11.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "carbohydrateContent", unit: "g", amount: 29.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 7.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
