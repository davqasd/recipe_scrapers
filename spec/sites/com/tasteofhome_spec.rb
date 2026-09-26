# frozen_string_literal: true

RSpec.describe "tasteofhome.com" do
  subject(:recipe) { scrape_cassette("com/tasteofhome", url: "https://www.tasteofhome.com/recipes/pressure-cooker-sauerbraten/") }

  it "reads the title" do
    expect(recipe.title).to eq("Pressure-Cooker Sauerbraten")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 whole cloves",
      "4 whole peppercorns",
      "1 bay leaf",
      "1/2 cup water",
      "1/2 cup white vinegar",
      "2 teaspoons sugar",
      "1/2 teaspoon salt",
      "Dash ground ginger",
      "1 pound boneless beef top round steak, cut into 1-inch cubes",
      "3 medium carrots, cut into 1/2-inch slices",
      "2 celery ribs, cut into 1/2-inch slices",
      "1 small onion, chopped",
      "1/3 cup crushed gingersnaps",
      "Hot cooked egg noodles",
      "Optional: Chopped fresh parsley and coarsely ground pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: nil, name: "whole cloves" },
      { amount: 4.0, unit: nil, name: "whole peppercorns" },
      { amount: 1.0, unit: nil, name: "bay leaf" },
      { amount: 0.5, unit: "cup", name: "water" },
      { amount: 0.5, unit: "cup", name: "white vinegar" },
      { amount: 2.0, unit: "teaspoons", name: "sugar" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 1.0, unit: "Dash", name: "ground ginger" },
      { amount: 1.0, unit: "pound", name: "boneless beef top round steak, cut into 1-inch cubes" },
      { amount: 3.0, unit: nil, name: "medium carrots, cut into 1/2-inch slices" },
      { amount: 2.0, unit: nil, name: "celery ribs, cut into 1/2-inch slices" },
      { amount: 1.0, unit: nil, name: "small onion, chopped" },
      { amount: 0.33, unit: "cup", name: "crushed gingersnaps" },
      { amount: nil, unit: nil, name: "Hot cooked egg noodles" },
      { amount: nil, unit: nil, name: "Optional: Chopped fresh parsley and coarsely ground pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Place cloves, peppercorns and bay leaf on a double thickness of cheesecloth; bring up corners of cloth and tie with kitchen string to form a bag. In a large bowl, combine the water, vinegar, sugar, salt and ginger. Add beef and spice bag; let stand at room temperature for 30 minutes.",
      "Transfer all to a 6-qt. electric pressure cooker. Add carrots, celery and onion. Lock the lid and close pressure-release valve. Adjust to pressure-cook on high for 10 minutes. Quick-release pressure. Select saute setting and adjust for medium heat; bring liquid to a boil. Discard the spice bag. Stir in gingersnaps; cook and stir until thickened, about 3 minutes. Serve with egg noodles. If desired, top with parsley and pepper."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Place cloves, peppercorns and bay leaf on a double thickness of cheesecloth; bring up corners of cloth and tie with kitchen string to form a bag. In a large bowl, combine the water, vinegar, sugar, salt and ginger. Add beef and spice bag; let stand at room temperature for 30 minutes.\nTransfer all to a 6-qt. electric pressure cooker. Add carrots, celery and onion. Lock the lid and close pressure-release valve. Adjust to pressure-cook on high for 10 minutes. Quick-release pressure. Select saute setting and adjust for medium heat; bring liquid to a boil. Discard the spice bag. Stir in gingersnaps; cook and stir until thickened, about 3 minutes. Serve with egg noodles. If desired, top with parsley and pepper.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("tasteofhome.com")
    expect(recipe.canonical_url).to eq("https://www.tasteofhome.com/recipes/pressure-cooker-sauerbraten/")
    expect(recipe.site_name).to eq("Taste of Home")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Taste of Home Editorial Team")
    expect(recipe.description).to eq("One of my all-time favorite German dishes is sauerbraten, but I don't love that it normally takes five to 10 days to make. Using an electric pressure cooker, I think I've captured that same distinctive flavor in less than two hours. —James Schend, Pleasant Prairie, Wisconsin")
    expect(recipe.image).to eq("https://www.tasteofhome.com/wp-content/uploads/0001/01/Pressure-Cooker-Sauerbraten_EXPS_THN18_39243_E06_06_2b.jpg")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to eq("Europe, German")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(3.63)
    expect(recipe.ratings_count).to eq(8)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "228 calories",
      "fatContent" => "5g fat (2g saturated fat)",
      "cholesterolContent" => "63mg cholesterol",
      "sodiumContent" => "436mg sodium",
      "carbohydrateContent" => "18g carbohydrate (8g sugars",
      "fiberContent" => "2g fiber)",
      "proteinContent" => "27g protein. Diabetic Exchanges: 3 lean meat"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 228.0 },
      { name: "fatContent", unit: "g", amount: 5.0 },
      { name: "cholesterolContent", unit: "mg", amount: 63.0 },
      { name: "sodiumContent", unit: "mg", amount: 436.0 },
      { name: "carbohydrateContent", unit: "g", amount: 18.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "proteinContent", unit: "g", amount: 27.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
