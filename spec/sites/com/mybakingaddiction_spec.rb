# frozen_string_literal: true

RSpec.describe "mybakingaddiction.com" do
  subject(:recipe) { scrape_cassette("com/mybakingaddiction", url: "https://www.mybakingaddiction.com/chocolate-coconut-zucchini-bread/") }

  it "reads the title" do
    expect(recipe.title).to eq("Chocolate Zucchini Bread")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 1/2 cups all-purpose flour",
      "1/2 cup unsweetened cocoa powder",
      "1 teaspoon salt",
      "1 teaspoon baking soda",
      "1/2 teaspoon baking powder",
      "1 teaspoon ground cinnamon",
      "1 cup coconut oil (melted)",
      "2/3 cup granulated sugar",
      "2/3 cup light brown sugar",
      "1/2 cup sour cream",
      "3 large eggs",
      "2 teaspoons pure vanilla extract",
      "2 1/2 cups grated zucchini",
      "1 cup semi-sweet chocolate chips",
      "3/4 cup shredded sweetened coconut"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.5, unit: "cups", name: "all-purpose flour" },
      { amount: 0.5, unit: "cup", name: "unsweetened cocoa powder" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: 1.0, unit: "teaspoon", name: "baking soda" },
      { amount: 0.5, unit: "teaspoon", name: "baking powder" },
      { amount: 1.0, unit: "teaspoon", name: "ground cinnamon" },
      { amount: 1.0, unit: "cup", name: "coconut oil" },
      { amount: 0.67, unit: "cup", name: "granulated sugar" },
      { amount: 0.67, unit: "cup", name: "light brown sugar" },
      { amount: 0.5, unit: "cup", name: "sour cream" },
      { amount: 3.0, unit: nil, name: "large eggs" },
      { amount: 2.0, unit: "teaspoons", name: "pure vanilla extract" },
      { amount: 2.5, unit: "cups", name: "grated zucchini" },
      { amount: 1.0, unit: "cup", name: "semi-sweet chocolate chips" },
      { amount: 0.75, unit: "cup", name: "shredded sweetened coconut" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 350°F. Spray two 8x4-inch loaf pans with baking spray and/or line with parchment paper.",
      "In a medium bowl, whisk together the flour, cocoa, salt, baking soda, baking powder and cinnamon.",
      "In a large bowl with an electric mixer, mix the coconut oil and sugars until combined. Mix in the sour cream. Add in the eggs and vanilla and mix until thoroughly incorporated.",
      "Slowly add dry ingredients to wet ingredients and mix until just combined.",
      "Add in the zucchini and mix for about 1 minute, or until the batter is moistened and the zucchini is evenly incorporated into the batter. Stir in the chocolate chips and shredded coconut.",
      "Spread the batter into the prepared pans and bake in preheated oven for 55-60 minutes, or until a toothpick inserted into the center comes out clean.",
      "Cool bread in pan for 30 minutes. Remove bread to a wire rack to cool completely."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 350°F. Spray two 8x4-inch loaf pans with baking spray and/or line with parchment paper.\nIn a medium bowl, whisk together the flour, cocoa, salt, baking soda, baking powder and cinnamon.\nIn a large bowl with an electric mixer, mix the coconut oil and sugars until combined. Mix in the sour cream. Add in the eggs and vanilla and mix until thoroughly incorporated.\nSlowly add dry ingredients to wet ingredients and mix until just combined.\nAdd in the zucchini and mix for about 1 minute, or until the batter is moistened and the zucchini is evenly incorporated into the batter. Stir in the chocolate chips and shredded coconut.\nSpread the batter into the prepared pans and bake in preheated oven for 55-60 minutes, or until a toothpick inserted into the center comes out clean.\nCool bread in pan for 30 minutes. Remove bread to a wire rack to cool completely.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("mybakingaddiction.com")
    expect(recipe.canonical_url).to eq("https://www.mybakingaddiction.com/chocolate-coconut-zucchini-bread/")
    expect(recipe.site_name).to eq("My Baking Addiction")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jamie")
    expect(recipe.description).to eq("Chocolate zucchini bread is quick, delicious, and the perfect use for the last of your summer zucchini. Enjoy a slice with your morning coffee or serve it up for dessert.")
    expect(recipe.image).to eq("https://www.mybakingaddiction.com/wp-content/uploads/2016/08/slice-from-chocolate-zucchini-loaf-hero.jpg")
    expect(recipe.category).to eq("Bread")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("20 servings")
    expect(recipe.total_time).to eq(75)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(60)
    expect(recipe.keywords).to eq(["bread", "Chocolate", "coconut", "Summer Recipes", "zucchini"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.23)
    expect(recipe.ratings_count).to eq(27)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 slice",
      "calories" => "306 kcal",
      "carbohydrateContent" => "34 g",
      "proteinContent" => "4 g",
      "fatContent" => "19 g",
      "saturatedFatContent" => "14 g",
      "cholesterolContent" => "28 mg",
      "sodiumContent" => "199 mg",
      "fiberContent" => "3 g",
      "sugarContent" => "18 g",
      "transFatContent" => "0.01 g",
      "unsaturatedFatContent" => "3 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "slice", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 306.0 },
      { name: "carbohydrateContent", unit: "g", amount: 34.0 },
      { name: "proteinContent", unit: "g", amount: 4.0 },
      { name: "fatContent", unit: "g", amount: 19.0 },
      { name: "saturatedFatContent", unit: "g", amount: 14.0 },
      { name: "cholesterolContent", unit: "mg", amount: 28.0 },
      { name: "sodiumContent", unit: "mg", amount: 199.0 },
      { name: "fiberContent", unit: "g", amount: 3.0 },
      { name: "sugarContent", unit: "g", amount: 18.0 },
      { name: "transFatContent", unit: "g", amount: 0.01 },
      { name: "unsaturatedFatContent", unit: "g", amount: 3.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
