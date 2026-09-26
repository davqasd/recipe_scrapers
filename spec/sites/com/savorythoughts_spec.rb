# frozen_string_literal: true

RSpec.describe "savorythoughts.com" do
  subject(:recipe) { scrape_cassette("com/savorythoughts", url: "https://www.savorythoughts.com/ghanaian-light-soup/") }

  it "reads the title" do
    expect(recipe.title).to eq("Ghanaian Light Pepper Soup Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 ½ lbs. Goat Meat (Cleaned and washed)",
      "1 Tbsp. Kosher Salt",
      "1 Tbsp. Onion Powder",
      "1 Tbsp. Garlic Powder",
      "1 Tbsp. Ginger Powder",
      "1 Small Red Onion (Peeled and cut In Half)",
      "2 Roma Tomatoes (Cut in half or leave whole)",
      "6 Tbsp. Tomato Paste",
      "8 Cups Water",
      "3 Habanero Pepper",
      "1 Tbsp. Shrimp Powder (Optional)",
      "Salt and Pepper To Taste"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.5, unit: "lbs", name: "Goat Meat" },
      { amount: 1.0, unit: "Tbsp", name: "Kosher Salt" },
      { amount: 1.0, unit: "Tbsp", name: "Onion Powder" },
      { amount: 1.0, unit: "Tbsp", name: "Garlic Powder" },
      { amount: 1.0, unit: "Tbsp", name: "Ginger Powder" },
      { amount: 1.0, unit: nil, name: "Small Red Onion" },
      { amount: 2.0, unit: nil, name: "Roma Tomatoes" },
      { amount: 6.0, unit: "Tbsp", name: "Tomato Paste" },
      { amount: 8.0, unit: "Cups", name: "Water" },
      { amount: 3.0, unit: nil, name: "Habanero Pepper" },
      { amount: 1.0, unit: "Tbsp", name: "Shrimp Powder" },
      { amount: nil, unit: nil, name: "Salt and Pepper To Taste" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Marinate The Meat",
      "prepare the ingredients",
      "Clean and wash the meat thoroughly then season with salt, onion powder, garlic powder, and ginger. Mix well and marinate for 2 hours or longer. When ready to prepare the soup, steam the meat over medium high heat for about 15 minutes, covered. Then add in the onion, tomatoes, peppers, and tomato paste with 8 cups of water. Cover and cook for about 40 minutes.",
      "Cook the soup",
      "Reduce the heat to medium low. Remove the vegetables and peppers. Next, blend the vegetables and the peppers with ½ cup water. Blend to a smooth consistency. Add the blended mixture to the meat. Stir well to combine. Add in the shrimp powder (optional), and season with salt to taste. Mix well. Cover and simmer on medium low heat for 20 to 30 minutes. Serve warm and enjoy."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["For The Goat Meat", 5],
        ["For The Soup", 7]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Marinate The Meat\nprepare the ingredients\nClean and wash the meat thoroughly then season with salt, onion powder, garlic powder, and ginger. Mix well and marinate for 2 hours or longer. When ready to prepare the soup, steam the meat over medium high heat for about 15 minutes, covered. Then add in the onion, tomatoes, peppers, and tomato paste with 8 cups of water. Cover and cook for about 40 minutes.\nCook the soup\nReduce the heat to medium low. Remove the vegetables and peppers. Next, blend the vegetables and the peppers with ½ cup water. Blend to a smooth consistency. Add the blended mixture to the meat. Stir well to combine. Add in the shrimp powder (optional), and season with salt to taste. Mix well. Cover and simmer on medium low heat for 20 to 30 minutes. Serve warm and enjoy.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("savorythoughts.com")
    expect(recipe.canonical_url).to eq("https://www.savorythoughts.com/ghanaian-light-soup/")
    expect(recipe.site_name).to eq("Savory Thoughts")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Mirlene")
    expect(recipe.description).to eq("Cozy up with a steaming bowl of homemade Ghanaian Light Soup! Made with fresh tomatoes and onions, this recipe is easy, nourishing, and delicious.")
    expect(recipe.image).to eq("https://www.savorythoughts.com/wp-content/uploads/2022/03/Ghanaian-Light-Soup-Savory-Thoughts-12.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("African")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(120)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(90)
    expect(recipe.keywords).to eq(["Ghanaian Goat Soup", "Ghanaian Light Soup", "Pepper Soup"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(9)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "6 Servings",
      "calories" => "327 kcal",
      "carbohydrateContent" => "17 g",
      "proteinContent" => "28 g",
      "fatContent" => "16 g",
      "saturatedFatContent" => "3 g",
      "cholesterolContent" => "80 mg",
      "sodiumContent" => "1168 mg",
      "fiberContent" => "5 g",
      "sugarContent" => "7 g",
      "unsaturatedFatContent" => "12 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "Servings", amount: 6.0 },
      { name: "calories", unit: "kcal", amount: 327.0 },
      { name: "carbohydrateContent", unit: "g", amount: 17.0 },
      { name: "proteinContent", unit: "g", amount: 28.0 },
      { name: "fatContent", unit: "g", amount: 16.0 },
      { name: "saturatedFatContent", unit: "g", amount: 3.0 },
      { name: "cholesterolContent", unit: "mg", amount: 80.0 },
      { name: "sodiumContent", unit: "mg", amount: 1168.0 },
      { name: "fiberContent", unit: "g", amount: 5.0 },
      { name: "sugarContent", unit: "g", amount: 7.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 12.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
