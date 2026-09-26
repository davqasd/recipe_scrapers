# frozen_string_literal: true

RSpec.describe "cookfastrecipes.com" do
  subject(:recipe) { scrape_cassette("com/cookfastrecipes", url: "https://www.cookfastrecipes.com/easy-cute-ice-cream-designs/") }

  it "reads the title" do
    expect(recipe.title).to eq("Homemade Rocky Road Ice Cream")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 large egg yolks",
      "1/2 cup granulated sugar",
      "2 tablespoons unsweetened cocoa powder",
      "1/2 teaspoon Morton kosher salt",
      "1 1/2 cups whole milk, divided use",
      "4 ounces semisweet chocolate, roughly chopped or chips",
      "1 1/2 cups heavy cream",
      "1 teaspoon pure vanilla extract",
      "1/2 cup sliced, toasted almonds",
      "1 cup plant based mini marshmallows",
      "1/3 cup chocolate shavings"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: nil, name: "large egg yolks" },
      { amount: 0.5, unit: "cup", name: "granulated sugar" },
      { amount: 2.0, unit: "tablespoons", name: "unsweetened cocoa powder" },
      { amount: 0.5, unit: "teaspoon", name: "Morton kosher salt" },
      { amount: 1.5, unit: "cups", name: "whole milk, divided use" },
      { amount: 4.0, unit: "ounces", name: "semisweet chocolate, roughly chopped or chips" },
      { amount: 1.5, unit: "cups", name: "heavy cream" },
      { amount: 1.0, unit: "teaspoon", name: "pure vanilla extract" },
      { amount: 0.5, unit: "cup", name: "sliced, toasted almonds" },
      { amount: 1.0, unit: "cup", name: "plant based mini marshmallows" },
      { amount: 0.33, unit: "cup", name: "chocolate shavings" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Start by chilling your ice cream machine bowl according to the manufacturer's instructions until it is very well frozen.",
      "In a heatproof medium sized bowl, whisk together the egg yolks, granulated sugar, cocoa powder, and salt. Add 1/4 cup of the whole milk and whisk until the mixture is well combined and smooth.",
      "Pour the remaining 1 1/4 cups of milk into a medium saucepan and place it over medium heat until it is just steaming. Do not let it boil.",
      "Slowly drizzle the warm milk into the egg yolk mixture, whisking constantly. This tempers the eggs to prevent them from scrambling.",
      "Pour the tempered mixture back into the saucepan. Stir constantly over medium-low heat for about 5 minutes, until it thickens into a custard that coats the back of a wooden spoon.",
      "Pour the custard through a fine mesh sieve into a clean bowl. Add the chopped chocolate and whisk until it's fully melted and smooth. Whisk in the heavy cream and vanilla.",
      "Place plastic wrap directly on the surface of the custard base to prevent a skin from forming. Chill in the refrigerator for at least 4 hours, or overnight, until very cold.",
      "Churn the cold custard base in your ice cream maker according to its instructions, typically for about 20 minutes, until it reaches a soft-serve consistency. Gently fold in the almonds, mini marshmallows, and chocolate shavings.",
      "Transfer the ice cream to a large loaf pan or airtight container. Wrap tightly with plastic wrap and freeze for at least 4 hours, or until firm. Scoop and enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Start by chilling your ice cream machine bowl according to the manufacturer's instructions until it is very well frozen.\nIn a heatproof medium sized bowl, whisk together the egg yolks, granulated sugar, cocoa powder, and salt. Add 1/4 cup of the whole milk and whisk until the mixture is well combined and smooth.\nPour the remaining 1 1/4 cups of milk into a medium saucepan and place it over medium heat until it is just steaming. Do not let it boil.\nSlowly drizzle the warm milk into the egg yolk mixture, whisking constantly. This tempers the eggs to prevent them from scrambling.\nPour the tempered mixture back into the saucepan. Stir constantly over medium-low heat for about 5 minutes, until it thickens into a custard that coats the back of a wooden spoon.\nPour the custard through a fine mesh sieve into a clean bowl. Add the chopped chocolate and whisk until it's fully melted and smooth. Whisk in the heavy cream and vanilla.\nPlace plastic wrap directly on the surface of the custard base to prevent a skin from forming. Chill in the refrigerator for at least 4 hours, or overnight, until very cold.\nChurn the cold custard base in your ice cream maker according to its instructions, typically for about 20 minutes, until it reaches a soft-serve consistency. Gently fold in the almonds, mini marshmallows, and chocolate shavings.\nTransfer the ice cream to a large loaf pan or airtight container. Wrap tightly with plastic wrap and freeze for at least 4 hours, or until firm. Scoop and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cookfastrecipes.com")
    expect(recipe.canonical_url).to eq("https://www.cookfastrecipes.com/easy-cute-ice-cream-designs/")
    expect(recipe.site_name).to eq("Cook Fast Recipes")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Mateo Ramirez")
    expect(recipe.description).to eq("This no-fuss homemade Rocky Road ice cream is incredibly tasty and photogenic. A rich, creamy chocolate custard base loaded with toasted almonds, soft marshmallows, and chocolate shavings makes for a comforting family-friendly dessert.")
    expect(recipe.image).to eq("https://www.cookfastrecipes.com/wp-content/uploads/2026/01/easy-cute-ice-cream-aesthetic-designs-1-1.webp")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("1 items")
    expect(recipe.total_time).to eq(520)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1/2 cup",
      "calories" => "350 calories",
      "fatContent" => "20g fat",
      "saturatedFatContent" => "10g saturated fat",
      "carbohydrateContent" => "38g carbs",
      "sugarContent" => "30g sugar",
      "fiberContent" => "2g fiber",
      "proteinContent" => "5g protein",
      "sodiumContent" => "150mg sodium"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "cup", amount: 0.5 },
      { name: "calories", unit: "kcal", amount: 350.0 },
      { name: "fatContent", unit: "g", amount: 20.0 },
      { name: "saturatedFatContent", unit: "g", amount: 10.0 },
      { name: "carbohydrateContent", unit: "g", amount: 38.0 },
      { name: "sugarContent", unit: "g", amount: 30.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "proteinContent", unit: "g", amount: 5.0 },
      { name: "sodiumContent", unit: "mg", amount: 150.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
