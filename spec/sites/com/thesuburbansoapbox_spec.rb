# frozen_string_literal: true

RSpec.describe "thesuburbansoapbox.com" do
  subject(:recipe) { scrape_cassette("com/thesuburbansoapbox", url: "https://thesuburbansoapbox.com/easy-strawberry-trifle/") }

  it "reads the title" do
    expect(recipe.title).to eq("Strawberry Trifle Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "5.1 ounce package instant vanilla pudding mix",
      "3 cups cold milk",
      "9 inch pound cake (cut into bite size cubes)",
      "2 pounds fresh strawberries (sliced)",
      "12 ounce container frozen whipped topping (thawed)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 5.1, unit: "ounce", name: "package instant vanilla pudding mix" },
      { amount: 3.0, unit: "cups", name: "cold milk" },
      { amount: 9.0, unit: "inch", name: "pound cake" },
      { amount: 2.0, unit: "pounds", name: "fresh strawberries" },
      { amount: 12.0, unit: "ounce", name: "container frozen whipped topping" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Place pudding mix into a bowl. Add cold milk and whisk together for 2 minutes. Set aside and rest for 5 minutes.",
      "Layer ½ of the pound cake in the bottom of a trifle bowl or other glass serving dish. Layer ½ of the pudding, ½ of the strawberries, and ½ of the whipped topping on top. Repeat with the layers with the remaining ingredients.",
      "Cover the trifle with plastic wrap and chill in the refrigerator for at least 4 hours or overnight before serving.",
      "Garnish with fresh berries and mint, serve chilled dusted with powdered sugar, if desired."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Place pudding mix into a bowl. Add cold milk and whisk together for 2 minutes. Set aside and rest for 5 minutes.\nLayer ½ of the pound cake in the bottom of a trifle bowl or other glass serving dish. Layer ½ of the pudding, ½ of the strawberries, and ½ of the whipped topping on top. Repeat with the layers with the remaining ingredients.\nCover the trifle with plastic wrap and chill in the refrigerator for at least 4 hours or overnight before serving.\nGarnish with fresh berries and mint, serve chilled dusted with powdered sugar, if desired.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thesuburbansoapbox.com")
    expect(recipe.canonical_url).to eq("https://thesuburbansoapbox.com/easy-strawberry-trifle/")
    expect(recipe.site_name).to eq("The Suburban Soapbox")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Kellie")
    expect(recipe.description).to eq("This no-bake Strawberry Trifle is a stunning and simple dessert layered with fluffy pound cake, creamy vanilla pudding, fresh strawberries, and whipped topping. Ready in minutes and perfect for summer entertaining,")
    expect(recipe.image).to eq("https://thesuburbansoapbox.com/wp-content/uploads/2025/06/Strawberry-Trifle-2-scaled.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(270)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(240)
    expect(recipe.keywords).to eq(["no bake trifle", "strawberry trifle"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "280 kcal",
      "carbohydrateContent" => "50 g",
      "proteinContent" => "5 g",
      "fatContent" => "7 g",
      "saturatedFatContent" => "5 g",
      "cholesterolContent" => "46 mg",
      "sodiumContent" => "356 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "37 g",
      "unsaturatedFatContent" => "1.4 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 280.0 },
      { name: "carbohydrateContent", unit: "g", amount: 50.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "fatContent", unit: "g", amount: 7.0 },
      { name: "saturatedFatContent", unit: "g", amount: 5.0 },
      { name: "cholesterolContent", unit: "mg", amount: 46.0 },
      { name: "sodiumContent", unit: "mg", amount: 356.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 37.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 1.4 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
