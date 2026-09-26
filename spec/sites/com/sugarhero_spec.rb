# frozen_string_literal: true

RSpec.describe "sugarhero.com" do
  subject(:recipe) { scrape_cassette("com/sugarhero", url: "https://www.sugarhero.com/christmas-pinwheel-cookies/") }

  it "reads the title" do
    expect(recipe.title).to eq("Christmas Pinwheel Cookies")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "12.75 oz all-purpose flour (3 cups)",
      "1 tsp baking powder",
      "½ tsp salt",
      "8 oz unsalted butter ((1 cup), at room temperature)",
      "8.75 oz granulated sugar (1.25 cups)",
      "1 large egg (at room temperature)",
      "2 tsp vanilla extract",
      "Red and green food coloring (I used Americolor gel colors)",
      "6.75 oz sprinkles (1 cup)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 12.75, unit: "oz", name: "all-purpose flour" },
      { amount: 1.0, unit: "tsp", name: "baking powder" },
      { amount: 0.5, unit: "tsp", name: "salt" },
      { amount: 8.0, unit: "oz", name: "unsalted butter" },
      { amount: 8.75, unit: "oz", name: "granulated sugar" },
      { amount: 1.0, unit: nil, name: "large egg" },
      { amount: 2.0, unit: "tsp", name: "vanilla extract" },
      { amount: nil, unit: nil, name: "Red and green food coloring" },
      { amount: 6.75, unit: "oz", name: "sprinkles" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Whisk together the flour, baking powder, and salt in a medium bowl, and set aside temporarily.",
      "Combine the butter and granulated sugar in the bowl of a large stand mixer fitted with a paddle attachment. Mix the butter and sugar together at medium speed for 2-3 minutes until light and fluffy.",
      "Turn the mixer to low, add the egg and vanilla extract, and mix until well-incorporated.",
      "With the mixer stil on low speed, slowly add the flour and mix until just a few streaks of flour remain. Stop the mixer, and finish scraping down the bottom and sides of the bowl with a rubber spatula. The dough should be soft and supple but not sticky.",
      "Divide the dough into 3 equal parts. If you have a kitchen scale, each portion should be approximately 10 ounces.",
      "Leave one portion uncolored, and use gel food coloring to color the other two portions red and green. You can stir the food coloring in by hand, knead it in like bread dough, or mix it in using the mixer. (If you use the mixer, keep a close eye on the dough and run it for a short time so the dough doesn’t get overmixed and tough.)",
      "Form each color into a disc and wrap them tightly in plastic wrap. Refrigerate for at least 45 minutes, until firm.",
      "Roll each color out between two sheets of parchment to a long rectangle, approximately 6 x 13” long. Try to avoid adding additional flour at this step, or else the cookies might be tough. If the dough starts to feel too soft to work with at any point in the rolling/stacking process, chill it again in the refrigerator until you can work with it easily.",
      "Stack the dough rectangles on top of each other in this order: green, white, then red on top. Roll the dough up into a long, tight spiral.",
      "To roll the edges in sprinkles, brush the outside of the dough log with a very thin layer of corn syrup - you just want enough to make the sprinkles stick. Scatter the sprinkles on a baking sheet, and roll the log around the sprinkles, pressing it into the sprinkles so they adhere and it is completely covered. You can also skip this step and leave the edges plain.",
      "Wrap the dough log in plastic wrap, and refrigerate for at least 45 minutes, or until firm.",
      "Preheat the oven to 350 F, and cover 2 baking sheets with parchment.",
      "Use a large, sharp chef’s knife to slice the log into rounds a little under ½” thick. (You can do thinner, ¼” rounds for a larger yield.) Place them on the baking sheets with a few inches between each cookie.",
      "Bake the cookies for 13-15 minutes, until they have spread and puffed, and no longer have a raw shine in the center. They will continue to cook for a few minutes after they’re out of the oven, so don’t wait until they feel firm in the center or they will be overcooked. The perfect pinwheel cookie is crunchy around the edges and soft and tender on the inside!",
      "Once cool, remove from the baking sheets and enjoy! Pinwheel cookies can be stored in an airtight container at room temperature and should be enjoyed within 4-5 days for maximum freshness. Unbaked cookies can be frozen, well-wrapped, for up to 3 months."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Whisk together the flour, baking powder, and salt in a medium bowl, and set aside temporarily.\nCombine the butter and granulated sugar in the bowl of a large stand mixer fitted with a paddle attachment. Mix the butter and sugar together at medium speed for 2-3 minutes until light and fluffy.\nTurn the mixer to low, add the egg and vanilla extract, and mix until well-incorporated.\nWith the mixer stil on low speed, slowly add the flour and mix until just a few streaks of flour remain. Stop the mixer, and finish scraping down the bottom and sides of the bowl with a rubber spatula. The dough should be soft and supple but not sticky.\nDivide the dough into 3 equal parts. If you have a kitchen scale, each portion should be approximately 10 ounces.\nLeave one portion uncolored, and use gel food coloring to color the other two portions red and green. You can stir the food coloring in by hand, knead it in like bread dough, or mix it in using the mixer. (If you use the mixer, keep a close eye on the dough and run it for a short time so the dough doesn’t get overmixed and tough.)\nForm each color into a disc and wrap them tightly in plastic wrap. Refrigerate for at least 45 minutes, until firm.\nRoll each color out between two sheets of parchment to a long rectangle, approximately 6 x 13” long. Try to avoid adding additional flour at this step, or else the cookies might be tough. If the dough starts to feel too soft to work with at any point in the rolling/stacking process, chill it again in the refrigerator until you can work with it easily.\nStack the dough rectangles on top of each other in this order: green, white, then red on top. Roll the dough up into a long, tight spiral.\nTo roll the edges in sprinkles, brush the outside of the dough log with a very thin layer of corn syrup - you just want enough to make the sprinkles stick. Scatter the sprinkles on a baking sheet, and roll the log around the sprinkles, pressing it into the sprinkles so they adhere and it is completely covered. You can also skip this step and leave the edges plain.\nWrap the dough log in plastic wrap, and refrigerate for at least 45 minutes, or until firm.\nPreheat the oven to 350 F, and cover 2 baking sheets with parchment.\nUse a large, sharp chef’s knife to slice the log into rounds a little under ½” thick. (You can do thinner, ¼” rounds for a larger yield.) Place them on the baking sheets with a few inches between each cookie.\nBake the cookies for 13-15 minutes, until they have spread and puffed, and no longer have a raw shine in the center. They will continue to cook for a few minutes after they’re out of the oven, so don’t wait until they feel firm in the center or they will be overcooked. The perfect pinwheel cookie is crunchy around the edges and soft and tender on the inside!\nOnce cool, remove from the baking sheets and enjoy! Pinwheel cookies can be stored in an airtight container at room temperature and should be enjoyed within 4-5 days for maximum freshness. Unbaked cookies can be frozen, well-wrapped, for up to 3 months.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("sugarhero.com")
    expect(recipe.canonical_url).to eq("https://www.sugarhero.com/christmas-pinwheel-cookies/")
    expect(recipe.site_name).to eq("SugarHero")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Elizabeth LaBau")
    expect(recipe.description).to eq("These festive Pinwheel Sugar Cookies might be the best Christmas cookie recipe ever! They’re made with a simple sugar cookie dough formed into a beautiful red, white, and green spiral design.")
    expect(recipe.image).to eq("https://www.sugarhero.com/wp-content/uploads/2022/11/christmas-pinwheel-cookies-square.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("30 servings")
    expect(recipe.total_time).to eq(150)
    expect(recipe.prep_time).to eq(45)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq([
      "Christmas",
      "christmas cookies",
      "Christmas dessert",
      "pinwheel cookies",
      "sugar cookie",
      "sugar cookie pinwheels"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.67)
    expect(recipe.ratings_count).to eq(15)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "133 kcal",
      "carbohydrateContent" => "18 g",
      "proteinContent" => "1 g",
      "fatContent" => "6 g",
      "saturatedFatContent" => "4 g",
      "transFatContent" => "1 g",
      "cholesterolContent" => "22 mg",
      "sodiumContent" => "42 mg",
      "fiberContent" => "1 g",
      "sugarContent" => "8 g",
      "unsaturatedFatContent" => "3 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 133.0 },
      { name: "carbohydrateContent", unit: "g", amount: 18.0 },
      { name: "proteinContent", unit: "g", amount: 1.0 },
      { name: "fatContent", unit: "g", amount: 6.0 },
      { name: "saturatedFatContent", unit: "g", amount: 4.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 22.0 },
      { name: "sodiumContent", unit: "mg", amount: 42.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "sugarContent", unit: "g", amount: 8.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 3.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
