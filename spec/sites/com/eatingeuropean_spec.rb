# frozen_string_literal: true

RSpec.describe "eatingeuropean.com" do
  subject(:recipe) { scrape_cassette("com/eatingeuropean", url: "https://eatingeuropean.com/german-potato-pancakes-kartoffelpuffer/") }

  it "reads the title" do
    expect(recipe.title).to eq("German Potato Pancakes")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2½ lbs starchy potatoes (peeled and finely grated (see instructions))",
      "1 small yellow onion (very finely grated or processed)",
      "2 large eggs",
      "¼ cup all-purpose flour",
      "1 tsp sea salt",
      "6 tbsp neutral-tasting oil (avocado oil or light olive oil) (for frying)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.5, unit: "lbs", name: "starchy potatoes" },
      { amount: 1.0, unit: nil, name: "small yellow onion" },
      { amount: 2.0, unit: nil, name: "large eggs" },
      { amount: 0.25, unit: "cup", name: "all-purpose flour" },
      { amount: 1.0, unit: "tsp", name: "sea salt" },
      { amount: 6.0, unit: "tbsp", name: "neutral-tasting oil" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Grate the potatoes using two different-sized graters: grate half of the potatoes on a large whole grater and the other half on a small one. You want the texture to be different so the pancakes can be soft but also have crispy edges. You can use a food processor with a large and small holes shredding disk attachment.",
      "Place the grated potatoes in a colander over a bowl and let them sit for 10 minutes.",
      "After 10 minutes, carefully discard the liquid, making sure that you save the starch at the bottom of the bowl. Add the potatoes to the bowl.",
      "Either very finely chop or shred the onion, or use a small food processor to achieve a fine consistency. Add the onions to the potatoes.",
      "Add eggs, flour, and salt to the potato and onion mixture and mix well.",
      "Heat a few tablespoons of oil in a non-stick pan over medium-high heat and place 1/4 to 1/3 cup of the mixture in the hot pan and flatten into pancakes with the back of a spoon. Fry on both sides for about 3 minutes until the potatoes are golden and crispy on the edges.",
      "You can place them on a paper towel to remove excess fat. Serve with sour cream, apple sauce, sugar, or for the savory version with goulash or beef stew."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Grate the potatoes using two different-sized graters: grate half of the potatoes on a large whole grater and the other half on a small one. You want the texture to be different so the pancakes can be soft but also have crispy edges. You can use a food processor with a large and small holes shredding disk attachment.\nPlace the grated potatoes in a colander over a bowl and let them sit for 10 minutes.\nAfter 10 minutes, carefully discard the liquid, making sure that you save the starch at the bottom of the bowl. Add the potatoes to the bowl.\nEither very finely chop or shred the onion, or use a small food processor to achieve a fine consistency. Add the onions to the potatoes.\nAdd eggs, flour, and salt to the potato and onion mixture and mix well.\nHeat a few tablespoons of oil in a non-stick pan over medium-high heat and place 1/4 to 1/3 cup of the mixture in the hot pan and flatten into pancakes with the back of a spoon. Fry on both sides for about 3 minutes until the potatoes are golden and crispy on the edges.\nYou can place them on a paper towel to remove excess fat. Serve with sour cream, apple sauce, sugar, or for the savory version with goulash or beef stew.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("eatingeuropean.com")
    expect(recipe.canonical_url).to eq("https://eatingeuropean.com/german-potato-pancakes-kartoffelpuffer/")
    expect(recipe.site_name).to eq("Eating European")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Edyta")
    expect(recipe.description).to eq("Crispy on the outside and soft in the middle, German potato pancakes (also known as Kartoffelpuffer) are a much-loved dish across Germany and most of Central Europe. Made with simple ingredients like grated potatoes, onions, eggs, and flour, this comforting German potato pancake recipe is equally at home as a savory side dish or a sweet treat with applesauce and sugar.")
    expect(recipe.image).to eq("https://eatingeuropean.com/wp-content/uploads/2025/09/Potato-Pancaked-1.jpg")
    expect(recipe.category).to eq("Side Dish")
    expect(recipe.cuisine).to eq("German")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq(["german potato pancakes", "Kartoffelpuffer"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "320 kcal",
      "carbohydrateContent" => "40 g",
      "proteinContent" => "7 g",
      "fatContent" => "16 g",
      "saturatedFatContent" => "2 g",
      "transFatContent" => "0.1 g",
      "cholesterolContent" => "55 mg",
      "sodiumContent" => "419 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "2 g",
      "unsaturatedFatContent" => "13 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 320.0 },
      { name: "carbohydrateContent", unit: "g", amount: 40.0 },
      { name: "proteinContent", unit: "g", amount: 7.0 },
      { name: "fatContent", unit: "g", amount: 16.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "transFatContent", unit: "g", amount: 0.1 },
      { name: "cholesterolContent", unit: "mg", amount: 55.0 },
      { name: "sodiumContent", unit: "mg", amount: 419.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 13.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
