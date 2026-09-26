# frozen_string_literal: true

RSpec.describe "mealprepmanual.com" do
  subject(:recipe) { scrape_cassette("com/mealprepmanual", url: "https://mealprepmanual.com/slow-cooker-big-boy-beef-stroganoff/") }

  it "reads the title" do
    expect(recipe.title).to eq("Slow Cooker Big Boy Beef Stroganoff")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2½ lbs top round roast",
      "½ cup cream cheese",
      "2 cups beef broth",
      "1 tbsp Worcestershire sauce",
      "2 tsp garlic powder",
      "2 tsp paprika",
      "1 tsp salt",
      "1 tsp pepper",
      "1 medium onion",
      "1 lb carrots",
      "½ lb mushrooms",
      "1½ lbs pasta (I used fusilli)",
      "3 tbsp starch (tapioca or cornstarch)",
      "¼ cup water",
      "½ cup plain greek yogurt",
      "1 tbsp dijon mustard",
      "¼ cup chopped parsley for garnish (optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.5, unit: "lbs", name: "top round roast" },
      { amount: 0.5, unit: "cup", name: "cream cheese" },
      { amount: 2.0, unit: "cups", name: "beef broth" },
      { amount: 1.0, unit: "tbsp", name: "Worcestershire sauce" },
      { amount: 2.0, unit: "tsp", name: "garlic powder" },
      { amount: 2.0, unit: "tsp", name: "paprika" },
      { amount: 1.0, unit: "tsp", name: "salt" },
      { amount: 1.0, unit: "tsp", name: "pepper" },
      { amount: 1.0, unit: nil, name: "medium onion" },
      { amount: 1.0, unit: "lb", name: "carrots" },
      { amount: 0.5, unit: "lb", name: "mushrooms" },
      { amount: 1.5, unit: "lbs", name: "pasta" },
      { amount: 3.0, unit: "tbsp", name: "starch" },
      { amount: 0.25, unit: "cup", name: "water" },
      { amount: 0.5, unit: "cup", name: "plain greek yogurt" },
      { amount: 1.0, unit: "tbsp", name: "dijon mustard" },
      { amount: 0.25, unit: "cup", name: "chopped parsley for garnish" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "For the Slow Cooker",
      "Wash and cut all of your vegetables. Cut your onion into a small dice, the carrots into a large dice (about 1 inch pieces), and your mushrooms into a large dice as well.",
      "Into the vessel of your slow cooker add the beef broth, Worcestershire sauce, onions, salt, pepper, garlic powder, and paprika. Stir to mix in the seasonings.",
      "For the beef I used top round (London Broil). This is a cheap, lean piece of meat. Top sirloin is a more tender piece of beef of similar leanness but it is more expensive. Feel free to use either.",
      "Lay the beef into the vessel and place it into the slow cooker. Cook on high for 4 hours or low for 6 hours.",
      "When there are 30 minutes left of cook time, add in the mushrooms and carrots and stir to cover with the liquid.",
      "For the Pasta",
      "After you add in the vegetables you can start on your pasta. Bring a large pot of water to a boil and add the pasta of your choosing. I used fusilli.",
      "Strain and set aside when finished cooking.",
      "For the Sauce",
      "After the slow cooker timer is finished, remove the lid and pull out the beef. Set it aside to break down.",
      "Mix together 3 tbsp of tapioca starch (or cornstarch) with ¼ cup of cold water to make a slurry.",
      "Drizzle the slurry into the slow cooker and stir constantly to thicken the sauce.",
      "Next add in the cream cheese, Greek yogurt, and dijon mustard. Stir to melt the cheese and combine.",
      "Break the beef down into bite sized pieces or shred it up. Add it to the sauce and mix.",
      "Dump in your pasta and mix until all of the sauce is evenly distributed. Taste test and adjust with salt and pepper to meet your needs.",
      "Plating",
      "This recipe makes 5 servings. Divide the contents of the slow cooker evenly between your containers. Top with chopped parsley for garnish if you please."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("For the Slow Cooker\nWash and cut all of your vegetables. Cut your onion into a small dice, the carrots into a large dice (about 1 inch pieces), and your mushrooms into a large dice as well.\nInto the vessel of your slow cooker add the beef broth, Worcestershire sauce, onions, salt, pepper, garlic powder, and paprika. Stir to mix in the seasonings.\nFor the beef I used top round (London Broil). This is a cheap, lean piece of meat. Top sirloin is a more tender piece of beef of similar leanness but it is more expensive. Feel free to use either.\nLay the beef into the vessel and place it into the slow cooker. Cook on high for 4 hours or low for 6 hours.\nWhen there are 30 minutes left of cook time, add in the mushrooms and carrots and stir to cover with the liquid.\nFor the Pasta\nAfter you add in the vegetables you can start on your pasta. Bring a large pot of water to a boil and add the pasta of your choosing. I used fusilli.\nStrain and set aside when finished cooking.\nFor the Sauce\nAfter the slow cooker timer is finished, remove the lid and pull out the beef. Set it aside to break down.\nMix together 3 tbsp of tapioca starch (or cornstarch) with ¼ cup of cold water to make a slurry.\nDrizzle the slurry into the slow cooker and stir constantly to thicken the sauce.\nNext add in the cream cheese, Greek yogurt, and dijon mustard. Stir to melt the cheese and combine.\nBreak the beef down into bite sized pieces or shred it up. Add it to the sauce and mix.\nDump in your pasta and mix until all of the sauce is evenly distributed. Taste test and adjust with salt and pepper to meet your needs.\nPlating\nThis recipe makes 5 servings. Divide the contents of the slow cooker evenly between your containers. Top with chopped parsley for garnish if you please.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("mealprepmanual.com")
    expect(recipe.canonical_url).to eq("https://mealprepmanual.com/slow-cooker-big-boy-beef-stroganoff/")
    expect(recipe.site_name).to eq("The Meal Prep Manual")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Josh Cortis")
    expect(recipe.description).to eq("This Big Boy Beef Stroganoff is perfect for bulking season containing over 1000 calories and 80g of protein. It is made using a slow cooker to save you time and effort.")
    expect(recipe.image).to eq("https://mealprepmanual.com/wp-content/uploads/2024/12/Big-Boy-Beef-Stroganoff-.jpg")
    expect(recipe.category).to eq("Main Dish")
    expect(recipe.cuisine).to eq("meal prep")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("5 servings")
    expect(recipe.total_time).to eq(260)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(240)
    expect(recipe.keywords).to eq(["beef", "free", "gluten free"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(3.75)
    expect(recipe.ratings_count).to eq(12)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "1013 kcal",
      "carbohydrateContent" => "125 g",
      "proteinContent" => "80 g",
      "fatContent" => "22 g",
      "fiberContent" => "8.8 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 1013.0 },
      { name: "carbohydrateContent", unit: "g", amount: 125.0 },
      { name: "proteinContent", unit: "g", amount: 80.0 },
      { name: "fatContent", unit: "g", amount: 22.0 },
      { name: "fiberContent", unit: "g", amount: 8.8 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
