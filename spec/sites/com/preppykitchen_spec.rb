# frozen_string_literal: true

RSpec.describe "preppykitchen.com" do
  subject(:recipe) { scrape_cassette("com/preppykitchen", url: "https://preppykitchen.com/rocky-road-cookies/") }

  it "reads the title" do
    expect(recipe.title).to eq("Rocky Road Cookies Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1⅔ cups all-purpose flour (200g)",
      "½ cup cocoa powder (50g)",
      "1 teaspoon baking soda",
      "½ teaspoon salt",
      "¾ cup unsalted butter (softened (168g))",
      "¾ cup light brown sugar (165g)",
      "⅓ cup granulated sugar (66g)",
      "1 large egg (room temperature)",
      "2 teaspoons vanilla extract",
      "1 cup mini marshmallows (divided (56g))",
      "¾ cup semi-sweet chocolate chips (135g)",
      "½ cup almonds (chopped (75g))"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.67, unit: "cups", name: "all-purpose flour" },
      { amount: 0.5, unit: "cup", name: "cocoa powder" },
      { amount: 1.0, unit: "teaspoon", name: "baking soda" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 0.75, unit: "cup", name: "unsalted butter" },
      { amount: 0.75, unit: "cup", name: "light brown sugar" },
      { amount: 0.33, unit: "cup", name: "granulated sugar" },
      { amount: 1.0, unit: nil, name: "large egg" },
      { amount: 2.0, unit: "teaspoons", name: "vanilla extract" },
      { amount: 1.0, unit: "cup", name: "mini marshmallows" },
      { amount: 0.75, unit: "cup", name: "semi-sweet chocolate chips" },
      { amount: 0.5, unit: "cup", name: "almonds" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 350°F.",
      "In a medium mixing bowl, whisk to combine the flour, cocoa powder, baking soda and salt.",
      "In the bowl of a stand mixer fitted with the paddle attachment (or in a large bowl, using a handheld electric mixer), cream the butter, light brown sugar, and granulated sugars on medium speed for about 3 minutes until lightened in color and fluffy.",
      "Add the egg and vanilla and mix for 30 seconds, just until combined.",
      "Add the flour mixture in three parts, mixing on low speed just until combined between each addition. WIth a spatula, fold in ¾ cup of the marshmallows (40g), the chocolate chips and almonds.",
      "Scoop 1½ tablespoon-sized cookies (about 32g each) with a triggered cookie scoop or two spoons, onto parchment lined baking sheets, leaving about 2 inches of space between each cookie. Gently press 2 to 3 of the remaining ¼ cup of marshmallows (16g) into the top of each cookie.",
      "Bake for 8 to 10 minutes or until the edges are set and the tops appear dry. Let cool on the pan for 5 minutes, then transfer to a cooling rack to cool completely."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 350°F.\nIn a medium mixing bowl, whisk to combine the flour, cocoa powder, baking soda and salt.\nIn the bowl of a stand mixer fitted with the paddle attachment (or in a large bowl, using a handheld electric mixer), cream the butter, light brown sugar, and granulated sugars on medium speed for about 3 minutes until lightened in color and fluffy.\nAdd the egg and vanilla and mix for 30 seconds, just until combined.\nAdd the flour mixture in three parts, mixing on low speed just until combined between each addition. WIth a spatula, fold in ¾ cup of the marshmallows (40g), the chocolate chips and almonds.\nScoop 1½ tablespoon-sized cookies (about 32g each) with a triggered cookie scoop or two spoons, onto parchment lined baking sheets, leaving about 2 inches of space between each cookie. Gently press 2 to 3 of the remaining ¼ cup of marshmallows (16g) into the top of each cookie.\nBake for 8 to 10 minutes or until the edges are set and the tops appear dry. Let cool on the pan for 5 minutes, then transfer to a cooling rack to cool completely.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("preppykitchen.com")
    expect(recipe.canonical_url).to eq("https://preppykitchen.com/rocky-road-cookies/")
    expect(recipe.site_name).to eq("Preppy Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("John Kanell")
    expect(recipe.description).to eq("Rocky Road Cookies with gooey marshmallows, melty chocolate chips, and crunchy nuts are about to be your new favorite treat!")
    expect(recipe.image).to eq("https://preppykitchen.com/wp-content/uploads/2024/12/Rocky-Road-Cookies-Recipe-Card.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("28 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq([
      "how to make rocky road cookies",
      "rocky road cookies",
      "rocky road cookies recipe"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "157 kcal",
      "carbohydrateContent" => "19 g",
      "proteinContent" => "2 g",
      "fatContent" => "9 g",
      "saturatedFatContent" => "4 g",
      "transFatContent" => "0.2 g",
      "cholesterolContent" => "20 mg",
      "sodiumContent" => "88 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "11 g",
      "unsaturatedFatContent" => "4 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 157.0 },
      { name: "carbohydrateContent", unit: "g", amount: 19.0 },
      { name: "proteinContent", unit: "g", amount: 2.0 },
      { name: "fatContent", unit: "g", amount: 9.0 },
      { name: "saturatedFatContent", unit: "g", amount: 4.0 },
      { name: "transFatContent", unit: "g", amount: 0.2 },
      { name: "cholesterolContent", unit: "mg", amount: 20.0 },
      { name: "sodiumContent", unit: "mg", amount: 88.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 11.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 4.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#body")
  end
end
