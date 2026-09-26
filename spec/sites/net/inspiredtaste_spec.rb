# frozen_string_literal: true

RSpec.describe "inspiredtaste.net" do
  subject(:recipe) { scrape_cassette("net/inspiredtaste", url: "https://www.inspiredtaste.net/51500/pressure-cooker-applesauce/") }

  it "reads the title" do
    expect(recipe.title).to eq("Ridiculously Easy Instant Pot Applesauce")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 pounds crisp, sweet apples, 8 large",
      "One 3-inch cinnamon stick or ½ teaspoon ground cinnamon",
      "1 to 2 whole star anise, optional",
      "2 tablespoons fresh lemon juice, fresh orange juice, or apple cider vinegar",
      "1 ½ teaspoons vanilla extract",
      "Brown sugar, honey, maple syrup, or other sweetener to taste, optional"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: "pounds", name: "crisp, sweet apples, 8 large" },
      { amount: 1.0, unit: nil, name: "3-inch cinnamon stick or ½ teaspoon ground cinnamon" },
      { amount: 1.0, unit: nil, name: "whole star anise, optional" },
      { amount: 2.0, unit: "tablespoons", name: "fresh lemon juice, fresh orange juice, or apple cider vinegar" },
      { amount: 1.5, unit: "teaspoons", name: "vanilla extract" },
      { amount: nil, unit: nil, name: "Brown sugar, honey, maple syrup, or other sweetener to taste, optional" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Prepare apples: Peel the apples, remove the cores, and cut them into 1-inch chunks or wedges.",
      "Pressure cook: Add the apples, cinnamon stick, lemon juice, vanilla extract, and star anise to a 6-quart electric pressure cooker (Instant Pot). Pour in ⅓ cup water and stir to combine. Close the lid, select Pressure Cook (or Manual), and cook on high pressure for 5 minutes. The timer will begin once the pot reaches pressure.",
      "Naturally release: When the cooking time ends, let the pressure release naturally for 20 minutes. Then carefully quick-release any remaining pressure, keeping your hands and face away from the steam.",
      "Mash: Mash the apples to your preferred consistency, they’ll be soft enough for a spoon or potato masher. Taste and add sweetener if needed, starting with a teaspoon. The applesauce will thicken as it cools. If it seems thin, use the Sauté function to simmer briefly until slightly reduced."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Prepare apples: Peel the apples, remove the cores, and cut them into 1-inch chunks or wedges.\nPressure cook: Add the apples, cinnamon stick, lemon juice, vanilla extract, and star anise to a 6-quart electric pressure cooker (Instant Pot). Pour in ⅓ cup water and stir to combine. Close the lid, select Pressure Cook (or Manual), and cook on high pressure for 5 minutes. The timer will begin once the pot reaches pressure.\nNaturally release: When the cooking time ends, let the pressure release naturally for 20 minutes. Then carefully quick-release any remaining pressure, keeping your hands and face away from the steam.\nMash: Mash the apples to your preferred consistency, they’ll be soft enough for a spoon or potato masher. Taste and add sweetener if needed, starting with a teaspoon. The applesauce will thicken as it cools. If it seems thin, use the Sauté function to simmer briefly until slightly reduced.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("inspiredtaste.net")
    expect(recipe.canonical_url).to eq("https://www.inspiredtaste.net/51500/pressure-cooker-applesauce/")
    expect(recipe.site_name).to eq("Inspired Taste - Easy Recipes for Home Cooks")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Joanne Gallagher")
    expect(recipe.description).to eq("Instant Pot applesauce is incredibly simple to make, makes your kitchen smell incredible, and tastes far better than store-bought. Add sweetener only if needed after cooking. Brown sugar, maple syrup, or honey all work well. You can peel the apples for ease or leave the skins on. If you keep them, press the cooked apples through a food mill or fine mesh strainer for a smooth texture. **Cooking takes 5 minutes under pressure, but remember to allow time for the pot to come to pressure and release afterward.")
    expect(recipe.image).to eq("https://www.inspiredtaste.net/wp-content/uploads/2021/10/Instant-Pot-Applesauce-Recipe-4-1200.jpg")
    expect(recipe.category).to eq("Dessert, Sauce")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 items")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to eq(["instant pot applesauce", "pressure cooker applesauce"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "¼ cup",
      "calories" => "60",
      "fatContent" => "0.2g",
      "saturatedFatContent" => "0g",
      "cholesterolContent" => "0mg",
      "sodiumContent" => "1.3mg",
      "carbohydrateContent" => "15.5g",
      "fiberContent" => "2.7g",
      "sugarContent" => "11.6g",
      "proteinContent" => "0.3g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "cup", amount: 0.25 },
      { name: "calories", unit: nil, amount: 60.0 },
      { name: "fatContent", unit: "g", amount: 0.2 },
      { name: "saturatedFatContent", unit: "g", amount: 0.0 },
      { name: "cholesterolContent", unit: "mg", amount: 0.0 },
      { name: "sodiumContent", unit: "mg", amount: 1.3 },
      { name: "carbohydrateContent", unit: "g", amount: 15.5 },
      { name: "fiberContent", unit: "g", amount: 2.7 },
      { name: "sugarContent", unit: "g", amount: 11.6 },
      { name: "proteinContent", unit: "g", amount: 0.3 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://inspired-taste.kit.com/62875e8c82")
  end
end
