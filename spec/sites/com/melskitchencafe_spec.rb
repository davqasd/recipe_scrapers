# frozen_string_literal: true

RSpec.describe "melskitchencafe.com" do
  subject(:recipe) { scrape_cassette("com/melskitchencafe", url: "https://www.melskitchencafe.com/licorice-caramels/") }

  it "reads the title" do
    expect(recipe.title).to eq("Licorice Caramels")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1/2 cup water",
      "2 cups sugar",
      "1 (14-ounce) can sweetened condensed milk",
      "1 cup light corn syrup",
      "3/4 cup salted butter",
      "2 teaspoons anise extract (see note)",
      "1/2 teaspoon black food coloring paste (optional; see note)",
      "1/4 teaspoon vanilla extract",
      "1/4 teaspoon salt"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.5, unit: "cup", name: "water" },
      { amount: 2.0, unit: "cups", name: "sugar" },
      { amount: 1.0, unit: "can", name: "sweetened condensed milk" },
      { amount: 1.0, unit: "cup", name: "light corn syrup" },
      { amount: 0.75, unit: "cup", name: "salted butter" },
      { amount: 2.0, unit: "teaspoons", name: "anise extract" },
      { amount: 0.5, unit: "teaspoon", name: "black food coloring paste" },
      { amount: 0.25, unit: "teaspoon", name: "vanilla extract" },
      { amount: 0.25, unit: "teaspoon", name: "salt" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Lightly butter an 8X8- or 9X9-inch pan and set aside.",
      "In a heavy-bottomed 4-quart saucepan, combine the water, sugar, condensed milk, corn syrup, and butter. Bring the mixture to a boil over medium heat, stirring constantly with a heat-resistant rubber spatula. Clip a candy thermometer to the side of the pan, ensuring that the tip of the thermometer isn’t touching the bottom of the pan and is inserted at least 1-2 inches into the liquid (or according to your thermometer’s directions).",
      "Continue stirring gently while the mixture boils and cooks, until the caramels reach 242-244 degrees F. If the caramels seem to be scorching on the bottom of the pan, moderate the heat to a lower temperature. You can also test the caramels using a spoon and dropping a pea-sized amount of the hot caramel into cold water. If the cooled piece of caramel is firm but not hard, the caramel is properly cooked.",
      "Remove the pot from the heat and stir in the anise extract, food coloring, vanilla extract and salt. Pour the caramels into the prepared pan and allow to cool completely to room temperature, at least 2 hours.",
      "When cool, remove the sheet of caramels from the pan. Cut the caramels into pieces using a large knife or bench scraper. Wrap each caramel square in a bit of wax paper, twisting the ends to secure."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Lightly butter an 8X8- or 9X9-inch pan and set aside.\nIn a heavy-bottomed 4-quart saucepan, combine the water, sugar, condensed milk, corn syrup, and butter. Bring the mixture to a boil over medium heat, stirring constantly with a heat-resistant rubber spatula. Clip a candy thermometer to the side of the pan, ensuring that the tip of the thermometer isn’t touching the bottom of the pan and is inserted at least 1-2 inches into the liquid (or according to your thermometer’s directions).\nContinue stirring gently while the mixture boils and cooks, until the caramels reach 242-244 degrees F. If the caramels seem to be scorching on the bottom of the pan, moderate the heat to a lower temperature. You can also test the caramels using a spoon and dropping a pea-sized amount of the hot caramel into cold water. If the cooled piece of caramel is firm but not hard, the caramel is properly cooked.\nRemove the pot from the heat and stir in the anise extract, food coloring, vanilla extract and salt. Pour the caramels into the prepared pan and allow to cool completely to room temperature, at least 2 hours.\nWhen cool, remove the sheet of caramels from the pan. Cut the caramels into pieces using a large knife or bench scraper. Wrap each caramel square in a bit of wax paper, twisting the ends to secure.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("melskitchencafe.com")
    expect(recipe.canonical_url).to eq("https://www.melskitchencafe.com/licorice-caramels/")
    expect(recipe.site_name).to eq("Mel's Kitchen Cafe")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Mel")
    expect(recipe.description).to eq("You have got to try these homemade licorice caramels! Each bite is a creamy explosion of caramel with a subtle, delicious licorice tingle.")
    expect(recipe.image).to eq("https://www.melskitchencafe.com/wp-content/uploads/2013/12/licorice-caramels3.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("50 servings")
    expect(recipe.total_time).to eq(150)
    expect(recipe.prep_time).to eq(130)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.58)
    expect(recipe.ratings_count).to eq(54)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 Caramel",
      "calories" => "100 kcal",
      "carbohydrateContent" => "18 g",
      "proteinContent" => "1 g",
      "fatContent" => "3 g",
      "saturatedFatContent" => "2 g",
      "cholesterolContent" => "10 mg",
      "sodiumContent" => "50 mg",
      "sugarContent" => "18 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "Caramel", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 100.0 },
      { name: "carbohydrateContent", unit: "g", amount: 18.0 },
      { name: "proteinContent", unit: "g", amount: 1.0 },
      { name: "fatContent", unit: "g", amount: 3.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "cholesterolContent", unit: "mg", amount: 10.0 },
      { name: "sodiumContent", unit: "mg", amount: 50.0 },
      { name: "sugarContent", unit: "g", amount: 18.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
