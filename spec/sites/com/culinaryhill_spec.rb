# frozen_string_literal: true

RSpec.describe "culinaryhill.com" do
  subject(:recipe) { scrape_cassette("com/culinaryhill", url: "https://www.culinaryhill.com/eggnog-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Eggnog")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "12 eggs (separated (see note 1))",
      "2 cups granulated sugar (or less to taste)",
      "4 cups whole milk",
      "2 cups heavy cream",
      "2 cups bourbon (or whiskey, for serving, optional)",
      "ground nutmeg (for serving (see note 3))"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 12.0, unit: nil, name: "eggs" },
      { amount: 2.0, unit: "cups", name: "granulated sugar" },
      { amount: 4.0, unit: "cups", name: "whole milk" },
      { amount: 2.0, unit: "cups", name: "heavy cream" },
      { amount: 2.0, unit: "cups", name: "bourbon" },
      { amount: nil, unit: nil, name: "ground nutmeg" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Refrigerate egg whites until needed. In a stand mixer fit with the paddle attachment, or with an electric mixer or whisk and a medium bowl, add yolks and sugar. Mix on medium-speed until the mixture is smooth, creamy, and has a pale yellow color.",
      "Add milk, cream, and liquor and continue mixing until evenly combined. Cover and chill for at least one hour.",
      "In a stand mixer fit with the whisk attachment, or with an electric mixer at high speed, whisk egg whites until stiff peaks form. Gently fold into chilled eggnog mixture (some egg whites will float like foam to the top).",
      "To serve, transfer to a pitcher or punch bowl and garnish with freshly grated nutmeg."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Refrigerate egg whites until needed. In a stand mixer fit with the paddle attachment, or with an electric mixer or whisk and a medium bowl, add yolks and sugar. Mix on medium-speed until the mixture is smooth, creamy, and has a pale yellow color.\nAdd milk, cream, and liquor and continue mixing until evenly combined. Cover and chill for at least one hour.\nIn a stand mixer fit with the whisk attachment, or with an electric mixer at high speed, whisk egg whites until stiff peaks form. Gently fold into chilled eggnog mixture (some egg whites will float like foam to the top).\nTo serve, transfer to a pitcher or punch bowl and garnish with freshly grated nutmeg.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("culinaryhill.com")
    expect(recipe.canonical_url).to eq("https://www.culinaryhill.com/eggnog-recipe/")
    expect(recipe.site_name).to eq("Culinary Hill")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Meggan Hill")
    expect(recipe.description).to eq("Homemade Eggnog is the ultimate holiday cocktail. This easy holiday drink recipe is going to become your new holiday party tradition. So much better than store-bought eggnog!")
    expect(recipe.image).to eq("https://www.culinaryhill.com/wp-content/uploads/2021/12/Eggnog-1200x800-Culinary-Hill.jpg")
    expect(recipe.category).to eq("Drinks")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(75)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(%w[christmas eggnog])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "487 kcal",
      "carbohydrateContent" => "43 g",
      "proteinContent" => "10 g",
      "fatContent" => "22 g",
      "saturatedFatContent" => "12 g",
      "cholesterolContent" => "248 mg",
      "sodiumContent" => "125 mg",
      "sugarContent" => "42 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 487.0 },
      { name: "carbohydrateContent", unit: "g", amount: 43.0 },
      { name: "proteinContent", unit: "g", amount: 10.0 },
      { name: "fatContent", unit: "g", amount: 22.0 },
      { name: "saturatedFatContent", unit: "g", amount: 12.0 },
      { name: "cholesterolContent", unit: "mg", amount: 248.0 },
      { name: "sodiumContent", unit: "mg", amount: 125.0 },
      { name: "sugarContent", unit: "g", amount: 42.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
