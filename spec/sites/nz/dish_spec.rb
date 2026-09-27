# frozen_string_literal: true

RSpec.describe "dish.co.nz" do
  subject(:recipe) { scrape_cassette("nz/dish", url: "https://www.dish.co.nz/recipes/lee-kum-kee-orange-honey-and-hot-chilli-soy-sauce-chicken-wings") }

  it "reads the title" do
    expect(recipe.title).to eq("Lee Kum Kee Orange, Honey and Hot Chilli Soy Sauce Chicken Wings")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "¼ cup cornflour",
      "1 medium egg white",
      "2 tablespoons Lee Kum Kee Hot Chilli Soy Sauce",
      "½ teaspoon cracked black pepper",
      "¼ teaspoon Chinese five spice",
      "1.25 kilograms chicken wings or nibbles",
      "neutral oil for cooking, e.g. canola",
      "¼ cup orange juice",
      "3 tablespoons runny honey",
      "1 tablespoon Lee Kum Kee Hot Chilli Soy Sauce",
      "1½ teaspoons cornflour",
      "1 teaspoon each rice wine vinegar, finely grated orange zest and finely grated fresh ginger",
      "2 cloves garlic, finely grated",
      "1 tablespoon sesame seeds, toasted"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.25, unit: "cup", name: "cornflour" },
      { amount: 1.0, unit: nil, name: "medium egg white" },
      { amount: 2.0, unit: "tablespoons", name: "Lee Kum Kee Hot Chilli Soy Sauce" },
      { amount: 0.5, unit: "teaspoon", name: "cracked black pepper" },
      { amount: 0.25, unit: "teaspoon", name: "Chinese five spice" },
      { amount: 1.25, unit: "kilograms", name: "chicken wings or nibbles" },
      { amount: nil, unit: nil, name: "neutral oil for cooking, e.g. canola" },
      { amount: 0.25, unit: "cup", name: "orange juice" },
      { amount: 3.0, unit: "tablespoons", name: "runny honey" },
      { amount: 1.0, unit: "tablespoon", name: "Lee Kum Kee Hot Chilli Soy Sauce" },
      { amount: 1.5, unit: "teaspoons", name: "cornflour" },
      { amount: 1.0, unit: "teaspoon", name: "each rice wine vinegar, finely grated orange zest and finely grated fresh ginger" },
      { amount: 2.0, unit: "cloves", name: "garlic, finely grated" },
      { amount: 1.0, unit: "tablespoon", name: "sesame seeds, toasted" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "EQUIPMENT: Line an oven tray with baking paper.",
      "Preheat the oven to 180°C fan bake.",
      "CHICKEN WINGS: Combine all the ingredients, except the wings and oil, in a large bowl. Add the chicken wings and toss to coat.",
      "Transfer the wings to the prepared tray and drizzle with a little oil. Bake for 25–28 minutes or until golden and cooked through (the cook time may vary depending on the size of the wings).",
      "ORANGE GLAZE: Put all the ingredients in a small pot and whisk together, making sure any cornflour lumps are mixed in. Bring to a simmer over a medium heat, whisking constantly for roughly 2 minutes or until the sauce has thickened.",
      "TO SERVE: Brush the glaze over the chicken wings and garnish with toasted sesame seeds before serving."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 7],
        ["ORANGE GLAZE", 6],
        ["TO SERVE", 1]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("EQUIPMENT: Line an oven tray with baking paper.\nPreheat the oven to 180°C fan bake.\nCHICKEN WINGS: Combine all the ingredients, except the wings and oil, in a large bowl. Add the chicken wings and toss to coat.\nTransfer the wings to the prepared tray and drizzle with a little oil. Bake for 25–28 minutes or until golden and cooked through (the cook time may vary depending on the size of the wings).\nORANGE GLAZE: Put all the ingredients in a small pot and whisk together, making sure any cornflour lumps are mixed in. Bring to a simmer over a medium heat, whisking constantly for roughly 2 minutes or until the sauce has thickened.\nTO SERVE: Brush the glaze over the chicken wings and garnish with toasted sesame seeds before serving.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("dish.co.nz")
    expect(recipe.canonical_url).to eq("https://dish.co.nz/recipes/lee-kum-kee-orange-honey-and-hot-chilli-soy-sauce-chicken-wings")
    expect(recipe.site_name).to eq("Dish")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Lee Kum Kee makes it easy to build flavour and elevate any dish.Hot and sweet is a classic flavour pairing, and one that works perfectly in Olivia Galletly's Orange, Honey and Hot Chilli Soy Sauce Chicken Wings. With a generous splash of Lee Kum Kee Hot Chilli Soy Sauce you’ve got the perfect recipe for finger lickin’ chicken!")
    expect(recipe.image).to eq("https://dish.co.nz/assets/Uploads/LKK-v3__FillWzc0MCwxMDA1XQ.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#0")
  end
end
