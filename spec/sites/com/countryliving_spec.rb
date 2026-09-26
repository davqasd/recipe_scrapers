# frozen_string_literal: true

RSpec.describe "countryliving.com" do
  subject(:recipe) { scrape_cassette("com/countryliving", url: "https://www.countryliving.com/food-drinks/a41319911/honey-apple-baked-brie-with-fried-sage-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Honey-Apple Baked Brie with Fried Sage")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 (8-ounce) wheel Brie",
      "1/2 sheet all-butter puff pastry (such as Dufour), thawed",
      "2 tbsp. apple butter",
      "1 tbsp. pure honey",
      "1 large egg, beaten",
      "2 tbsp. unsalted butter",
      "4 tsp. pure maple syrup",
      "1 Honeycrisp apple, sliced",
      "Canola oil, for frying",
      "12 fresh sage leaves",
      "Kosher salt",
      "Crackers, for serving"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "wheel Brie" },
      { amount: 0.5, unit: "sheet", name: "all-butter puff pastry, thawed" },
      { amount: 2.0, unit: "tbsp", name: "apple butter" },
      { amount: 1.0, unit: "tbsp", name: "pure honey" },
      { amount: 1.0, unit: nil, name: "large egg, beaten" },
      { amount: 2.0, unit: "tbsp", name: "unsalted butter" },
      { amount: 4.0, unit: "tsp", name: "pure maple syrup" },
      { amount: 1.0, unit: nil, name: "Honeycrisp apple, sliced" },
      { amount: nil, unit: nil, name: "Canola oil, for frying" },
      { amount: 12.0, unit: nil, name: "fresh sage leaves" },
      { amount: nil, unit: nil, name: "Kosher salt" },
      { amount: nil, unit: nil, name: "Crackers, for serving" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 425°F. Line a rimmed baking sheet with parchment paper. Place cheese on puff pastry and cut off top rind. Top with apple butter and honey. Fold pastry up around cheese, pinching to seal. Place on prepared baking sheet; brush with egg. Bake until golden brown, 20 to 25 minutes.",
      "Meanwhile, melt butter and syrup in a large skillet over medium heat. Add apples and cook, stirring occasionally, until soft, 9 to 11 minutes. Transfer to a bowl; clean out skillet.",
      "Line a plate with paper towels. Heat 1/8 inch oil in skillet over medium-high heat. Add sage and press into oil to fully coat. Fry just until leaves are crisp, 10 to 20 seconds. Transfer to prepared plate. Season with salt.",
      "Transfer Brie to a serving plate and top with apples and sage. Serve with crackers alongside."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 425°F. Line a rimmed baking sheet with parchment paper. Place cheese on puff pastry and cut off top rind. Top with apple butter and honey. Fold pastry up around cheese, pinching to seal. Place on prepared baking sheet; brush with egg. Bake until golden brown, 20 to 25 minutes.\nMeanwhile, melt butter and syrup in a large skillet over medium heat. Add apples and cook, stirring occasionally, until soft, 9 to 11 minutes. Transfer to a bowl; clean out skillet.\nLine a plate with paper towels. Heat 1/8 inch oil in skillet over medium-high heat. Add sage and press into oil to fully coat. Fry just until leaves are crisp, 10 to 20 seconds. Transfer to prepared plate. Season with salt.\nTransfer Brie to a serving plate and top with apples and sage. Serve with crackers alongside.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("countryliving.com")
    expect(recipe.canonical_url).to eq("https://www.countryliving.com/food-drinks/a41319911/honey-apple-baked-brie-with-fried-sage-recipe/")
    expect(recipe.site_name).to eq("Country Living")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Christopher Michel")
    expect(recipe.description).to eq("This elegant appetizer is a sure-fire way to treat your guests.")
    expect(recipe.image).to eq("https://hips.hearstapps.com/hmg-prod/images/honey-apple-baked-brie-with-fried-sage-1663854012.jpg?crop=1.00xw:0.803xh;0,0.177xh&resize=1200:*")
    expect(recipe.category).to eq("autumn")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(35)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["appetizers", "autumn", "cocktail party"])
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
    expect(recipe.links).to include("/search/")
  end
end
