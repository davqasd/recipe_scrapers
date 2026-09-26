# frozen_string_literal: true

RSpec.describe "barefootinthepines.com" do
  subject(:recipe) { scrape_cassette("com/barefootinthepines", url: "https://barefootinthepines.com/brussel-sprouts-with-bacon/") }

  it "reads the title" do
    expect(recipe.title).to eq("Maple Brussels Sprouts With Bacon")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 slices thick-cut bacon (diced)",
      "1 tablespoons olive oil",
      "1 lb fresh Brussels sprouts (trimmed, outer leaves removed, and halved)",
      "1/2 teaspoon coarse Kosher Salt",
      "1/4 teaspoon pepper",
      "2 tablespoons pure maple syrup (not pancake syrup)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "slices", name: "thick-cut bacon" },
      { amount: 1.0, unit: "tablespoons", name: "olive oil" },
      { amount: 1.0, unit: "lb", name: "fresh Brussels sprouts" },
      { amount: 0.5, unit: "teaspoon", name: "coarse Kosher Salt" },
      { amount: 0.25, unit: "teaspoon", name: "pepper" },
      { amount: 2.0, unit: "tablespoons", name: "pure maple syrup" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large skillet, cook the diced bacon over medium heat until crispy, about 5-7 minutes. Remove the bacon with a slotted spoon and drain on a plate lined with paper towels. Leave the bacon grease in the pan.",
      "Add 1 tablespoon of olive oil to the skillet with the bacon grease and heat over medium heat. Place the the halved Brussels sprouts cut-side down in the pan. Do your best to make a single layer. Push overlapping sprouts out to the side of the pan.",
      "Cook for 5 -7 minutes until the sprouts start to develop a golden-brown sear.",
      "Season with salt and pepper. Move the golden brown sprouts to the outer edges of the pan and flip to brown on the other side. Shift the paler sprouts (cut side down) to the center of the pan to brown. Continue cooking for another 5 minutes. Hint: Add 1 tablespoon of oil if the pan looks dry.",
      "Continue flipping and cooking the remaining Brussels sprouts for another 2-5 minutes until all the sprouts are tender, but still green and covered in crispy brown spots.",
      "Once the sprouts are tender, remove the pan from the heat. Drizzle the maple syrup over the Brussels sprouts and toss to coat in the maple glaze.",
      "Transfer the maple-glazed Brussel sprouts to a serving dish and top with crispy bacon. Serve warm."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large skillet, cook the diced bacon over medium heat until crispy, about 5-7 minutes. Remove the bacon with a slotted spoon and drain on a plate lined with paper towels. Leave the bacon grease in the pan.\nAdd 1 tablespoon of olive oil to the skillet with the bacon grease and heat over medium heat. Place the the halved Brussels sprouts cut-side down in the pan. Do your best to make a single layer. Push overlapping sprouts out to the side of the pan.\nCook for 5 -7 minutes until the sprouts start to develop a golden-brown sear.\nSeason with salt and pepper. Move the golden brown sprouts to the outer edges of the pan and flip to brown on the other side. Shift the paler sprouts (cut side down) to the center of the pan to brown. Continue cooking for another 5 minutes. Hint: Add 1 tablespoon of oil if the pan looks dry.\nContinue flipping and cooking the remaining Brussels sprouts for another 2-5 minutes until all the sprouts are tender, but still green and covered in crispy brown spots.\nOnce the sprouts are tender, remove the pan from the heat. Drizzle the maple syrup over the Brussels sprouts and toss to coat in the maple glaze.\nTransfer the maple-glazed Brussel sprouts to a serving dish and top with crispy bacon. Serve warm.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("barefootinthepines.com")
    expect(recipe.canonical_url).to eq("https://barefootinthepines.com/brussel-sprouts-with-bacon/")
    expect(recipe.site_name).to eq("Barefoot In The Pines")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Michelle")
    expect(recipe.description).to eq("A delicious recipe for pan fried brussels sprouts with bacon. Fresh brussels sprouts are seared until golden brown and tender and topped with maple syrup and crispy bacon.")
    expect(recipe.image).to eq("https://barefootinthepines.com/wp-content/uploads/2024/09/Maple-Bacon-Brussels-Sprouts-4.jpg")
    expect(recipe.category).to eq("Thanksgiving Recipes")
    expect(recipe.cuisine).to eq("Side Dishes")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq([
      "Brussel Sprouts With Bacon",
      "Brussels Sprouts With Bacon and Maple Syrup",
      "Maple Brussels Sprouts With Bacon"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 Serving",
      "calories" => "139 kcal",
      "sugarContent" => "8 g",
      "sodiumContent" => "334 mg",
      "fatContent" => "7 g",
      "saturatedFatContent" => "2 g",
      "carbohydrateContent" => "15 g",
      "fiberContent" => "3 g",
      "proteinContent" => "6 g",
      "cholesterolContent" => "9 mg",
      "unsaturatedFatContent" => "5 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "Serving", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 139.0 },
      { name: "sugarContent", unit: "g", amount: 8.0 },
      { name: "sodiumContent", unit: "mg", amount: 334.0 },
      { name: "fatContent", unit: "g", amount: 7.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "carbohydrateContent", unit: "g", amount: 15.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "proteinContent", unit: "g", amount: 6.0 },
      { name: "cholesterolContent", unit: "mg", amount: 9.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 5.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
