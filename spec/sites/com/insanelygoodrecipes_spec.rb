# frozen_string_literal: true

RSpec.describe "insanelygoodrecipes.com" do
  subject(:recipe) { scrape_cassette("com/insanelygoodrecipes", url: "https://insanelygoodrecipes.com/ghirardelli-chocolate-chip-cookie-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Ghirardelli Chocolate Chip Cookie Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 1/4 cups all-purpose flour",
      "1 teaspoon baking soda",
      "1/2 teaspoon salt",
      "1 cup butter, softened",
      "3/4 cup granulated sugar",
      "3/4 cup brown sugar, packed",
      "2 large eggs, room temperature",
      "2 teaspoons vanilla extract",
      "2 cups Ghirardelli Bittersweet Cacao Baking Chips",
      "1 cup chopped walnuts or pecans, optional"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.25, unit: "cups", name: "all-purpose flour" },
      { amount: 1.0, unit: "teaspoon", name: "baking soda" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 1.0, unit: "cup", name: "butter, softened" },
      { amount: 0.75, unit: "cup", name: "granulated sugar" },
      { amount: 0.75, unit: "cup", name: "brown sugar, packed" },
      { amount: 2.0, unit: nil, name: "large eggs, room temperature" },
      { amount: 2.0, unit: "teaspoons", name: "vanilla extract" },
      { amount: 2.0, unit: "cups", name: "Ghirardelli Bittersweet Cacao Baking Chips" },
      { amount: 1.0, unit: "cup", name: "chopped walnuts or pecans, optional" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 375 degrees Fahrenheit.",
      "Combine the flour, baking soda, and salt. Set aside.",
      "In a large mixing bowl, beat the butter and sugars at medium speed until light and creamy, about 1 to 2 minutes. Beat in the eggs, one by one. Stir in the vanilla. Beat on low speed until combined.",
      "Gradually pour the dry ingredients into the bowl and beat until incorporated. Fold in the chocolate chips and nuts, if using.",
      "Drop tablespoonfuls of cookie dough onto cthe ookie sheets, about 2 inches apart to give room for spreading.",
      "Bake for 9 to 11 minutes or until the cookies are golden brown. Cool slightly for 10 minutes on the cookie sheets before serving."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 375 degrees Fahrenheit.\nCombine the flour, baking soda, and salt. Set aside.\nIn a large mixing bowl, beat the butter and sugars at medium speed until light and creamy, about 1 to 2 minutes. Beat in the eggs, one by one. Stir in the vanilla. Beat on low speed until combined.\nGradually pour the dry ingredients into the bowl and beat until incorporated. Fold in the chocolate chips and nuts, if using.\nDrop tablespoonfuls of cookie dough onto cthe ookie sheets, about 2 inches apart to give room for spreading.\nBake for 9 to 11 minutes or until the cookies are golden brown. Cool slightly for 10 minutes on the cookie sheets before serving.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("insanelygoodrecipes.com")
    expect(recipe.canonical_url).to eq("https://insanelygoodrecipes.com/ghirardelli-chocolate-chip-cookie-recipe/")
    expect(recipe.site_name).to eq("Insanely Good Recipes")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Kim - InsanelyGood")
    expect(recipe.description).to eq("This Ghirardelli chocolate chip cookie recipe is an American classic! Learn how to make it, plus, get tips for making the best cookies you've ever had.")
    expect(recipe.image).to eq("https://insanelygoodrecipes.com/wp-content/uploads/2021/04/Chocolate-Chip-Cookies-with-Milk.png")
    expect(recipe.category).to eq("Cookies")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("36 servings")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(4)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#hubbub")
  end
end
