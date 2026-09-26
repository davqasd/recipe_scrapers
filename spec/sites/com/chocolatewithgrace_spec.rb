# frozen_string_literal: true

RSpec.describe "chocolatewithgrace.com" do
  subject(:recipe) { scrape_cassette("com/chocolatewithgrace", url: "https://chocolatewithgrace.com/peanut-butter-balls-with-rice-krispies/") }

  it "reads the title" do
    expect(recipe.title).to eq("Peanut Butter Balls with Rice Krispies")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup peanut butter (creamy or crunchy)",
      "¼ cup butter (softened)",
      "1 cup powdered sugar",
      "2 cups Rice Krispies cereal (slightly crushed)",
      "2 cups semi-sweet chocolate chips",
      "2 tablespoons vegetable shortening"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "peanut butter" },
      { amount: 0.25, unit: "cup", name: "butter" },
      { amount: 1.0, unit: "cup", name: "powdered sugar" },
      { amount: 2.0, unit: "cups", name: "Rice Krispies cereal" },
      { amount: 2.0, unit: "cups", name: "semi-sweet chocolate chips" },
      { amount: 2.0, unit: "tablespoons", name: "vegetable shortening" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Line cookie sheet with parchment paper or wax paper. In a large bowl, cream together peanut butter, butter, and powdered sugar. Stir in cereal until well combined.",
      "Shape into balls, place on a cookie sheet, and chill for at least 30 minutes. In a large microwave-safe bowl, add chocolate chips and shortening.",
      "Heat for 1 minute and stir, then continue heating for 20-30 seconds and stirring after each interval until chocolate is almost melted. Stir until completely smooth. Dip balls into chocolate and place on a cookie sheet until firm.",
      "Store in an airtight container in the refrigerator for several days or in the freezer for several weeks."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Line cookie sheet with parchment paper or wax paper. In a large bowl, cream together peanut butter, butter, and powdered sugar. Stir in cereal until well combined.\nShape into balls, place on a cookie sheet, and chill for at least 30 minutes. In a large microwave-safe bowl, add chocolate chips and shortening.\nHeat for 1 minute and stir, then continue heating for 20-30 seconds and stirring after each interval until chocolate is almost melted. Stir until completely smooth. Dip balls into chocolate and place on a cookie sheet until firm.\nStore in an airtight container in the refrigerator for several days or in the freezer for several weeks.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("chocolatewithgrace.com")
    expect(recipe.canonical_url).to eq("https://chocolatewithgrace.com/peanut-butter-balls-with-rice-krispies/")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Mary Younkin")
    expect(recipe.description).to eq("Classic Chocolate Peanut Butter Balls with Rice Krispies for extra texture and crunch. A quick and easy Christmas candy recipe.")
    expect(recipe.image).to eq("https://chocolatewithgrace.com/wp-content/uploads/2019/08/CWG-Rice-Crispy-PB-Balls-6-1-of-1-scaled.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("36 servings")
    expect(recipe.total_time).to eq(180)
    expect(recipe.prep_time).to eq(60)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["peanut butter balls with rice krispies"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.75)
    expect(recipe.ratings_count).to eq(55)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 g",
      "calories" => "124 kcal",
      "carbohydrateContent" => "12 g",
      "proteinContent" => "2 g",
      "fatContent" => "8 g",
      "saturatedFatContent" => "4 g",
      "cholesterolContent" => "4 mg",
      "sodiumContent" => "53 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "9 g",
      "unsaturatedFatContent" => "4 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "g", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 124.0 },
      { name: "carbohydrateContent", unit: "g", amount: 12.0 },
      { name: "proteinContent", unit: "g", amount: 2.0 },
      { name: "fatContent", unit: "g", amount: 8.0 },
      { name: "saturatedFatContent", unit: "g", amount: 4.0 },
      { name: "cholesterolContent", unit: "mg", amount: 4.0 },
      { name: "sodiumContent", unit: "mg", amount: 53.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 9.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 4.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
