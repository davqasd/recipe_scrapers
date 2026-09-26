# frozen_string_literal: true

RSpec.describe "copykat.com" do
  subject(:recipe) { scrape_cassette("com/copykat", url: "https://copykat.com/make-tender-beef-tips-in-gravy/") }

  it "reads the title" do
    expect(recipe.title).to eq("Make Tender Beef Tips and Gravy")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup flour",
      "1 teaspoon salt",
      "1/4 teaspoon black pepper",
      "3 pounds lean chuck roast",
      "48 ounces beef stock",
      "1 tablespoon vegetable oil",
      "2 teaspoons gravy master",
      "1 cup onions (chopped)",
      "16 ounces noodles (or rice for serving)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "flour" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: 0.25, unit: "teaspoon", name: "black pepper" },
      { amount: 3.0, unit: "pounds", name: "lean chuck roast" },
      { amount: 48.0, unit: "ounces", name: "beef stock" },
      { amount: 1.0, unit: "tablespoon", name: "vegetable oil" },
      { amount: 2.0, unit: "teaspoons", name: "gravy master" },
      { amount: 1.0, unit: "cup", name: "onions" },
      { amount: 16.0, unit: "ounces", name: "noodles" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a small bowl add flour, salt, and pepper. Stir the salt and pepper into the flour. Cut and trim roast into small bite-sized pieces. Dredge beef pieces in seasoned flour shake off excess flour.",
      "Instant Pot Directions",
      "Set the Instant Pot to saute, add oil. When the oil has heated drop in several pieces of the beef. Cook seasoned beef on all sides until lightly browned. Cook beef in small batches. When all of the beef is cooked add it back to the Instant Pot.",
      "Add 1 cup of onion, two teaspoons of Gravy Master, and beef stock. Place lid on high and cook for 15 minutes on high pressure. Release pot after cooking with either a quick release or a natural release.",
      "Slow Cooker Directions",
      "Brown the beef in a large skillet in small batches with some vegetable oil. Add the browned beef, beef broth, onion, and Gravy Master to the slow cooker. Cook for 4 to 6 hours on low.",
      "If the liquid hasn't thickened up to your desired consistency, you can thicken it up by mixing 1 tablespoon of butter and one tablespoon of flour together. Stir this into the liquid and it will thicken up the gravy in the slow cooker.",
      "Serving",
      "Prepare noodles or rice according to package instructions.",
      "Serve beef tips and gravy over noodles or rice."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a small bowl add flour, salt, and pepper. Stir the salt and pepper into the flour. Cut and trim roast into small bite-sized pieces. Dredge beef pieces in seasoned flour shake off excess flour.\nInstant Pot Directions\nSet the Instant Pot to saute, add oil. When the oil has heated drop in several pieces of the beef. Cook seasoned beef on all sides until lightly browned. Cook beef in small batches. When all of the beef is cooked add it back to the Instant Pot.\nAdd 1 cup of onion, two teaspoons of Gravy Master, and beef stock. Place lid on high and cook for 15 minutes on high pressure. Release pot after cooking with either a quick release or a natural release.\nSlow Cooker Directions\nBrown the beef in a large skillet in small batches with some vegetable oil. Add the browned beef, beef broth, onion, and Gravy Master to the slow cooker. Cook for 4 to 6 hours on low.\nIf the liquid hasn't thickened up to your desired consistency, you can thicken it up by mixing 1 tablespoon of butter and one tablespoon of flour together. Stir this into the liquid and it will thicken up the gravy in the slow cooker.\nServing\nPrepare noodles or rice according to package instructions.\nServe beef tips and gravy over noodles or rice.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("copykat.com")
    expect(recipe.canonical_url).to eq("https://copykat.com/make-tender-beef-tips-in-gravy/")
    expect(recipe.site_name).to eq("CopyKat Recipes")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Stephanie Manley")
    expect(recipe.description).to eq("You can make amazingly tender beef tips and gravy in an Instant Pot or slow cooker.")
    expect(recipe.image).to eq("https://copykat.com/wp-content/uploads/2020/11/Beef-Tips-and-Gravy-Pin2.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq([
      "Beef Tips and Gravy",
      "comfort food",
      "hearty",
      "Instant Pot Recipes",
      "one-pot",
      "Quick",
      "Slow Cooker Recipes"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(3)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "495 kcal",
      "carbohydrateContent" => "46 g",
      "proteinContent" => "36 g",
      "fatContent" => "17 g",
      "saturatedFatContent" => "8 g",
      "cholesterolContent" => "93 mg",
      "sodiumContent" => "682 mg",
      "fiberContent" => "2 g",
      "sugarContent" => "2 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 495.0 },
      { name: "carbohydrateContent", unit: "g", amount: 46.0 },
      { name: "proteinContent", unit: "g", amount: 36.0 },
      { name: "fatContent", unit: "g", amount: 17.0 },
      { name: "saturatedFatContent", unit: "g", amount: 8.0 },
      { name: "cholesterolContent", unit: "mg", amount: 93.0 },
      { name: "sodiumContent", unit: "mg", amount: 682.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
