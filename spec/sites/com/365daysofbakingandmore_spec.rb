# frozen_string_literal: true

RSpec.describe "365daysofbakingandmore.com" do
  subject(:recipe) { scrape_cassette("com/365daysofbakingandmore", url: "https://www.365daysofbakingandmore.com/chocolate-pizzelle-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Chocolate Pizzelle Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 large eggs (room temperature)",
      "3/4 cup granulated sugar",
      "3 tablespoons granulated sugar",
      "3/4 cup unsalted butter (melted and completely cooled)",
      "1/4 teaspoon pure vanilla extract",
      "2 cups all-purpose flour",
      "3 tablespoons unsweetened cocoa powder",
      "2 teaspoons baking powder",
      "1/4 teaspoon cinnamon",
      "pinch of kosher salt",
      "powdered sugar for dusting (optional )"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: nil, name: "large eggs" },
      { amount: 0.75, unit: "cup", name: "granulated sugar" },
      { amount: 3.0, unit: "tablespoons", name: "granulated sugar" },
      { amount: 0.75, unit: "cup", name: "unsalted butter" },
      { amount: 0.25, unit: "teaspoon", name: "pure vanilla extract" },
      { amount: 2.0, unit: "cups", name: "all-purpose flour" },
      { amount: 3.0, unit: "tablespoons", name: "unsweetened cocoa powder" },
      { amount: 2.0, unit: "teaspoons", name: "baking powder" },
      { amount: 0.25, unit: "teaspoon", name: "cinnamon" },
      { amount: 1.0, unit: "pinch", name: "kosher salt" },
      { amount: nil, unit: nil, name: "powdered sugar for dusting" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Melt butter and set aside to cool completely. Preheat the pizzelle Iron and spray with cooking spray, if needed. *See Note.",
      "In a medium bowl, whisk together the flour, unsweetened cocoa, baking powder, cinnamon and salt.",
      "In a large mixing bowl, beat the 4 eggs, 3/4 cup sugar, and 3 tablespoons sugar until light in color, about 3 minutes. Add the cooled 3/4 cup melted butter, 1/4 teaspoon vanilla, and mix well.",
      "Add half of the dry ingredients to the wet, and mix until just blended. Fold in the remaining flour mixture and combine until just mixed.",
      "Drop batter by heaping tablespoonfuls into the center of pizzelle pattern and close. Bake for about 1 - 1 ½ minutes or until golden. Times will vary depending on the pizzelle iron you are using.",
      "Carefully remove with a spatula and place on a wire rack to cool completely before dusting with powdered sugar."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Melt butter and set aside to cool completely. Preheat the pizzelle Iron and spray with cooking spray, if needed. *See Note.\nIn a medium bowl, whisk together the flour, unsweetened cocoa, baking powder, cinnamon and salt.\nIn a large mixing bowl, beat the 4 eggs, 3/4 cup sugar, and 3 tablespoons sugar until light in color, about 3 minutes. Add the cooled 3/4 cup melted butter, 1/4 teaspoon vanilla, and mix well.\nAdd half of the dry ingredients to the wet, and mix until just blended. Fold in the remaining flour mixture and combine until just mixed.\nDrop batter by heaping tablespoonfuls into the center of pizzelle pattern and close. Bake for about 1 - 1 ½ minutes or until golden. Times will vary depending on the pizzelle iron you are using.\nCarefully remove with a spatula and place on a wire rack to cool completely before dusting with powdered sugar.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("365daysofbakingandmore.com")
    expect(recipe.canonical_url).to eq("https://www.365daysofbakingandmore.com/chocolate-pizzelle-recipe/")
    expect(recipe.site_name).to eq("365 Days of Baking and More")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Lynne")
    expect(recipe.description).to eq("This Chocolate Pizzelle Recipe is a twist on the classic Italian cookies. This delicate cookie is easy to make with a pizzelle iron and is a beautiful addition to any cookie tray or special occasion.")
    expect(recipe.image).to eq("https://www.365daysofbakingandmore.com/wp-content/uploads/2025/12/Chocolate-Pizzelles-13.jpg")
    expect(recipe.category).to eq("Cookies")
    expect(recipe.cuisine).to eq("Italian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("39 servings")
    expect(recipe.total_time).to eq(11)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(1)
    expect(recipe.keywords).to eq(["Chocolate Pizzelle Recipe"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 cookie",
      "calories" => "82 kcal",
      "carbohydrateContent" => "10 g",
      "proteinContent" => "1 g",
      "fatContent" => "4 g",
      "saturatedFatContent" => "2 g",
      "transFatContent" => "0.1 g",
      "cholesterolContent" => "28 mg",
      "sodiumContent" => "8 mg",
      "fiberContent" => "0.3 g",
      "sugarContent" => "5 g",
      "unsaturatedFatContent" => "1.3 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "cookie", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 82.0 },
      { name: "carbohydrateContent", unit: "g", amount: 10.0 },
      { name: "proteinContent", unit: "g", amount: 1.0 },
      { name: "fatContent", unit: "g", amount: 4.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "transFatContent", unit: "g", amount: 0.1 },
      { name: "cholesterolContent", unit: "mg", amount: 28.0 },
      { name: "sodiumContent", unit: "mg", amount: 8.0 },
      { name: "fiberContent", unit: "g", amount: 0.3 },
      { name: "sugarContent", unit: "g", amount: 5.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 1.3 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
