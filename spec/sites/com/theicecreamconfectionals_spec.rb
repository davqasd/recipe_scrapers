# frozen_string_literal: true

RSpec.describe "theicecreamconfectionals.com" do
  subject(:recipe) { scrape_cassette("com/theicecreamconfectionals", url: "https://theicecreamconfectionals.com/recipe/ninja-creami-black-forest-ice-cream/") }

  it "reads the title" do
    expect(recipe.title).to eq("Ninja Creami Black Forest Ice Cream")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 tbsp Cream Cheese",
      "1 tsp Vanilla Extract",
      "1/3 cup Granulated Sugar",
      "1 cup Whole Milk",
      "3/4 cup Heavy Cream",
      "1/2 cup Cherry Pie Filling",
      "1 tbsp Unsweetened Cocoa Powder",
      "1 tbsp Grenadine",
      "1 tbsp Captain Morgan Spiced Rum"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "tbsp", name: "Cream Cheese" },
      { amount: 1.0, unit: "tsp", name: "Vanilla Extract" },
      { amount: 0.33, unit: "cup", name: "Granulated Sugar" },
      { amount: 1.0, unit: "cup", name: "Whole Milk" },
      { amount: 0.75, unit: "cup", name: "Heavy Cream" },
      { amount: 0.5, unit: "cup", name: "Cherry Pie Filling" },
      { amount: 1.0, unit: "tbsp", name: "Unsweetened Cocoa Powder" },
      { amount: 1.0, unit: "tbsp", name: "Grenadine" },
      { amount: 1.0, unit: "tbsp", name: "Captain Morgan Spiced Rum" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Place 1 tbsp cream cheese in a medium bowl and microwave for 5-10 seconds. If the cream cheese was in the fridge, these 5-10 seconds in the microwave will help soften it up to mix well with the other ingredients.",
      "Combine cream cheese with 1 tsp vanilla extract, 1 tbsp unsweetened cocoa powder, 1 tbsp grenadine, 1 tbsp Captain Morgan Spiced Rum (optional to spike) and 1/3 cup granulated sugar. Whisk until the ingredients are mixed together.",
      "Whisk in 1/2 cup cherry pie filling.",
      "Slowly whisk in 1 cup whole milk and 3/4 cup heavy cream.",
      "Pour the mixture into a Ninja Creami pint container, ensuring it does not go over the max fill line. There will probably be more ice cream mixture than needed, so dispose of the rest (or save it for next time) after filling the pint to the fill line.",
      "Freeze the pint for 24 hours, ensuring it is placed on a flat surface in the freezer.",
      "After 24 hours, remove the pint from the freezer, and plug in your Ninja Creami machine! Time for the magic. Remove the lid from the pint and grab the Ninja Creami outer bowl. Place the pint securely into the outer bowl and cover with the lid. Once the lid is on, place the outer bowl into the machine, twisting to the right until it locks into place. Press the \"Ice Cream\" button and (try to) wait patiently for the creamy treat coming your way.",
      "Once the process is finished, press and hold the button on the left side of the Creami to twist the bowl to the left and remove it from the machine. Twist the lid off of the outer bowl and remove the pint.",
      "Now your black forest ice cream is ready to enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Place 1 tbsp cream cheese in a medium bowl and microwave for 5-10 seconds. If the cream cheese was in the fridge, these 5-10 seconds in the microwave will help soften it up to mix well with the other ingredients.\nCombine cream cheese with 1 tsp vanilla extract, 1 tbsp unsweetened cocoa powder, 1 tbsp grenadine, 1 tbsp Captain Morgan Spiced Rum (optional to spike) and 1/3 cup granulated sugar. Whisk until the ingredients are mixed together.\nWhisk in 1/2 cup cherry pie filling.\nSlowly whisk in 1 cup whole milk and 3/4 cup heavy cream.\nPour the mixture into a Ninja Creami pint container, ensuring it does not go over the max fill line. There will probably be more ice cream mixture than needed, so dispose of the rest (or save it for next time) after filling the pint to the fill line.\nFreeze the pint for 24 hours, ensuring it is placed on a flat surface in the freezer.\nAfter 24 hours, remove the pint from the freezer, and plug in your Ninja Creami machine! Time for the magic. Remove the lid from the pint and grab the Ninja Creami outer bowl. Place the pint securely into the outer bowl and cover with the lid. Once the lid is on, place the outer bowl into the machine, twisting to the right until it locks into place. Press the \"Ice Cream\" button and (try to) wait patiently for the creamy treat coming your way.\nOnce the process is finished, press and hold the button on the left side of the Creami to twist the bowl to the left and remove it from the machine. Twist the lid off of the outer bowl and remove the pint.\nNow your black forest ice cream is ready to enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("theicecreamconfectionals.com")
    expect(recipe.canonical_url).to eq("https://theicecreamconfectionals.com/recipe/ninja-creami-black-forest-ice-cream/")
    expect(recipe.site_name).to eq("The Ice Cream Confectionals")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("theicecreamconfectionals")
    expect(recipe.description).to eq("Black forest ice cream is based on the classic black forest cake. The cherry and chocolate flavors (plus a pop of rum) combine for a decadent and delicious ice cream! To make this recipe in the Ninja Creami Deluxe, multiply all ingredients by 1.5 Note: 1 serving = 1 pint")
    expect(recipe.image).to eq("https://i0.wp.com/theicecreamconfectionals.com/wp-content/uploads/2022/07/Black-Forest-Cake-Ice-Cream.jpg?resize=500%2C500&ssl=1")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("Boozy Ice Cream")
    expect(recipe.cooking_method).to eq("Ninja Creami")
    expect(recipe.yields).to eq("1 servings")
    expect(recipe.total_time).to eq(1455)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(5)
    expect(recipe.keywords).to eq([
      "ninja creami",
      "ice cream",
      "ice cream recipes",
      "black forest ice cream",
      "ninja creami recipes dairy free",
      "ninja creami recipes healthy",
      "ninja creami recipe book",
      "ninja creami recipes vegan",
      "ninja creami base recipe",
      "ninja creami recipe book pdf",
      "ninja creami recipes pdf",
      "black forest ice cream recipe",
      "ninja creami black forest",
      "ninja creami black forest ice cream",
      "ninja creami black forest ice cream recipe",
      "ninja creami recipe",
      "ninja cream ice cream recipes",
      "ninja creamy",
      "best ninja creami recipes",
      "recipes for ninja creami",
      "ice cream recipes for ninja creami",
      "ninja creami pints",
      "ninja creami dairy-free",
      "ninja creami dairy free",
      "ninja creami dairy free recipes",
      "creami ninja recipes",
      "ninja creami frozen treat maker recipes",
      "ninja creami recipes",
      "recipes ninja creami",
      "ice cream ninja",
      "ninja cream",
      "ice cream ninja",
      "ninja ice cream",
      "ninja creamy ice cream maker",
      "ninja creami frozen treat maker",
      "ninja creami ice cream recipes",
      "ninja ice cream maker recipes",
      "ninja creami gelato recipes",
      "ninja creami gelato",
      "gelato recipes for ninja creami",
      "gelato ninja creami",
      "creami gelato recipes",
      "boozy ice cream recipes",
      "ninja creami boozy recipes",
      "ninja creami boozy ice cream recipes",
      "ninja creami alcohol recipes",
      "alcohol in ninja creami",
      "alcohol recipes ninja creami",
      "alcohol ice cream recipes ninja creami",
      "black forest cake ice cream",
      "ninja creami black forest cake",
      "ninja creami black forest cake ice cream",
      "ninja creami i c e cream recipes",
      "ninja creami deluxe recipes",
      "ninja creami recipes non dairy",
      "ninja creami 11 in 1 recipes",
      "healthy ninja creami recipes",
      "easy ninja creami recipes",
      "ninja creami cherry",
      "ninja creami cherry ice cream"
    ])
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
    expect(recipe.links).to include("#content")
  end
end
