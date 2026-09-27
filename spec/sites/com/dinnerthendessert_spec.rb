# frozen_string_literal: true

RSpec.describe "dinnerthendessert.com" do
  subject(:recipe) { scrape_cassette("com/dinnerthendessert", url: "https://dinnerthendessert.com/vietnamese-pho-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Vietnamese Pho")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 pounds beef knuckle bones",
      "1 yellow onion (, cut into wedges)",
      "1 tablespoon kosher salt",
      "2 tablespoons fish sauce",
      "16 cups water",
      "3 pods star anise",
      "1 stick cinnamon",
      "3 cloves garlic (, unpeeled if you have it)",
      "6 whole cloves",
      "2 teaspoons fennel seeds",
      "1 teaspoon whole coriander seeds",
      "1 inch ginger (, unpeeled and cut into chunks)",
      "1 cheesecloth (, with kitchen string to tie)",
      "8 ounces rice noodles",
      "6 cups water (, room temperature)",
      "2 pounds sirloin steak (, or tenderloin if you can)",
      "1 cup cilantro (, chopped)",
      "1/4 cup green onion (, thinly sliced)",
      "12 ounces bean sprouts",
      "Sriracha (, to taste)",
      "Hoisin Sauce (, to taste)",
      "lime wedges"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: "pounds", name: "beef knuckle bones" },
      { amount: 1.0, unit: nil, name: "yellow onion" },
      { amount: 1.0, unit: "tablespoon", name: "kosher salt" },
      { amount: 2.0, unit: "tablespoons", name: "fish sauce" },
      { amount: 16.0, unit: "cups", name: "water" },
      { amount: 3.0, unit: nil, name: "pods star anise" },
      { amount: 1.0, unit: "stick", name: "cinnamon" },
      { amount: 3.0, unit: "cloves", name: "garlic" },
      { amount: 6.0, unit: nil, name: "whole cloves" },
      { amount: 2.0, unit: "teaspoons", name: "fennel seeds" },
      { amount: 1.0, unit: "teaspoon", name: "whole coriander seeds" },
      { amount: 1.0, unit: "inch", name: "ginger" },
      { amount: 1.0, unit: nil, name: "cheesecloth" },
      { amount: 8.0, unit: "ounces", name: "rice noodles" },
      { amount: 6.0, unit: "cups", name: "water" },
      { amount: 2.0, unit: "pounds", name: "sirloin steak" },
      { amount: 1.0, unit: "cup", name: "cilantro" },
      { amount: 0.25, unit: "cup", name: "green onion" },
      { amount: 12.0, unit: "ounces", name: "bean sprouts" },
      { amount: nil, unit: nil, name: "Sriracha" },
      { amount: nil, unit: nil, name: "Hoisin Sauce" },
      { amount: nil, unit: nil, name: "lime wedges" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Broth:",
      "Preheat oven to 400 degrees.",
      "Add the soup bones and onion wedges to a baking sheet.",
      "Bake for 1 hour.",
      "Add the bones and onion to a large pot (see below for slow cooker version).",
      "Note: Do not add the fat that is on the baking sheet, the soup does not need additional oil.",
      "Add salt, fish sauce and water, stir well.",
      "Heat",
      "On medium heat bring to a simmer.",
      "Lower the heat to medium-low.",
      "Add",
      "To a cheesecloth add the anise pods, cinnamon, garlic cloves, whole cloves, fennel seeds, coriander seeds and ginger.",
      "Tie the cheesecloth closed with some kitchen string.",
      "Add to the simmering liquid.",
      "Simmer",
      "Stir well, then cover and simmer for a minimum of 8 hours.",
      "Strain the broth through a chinois or a cheesecloth lined strainer.",
      "Refrigerate",
      "Let broth cool then place in refrigerator overnight.",
      "Day of Serving:",
      "Sit",
      "Add rice noodles to a large bowl with the 6 cups of water and let sit for 1 hour.",
      "Note: This water is only to soak the noodles, it does not go in the pot with the broth.",
      "Freeze the beef for 1 hour, then slice it as thinly as possible, giving it a shaved beef thickness and appearance.",
      "Scoop off much of the congealed fat (you can reserve this for cooking in the future as you would with bacon fat).",
      "Note: If you leave too much fat in the soup, it will coat your spoon and mouth with oiliness when you eat it.",
      "Simmer",
      "Bring the broth to a low simmer in a pot on medium heat.",
      "Cook",
      "Add the soaked rice noodles (not the water they soaked in), to the broth and let cook for 1 minute.",
      "Remove the noodles from the pot and place into 4 bowls.",
      "Add the beef to the broth, then immediately remove and place in the bowls.",
      "Note: The beef should be barely cooked, maybe not even all the way cooked in some spots, but the heat of the broth in the bowls will finish the cooking.",
      "Add",
      "To your bowl of noodles and beef and add additional toppings as desired including cilantro, green onions, bean sprouts, sriracha and hoisin sauce.",
      "Top with simmering broth, stir to mix and garnish with additional toppings if desired along with lime wedges for squeezing.",
      "Slow Cooker:",
      "Roast",
      "To make this broth in the slow cooker, roast the bones and onions as directed above.",
      "Add the bones and onions to the slow cooker.",
      "Add salt, fish sauce and water.",
      "Add",
      "To a cheesecloth add the anise pods, cinnamon, garlic cloves, whole cloves, fennel seeds, coriander seeds and ginger.",
      "Tie the cheesecloth closed with some kitchen string.",
      "Heat",
      "Stir well, then cover and cook on high heat for 1 hour.",
      "Cook",
      "Lower the heat to low and cook for 12-24 hours (the longer the better).",
      "Strain the broth through a chinois or a cheesecloth lined strainer.",
      "Cool",
      "Let broth cool then refrigerate.",
      "Continue the recipe from \"Day of Serving\"."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Broth:", 5],
        ["Bouquet Garni:", 8],
        ["Add Ins:", 3],
        ["To Finish:", 6]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Broth:\nPreheat oven to 400 degrees.\nAdd the soup bones and onion wedges to a baking sheet.\nBake for 1 hour.\nAdd the bones and onion to a large pot (see below for slow cooker version).\nNote: Do not add the fat that is on the baking sheet, the soup does not need additional oil.\nAdd salt, fish sauce and water, stir well.\nHeat\nOn medium heat bring to a simmer.\nLower the heat to medium-low.\nAdd\nTo a cheesecloth add the anise pods, cinnamon, garlic cloves, whole cloves, fennel seeds, coriander seeds and ginger.\nTie the cheesecloth closed with some kitchen string.\nAdd to the simmering liquid.\nSimmer\nStir well, then cover and simmer for a minimum of 8 hours.\nStrain the broth through a chinois or a cheesecloth lined strainer.\nRefrigerate\nLet broth cool then place in refrigerator overnight.\nDay of Serving:\nSit\nAdd rice noodles to a large bowl with the 6 cups of water and let sit for 1 hour.\nNote: This water is only to soak the noodles, it does not go in the pot with the broth.\nFreeze the beef for 1 hour, then slice it as thinly as possible, giving it a shaved beef thickness and appearance.\nScoop off much of the congealed fat (you can reserve this for cooking in the future as you would with bacon fat).\nNote: If you leave too much fat in the soup, it will coat your spoon and mouth with oiliness when you eat it.\nSimmer\nBring the broth to a low simmer in a pot on medium heat.\nCook\nAdd the soaked rice noodles (not the water they soaked in), to the broth and let cook for 1 minute.\nRemove the noodles from the pot and place into 4 bowls.\nAdd the beef to the broth, then immediately remove and place in the bowls.\nNote: The beef should be barely cooked, maybe not even all the way cooked in some spots, but the heat of the broth in the bowls will finish the cooking.\nAdd\nTo your bowl of noodles and beef and add additional toppings as desired including cilantro, green onions, bean sprouts, sriracha and hoisin sauce.\nTop with simmering broth, stir to mix and garnish with additional toppings if desired along with lime wedges for squeezing.\nSlow Cooker:\nRoast\nTo make this broth in the slow cooker, roast the bones and onions as directed above.\nAdd the bones and onions to the slow cooker.\nAdd salt, fish sauce and water.\nAdd\nTo a cheesecloth add the anise pods, cinnamon, garlic cloves, whole cloves, fennel seeds, coriander seeds and ginger.\nTie the cheesecloth closed with some kitchen string.\nHeat\nStir well, then cover and cook on high heat for 1 hour.\nCook\nLower the heat to low and cook for 12-24 hours (the longer the better).\nStrain the broth through a chinois or a cheesecloth lined strainer.\nCool\nLet broth cool then refrigerate.\nContinue the recipe from \"Day of Serving\".")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("dinnerthendessert.com")
    expect(recipe.canonical_url).to eq("https://dinnerthendessert.com/vietnamese-pho-recipe/")
    expect(recipe.site_name).to eq("Dinner, then Dessert")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Sabrina Snyder")
    expect(recipe.description).to eq("Vietnamese Pho is the perfect soup with flavorful broth, rice noodles, delicious steak, bean sprouts, and simple but amazing seasonings!")
    expect(recipe.image).to eq("https://dinnerthendessert.com/wp-content/uploads/2024/01/vietnamese-pho-48.jpg")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to eq("Vietnamese")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(1090)
    expect(recipe.prep_time).to eq(1080)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq(["Vietnamese Pho"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "568 kcal",
      "carbohydrateContent" => "59 g",
      "proteinContent" => "56 g",
      "fatContent" => "11 g",
      "saturatedFatContent" => "4 g",
      "cholesterolContent" => "138 mg",
      "sodiumContent" => "2760 mg",
      "fiberContent" => "4 g",
      "sugarContent" => "5 g",
      "unsaturatedFatContent" => "6 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 568.0 },
      { name: "carbohydrateContent", unit: "g", amount: 59.0 },
      { name: "proteinContent", unit: "g", amount: 56.0 },
      { name: "fatContent", unit: "g", amount: 11.0 },
      { name: "saturatedFatContent", unit: "g", amount: 4.0 },
      { name: "cholesterolContent", unit: "mg", amount: 138.0 },
      { name: "sodiumContent", unit: "mg", amount: 2760.0 },
      { name: "fiberContent", unit: "g", amount: 4.0 },
      { name: "sugarContent", unit: "g", amount: 5.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 6.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
