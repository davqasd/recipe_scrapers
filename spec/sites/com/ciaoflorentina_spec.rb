# frozen_string_literal: true

RSpec.describe "ciaoflorentina.com" do
  subject(:recipe) { scrape_cassette("com/ciaoflorentina", url: "https://ciaoflorentina.com/rosemary-shortbread-cookies-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Rosemary Shortbread Cookies")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1.75 cups all purpose flour (or whole wheat pastry flour)",
      "1/2 cup powdered sugar",
      "1 pinch sea salt",
      "the zest from 4 large lemons",
      "2 sprigs rosemary leaves (chopped- about 1 Tbsp)",
      "12 Tbsp cultured vegan butter (salted, chilled + cut into cubes)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.75, unit: "cups", name: "all purpose flour" },
      { amount: 0.5, unit: "cup", name: "powdered sugar" },
      { amount: 1.0, unit: "pinch", name: "sea salt" },
      { amount: nil, unit: nil, name: "the zest from 4 large lemons" },
      { amount: 2.0, unit: "sprigs", name: "rosemary leaves" },
      { amount: 12.0, unit: "Tbsp", name: "cultured vegan butter" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "To the bowl of a food processor add the flour, sugar, rosemary lemon zest and salt. Process until combined.",
      "Add the butter and process using the pulse button until a dough starts to form.",
      "Transfer the cookie dough to a piece of parchment paper and using your hands form an 8 inch long log. Wrap it tightly in parchment paper and form a smooth shaped log as best you can then pop in the freezer for 10 to 15 minutes to set.",
      "Prepare a large rimmed cookie sheet lined with parchment paper. Pre-heat oven to 350”F.",
      "Take the cookie dough from the freezer and unwrap it. Slice into 16 equal slices. (At this point you can bake the cookies in slices if you don't want to stamp them).",
      "STAMPING COOKIES: Roll each slice into a ball the size of a walnut and place on the prepared cookie sheet a couple of inches apart.",
      "Take the chilled cookie stamp and dip it in flour. Press on top of each dough ball to flatten. Repeat with the rest of the cookies making sure to dip your cookie stamp in flour in between each cookie pressing to prevent any sticking. (Optional: sprinkle each cookie with a couple of sea salt flakes).",
      "FREEZE - Place stamped cookies in the freezer for the design to set for 10 minutes or so. This will help ensure the dough is firm enough and the design won't disappear on you during baking.",
      "Bake in the preheat oven for 21 to 22 minutes until lightly golden at the edges. Transfer to a cooling rack and allow to cool completely. Store in a cookie jar or lidded container at room temperature."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("To the bowl of a food processor add the flour, sugar, rosemary lemon zest and salt. Process until combined.\nAdd the butter and process using the pulse button until a dough starts to form.\nTransfer the cookie dough to a piece of parchment paper and using your hands form an 8 inch long log. Wrap it tightly in parchment paper and form a smooth shaped log as best you can then pop in the freezer for 10 to 15 minutes to set.\nPrepare a large rimmed cookie sheet lined with parchment paper. Pre-heat oven to 350”F.\nTake the cookie dough from the freezer and unwrap it. Slice into 16 equal slices. (At this point you can bake the cookies in slices if you don't want to stamp them).\nSTAMPING COOKIES: Roll each slice into a ball the size of a walnut and place on the prepared cookie sheet a couple of inches apart.\nTake the chilled cookie stamp and dip it in flour. Press on top of each dough ball to flatten. Repeat with the rest of the cookies making sure to dip your cookie stamp in flour in between each cookie pressing to prevent any sticking. (Optional: sprinkle each cookie with a couple of sea salt flakes).\nFREEZE - Place stamped cookies in the freezer for the design to set for 10 minutes or so. This will help ensure the dough is firm enough and the design won't disappear on you during baking.\nBake in the preheat oven for 21 to 22 minutes until lightly golden at the edges. Transfer to a cooling rack and allow to cool completely. Store in a cookie jar or lidded container at room temperature.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("ciaoflorentina.com")
    expect(recipe.canonical_url).to eq("https://ciaoflorentina.com/rosemary-shortbread-cookies-recipe/")
    expect(recipe.site_name).to eq("Ciao Florentina")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Florentina")
    expect(recipe.description).to eq("The best, flakiest rosemary shortbread cookies with lemon zest, sea salt and plant butter. The buttery and crumbly texture makes these the perfect Italian Christmas cookies to leave under the tree!")
    expect(recipe.image).to eq("https://ciaoflorentina.com/wp-content/uploads/2023/12/rosemary-shortbread-cookies.jpeg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("Italian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("16 servings")
    expect(recipe.total_time).to eq(41)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(21)
    expect(recipe.keywords).to eq(["rosemary shortbread cookies"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 cookie",
      "calories" => "140 kcal",
      "carbohydrateContent" => "14 g",
      "proteinContent" => "1 g",
      "fatContent" => "9 g",
      "saturatedFatContent" => "2 g",
      "transFatContent" => "2 g",
      "sodiumContent" => "71 mg",
      "fiberContent" => "0.4 g",
      "sugarContent" => "4 g",
      "unsaturatedFatContent" => "7 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "cookie", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 140.0 },
      { name: "carbohydrateContent", unit: "g", amount: 14.0 },
      { name: "proteinContent", unit: "g", amount: 1.0 },
      { name: "fatContent", unit: "g", amount: 9.0 },
      { name: "saturatedFatContent", unit: "g", amount: 2.0 },
      { name: "transFatContent", unit: "g", amount: 2.0 },
      { name: "sodiumContent", unit: "mg", amount: 71.0 },
      { name: "fiberContent", unit: "g", amount: 0.4 },
      { name: "sugarContent", unit: "g", amount: 4.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 7.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
