# frozen_string_literal: true

RSpec.describe "sipandfeast.com" do
  subject(:recipe) { scrape_cassette("com/sipandfeast", url: "https://www.sipandfeast.com/salisbury-steak-mushroom-gravy/") }

  it "reads the title" do
    expect(recipe.title).to eq("Salisbury Steak with Mushroom Gravy")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 1/2 pounds ground chuck",
      "1/4 cup milk",
      "1/2 cup Italian seasoned breadcrumbs",
      "1/3 cup grated onion",
      "4 cloves garlic (grated)",
      "1 tablespoon Dijon mustard",
      "1 tablespoon Worcestershire sauce",
      "1 teaspoon salt",
      "1/2 teaspoon black pepper",
      "2 large eggs",
      "1 tablespoon olive oil",
      "1 pound mushrooms (sliced)",
      "1 large onion (sliced)",
      "1/2 cup dry red wine",
      "3 tablespoons butter",
      "2 tablespoons all-purpose flour",
      "2 cups low-sodium beef stock",
      "1 tablespoon Dijon mustard",
      "2 teaspoons fresh thyme leaves",
      "2 tablespoons Worcestershire sauce",
      "salt and pepper (to taste)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.5, unit: "pounds", name: "ground chuck" },
      { amount: 0.25, unit: "cup", name: "milk" },
      { amount: 0.5, unit: "cup", name: "Italian seasoned breadcrumbs" },
      { amount: 0.33, unit: "cup", name: "grated onion" },
      { amount: 4.0, unit: "cloves", name: "garlic" },
      { amount: 1.0, unit: "tablespoon", name: "Dijon mustard" },
      { amount: 1.0, unit: "tablespoon", name: "Worcestershire sauce" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: 0.5, unit: "teaspoon", name: "black pepper" },
      { amount: 2.0, unit: nil, name: "large eggs" },
      { amount: 1.0, unit: "tablespoon", name: "olive oil" },
      { amount: 1.0, unit: "pound", name: "mushrooms" },
      { amount: 1.0, unit: nil, name: "large onion" },
      { amount: 0.5, unit: "cup", name: "dry red wine" },
      { amount: 3.0, unit: "tablespoons", name: "butter" },
      { amount: 2.0, unit: "tablespoons", name: "all-purpose flour" },
      { amount: 2.0, unit: "cups", name: "low-sodium beef stock" },
      { amount: 1.0, unit: "tablespoon", name: "Dijon mustard" },
      { amount: 2.0, unit: "teaspoons", name: "fresh thyme leaves" },
      { amount: 2.0, unit: "tablespoons", name: "Worcestershire sauce" },
      { amount: nil, unit: nil, name: "salt and pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "For the steaks",
      "Combine the breadcrumbs, milk, and grated onion in a large bowl and let sit for 5 minutes.",
      "Add the remaining ingredients to the bowl and gently mix together. Form 4 equal-sized oval patties approximately 1-inch thick.",
      "Sear the steaks and make the gravy",
      "Heat a large cast-iron or heavy skillet to medium heat. Add the olive oil and sear the patties for 3-4 minutes per side or until well browned on both sides. Remove the patties to a plate and tent with foil to keep warm.",
      "Add the onions and mushrooms to the pan along with a pinch of salt. Saute until the mushrooms release their water then let them brown for a few minutes.",
      "Add the wine to the pan and turn the heat to high. With a wooden spoon scrape up all of the brown bits from the bottom of the pan. Cook until the wine almost entirely evaporates (2-3 minutes) then turn the heat down to medium.",
      "Add the butter to the pan. Once it melts add the flour and cook for 2 minutes or until golden.",
      "Slowly pour the stock into the pan while whisking. Turn the heat to medium-high and whisk until the gravy is smooth. Mix in the mustard, Worcestershire sauce, and thyme then turn the heat down to a simmer.",
      "Add the steaks to the pan and spoon the gravy on top of them. Simmer for 5-7 minutes, covered, flipping at halfway point. Once the steaks are cooked through, test the gravy and adjust salt and pepper to taste. Enjoy!"
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["For the steaks", 10],
        ["For the mushroom gravy", 11]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("For the steaks\nCombine the breadcrumbs, milk, and grated onion in a large bowl and let sit for 5 minutes.\nAdd the remaining ingredients to the bowl and gently mix together. Form 4 equal-sized oval patties approximately 1-inch thick.\nSear the steaks and make the gravy\nHeat a large cast-iron or heavy skillet to medium heat. Add the olive oil and sear the patties for 3-4 minutes per side or until well browned on both sides. Remove the patties to a plate and tent with foil to keep warm.\nAdd the onions and mushrooms to the pan along with a pinch of salt. Saute until the mushrooms release their water then let them brown for a few minutes.\nAdd the wine to the pan and turn the heat to high. With a wooden spoon scrape up all of the brown bits from the bottom of the pan. Cook until the wine almost entirely evaporates (2-3 minutes) then turn the heat down to medium.\nAdd the butter to the pan. Once it melts add the flour and cook for 2 minutes or until golden.\nSlowly pour the stock into the pan while whisking. Turn the heat to medium-high and whisk until the gravy is smooth. Mix in the mustard, Worcestershire sauce, and thyme then turn the heat down to a simmer.\nAdd the steaks to the pan and spoon the gravy on top of them. Simmer for 5-7 minutes, covered, flipping at halfway point. Once the steaks are cooked through, test the gravy and adjust salt and pepper to taste. Enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("sipandfeast.com")
    expect(recipe.canonical_url).to eq("https://www.sipandfeast.com/salisbury-steak-mushroom-gravy/")
    expect(recipe.site_name).to eq("Sip and Feast")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("James Delmage")
    expect(recipe.description).to eq("Salisbury steak with mushroom gravy is a tasty stick-to-your-ribs comfort food that tastes like it's cooked for hours but can be on your table in 45 minutes!")
    expect(recipe.image).to eq("https://www.sipandfeast.com/wp-content/uploads/2023/11/salisbury-steak-recipe-snippet.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(35)
    expect(recipe.keywords).to eq(["salisbury steak", "salisbury steak with mushroom gravy"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.96)
    expect(recipe.ratings_count).to eq(43)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "591 kcal",
      "fatContent" => "24.7 g",
      "saturatedFatContent" => "11.8 g",
      "cholesterolContent" => "223 mg",
      "sodiumContent" => "1112 mg",
      "fiberContent" => "3.1 g",
      "sugarContent" => "7.3 g",
      "proteinContent" => "59.8 g",
      "carbohydrateContent" => "25.5 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 591.0 },
      { name: "fatContent", unit: "g", amount: 24.7 },
      { name: "saturatedFatContent", unit: "g", amount: 11.8 },
      { name: "cholesterolContent", unit: "mg", amount: 223.0 },
      { name: "sodiumContent", unit: "mg", amount: 1112.0 },
      { name: "fiberContent", unit: "g", amount: 3.1 },
      { name: "sugarContent", unit: "g", amount: 7.3 },
      { name: "proteinContent", unit: "g", amount: 59.8 },
      { name: "carbohydrateContent", unit: "g", amount: 25.5 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
