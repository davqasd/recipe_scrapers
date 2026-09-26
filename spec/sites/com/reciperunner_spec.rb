# frozen_string_literal: true

RSpec.describe "reciperunner.com" do
  subject(:recipe) { scrape_cassette("com/reciperunner", url: "https://reciperunner.com/cranberry-orange-curd/") }

  it "reads the title" do
    expect(recipe.title).to eq("Cranberry Orange Curd")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "12 ounces fresh or frozen cranberries",
      "Zest and juice of a large orange",
      "Enough water to equal 3/4 cup after orange juice added",
      "1/2 cup granulated sugar",
      "1/4 cup dark brown sugar",
      "1/2 teaspoon ground cinnamon",
      "1/8 teaspoon salt",
      "1 egg",
      "2 egg yolks",
      "2 tablespoons unsalted butter (room temperature)",
      "1 teaspoon vanilla extract or vanilla bean paste"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 12.0, unit: "ounces", name: "fresh or frozen cranberries" },
      { amount: nil, unit: nil, name: "Zest and juice of a large orange" },
      { amount: nil, unit: nil, name: "Enough water to equal 3/4 cup after orange juice added" },
      { amount: 0.5, unit: "cup", name: "granulated sugar" },
      { amount: 0.25, unit: "cup", name: "dark brown sugar" },
      { amount: 0.5, unit: "teaspoon", name: "ground cinnamon" },
      { amount: 0.13, unit: "teaspoon", name: "salt" },
      { amount: 1.0, unit: nil, name: "egg" },
      { amount: 2.0, unit: nil, name: "egg yolks" },
      { amount: 2.0, unit: "tablespoons", name: "unsalted butter" },
      { amount: 1.0, unit: "teaspoon", name: "vanilla extract or vanilla bean paste" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Add the cranberries, orange zest and juice, water, granulated and brown sugar, salt, and cinnamon to a saucepan. Bring the mixture to a boil and then reduce the heat and let it simmer for about 8 minutes or until the cranberries pop and are soft.",
      "Pour the cranberry sauce into a food processor or blender and blend it until it’s smooth. Reserve a 1/2 cup of the sauce and add the remaining to a saucepan over medium-low heat.",
      "In a small bowl whisk egg and egg yolks. Slowly pour in the reserved 1/2 cup of cranberry sauce in with the eggs whisking the entire time.",
      "Pour the cranberry egg mixture into the saucepan whisking it the entire time. Continue to whisk the cranberry orange curd until it thickens enough to coat the back of a spoon, about 3-5 minutes.",
      "Turn off the heat and remove the saucepan. Whisk in the butter and vanilla until the butter is melted and incorporated. Strain the curd into a sterile jar or jars and screw on the lid. Store the curd in the refrigerator for up to a week."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Add the cranberries, orange zest and juice, water, granulated and brown sugar, salt, and cinnamon to a saucepan. Bring the mixture to a boil and then reduce the heat and let it simmer for about 8 minutes or until the cranberries pop and are soft.\nPour the cranberry sauce into a food processor or blender and blend it until it’s smooth. Reserve a 1/2 cup of the sauce and add the remaining to a saucepan over medium-low heat.\nIn a small bowl whisk egg and egg yolks. Slowly pour in the reserved 1/2 cup of cranberry sauce in with the eggs whisking the entire time.\nPour the cranberry egg mixture into the saucepan whisking it the entire time. Continue to whisk the cranberry orange curd until it thickens enough to coat the back of a spoon, about 3-5 minutes.\nTurn off the heat and remove the saucepan. Whisk in the butter and vanilla until the butter is melted and incorporated. Strain the curd into a sterile jar or jars and screw on the lid. Store the curd in the refrigerator for up to a week.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("reciperunner.com")
    expect(recipe.canonical_url).to eq("https://reciperunner.com/cranberry-orange-curd/")
    expect(recipe.site_name).to eq("Recipe Runner")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Danae Halliday")
    expect(recipe.description).to eq("Cranberry orange curd is perfect for the holidays! It's easy to make and a delicious topping for pancakes, swirled into yogurt or oatmeal, or you can use even use it as a filling for a tart!")
    expect(recipe.image).to eq("https://reciperunner.com/wp-content/uploads/2013/11/cranberry-orange-curd-picture.jpg")
    expect(recipe.category).to eq("Desserts")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(80)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(%w[cranberry curd orange])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "2 tablespoons",
      "calories" => "74 kcal",
      "carbohydrateContent" => "13 g",
      "proteinContent" => "1 g",
      "fatContent" => "2 g",
      "saturatedFatContent" => "1 g",
      "cholesterolContent" => "39 mg",
      "sodiumContent" => "23 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "11 g",
      "unsaturatedFatContent" => "1 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "tablespoons", amount: 2.0 },
      { name: "calories", unit: "kcal", amount: 74.0 },
      { name: "carbohydrateContent", unit: "g", amount: 13.0 },
      { name: "proteinContent", unit: "g", amount: 1.0 },
      { name: "fatContent", unit: "g", amount: 2.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 39.0 },
      { name: "sodiumContent", unit: "mg", amount: 23.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 11.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
