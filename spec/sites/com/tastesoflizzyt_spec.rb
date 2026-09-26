# frozen_string_literal: true

RSpec.describe "tastesoflizzyt.com" do
  subject(:recipe) { scrape_cassette("com/tastesoflizzyt", url: "https://www.tastesoflizzyt.com/soft-baked-gingerbread-cookies/") }

  it "reads the title" do
    expect(recipe.title).to eq("Soft Molasses Christmas Cookies")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup shortening (or room temperature butter*)",
      "1 cup brown sugar (packed)",
      "1 cup molasses",
      "1 cup buttermilk",
      "5 1/2 cups all-purpose flour",
      "4 teaspoons baking soda",
      "1 teaspoon ground ginger",
      "3/4 teaspoon ground cinnamon",
      "1/4 teaspoon ground nutmeg",
      "1/4 teaspoon ground cloves",
      "1 teaspoons salt",
      "1/2 cup extra granulated sugar for rolling dough"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "shortening" },
      { amount: 1.0, unit: "cup", name: "brown sugar" },
      { amount: 1.0, unit: "cup", name: "molasses" },
      { amount: 1.0, unit: "cup", name: "buttermilk" },
      { amount: 5.5, unit: "cups", name: "all-purpose flour" },
      { amount: 4.0, unit: "teaspoons", name: "baking soda" },
      { amount: 1.0, unit: "teaspoon", name: "ground ginger" },
      { amount: 0.75, unit: "teaspoon", name: "ground cinnamon" },
      { amount: 0.25, unit: "teaspoon", name: "ground nutmeg" },
      { amount: 0.25, unit: "teaspoon", name: "ground cloves" },
      { amount: 1.0, unit: "teaspoons", name: "salt" },
      { amount: 0.5, unit: "cup", name: "extra granulated sugar for rolling dough" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 350ºF.",
      "In a large bowl (or a stand mixer bowl with the paddle attachment), cream together the shortening, brown sugar, molasses and buttermilk. The mixture will look curdled, but don't worry...it will all come together with the dry ingredients. 1 cup shortening, 1 cup brown sugar, 1 cup molasses, 1 cup buttermilk",
      "In a separate bowl, sift together the flour, baking soda, ginger, cinnamon, nutmeg, cloves and salt. 5 1/2 cups all-purpose flour, 4 teaspoons baking soda, 1 teaspoon ground ginger, 3/4 teaspoon ground cinnamon, 1/4 teaspoon ground nutmeg, 1/4 teaspoon ground cloves, 1 teaspoons salt",
      "Add the dry ingredients to the wet ingredients and mix well. The dough will be very soft and slightly sticky, but you should be able to roll",
      "Use a cookie scoop to spoon out the dough and roll into balls. Then roll the balls in sugar.",
      "Place the cookie dough balls on an ungreased cookie sheet about 2\" apart. Bake in the preheated oven for 8-10 minutes. Don't over bake the cookies. We remove them before they get browned.",
      "Allow the cookies to cool on the pan for 3-5 minutes before moving to a wire rack to cool completely."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 350ºF.\nIn a large bowl (or a stand mixer bowl with the paddle attachment), cream together the shortening, brown sugar, molasses and buttermilk. The mixture will look curdled, but don't worry...it will all come together with the dry ingredients. 1 cup shortening, 1 cup brown sugar, 1 cup molasses, 1 cup buttermilk\nIn a separate bowl, sift together the flour, baking soda, ginger, cinnamon, nutmeg, cloves and salt. 5 1/2 cups all-purpose flour, 4 teaspoons baking soda, 1 teaspoon ground ginger, 3/4 teaspoon ground cinnamon, 1/4 teaspoon ground nutmeg, 1/4 teaspoon ground cloves, 1 teaspoons salt\nAdd the dry ingredients to the wet ingredients and mix well. The dough will be very soft and slightly sticky, but you should be able to roll\nUse a cookie scoop to spoon out the dough and roll into balls. Then roll the balls in sugar.\nPlace the cookie dough balls on an ungreased cookie sheet about 2\" apart. Bake in the preheated oven for 8-10 minutes. Don't over bake the cookies. We remove them before they get browned.\nAllow the cookies to cool on the pan for 3-5 minutes before moving to a wire rack to cool completely.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("tastesoflizzyt.com")
    expect(recipe.canonical_url).to eq("https://www.tastesoflizzyt.com/soft-baked-gingerbread-cookies/")
    expect(recipe.site_name).to eq("Tastes of Lizzy T")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Julie Clark")
    expect(recipe.description).to eq("Molasses Christmas Cookies have the taste of gingerbread cookies, but are soft and thick. Roll the dough balls in sugar for the perfect sweetness!")
    expect(recipe.image).to eq("https://www.tastesoflizzyt.com/wp-content/uploads/2020/11/molasses-cookies-500-1.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("60 servings")
    expect(recipe.total_time).to eq(23)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(8)
    expect(recipe.keywords).to eq([
      "christmas cookies",
      "cookies without eggs",
      "easy cookies",
      "egg free cookies",
      "gingerbread cookies"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.92)
    expect(recipe.ratings_count).to eq(12)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "111 kcal",
      "carbohydrateContent" => "18 g",
      "proteinContent" => "1 g",
      "fatContent" => "4 g",
      "sodiumContent" => "119 mg",
      "sugarContent" => "10 g",
      "saturatedFatContent" => "1 g",
      "transFatContent" => "0.4 g",
      "cholesterolContent" => "0.4 mg",
      "fiberContent" => "0.3 g",
      "unsaturatedFatContent" => "2 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 111.0 },
      { name: "carbohydrateContent", unit: "g", amount: 18.0 },
      { name: "proteinContent", unit: "g", amount: 1.0 },
      { name: "fatContent", unit: "g", amount: 4.0 },
      { name: "sodiumContent", unit: "mg", amount: 119.0 },
      { name: "sugarContent", unit: "g", amount: 10.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "transFatContent", unit: "g", amount: 0.4 },
      { name: "cholesterolContent", unit: "mg", amount: 0.4 },
      { name: "fiberContent", unit: "g", amount: 0.3 },
      { name: "unsaturatedFatContent", unit: "g", amount: 2.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
