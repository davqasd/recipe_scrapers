# frozen_string_literal: true

RSpec.describe "fantabulosity.com" do
  subject(:recipe) { scrape_cassette("com/fantabulosity", url: "https://fantabulosity.com/nutella-cheesecake-no-bake-filling-baked-brownie-crust/") }

  it "reads the title" do
    expect(recipe.title).to eq("Oreo Nutella Cheesecake")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups crushed Oreos",
      "¼ cup salted butter (melted)",
      "16 ounces cream cheese (2 - 8 oz. boxes)",
      "¾ cup granulated sugar",
      "½ cup heavy whipping cream",
      "1 teaspoon vanilla extract",
      "½ cup Nutella"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "crushed Oreos" },
      { amount: 0.25, unit: "cup", name: "salted butter" },
      { amount: 16.0, unit: "ounces", name: "cream cheese" },
      { amount: 0.75, unit: "cup", name: "granulated sugar" },
      { amount: 0.5, unit: "cup", name: "heavy whipping cream" },
      { amount: 1.0, unit: "teaspoon", name: "vanilla extract" },
      { amount: 0.5, unit: "cup", name: "Nutella" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Use a fork to stir together the crushed Oreos and the melted butter in a medium sized bowl. Once the ingredients form a wet, sandy mixture, press the mixture into a standard 9-inch springform pan.",
      "In a separate medium sized bowl, use an electric hand mixer to whip the cream cheese until it is smooth and creamy.",
      "Add the granulated sugar, heavy cream, and vanilla extract. Use the electric hand mixer to incorporate the added ingredients to the cream cheese until the mixture is homogenous.",
      "Whisk in the Nutella until no clumps of Nutella remain in the cream cheese mixture.",
      "Pour the cream cheese mixture into the springform pan and cover with plastic wrap. Allow the cheesecake to sit in the freezer for at least 5 hours. (Some freezers may require longer, and it may even be safe to freeze it for 24 hours, to guarantee it will set.",
      "Slice and enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Use a fork to stir together the crushed Oreos and the melted butter in a medium sized bowl. Once the ingredients form a wet, sandy mixture, press the mixture into a standard 9-inch springform pan.\nIn a separate medium sized bowl, use an electric hand mixer to whip the cream cheese until it is smooth and creamy.\nAdd the granulated sugar, heavy cream, and vanilla extract. Use the electric hand mixer to incorporate the added ingredients to the cream cheese until the mixture is homogenous.\nWhisk in the Nutella until no clumps of Nutella remain in the cream cheese mixture.\nPour the cream cheese mixture into the springform pan and cover with plastic wrap. Allow the cheesecake to sit in the freezer for at least 5 hours. (Some freezers may require longer, and it may even be safe to freeze it for 24 hours, to guarantee it will set.\nSlice and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("fantabulosity.com")
    expect(recipe.canonical_url).to eq("https://fantabulosity.com/nutella-cheesecake-no-bake-filling-baked-brownie-crust/")
    expect(recipe.site_name).to eq("Fantabulosity")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jessica")
    expect(recipe.description).to eq("Oreo Nutella Cheesecake - This homemade, smooth, Nutella cheesecake filling that's on top of a buttery Oreo crust, is an easy dessert that you can make ahead of time!")
    expect(recipe.image).to eq("https://fantabulosity.com/wp-content/uploads/2018/08/Oreo-Nutella-Cheesecake-22-copy.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(315)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq([
      "easy no bake dessert",
      "no bake cheesecake recipe",
      "no bake nutella cheesecake",
      "nutella cheesecake",
      "nutella cheesecake recipe",
      "nutella recipe",
      "oreo recipe"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(4)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 serving (1/8 recipe)",
      "calories" => "660 kcal",
      "carbohydrateContent" => "62 g",
      "proteinContent" => "7 g",
      "fatContent" => "44 g",
      "saturatedFatContent" => "26 g",
      "cholesterolContent" => "89 mg",
      "sodiumContent" => "391 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "48 g",
      "transFatContent" => "0.3 g",
      "unsaturatedFatContent" => "15 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "serving", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 660.0 },
      { name: "carbohydrateContent", unit: "g", amount: 62.0 },
      { name: "proteinContent", unit: "g", amount: 7.0 },
      { name: "fatContent", unit: "g", amount: 44.0 },
      { name: "saturatedFatContent", unit: "g", amount: 26.0 },
      { name: "cholesterolContent", unit: "mg", amount: 89.0 },
      { name: "sodiumContent", unit: "mg", amount: 391.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 48.0 },
      { name: "transFatContent", unit: "g", amount: 0.3 },
      { name: "unsaturatedFatContent", unit: "g", amount: 15.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
