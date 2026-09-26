# frozen_string_literal: true

RSpec.describe "cambreabakes.com" do
  subject(:recipe) { scrape_cassette("com/cambreabakes", url: "https://cambreabakes.com/oreo-brownies/") }

  it "reads the title" do
    expect(recipe.title).to eq("Oreo Brownies")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "10 tablespoons unsalted butter",
      "2/3 + 1/4 cup semi-sweet chocolate chips",
      "1/8 cup unsweetened Dutch cocoa powder",
      "1/8 cup black cocoa powder",
      "1/2 cup light or dark brown sugar (packed)",
      "1/2 cup granulated sugar",
      "2 large eggs",
      "1 large egg yolk",
      "1 tablespoon vanilla extract",
      "2/3 cup + 1 tablespoon all-purpose flour",
      "1 teaspoon espresso powder (optional)",
      "1/2 teaspoon fine sea salt",
      "16 Oreo cookies (for the center)",
      "1/3 cup chopped Oreo cookies (for the top)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 10.0, unit: "tablespoons", name: "unsalted butter" },
      { amount: 0.92, unit: "cup", name: "semi-sweet chocolate chips" },
      { amount: 0.13, unit: "cup", name: "unsweetened Dutch cocoa powder" },
      { amount: 0.13, unit: "cup", name: "black cocoa powder" },
      { amount: 0.5, unit: "cup", name: "light or dark brown sugar" },
      { amount: 0.5, unit: "cup", name: "granulated sugar" },
      { amount: 2.0, unit: nil, name: "large eggs" },
      { amount: 1.0, unit: nil, name: "large egg yolk" },
      { amount: 1.0, unit: "tablespoon", name: "vanilla extract" },
      { amount: 0.67, unit: "cup", name: "all-purpose flour" },
      { amount: 1.0, unit: "teaspoon", name: "espresso powder" },
      { amount: 0.5, unit: "teaspoon", name: "fine sea salt" },
      { amount: 16.0, unit: nil, name: "Oreo cookies" },
      { amount: 0.33, unit: "cup", name: "chopped Oreo cookies" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Line a square 8x8 baking pan with parchment paper to cover all four sides. Then preheat the oven to 350 F/180 C.",
      "Melt the butter and chocolate chips together until smooth. Then whisk in both cocoa powders. Set aside.",
      "Whisk the sugar, eggs, and vanilla extract until combined. Stream the melted chocolate mixture into the egg mixture until just combined.",
      "Fold in the flour, espresso powder, and salt until just combined. Then pour half of the brownie batter into the prepared baking pan (about 340 grams).",
      "Place the Oreo cookies on top of the batter, then spread the rest of the batter on top. Sprinkle the chopped Oreos over the top of the brownies. Then bake for 33-40 minutes, or until a toothpick inserted into the center comes out covered in a few moist crumbs.",
      "Let the baking pan cool on a wire rack compeltely before cutting into 16 squares. Enjoy!",
      "Store leftover brownies in an airtight container at room temperature for 2-3 days. You can also freeze the brownies after cutting in an airtight container or freezer bag for up to one month!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Line a square 8x8 baking pan with parchment paper to cover all four sides. Then preheat the oven to 350 F/180 C.\nMelt the butter and chocolate chips together until smooth. Then whisk in both cocoa powders. Set aside.\nWhisk the sugar, eggs, and vanilla extract until combined. Stream the melted chocolate mixture into the egg mixture until just combined.\nFold in the flour, espresso powder, and salt until just combined. Then pour half of the brownie batter into the prepared baking pan (about 340 grams).\nPlace the Oreo cookies on top of the batter, then spread the rest of the batter on top. Sprinkle the chopped Oreos over the top of the brownies. Then bake for 33-40 minutes, or until a toothpick inserted into the center comes out covered in a few moist crumbs.\nLet the baking pan cool on a wire rack compeltely before cutting into 16 squares. Enjoy!\nStore leftover brownies in an airtight container at room temperature for 2-3 days. You can also freeze the brownies after cutting in an airtight container or freezer bag for up to one month!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cambreabakes.com")
    expect(recipe.canonical_url).to eq("https://cambreabakes.com/oreo-brownies/")
    expect(recipe.site_name).to eq("Cambrea Bakes")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Cambrea Gordon")
    expect(recipe.description).to eq("These fudgy Oreo brownies are packed with Oreo cookies and have perfect crinkle tops—Oreo fans will love them!")
    expect(recipe.image).to eq("https://cambreabakes.com/wp-content/uploads/2023/07/oreo-brownies-featured.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("16 servings")
    expect(recipe.total_time).to eq(48)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(33)
    expect(recipe.keywords).to eq([
      "brownies with oreos",
      "cookies and cream brownies",
      "Oreo brownie bars",
      "oreo brownies",
      "Oreo cookie brownies",
      "Oreo topped brownies",
      "Ultimate oreo brownie"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(6)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 serving",
      "calories" => "195 kcal",
      "carbohydrateContent" => "23 g",
      "proteinContent" => "2 g",
      "fatContent" => "11 g",
      "saturatedFatContent" => "6 g",
      "transFatContent" => "0.3 g",
      "cholesterolContent" => "52 mg",
      "sodiumContent" => "131 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "19 g",
      "unsaturatedFatContent" => "5 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "serving", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 195.0 },
      { name: "carbohydrateContent", unit: "g", amount: 23.0 },
      { name: "proteinContent", unit: "g", amount: 2.0 },
      { name: "fatContent", unit: "g", amount: 11.0 },
      { name: "saturatedFatContent", unit: "g", amount: 6.0 },
      { name: "transFatContent", unit: "g", amount: 0.3 },
      { name: "cholesterolContent", unit: "mg", amount: 52.0 },
      { name: "sodiumContent", unit: "mg", amount: 131.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 19.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 5.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
