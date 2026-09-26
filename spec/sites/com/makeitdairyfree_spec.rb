# frozen_string_literal: true

RSpec.describe "makeitdairyfree.com" do
  subject(:recipe) { scrape_cassette("com/makeitdairyfree", url: "https://makeitdairyfree.com/the-best-vegan-mac-and-cheese/") }

  it "reads the title" do
    expect(recipe.title).to eq("Baked Vegan Mac and Cheese Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 pound macaroni noodles, (uncooked (16oz or 454g) (Use gluten free if needed))",
      "15 oz can butter beans, (drained and rinsed (439g))",
      "2 cups dairy free milk (480g)",
      "1/2 cup vegetable stock (120g)",
      "1/2 cup vegan butter (113g)",
      "1/3 cup nutritional yeast (27g)",
      "2 tablespoon lemon juice",
      "1 teaspoon salt",
      "1 teaspoon cracked black pepper",
      "1/4 teaspoon paprika",
      "2 cups vegan shredded cheddar cheese, (divided (240g))",
      "1 cup vegan parmesan cheese (115g)",
      "1/3 cup seasoned panko breadcrumbs (20g)",
      "2 teaspoon olive oil, (optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "pound", name: "macaroni noodles" },
      { amount: 15.0, unit: "oz", name: "can butter beans" },
      { amount: 2.0, unit: "cups", name: "dairy free milk" },
      { amount: 0.5, unit: "cup", name: "vegetable stock" },
      { amount: 0.5, unit: "cup", name: "vegan butter" },
      { amount: 0.33, unit: "cup", name: "nutritional yeast" },
      { amount: 2.0, unit: "tablespoon", name: "lemon juice" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: 1.0, unit: "teaspoon", name: "cracked black pepper" },
      { amount: 0.25, unit: "teaspoon", name: "paprika" },
      { amount: 2.0, unit: "cups", name: "vegan shredded cheddar cheese" },
      { amount: 1.0, unit: "cup", name: "vegan parmesan cheese" },
      { amount: 0.33, unit: "cup", name: "seasoned panko breadcrumbs" },
      { amount: 2.0, unit: "teaspoon", name: "olive oil" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Bring a salted pot of water to a boil. Preheat oven to 350˚F/180˚C degrees. Cook 1lb macaroni noodles according to the package. Drain noodles once done and set aside.",
      "While noodles cook, to a high powdered blender, add 15oz can butter beans, 2 cups dairy free milk, 1/2 cup stock, 1/2 cup vegan butter, 1/3 cupnutritional yeast, 2 tablespoons lemon juice, 1 teaspoon each salt and pepper, 1/4 teaspoon paprika, 1 cup each non-dairy cheddar shreds and parmesan cheese. Blend this until smooth. Set aside.",
      "In a lightly greased 9x13 casserole dish, add the drained, cooked noodles. Pour the sauce mixture over the noodles and carefully stir together.",
      "Top with remaining 1 cup of the cheese shreds. If using the oil, in a small bowl combine the oil with the breadcrumbs and stir to well coated. Sprinkle evenly across the top.",
      "Bake for 25-30 minutes or until breadcrumbs have started turning golden brown on top. Remove from oven and let set for 15 minutes before cutting into."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Bring a salted pot of water to a boil. Preheat oven to 350˚F/180˚C degrees. Cook 1lb macaroni noodles according to the package. Drain noodles once done and set aside.\nWhile noodles cook, to a high powdered blender, add 15oz can butter beans, 2 cups dairy free milk, 1/2 cup stock, 1/2 cup vegan butter, 1/3 cupnutritional yeast, 2 tablespoons lemon juice, 1 teaspoon each salt and pepper, 1/4 teaspoon paprika, 1 cup each non-dairy cheddar shreds and parmesan cheese. Blend this until smooth. Set aside.\nIn a lightly greased 9x13 casserole dish, add the drained, cooked noodles. Pour the sauce mixture over the noodles and carefully stir together.\nTop with remaining 1 cup of the cheese shreds. If using the oil, in a small bowl combine the oil with the breadcrumbs and stir to well coated. Sprinkle evenly across the top.\nBake for 25-30 minutes or until breadcrumbs have started turning golden brown on top. Remove from oven and let set for 15 minutes before cutting into.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("makeitdairyfree.com")
    expect(recipe.canonical_url).to eq("https://makeitdairyfree.com/the-best-vegan-mac-and-cheese/")
    expect(recipe.site_name).to eq("Make It Dairy Free")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Andrew Bernard")
    expect(recipe.description).to eq("This is the best vegan mac and cheese recipe ever! Directions for stovetop version and the most delicious baked vegan mac and cheese ever! Not cashew based, so allergy friendly!")
    expect(recipe.image).to eq("https://makeitdairyfree.com/wp-content/uploads/2019/10/the-best-vegan-mac-and-cheese-6.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("16 servings")
    expect(recipe.total_time).to eq(50)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq([
      "dairy free holidays",
      "dairy free main course",
      "dairy free recipes",
      "dairy free side dish",
      "vegan holidays",
      "vegan main course",
      "vegan recipes",
      "vegan side dish"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.92)
    expect(recipe.ratings_count).to eq(134)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 serving",
      "calories" => "127 kcal",
      "carbohydrateContent" => "16 g",
      "proteinContent" => "3 g",
      "fatContent" => "5 g",
      "saturatedFatContent" => "1 g",
      "sodiumContent" => "384 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "2 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "serving", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 127.0 },
      { name: "carbohydrateContent", unit: "g", amount: 16.0 },
      { name: "proteinContent", unit: "g", amount: 3.0 },
      { name: "fatContent", unit: "g", amount: 5.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 384.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 2.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
