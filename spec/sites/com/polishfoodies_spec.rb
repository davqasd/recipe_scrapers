# frozen_string_literal: true

RSpec.describe "polishfoodies.com" do
  subject(:recipe) { scrape_cassette("com/polishfoodies", url: "https://polishfoodies.com/polish-sweet-cheese-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Polish Sweet Cheese Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups of cottage/ farmer cheese",
      "2 tbsps of butter",
      "1/2 cup of sugar, xylitol or any other sweetener",
      "2 egg yolks (optional)",
      "1/2 teaspoon of vanilla extract (optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "cottage/ farmer cheese" },
      { amount: 2.0, unit: "tbsps", name: "butter" },
      { amount: 0.5, unit: "cup", name: "sugar, xylitol or any other sweetener" },
      { amount: 2.0, unit: nil, name: "egg yolks" },
      { amount: 0.5, unit: "teaspoon", name: "vanilla extract" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Mix all the ingredients together using a food processor or blender until you will get a smooth and creamy consistency. (Refer to Polish Foodies for Karolina's authentic sensory cues, exact ratios, and step-by-step video guide.)"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Mix all the ingredients together using a food processor or blender until you will get a smooth and creamy consistency. (Refer to Polish Foodies for Karolina's authentic sensory cues, exact ratios, and step-by-step video guide.)")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("polishfoodies.com")
    expect(recipe.canonical_url).to eq("https://polishfoodies.com/polish-sweet-cheese-recipe/")
    expect(recipe.site_name).to eq("Polish Foodies")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Karolina Klesta")
    expect(recipe.description).to eq("Stop settling for store-bought versions. My foolproof, 5-minute recipe gives you the authentic taste of Polish sweet cheese just like Babcia used to make.")
    expect(recipe.image).to eq("https://polishfoodies.com/wp-content/uploads/2020/09/polish-sweer-cheese_3-720x720.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("Polish")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(5)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Sweet Cheese Recipe", "Cheese Recipe"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["GlutenFreeDiet"])
    expect(recipe.ratings).to eq(4.4)
    expect(recipe.ratings_count).to eq(8)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "182 calories",
      "carbohydrateContent" => "14 grams carbohydrates",
      "cholesterolContent" => "75 milligrams cholesterol",
      "fatContent" => "11 grams fat",
      "fiberContent" => "0 grams fiber",
      "proteinContent" => "6 grams protein",
      "saturatedFatContent" => "6 grams saturated fat",
      "servingSize" => "1",
      "sodiumContent" => "254 milligrams sodium",
      "sugarContent" => "13 grams sugar",
      "transFatContent" => "0 grams trans fat",
      "unsaturatedFatContent" => "4 grams unsaturated fat"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 182.0 },
      { name: "carbohydrateContent", unit: "g", amount: 14.0 },
      { name: "cholesterolContent", unit: "mg", amount: 75.0 },
      { name: "fatContent", unit: "g", amount: 11.0 },
      { name: "fiberContent", unit: "g", amount: 0.0 },
      { name: "proteinContent", unit: "g", amount: 6.0 },
      { name: "saturatedFatContent", unit: "g", amount: 6.0 },
      { name: "servingSize", unit: nil, amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 254.0 },
      { name: "sugarContent", unit: "g", amount: 13.0 },
      { name: "transFatContent", unit: "g", amount: 0.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 4.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
