# frozen_string_literal: true

RSpec.describe "zestfulkitchen.com" do
  subject(:recipe) { scrape_cassette("com/zestfulkitchen", url: "https://zestfulkitchen.com/roast-halibut-with-red-potatoes-corn-and-andouille/") }

  it "reads the title" do
    expect(recipe.title).to eq("Roast Halibut with Red Potatoes, Corn, and Andouille")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 tablespoons unsalted butter (softened)",
      "2 teaspoons Old Bay seasoning",
      "1 teaspoon lemon juice",
      "4 (6 to 8-ounce skinless halibut fillets (1 to 1½ inches thick)",
      "Salt and pepper",
      "¼ cup vegetable oil (I used olive oil)",
      "1½ pounds small red potatoes (unpeeled, halved)",
      "4 ears corn (husks and silks removed, cut into thirds)",
      "12 ounces andouille sausage (sliced 1 inch thick (I used turkey andouille))",
      "1 tablespoons minced fresh parsley"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: "tablespoons", name: "unsalted butter" },
      { amount: 2.0, unit: "teaspoons", name: "Old Bay seasoning" },
      { amount: 1.0, unit: "teaspoon", name: "lemon juice" },
      { amount: 4.0, unit: nil, name: "(6 to 8-ounce skinless halibut fillets" },
      { amount: nil, unit: nil, name: "Salt and pepper" },
      { amount: 0.25, unit: "cup", name: "vegetable oil" },
      { amount: 1.5, unit: "pounds", name: "small red potatoes" },
      { amount: 4.0, unit: "ears", name: "corn" },
      { amount: 12.0, unit: "ounces", name: "andouille sausage" },
      { amount: 1.0, unit: "tablespoons", name: "minced fresh parsley" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Adjust oven rack to lowest position and heat oven to 500°F. Mash butter, Old Bay, and lemon juice together in a bowl; set aside. Pat halibut dry with paper towels and season with salt and pepper; refrigerate until needed.",
      "Brush rimmed baking sheet with 1 tablespoon oil. Toss potatoes with 2 tablespoons oil, ¼ teaspoon salt, and ¼ teaspoon pepper in a bowl. Arrange potatoes, cut side down, on half of the sheet. Toss corn in now-empty bowl with remaining 1 tablespoon oil, ¼ teaspoon salt, and ¼ teaspoon pepper, then place on empty side of sheet. Nestle andouille onto sheet around corn. Roast until potatoes and andouille are lightly browned and corn kernels are plump, 20–25 minutes, rotating halfway through roasting.",
      "Remove sheet from oven and reduce oven temperature to 425°F. Transfer corn to clean bowl, leaving andouille and potatoes on sheet. Add 2 tablespoons Old Bay butter to corn, toss to coat, and cover bowl tightly with aluminum foil; set aside.",
      "Slide andouille to side of sheet with potatoes, then place halibut on now-empty side of sheet. Roast potatoes, andouille, and halibut until fish flakes apart when gently prodded with paring knife and registers 140°F, 8–10 minutes, rotating sheet halfway through roasting.",
      "Remove sheet from oven. Transfer potatoes, andouille, and hailbut browned side up to serving dish. Dot remaining Old Bay butter over halibut. Add corn to serving dish, sprinkle with parsley, and serve."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Adjust oven rack to lowest position and heat oven to 500°F. Mash butter, Old Bay, and lemon juice together in a bowl; set aside. Pat halibut dry with paper towels and season with salt and pepper; refrigerate until needed.\nBrush rimmed baking sheet with 1 tablespoon oil. Toss potatoes with 2 tablespoons oil, ¼ teaspoon salt, and ¼ teaspoon pepper in a bowl. Arrange potatoes, cut side down, on half of the sheet. Toss corn in now-empty bowl with remaining 1 tablespoon oil, ¼ teaspoon salt, and ¼ teaspoon pepper, then place on empty side of sheet. Nestle andouille onto sheet around corn. Roast until potatoes and andouille are lightly browned and corn kernels are plump, 20–25 minutes, rotating halfway through roasting.\nRemove sheet from oven and reduce oven temperature to 425°F. Transfer corn to clean bowl, leaving andouille and potatoes on sheet. Add 2 tablespoons Old Bay butter to corn, toss to coat, and cover bowl tightly with aluminum foil; set aside.\nSlide andouille to side of sheet with potatoes, then place halibut on now-empty side of sheet. Roast potatoes, andouille, and halibut until fish flakes apart when gently prodded with paring knife and registers 140°F, 8–10 minutes, rotating sheet halfway through roasting.\nRemove sheet from oven. Transfer potatoes, andouille, and hailbut browned side up to serving dish. Dot remaining Old Bay butter over halibut. Add corn to serving dish, sprinkle with parsley, and serve.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("zestfulkitchen.com")
    expect(recipe.canonical_url).to eq("https://zestfulkitchen.com/roast-halibut-with-red-potatoes-corn-and-andouille/")
    expect(recipe.site_name).to eq("Zestful Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Lauren Grant")
    expect(recipe.description).to eq("The perfect spring and summer meal, this Roast Halibut with Red Potatoes, Corn, and Andouille is simple, yet packed with flavor. Incredibly easy to whip up, everything for this meal is made on one sheet pan, making prep and clean up a breeze.")
    expect(recipe.image).to eq("https://zestfulkitchen.com/wp-content/uploads/2018/04/ATK-Roast-Halibut-scaled.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(25)
    expect(recipe.cook_time).to eq(35)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
