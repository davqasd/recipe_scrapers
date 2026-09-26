# frozen_string_literal: true

RSpec.describe "asweetpeachef.com" do
  subject(:recipe) { scrape_cassette("com/asweetpeachef", url: "https://www.asweetpeachef.com/healthy-apple-crumble/") }

  it "reads the title" do
    expect(recipe.title).to eq("Healthy Apple Crumble")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "8 cups sliced Granny Smith apples (approx. 7 apples)",
      "1/2 cup coconut sugar (plus more to taste if needed)",
      "1/2 fresh lemon zest and juice (plus more to taste if needed)",
      "1 tsp ground cinnamon",
      "1/4 tsp ground nutmeg",
      "1/8 tsp sea salt",
      "1 cup almond flour",
      "1/3 cup chopped pecans (can also use walnuts or almonds or a mixture of all 3)",
      "1/4 cup pepitas",
      "1 tsp ground cinnamon",
      "1/8 tsp sea salt",
      "2 tbsp melted coconut oil (plus more to lightly grease baking dish)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 8.0, unit: "cups", name: "sliced Granny Smith apples" },
      { amount: 0.5, unit: "cup", name: "coconut sugar" },
      { amount: 0.5, unit: nil, name: "fresh lemon zest and juice" },
      { amount: 1.0, unit: "tsp", name: "ground cinnamon" },
      { amount: 0.25, unit: "tsp", name: "ground nutmeg" },
      { amount: 0.13, unit: "tsp", name: "sea salt" },
      { amount: 1.0, unit: "cup", name: "almond flour" },
      { amount: 0.33, unit: "cup", name: "chopped pecans" },
      { amount: 0.25, unit: "cup", name: "pepitas" },
      { amount: 1.0, unit: "tsp", name: "ground cinnamon" },
      { amount: 0.13, unit: "tsp", name: "sea salt" },
      { amount: 2.0, unit: "tbsp", name: "melted coconut oil" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 375 degrees F and lightly grease an 8x13-inch baking pan with coconut oil. Set aside.",
      "In a large mixing bowl, combine the ingredients for the apple filling, including the apples, coconut sugar, lemon zest and juice, ground cinnamon, ground nutmeg, and sea salt. Stir to combine.",
      "Pour the apple mixture into the baking dish, and place into the oven. Cook for 10 minutes, or until the apples begin to soften. While the apples are cooking, prepare the crumble topping.",
      "In a separate mixing bowl, combine the ingredients for the crumble, which include the almond flour, chopped nuts, pepitas, cinnamon, sea salt, and melted coconut oil.",
      "Carefully remove the apples from the oven and top with the crumble topping. Return the crumble to the oven, and bake, uncovered, for an additional 20-25 minutes, or until the topping is golden brown and apple mixture is bubbly.",
      "Remove from the oven and let cool for 5 minutes. Serve warm."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["For the Apple Filling", 6],
        ["For the Crumble Topping", 6]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 375 degrees F and lightly grease an 8x13-inch baking pan with coconut oil. Set aside.\nIn a large mixing bowl, combine the ingredients for the apple filling, including the apples, coconut sugar, lemon zest and juice, ground cinnamon, ground nutmeg, and sea salt. Stir to combine.\nPour the apple mixture into the baking dish, and place into the oven. Cook for 10 minutes, or until the apples begin to soften. While the apples are cooking, prepare the crumble topping.\nIn a separate mixing bowl, combine the ingredients for the crumble, which include the almond flour, chopped nuts, pepitas, cinnamon, sea salt, and melted coconut oil.\nCarefully remove the apples from the oven and top with the crumble topping. Return the crumble to the oven, and bake, uncovered, for an additional 20-25 minutes, or until the topping is golden brown and apple mixture is bubbly.\nRemove from the oven and let cool for 5 minutes. Serve warm.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("asweetpeachef.com")
    expect(recipe.canonical_url).to eq("https://www.asweetpeachef.com/healthy-apple-crumble/")
    expect(recipe.site_name).to eq("A Sweet Pea Chef")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Lacey Baier")
    expect(recipe.description).to eq("This Healthy Apple Crumble is apple and spice goodness, and a good-for-you crumble all rolled into one. With nuts, pepitas, and tasty cinnamon, this is a gluten-free clean eating dessert soon to be your next favorite!")
    expect(recipe.image).to eq("https://www.asweetpeachef.com/wp-content/uploads/2014/01/healthy-apple-crumble-square.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(35)
    expect(recipe.keywords).to eq([
      "healthy apple crumble",
      "warm apple crisp",
      "warm apple crumble",
      "warm apple recipe"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(4)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "251 kcal",
      "carbohydrateContent" => "30 g",
      "proteinContent" => "4 g",
      "fatContent" => "15 g",
      "saturatedFatContent" => "4 g",
      "sodiumContent" => "94 mg",
      "fiberContent" => "5 g",
      "sugarContent" => "20 g",
      "servingSize" => "1 cup"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 251.0 },
      { name: "carbohydrateContent", unit: "g", amount: 30.0 },
      { name: "proteinContent", unit: "g", amount: 4.0 },
      { name: "fatContent", unit: "g", amount: 15.0 },
      { name: "saturatedFatContent", unit: "g", amount: 4.0 },
      { name: "sodiumContent", unit: "mg", amount: 94.0 },
      { name: "fiberContent", unit: "g", amount: 5.0 },
      { name: "sugarContent", unit: "g", amount: 20.0 },
      { name: "servingSize", unit: "cup", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://cleanishsquad.com/")
  end
end
