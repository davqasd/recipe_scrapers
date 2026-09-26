# frozen_string_literal: true

RSpec.describe "thecookierookie.com" do
  subject(:recipe) { scrape_cassette("com/thecookierookie", url: "https://www.thecookierookie.com/brown-sugar-glazed-ham/") }

  it "reads the title" do
    expect(recipe.title).to eq("Brown Sugar Glazed Ham Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "14-16 lb. bone-in ham",
      "3 cups water",
      "1 cup brown sugar",
      "½ cup honey",
      "⅓ cup Dijon mustard",
      "¼ cup unsalted butter (½ stick)",
      "¼ cup apple cider vinegar",
      "3 cloves garlic (minced)",
      "¼ tsp ground cinnamon",
      "¼ tsp ground ginger"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 14.0, unit: "lb", name: "bone-in ham" },
      { amount: 3.0, unit: "cups", name: "water" },
      { amount: 1.0, unit: "cup", name: "brown sugar" },
      { amount: 0.5, unit: "cup", name: "honey" },
      { amount: 0.33, unit: "cup", name: "Dijon mustard" },
      { amount: 0.25, unit: "cup", name: "unsalted butter" },
      { amount: 0.25, unit: "cup", name: "apple cider vinegar" },
      { amount: 3.0, unit: "cloves", name: "garlic" },
      { amount: 0.25, unit: "tsp", name: "ground cinnamon" },
      { amount: 0.25, unit: "tsp", name: "ground ginger" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 325°F.",
      "Score",
      "Place the ham on a cutting board. Score the ham by using a sharp knife to cut parallel lines about ½-inch deep and 1 inch apart across the entire ham. Turn the ham, and then repeat this process, cutting lines across the previous lines to create small diamond shapes.",
      "Cook",
      "Place the ham, flat side down, in a roasting pan. Pour 3 cups of water into the pan. Cover with foil. The ham should cook for about 12 minutes per pound.",
      "Prepare",
      "After 1 hour, prepare the glaze. Add the brown sugar, honey, dijon mustard, butter, apple cider vinegar, garlic, cinnamon, and ginger to a saucepan over medium heat. Once it starts bubbling, turn down the heat to low and continue cooking for a couple more minutes. The glaze may seem runny at first, but that’s okay. It will thicken up as it sits.",
      "Spread",
      "Remove the ham from the oven and spread ⅓ of the glaze over the ham and return to the oven without the foil. Continue cooking for another hour.",
      "Repeat",
      "Remove the ham from the oven again, and spread another ⅓ of the glaze over the ham. Cook for the remaining time based the weight of your ham.",
      "Remove the ham from the oven and spread the remaining glaze over the ham.",
      "Rest",
      "Let the ham rest for at least 15 minutes before carving."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 325°F.\nScore\nPlace the ham on a cutting board. Score the ham by using a sharp knife to cut parallel lines about ½-inch deep and 1 inch apart across the entire ham. Turn the ham, and then repeat this process, cutting lines across the previous lines to create small diamond shapes.\nCook\nPlace the ham, flat side down, in a roasting pan. Pour 3 cups of water into the pan. Cover with foil. The ham should cook for about 12 minutes per pound.\nPrepare\nAfter 1 hour, prepare the glaze. Add the brown sugar, honey, dijon mustard, butter, apple cider vinegar, garlic, cinnamon, and ginger to a saucepan over medium heat. Once it starts bubbling, turn down the heat to low and continue cooking for a couple more minutes. The glaze may seem runny at first, but that’s okay. It will thicken up as it sits.\nSpread\nRemove the ham from the oven and spread ⅓ of the glaze over the ham and return to the oven without the foil. Continue cooking for another hour.\nRepeat\nRemove the ham from the oven again, and spread another ⅓ of the glaze over the ham. Cook for the remaining time based the weight of your ham.\nRemove the ham from the oven and spread the remaining glaze over the ham.\nRest\nLet the ham rest for at least 15 minutes before carving.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thecookierookie.com")
    expect(recipe.canonical_url).to eq("https://www.thecookierookie.com/brown-sugar-glazed-ham/")
    expect(recipe.site_name).to eq("The Cookie Rookie®")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Becky Hardin")
    expect(recipe.description).to eq("A whole ham, baked and brushed with the sweetest, tangiest glaze, makes this juicy, tender, and delicious ham your family craves for the holidays.")
    expect(recipe.image).to eq("https://www.thecookierookie.com/wp-content/uploads/2022/12/featured-brown-sugar-glazed-ham-recipe.jpg")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("20 servings")
    expect(recipe.total_time).to eq(150)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(150)
    expect(recipe.keywords).to eq([
      "brown sugar glaze for ham",
      "brown sugar glazed ham",
      "brown sugar ham glaze",
      "brown sugar ham glaze recipe",
      "glaze for ham with brown sugar",
      "how to make brown sugar glaze for ham"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.67)
    expect(recipe.ratings_count).to eq(36)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "0.75 pounds",
      "calories" => "565 kcal",
      "carbohydrateContent" => "18 g",
      "proteinContent" => "60 g",
      "fatContent" => "27 g",
      "saturatedFatContent" => "7 g",
      "transFatContent" => "0.1 g",
      "cholesterolContent" => "238 mg",
      "sodiumContent" => "3719 mg",
      "fiberContent" => "0.2 g",
      "sugarContent" => "18 g",
      "unsaturatedFatContent" => "12 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "pounds", amount: 0.75 },
      { name: "calories", unit: "kcal", amount: 565.0 },
      { name: "carbohydrateContent", unit: "g", amount: 18.0 },
      { name: "proteinContent", unit: "g", amount: 60.0 },
      { name: "fatContent", unit: "g", amount: 27.0 },
      { name: "saturatedFatContent", unit: "g", amount: 7.0 },
      { name: "transFatContent", unit: "g", amount: 0.1 },
      { name: "cholesterolContent", unit: "mg", amount: 238.0 },
      { name: "sodiumContent", unit: "mg", amount: 3719.0 },
      { name: "fiberContent", unit: "g", amount: 0.2 },
      { name: "sugarContent", unit: "g", amount: 18.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 12.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
