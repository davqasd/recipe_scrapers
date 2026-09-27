# frozen_string_literal: true

RSpec.describe "sharkninja.com" do
  subject(:recipe) { scrape_cassette("com/sharkninja", url: "https://www.sharkninja.com/deep-dish-sausage-pizza-with-mozzarella-crust/REC5249.html") }

  it "reads the title" do
    expect(recipe.title).to eq("Deep Dish Sausage Pizza with Mozzarella Crust")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups all-purpose flour",
      "2 cups bread flour",
      "3 tablespoons yellow cornmeal",
      "2 teaspoons kosher salt",
      "1 packet instant yeast (2 3/4 teaspoons)",
      "2 tablespoons olive oil",
      "4 tablespoons butter",
      "1 1/4 cups lukewarm water",
      "2 ounces shredded mozzarella cheese (divided)",
      "1 cup drained plum tomatoes, lightly crushed",
      "2 cloves garlic, crushed",
      "1 teaspoon sugar",
      "1 teaspoon Italian seasoning",
      "1/2 teaspoon kosher salt",
      "1/4 teaspoon crushed red pepper (optional)",
      "6 ounces sliced low-moisture mozzarella cheese",
      "4 ounces sweet or spicy Italian sausage, raw",
      "1/4 cup Parmesan cheese"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "all-purpose flour" },
      { amount: 2.0, unit: "cups", name: "bread flour" },
      { amount: 3.0, unit: "tablespoons", name: "yellow cornmeal" },
      { amount: 2.0, unit: "teaspoons", name: "kosher salt" },
      { amount: 1.0, unit: "packet", name: "instant yeast" },
      { amount: 2.0, unit: "tablespoons", name: "olive oil" },
      { amount: 4.0, unit: "tablespoons", name: "butter" },
      { amount: 1.25, unit: "cups", name: "lukewarm water" },
      { amount: 2.0, unit: "ounces", name: "shredded mozzarella cheese" },
      { amount: 1.0, unit: "cup", name: "drained plum tomatoes, lightly crushed" },
      { amount: 2.0, unit: "cloves", name: "garlic, crushed" },
      { amount: 1.0, unit: "teaspoon", name: "sugar" },
      { amount: 1.0, unit: "teaspoon", name: "Italian seasoning" },
      { amount: 0.5, unit: "teaspoon", name: "kosher salt" },
      { amount: 0.25, unit: "teaspoon", name: "crushed red pepper" },
      { amount: 6.0, unit: "ounces", name: "sliced low-moisture mozzarella cheese" },
      { amount: 4.0, unit: "ounces", name: "sweet or spicy Italian sausage, raw" },
      { amount: 0.25, unit: "cup", name: "Parmesan cheese" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In the bowl of a stand mixer, combine all ingredients except about 1/2 cup all-purpose flour.",
      "Mix on medium speed using the dough hook. When the mixture starts to come together, carefully add as much of the remaining flour as needed for the dough to come together and continue to mix until very smooth, about ten minutes.",
      "Add 1/4 cup water to the pot.",
      "Place an 8-inch circle of parchment paper in the bottom of the Cook & Crisp Basket.",
      "Divide the dough in 2 portions and save 1 in a sealable plastic bag in the refrigerator or freezer for another use.",
      "Place the other half in the Cook & Crisp Basket. Place the basket in the pot. Close the lid and move slider to AIR FRY/STOVETOP. Select PROOF, set temperature to 95°F, and set time for 30 minutes. Press START/STOP to begin the rise.",
      "Roll out dough to 12 inches in diameter.",
      "Sprinkle 1 ounce mozzarella cheese across the bottom of the 8 inch cake pan.",
      "Transfer dough to the pan, pressing dough up the sides of the pan.",
      "Sprinkle additional mozzarella cheese around the edge of the pan between the dough and the pan.",
      "Let dough rest while you assemble the remaining ingredients.",
      "Combine tomatoes, garlic, sugar, Italian seasoning, and salt.",
      "Sprinkle remaining mozzarella cheese on the dough.",
      "Sprinkle sausage evenly over the cheese in roughly 1 teaspoon pieces.",
      "Top sausage and cheese with tomato mixture and sprinkle Parmesan cheese over the top.",
      "Place the Deluxe Reversible Rack in the pot on the lower setting and place the pizza on top.",
      "Close the lid and move slider to STEAMCRISP. Select STEAM & CRISP, set temperature for 350°F, and set time to 20 minutes. Press START/STOP to begin cooking (PrE will display for approximately 5 minutes as the unit steams, then the timer will start counting down).",
      "When cooking is complete, remove the Deluxe Reversible Rack with pizza. Let cool 10 minutes before cutting into wedges."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In the bowl of a stand mixer, combine all ingredients except about 1/2 cup all-purpose flour.\nMix on medium speed using the dough hook. When the mixture starts to come together, carefully add as much of the remaining flour as needed for the dough to come together and continue to mix until very smooth, about ten minutes.\nAdd 1/4 cup water to the pot.\nPlace an 8-inch circle of parchment paper in the bottom of the Cook & Crisp Basket.\nDivide the dough in 2 portions and save 1 in a sealable plastic bag in the refrigerator or freezer for another use.\nPlace the other half in the Cook & Crisp Basket. Place the basket in the pot. Close the lid and move slider to AIR FRY/STOVETOP. Select PROOF, set temperature to 95°F, and set time for 30 minutes. Press START/STOP to begin the rise.\nRoll out dough to 12 inches in diameter.\nSprinkle 1 ounce mozzarella cheese across the bottom of the 8 inch cake pan.\nTransfer dough to the pan, pressing dough up the sides of the pan.\nSprinkle additional mozzarella cheese around the edge of the pan between the dough and the pan.\nLet dough rest while you assemble the remaining ingredients.\nCombine tomatoes, garlic, sugar, Italian seasoning, and salt.\nSprinkle remaining mozzarella cheese on the dough.\nSprinkle sausage evenly over the cheese in roughly 1 teaspoon pieces.\nTop sausage and cheese with tomato mixture and sprinkle Parmesan cheese over the top.\nPlace the Deluxe Reversible Rack in the pot on the lower setting and place the pizza on top.\nClose the lid and move slider to STEAMCRISP. Select STEAM & CRISP, set temperature for 350°F, and set time to 20 minutes. Press START/STOP to begin cooking (PrE will display for approximately 5 minutes as the unit steams, then the timer will start counting down).\nWhen cooking is complete, remove the Deluxe Reversible Rack with pizza. Let cool 10 minutes before cutting into wedges.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("sharkninja.com")
    expect(recipe.canonical_url).to eq("https://www.sharkninja.com/deep-dish-sausage-pizza-with-mozzarella-crust/REC5249.html")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("TIP:Use premade dough if desired. If making 2 pizzas, double all ingredients except the dough.")
    expect(recipe.image).to eq("https://assets.sharkninja.com/image/upload/f_auto/q_auto/recipes/Deep-Dish-Sausage-Pizza-with-Mozzarella-Crust.jpg")
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
    expect(recipe.links).to include("#maincontent")
  end
end
