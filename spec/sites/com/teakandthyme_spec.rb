# frozen_string_literal: true

RSpec.describe "teakandthyme.com" do
  subject(:recipe) { scrape_cassette("com/teakandthyme", url: "https://teakandthyme.com/matcha-ice-cream/") }

  it "reads the title" do
    expect(recipe.title).to eq("Matcha Ice Cream")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "600 mL whipping cream",
      "4 tablespoons matcha powder (culinary grade)",
      "1 tablespoon vanilla extract",
      "300 mL sweetened condensed milk (one can)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 600.0, unit: "mL", name: "whipping cream" },
      { amount: 4.0, unit: "tablespoons", name: "matcha powder" },
      { amount: 1.0, unit: "tablespoon", name: "vanilla extract" },
      { amount: 300.0, unit: "mL", name: "sweetened condensed milk" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large mixing bowl, add the whipping cream, matcha powder, and vanilla extract. Use an electric mixer fitted with a whisk attachment to whip the mixture until it becomes firm peaks.",
      "With hand, drizzle the condensed milk into the whipped cream while folding it in with a silicone spatula with your other hand. Fold until combined and no streaks of condensed milk remain.",
      "Pour the mixture into a loaf tin or any container of your choice. Cover with plastic wrap and freeze for at least 6 hours or preferably overnight.",
      "When serving, run an ice cream scooper until hot water and wipe dry before scooping. Immediately return the rest of the ice cream to the freezer. Serve as is or top with dango mochi."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large mixing bowl, add the whipping cream, matcha powder, and vanilla extract. Use an electric mixer fitted with a whisk attachment to whip the mixture until it becomes firm peaks.\nWith hand, drizzle the condensed milk into the whipped cream while folding it in with a silicone spatula with your other hand. Fold until combined and no streaks of condensed milk remain.\nPour the mixture into a loaf tin or any container of your choice. Cover with plastic wrap and freeze for at least 6 hours or preferably overnight.\nWhen serving, run an ice cream scooper until hot water and wipe dry before scooping. Immediately return the rest of the ice cream to the freezer. Serve as is or top with dango mochi.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("teakandthyme.com")
    expect(recipe.canonical_url).to eq("https://teakandthyme.com/matcha-ice-cream/")
    expect(recipe.site_name).to eq("Teak & Thyme")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Gail Ng")
    expect(recipe.description).to eq("No-churn matcha ice cream that’s creamy and full of matcha green tea flavour. It’s made with only 4 ingredients and no ice cream maker needed.")
    expect(recipe.image).to eq("https://teakandthyme.com/wp-content/uploads/2022/07/matcha-ice-cream-DSC_5061-1x1-1600.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("Japanese")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("1 servings")
    expect(recipe.total_time).to eq(380)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["matcha", "matcha ice cream"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(48)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "3515 kcal",
      "carbohydrateContent" => "230 g",
      "proteinContent" => "78 g",
      "fatContent" => "252 g",
      "saturatedFatContent" => "160 g",
      "cholesterolContent" => "814 mg",
      "sodiumContent" => "657 mg",
      "sugarContent" => "230 g",
      "unsaturatedFatContent" => "75 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 3515.0 },
      { name: "carbohydrateContent", unit: "g", amount: 230.0 },
      { name: "proteinContent", unit: "g", amount: 78.0 },
      { name: "fatContent", unit: "g", amount: 252.0 },
      { name: "saturatedFatContent", unit: "g", amount: 160.0 },
      { name: "cholesterolContent", unit: "mg", amount: 814.0 },
      { name: "sodiumContent", unit: "mg", amount: 657.0 },
      { name: "sugarContent", unit: "g", amount: 230.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 75.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://teakandthyme.com/")
  end
end
