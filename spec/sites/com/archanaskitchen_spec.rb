# frozen_string_literal: true

RSpec.describe "archanaskitchen.com" do
  subject(:recipe) { scrape_cassette("com/archanaskitchen", url: "https://www.archanaskitchen.com/recipe/chicken-seekh-kebab-recipe") }

  it "reads the title" do
    expect(recipe.title).to eq("Chicken Seekh Kebab Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "500 grams Chicken breasts chopped",
      "1 Onion chopped",
      "6 cloves Garlic",
      "1 inch Ginger",
      "3 Green Chillies chopped",
      "2 teaspoon Garam masala powder",
      "1 teaspoon Coriander (Dhania) Powder",
      "1 teaspoon Kashmiri Red Chilli Powder",
      "1/2 teaspoon Fennel seeds (Saunf) coarsely ground",
      "1 inch Cinnamon Stick (Dalchini)",
      "1/4 teaspoon Black pepper powder",
      "1 teaspoon Lemon juice",
      "1/4 cup Gram flour (besan)",
      "Salt to taste",
      "1 Coal piece",
      "Ghee as required"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 500.0, unit: "grams", name: "Chicken breasts chopped" },
      { amount: 1.0, unit: nil, name: "Onion chopped" },
      { amount: 6.0, unit: "cloves", name: "Garlic" },
      { amount: 1.0, unit: "inch", name: "Ginger" },
      { amount: 3.0, unit: nil, name: "Green Chillies chopped" },
      { amount: 2.0, unit: "teaspoon", name: "Garam masala powder" },
      { amount: 1.0, unit: "teaspoon", name: "Coriander Powder" },
      { amount: 1.0, unit: "teaspoon", name: "Kashmiri Red Chilli Powder" },
      { amount: 0.5, unit: "teaspoon", name: "Fennel seeds coarsely ground" },
      { amount: 1.0, unit: "inch", name: "Cinnamon Stick" },
      { amount: 0.25, unit: "teaspoon", name: "Black pepper powder" },
      { amount: 1.0, unit: "teaspoon", name: "Lemon juice" },
      { amount: 0.25, unit: "cup", name: "Gram flour" },
      { amount: nil, unit: nil, name: "Salt to taste" },
      { amount: 1.0, unit: nil, name: "Coal piece" },
      { amount: nil, unit: nil, name: "Ghee as required" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "To begin making the Chicken Seekh Kebab Recipe, first add the onions, garlic, ginger and chilli into the small jar of the grinder and blend to make a smooth paste.",
      "Into the food processor; add the chopped chicken breasts, 2 tablespoon of the ginger garlic, onion and chilli paste, garam masala, coriander powder, fennel powder, chilli powder, black pepper powder, lemon juice, gram flour and salt to taste.",
      "Pulse to make a coarse mixture.",
      "Transfer the Chicken Seekh Kebab mixture into a bowl. Cover and refrigerate the mixture for at least 2 hours or overnight.",
      "Once done we will coal smoke the sheek kebab mixture. Place a steel katori or bowl in the center of the chicken seekh kebab mixture.",
      "Heat a piece of coal on gas. Allow it to get red hot. Place the hot coal in the steel katori.",
      "Add a spoon of ghee over the coal. You will notice the coal smoking up. Immediately cover the bowl and allow the Chicken Seekh Kebab mixture to get smoked.",
      "Once all the smoke has settled down, open the lid and divide the mixture into 10 to 12 portions.",
      "Grease your palm with oil and shape the kebabs over long skewer.",
      "Once done place the Chicken Seekh Kebabs on a preheated pan, drizzle oil over the kebabs and fry until golden brown on all sides. Serve hot.",
      "Serve the Seekh Kebabs along with Pita Breads or rotis with a combination of Mint Chutney,Yogurt Dip, Pickled Onions to make it more exciting. You can also serve it as an appetizer along with a party meal of Hyderabadi Mutton Dum Biryani, Hyderabadi Bagara Baingan Recipe and Rose Gulkand Phirni Recipe"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("To begin making the Chicken Seekh Kebab Recipe, first add the onions, garlic, ginger and chilli into the small jar of the grinder and blend to make a smooth paste.\nInto the food processor; add the chopped chicken breasts, 2 tablespoon of the ginger garlic, onion and chilli paste, garam masala, coriander powder, fennel powder, chilli powder, black pepper powder, lemon juice, gram flour and salt to taste.\nPulse to make a coarse mixture.\nTransfer the Chicken Seekh Kebab mixture into a bowl. Cover and refrigerate the mixture for at least 2 hours or overnight.\nOnce done we will coal smoke the sheek kebab mixture. Place a steel katori or bowl in the center of the chicken seekh kebab mixture.\nHeat a piece of coal on gas. Allow it to get red hot. Place the hot coal in the steel katori.\nAdd a spoon of ghee over the coal. You will notice the coal smoking up. Immediately cover the bowl and allow the Chicken Seekh Kebab mixture to get smoked.\nOnce all the smoke has settled down, open the lid and divide the mixture into 10 to 12 portions.\nGrease your palm with oil and shape the kebabs over long skewer.\nOnce done place the Chicken Seekh Kebabs on a preheated pan, drizzle oil over the kebabs and fry until golden brown on all sides. Serve hot.\nServe the Seekh Kebabs along with Pita Breads or rotis with a combination of Mint Chutney,Yogurt Dip, Pickled Onions to make it more exciting. You can also serve it as an appetizer along with a party meal of Hyderabadi Mutton Dum Biryani, Hyderabadi Bagara Baingan Recipe and Rose Gulkand Phirni Recipe")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("archanaskitchen.com")
    expect(recipe.canonical_url).to eq("https://www.archanaskitchen.com/recipe/chicken-seekh-kebab-recipe")
    expect(recipe.site_name).to eq("Archana's Kitchen")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Archana's Kitchen")
    expect(recipe.description).to eq("If you love kebabs, then you must try this lip smacking Chicken Seekh Kebab Recipe. It is super simple to make and is packed with delectable flavours. Grill these kebabs over your BBQ grills and serve them along with a spicy Dahi Wali Green Chutney for parties.")
    expect(recipe.image).to eq("https://images.archanaskitchen.com/images/recipes/snack-recipes/indian-snack-recipes/thumbnail_Chicken_Seekh_Kebab_Video_Recipe_21_1_94c405994e.jpg")
    expect(recipe.category).to eq("Indian Snack Recipes")
    expect(recipe.cuisine).to eq("Hyderabadi")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(60)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["Party Food Recipes", "Party Starter & Appetizer Recipes", "Kebab Recipes", "Ramzan Ramadan Recipes"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.9)
    expect(recipe.ratings_count).to eq(10_275)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#comments")
  end
end
