# frozen_string_literal: true

RSpec.describe "40aprons.com" do
  subject(:recipe) { scrape_cassette("com/40aprons", url: "https://40aprons.com/rosemary-raspberry-vodka-fizz/") }

  it "reads the title" do
    expect(recipe.title).to eq("Raspberry Cocktails with Rosemary")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 tablespoon rosemary needles",
      "1 ½ cups frozen raspberries (defrosted)",
      "juice of 1 lemon (approximately 2 tablespoons)",
      "5 tablespoons sugar (¼ cup + 1 tablespoon)",
      "¾ cup water",
      "1 tablespoon cornstarch",
      "1 ½ ounces vodka (or gin)",
      "½ ounce St. Germaine elderflower liqueur",
      "1 ½ ounces raspberry-rosemary syrup (made from ingredients above)",
      "ice",
      "1 tablespoon soda water",
      "1 tablespoon champagne",
      "ice",
      "rosemary sprigs",
      "raspberries"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "tablespoon", name: "rosemary needles" },
      { amount: 1.5, unit: "cups", name: "frozen raspberries" },
      { amount: nil, unit: nil, name: "juice of 1 lemon" },
      { amount: 5.0, unit: "tablespoons", name: "sugar" },
      { amount: 0.75, unit: "cup", name: "water" },
      { amount: 1.0, unit: "tablespoon", name: "cornstarch" },
      { amount: 1.5, unit: "ounces", name: "vodka" },
      { amount: 0.5, unit: "ounce", name: "St. Germaine elderflower liqueur" },
      { amount: 1.5, unit: "ounces", name: "raspberry-rosemary syrup" },
      { amount: nil, unit: nil, name: "ice" },
      { amount: 1.0, unit: "tablespoon", name: "soda water" },
      { amount: 1.0, unit: "tablespoon", name: "champagne" },
      { amount: nil, unit: nil, name: "ice" },
      { amount: nil, unit: nil, name: "rosemary sprigs" },
      { amount: nil, unit: nil, name: "raspberries" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "For the Syrup (Makes Enough for 6-8 Cocktails)",
      "Add 1 tablespoon rosemary needles to small bowl. Muddle rosemary needles with muddler or back of wooden spoon to release oils.",
      "Place small saucepan on stovetop over high heat. Add muddled rosemary needles, 1 ½ cups frozen raspberries, juice of 1 lemon, 5 tablespoons sugar, ¾ cup water, and 1 tablespoon cornstarch to saucepan. Stir to incorporate, then bring mixture to rolling boil.",
      "When mixture begins to boil, immediately reduce heat under saucepan to low.",
      "Use potato masher to mash raspberries completely, then stir mixture and simmer 10 minutes.",
      "After 10 minutes, remove saucepan from heat and set aside. Let mixture cool completely.",
      "Once cooled, pour mixture through fine-mesh strainer or nut-milk bag and into airtight container. Use immediately or refrigerate until ready to use.",
      "For the Cocktail (Makes Enough for 1 Cocktail)",
      "Add 1 ½ ounces vodka (or gin), ½ ounce St. Germaine elderflower liqueur, 1 ½ ounces raspberry-rosemary syrup, and ice to cocktail shaker. Shake vigorously.",
      "Strain cocktail into glass, with or without ice. Add 1 tablespoon soda water and stir to incorporate into drink. Top cocktail with 1 tablespoon champagne, then garnish with rosemary sprigs and raspberries if desired. Serve immediately."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["For the Raspberry-Rosemary Syrup (Makes Enough for 6–8 Cocktails)", 6],
        ["For the Cocktail (Makes Enough for 1 Cocktail)", 6],
        ["Serving Suggestions (All Optional)", 3]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("For the Syrup (Makes Enough for 6-8 Cocktails)\nAdd 1 tablespoon rosemary needles to small bowl. Muddle rosemary needles with muddler or back of wooden spoon to release oils.\nPlace small saucepan on stovetop over high heat. Add muddled rosemary needles, 1 ½ cups frozen raspberries, juice of 1 lemon, 5 tablespoons sugar, ¾ cup water, and 1 tablespoon cornstarch to saucepan. Stir to incorporate, then bring mixture to rolling boil.\nWhen mixture begins to boil, immediately reduce heat under saucepan to low.\nUse potato masher to mash raspberries completely, then stir mixture and simmer 10 minutes.\nAfter 10 minutes, remove saucepan from heat and set aside. Let mixture cool completely.\nOnce cooled, pour mixture through fine-mesh strainer or nut-milk bag and into airtight container. Use immediately or refrigerate until ready to use.\nFor the Cocktail (Makes Enough for 1 Cocktail)\nAdd 1 ½ ounces vodka (or gin), ½ ounce St. Germaine elderflower liqueur, 1 ½ ounces raspberry-rosemary syrup, and ice to cocktail shaker. Shake vigorously.\nStrain cocktail into glass, with or without ice. Add 1 tablespoon soda water and stir to incorporate into drink. Top cocktail with 1 tablespoon champagne, then garnish with rosemary sprigs and raspberries if desired. Serve immediately.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("40aprons.com")
    expect(recipe.canonical_url).to eq("https://40aprons.com/rosemary-raspberry-vodka-fizz/")
    expect(recipe.site_name).to eq("40 Aprons")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Cheryl Malik")
    expect(recipe.description).to eq("A flavorful, vibrant cocktail blending fruity raspberry, woodsy rosemary, floral St. Germaine, and bubbly champagne.")
    expect(recipe.image).to eq("https://40aprons.com/wp-content/uploads/2015/12/raspberry-cocktails-rosemary-01.jpg")
    expect(recipe.category).to eq("Drinks")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("1 servings")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["christmas dinner", "holiday drink", "winter flavors"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 cocktail",
      "calories" => "357 kcal",
      "carbohydrateContent" => "36 g",
      "proteinContent" => "1 g",
      "fatContent" => "1 g",
      "saturatedFatContent" => "1 g",
      "sodiumContent" => "18 mg",
      "fiberContent" => "4 g",
      "sugarContent" => "30 g",
      "unsaturatedFatContent" => "2 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "cocktail", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 357.0 },
      { name: "carbohydrateContent", unit: "g", amount: 36.0 },
      { name: "proteinContent", unit: "g", amount: 1.0 },
      { name: "fatContent", unit: "g", amount: 1.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 18.0 },
      { name: "fiberContent", unit: "g", amount: 4.0 },
      { name: "sugarContent", unit: "g", amount: 30.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 2.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
