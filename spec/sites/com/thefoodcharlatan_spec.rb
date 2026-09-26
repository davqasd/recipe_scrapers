# frozen_string_literal: true

RSpec.describe "thefoodcharlatan.com" do
  subject(:recipe) { scrape_cassette("com/thefoodcharlatan", url: "https://thefoodcharlatan.com/texas-cowboy-cookies-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Cowboy Cookie")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 cup butter (softened (2 sticks))",
      "1 cup white sugar",
      "1 cup brown sugar",
      "2 large eggs",
      "1 teaspoon vanilla",
      "2 cups flour (spooned and leveled)",
      "1/2 teaspoon salt",
      "1 teaspoon baking powder",
      "1 teaspoon baking soda",
      "1 cup old fashioned oats",
      "1 cup corn flakes",
      "1 cup pecans (roughly chopped (and toasted!))",
      "1/2 cup coconut flakes",
      "1 (6-oz) cup peanut butter chips (I used Reese's)",
      "1 (6-oz) cup semi-sweet chocolate chips"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cup", name: "butter" },
      { amount: 1.0, unit: "cup", name: "white sugar" },
      { amount: 1.0, unit: "cup", name: "brown sugar" },
      { amount: 2.0, unit: nil, name: "large eggs" },
      { amount: 1.0, unit: "teaspoon", name: "vanilla" },
      { amount: 2.0, unit: "cups", name: "flour" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 1.0, unit: "teaspoon", name: "baking powder" },
      { amount: 1.0, unit: "teaspoon", name: "baking soda" },
      { amount: 1.0, unit: "cup", name: "old fashioned oats" },
      { amount: 1.0, unit: "cup", name: "corn flakes" },
      { amount: 1.0, unit: "cup", name: "pecans" },
      { amount: 0.5, unit: "cup", name: "coconut flakes" },
      { amount: 1.0, unit: "cup", name: "peanut butter chips" },
      { amount: 1.0, unit: "cup", name: "semi-sweet chocolate chips" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "If you want to toast your pecans (you do! you do!) chop them up and throw them in a dry skillet over medium heat. Toast for 3-5 minutes, until fragrant. Don't let them burn! Remove from heat and let cool while you make the dough.",
      "In a large bowl or stand mixer, beat the butter until it is light and fluffy.",
      "Add both sugars and beat well, scraping sides and bottom.",
      "Add eggs and vanilla, beat well.",
      "Add the flour but don't mix it in. Add the salt, baking powder, and baking soda to the flour and use a small spoon to blend it with the flour a bit. Then mix in the flour, but stop before it's fully incorporated.",
      "Add the oats, corn flakes, pecans, and coconut to the bowl. Mix in gently.",
      "Add the peanut butter chips and chocolate chips and mix until everything is incorporated. Don't over mix, it will make your dough tough.",
      "Chill the dough in the fridge for at least an hour, or up to 24 hours.*",
      "Preheat oven to 350 degrees F. Line a couple baking sheets with a silpat or parchment paper.",
      "Use a 1/4 cup measuring cup (THINK TEXAS, YA'LL)* to scoop these onto the pan. Leave at least a couple inches in between each ball of dough.",
      "Bake at 350 for 12-14 minutes, until the cookies are golden on the edges and they are not too shiny in the middle. (A little shine is okay.)",
      "Let cool as long as you can before stuffing your face! These are great dipped in milk."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("If you want to toast your pecans (you do! you do!) chop them up and throw them in a dry skillet over medium heat. Toast for 3-5 minutes, until fragrant. Don't let them burn! Remove from heat and let cool while you make the dough.\nIn a large bowl or stand mixer, beat the butter until it is light and fluffy.\nAdd both sugars and beat well, scraping sides and bottom.\nAdd eggs and vanilla, beat well.\nAdd the flour but don't mix it in. Add the salt, baking powder, and baking soda to the flour and use a small spoon to blend it with the flour a bit. Then mix in the flour, but stop before it's fully incorporated.\nAdd the oats, corn flakes, pecans, and coconut to the bowl. Mix in gently.\nAdd the peanut butter chips and chocolate chips and mix until everything is incorporated. Don't over mix, it will make your dough tough.\nChill the dough in the fridge for at least an hour, or up to 24 hours.*\nPreheat oven to 350 degrees F. Line a couple baking sheets with a silpat or parchment paper.\nUse a 1/4 cup measuring cup (THINK TEXAS, YA'LL)* to scoop these onto the pan. Leave at least a couple inches in between each ball of dough.\nBake at 350 for 12-14 minutes, until the cookies are golden on the edges and they are not too shiny in the middle. (A little shine is okay.)\nLet cool as long as you can before stuffing your face! These are great dipped in milk.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thefoodcharlatan.com")
    expect(recipe.canonical_url).to eq("https://thefoodcharlatan.com/texas-cowboy-cookies-recipe/")
    expect(recipe.site_name).to eq("The Food Charlatan")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Karen Gifford")
    expect(recipe.description).to eq("Everything's bigger in Texas and these Cowboy cookies (sometimes called Texas Cow Chips) are no exception. They are crispy on the edges but chewy and moist in the middle, and have about a hundred mix-ins that all combine to create the Texas of all cookies.")
    expect(recipe.image).to eq("https://thefoodcharlatan.com/wp-content/uploads/2016/08/IMG_2488.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("18 servings")
    expect(recipe.total_time).to eq(82)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(12)
    expect(recipe.keywords).to eq(%w[Cookies cowboy texas])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.93)
    expect(recipe.ratings_count).to eq(54)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 cookie",
      "calories" => "421 kcal",
      "carbohydrateContent" => "50 g",
      "proteinContent" => "6 g",
      "fatContent" => "23 g",
      "saturatedFatContent" => "13 g",
      "transFatContent" => "1 g",
      "cholesterolContent" => "50 mg",
      "sodiumContent" => "283 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "31 g",
      "unsaturatedFatContent" => "8 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "cookie", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 421.0 },
      { name: "carbohydrateContent", unit: "g", amount: 50.0 },
      { name: "proteinContent", unit: "g", amount: 6.0 },
      { name: "fatContent", unit: "g", amount: 23.0 },
      { name: "saturatedFatContent", unit: "g", amount: 13.0 },
      { name: "transFatContent", unit: "g", amount: 1.0 },
      { name: "cholesterolContent", unit: "mg", amount: 50.0 },
      { name: "sodiumContent", unit: "mg", amount: 283.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 31.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 8.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
