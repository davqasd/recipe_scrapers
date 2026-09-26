# frozen_string_literal: true

RSpec.describe "downshiftology.com" do
  subject(:recipe) { scrape_cassette("com/downshiftology", url: "https://downshiftology.com/recipes/greek-chicken-kabobs/") }

  it "reads the title" do
    expect(recipe.title).to eq("Greek Chicken Kabobs")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "¼ cup olive oil",
      "2 tablespoons red wine vinegar",
      "3 tablespoons lemon juice",
      "1 teaspoon Dijon mustard",
      "3 garlic cloves (minced)",
      "1 teaspoon dried oregano",
      "½ teaspoon salt",
      "¼ teaspoon black pepper",
      "1 ½ pounds boneless skinless chicken breasts (about 3 large chicken breasts, cut into 1 ½-inch pieces.)",
      "1 red bell pepper (seeded, cut into 1 ½-Inch pieces)",
      "1 yellow bell pepper (seeded, cut into 1 ½-inch pieces)",
      "1 red onion (cut into 1 ½-inch chunks)",
      "1 zucchini (sliced)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.25, unit: "cup", name: "olive oil" },
      { amount: 2.0, unit: "tablespoons", name: "red wine vinegar" },
      { amount: 3.0, unit: "tablespoons", name: "lemon juice" },
      { amount: 1.0, unit: "teaspoon", name: "Dijon mustard" },
      { amount: 3.0, unit: nil, name: "garlic cloves" },
      { amount: 1.0, unit: "teaspoon", name: "dried oregano" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 0.25, unit: "teaspoon", name: "black pepper" },
      { amount: 1.5, unit: "pounds", name: "boneless skinless chicken breasts" },
      { amount: 1.0, unit: nil, name: "red bell pepper" },
      { amount: 1.0, unit: nil, name: "yellow bell pepper" },
      { amount: 1.0, unit: nil, name: "red onion" },
      { amount: 1.0, unit: nil, name: "zucchini" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Make marinade",
      "Make the marinade. In a bowl, whisk together the olive oil, red wine vinegar, lemon juice, Dijon mustard, minced garlic, dried oregano, salt, and pepper.",
      "Marinate chicken",
      "Marinate the chicken. Place chicken pieces in a glass dish and pour the marinade over the chicken. Cover and marinate in the fridge for at least one hour.",
      "Thread skewers. Light a gas or charcoal grill on medium-high heat. Thread the skewers with pieces of red onion, chicken, zucchini, and bell pepper. You can alternate the order.",
      "Grill kabobs",
      "Grill the skewers. Place the kabobs on the preheated grill, and cook about 4 to 5 minutes per side. The kabobs are done when the chicken is cooked through and the vegetables are lightly charred, about 15 minutes.",
      "Serve with lemon wedges and tzatziki sauce."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Marinade", 8],
        ["Chicken Kabobs", 5]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Make marinade\nMake the marinade. In a bowl, whisk together the olive oil, red wine vinegar, lemon juice, Dijon mustard, minced garlic, dried oregano, salt, and pepper.\nMarinate chicken\nMarinate the chicken. Place chicken pieces in a glass dish and pour the marinade over the chicken. Cover and marinate in the fridge for at least one hour.\nThread skewers. Light a gas or charcoal grill on medium-high heat. Thread the skewers with pieces of red onion, chicken, zucchini, and bell pepper. You can alternate the order.\nGrill kabobs\nGrill the skewers. Place the kabobs on the preheated grill, and cook about 4 to 5 minutes per side. The kabobs are done when the chicken is cooked through and the vegetables are lightly charred, about 15 minutes.\nServe with lemon wedges and tzatziki sauce.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("downshiftology.com")
    expect(recipe.canonical_url).to eq("https://downshiftology.com/recipes/greek-chicken-kabobs/")
    expect(recipe.site_name).to eq("Downshiftology")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Lisa Bryan")
    expect(recipe.description).to eq("These Greek chicken kabobs are a summer grilling staple! They're juicy, flavorful, and best served with my homemade tzatziki sauce.")
    expect(recipe.image).to eq("https://i2.wp.com/www.downshiftology.com/wp-content/uploads/2020/09/Greek-Chicken-Kabobs-main-1.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("Greek")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(55)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to eq(["easy chicken kabobs", "Greek chicken kabobs"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(47)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "135 kcal",
      "carbohydrateContent" => "11 g",
      "proteinContent" => "10 g",
      "fatContent" => "6 g",
      "saturatedFatContent" => "1 g",
      "cholesterolContent" => "24 mg",
      "sodiumContent" => "460 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "6 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 135.0 },
      { name: "carbohydrateContent", unit: "g", amount: 11.0 },
      { name: "proteinContent", unit: "g", amount: 10.0 },
      { name: "fatContent", unit: "g", amount: 6.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 24.0 },
      { name: "sodiumContent", unit: "mg", amount: 460.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 6.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
