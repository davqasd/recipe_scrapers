# frozen_string_literal: true

RSpec.describe "delscookingtwist.com" do
  subject(:recipe) { scrape_cassette("com/delscookingtwist", url: "https://www.delscookingtwist.com/skinny-oatmeal-peanut-butter-chocolate-chip-cookies/") }

  it "reads the title" do
    expect(recipe.title).to eq("Peanut Butter Oatmeal Chocolate Chip Cookies")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "⅔ cup (60g) rolled oats (gluten-free if needed)",
      "½ teaspoon baking soda",
      "1 cup (240g) creamy or crunchy peanut butter",
      "⅔ cup (120g) dark brown sugar*",
      "2 large eggs",
      "¼ cup (4 Tbsp) solid coconut oil (NOT melted)",
      "1 ½ teaspoon vanilla extract",
      "⅔ cup (100g) chocolate chips",
      "Sea salt, for sprinkling (optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.67, unit: "cup", name: "rolled oats" },
      { amount: 0.5, unit: "teaspoon", name: "baking soda" },
      { amount: 1.0, unit: "cup", name: "creamy or crunchy peanut butter" },
      { amount: 0.67, unit: "cup", name: "dark brown sugar*" },
      { amount: 2.0, unit: nil, name: "large eggs" },
      { amount: 0.25, unit: "cup", name: "solid coconut oil" },
      { amount: 1.5, unit: "teaspoon", name: "vanilla extract" },
      { amount: 0.67, unit: "cup", name: "chocolate chips" },
      { amount: nil, unit: nil, name: "Sea salt, for sprinkling" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 350°F (180°C). Line a large baking sheet with parchment paper, and set aside.",
      "In a small bowl, whisk together oats and baking soda. Set aside.",
      "In a large bowl, beat peanut butter, brown sugar, eggs, solid coconut oil and vanilla with an electric mixer until smooth, about 3 minutes. Mix in the dry ingredients with a rubber spatula or wooden spoon, then gently fold in the chocolate chips.",
      "Using an ice cream scoop, distribute the cookie dough onto the prepared baking sheet, spacing them out from each other, and slightly flatten each cookie ball with the palm of your hand.",
      "Bake for about 9 to 11 minutes, or until the edges are almost set while the center is still soft. The cookies may look slightly underbaked but that’s ok because they will continue to bake a few more minutes onto the warm baking sheet outside of the oven. Sprinkle with sea salt, and allow to cool for a few minutes, then transfer to a cooling rack. Enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 350°F (180°C). Line a large baking sheet with parchment paper, and set aside.\nIn a small bowl, whisk together oats and baking soda. Set aside.\nIn a large bowl, beat peanut butter, brown sugar, eggs, solid coconut oil and vanilla with an electric mixer until smooth, about 3 minutes. Mix in the dry ingredients with a rubber spatula or wooden spoon, then gently fold in the chocolate chips.\nUsing an ice cream scoop, distribute the cookie dough onto the prepared baking sheet, spacing them out from each other, and slightly flatten each cookie ball with the palm of your hand.\nBake for about 9 to 11 minutes, or until the edges are almost set while the center is still soft. The cookies may look slightly underbaked but that’s ok because they will continue to bake a few more minutes onto the warm baking sheet outside of the oven. Sprinkle with sea salt, and allow to cool for a few minutes, then transfer to a cooling rack. Enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("delscookingtwist.com")
    expect(recipe.canonical_url).to eq("https://www.delscookingtwist.com/skinny-oatmeal-peanut-butter-chocolate-chip-cookies/")
    expect(recipe.site_name).to eq("Del's cooking twist")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Delphine Fortin")
    expect(recipe.description).to eq("These generous peanut butter oatmeal chocolate chip cookies are prepared with no flour, no butter, and have a perfect chewy texture. Keeping the good stuff only, this cookie recipe is a dream come true to all peanut butter lovers!")
    expect(recipe.image).to eq("https://www.delscookingtwist.com/wp-content/uploads/2025/10/Peanut-Butter-Oatmeal-Chocolate-Chip-Cookies_1-225x225.jpg")
    expect(recipe.category).to eq("Cookies")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("16 servings")
    expect(recipe.total_time).to eq(19)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(9)
    expect(recipe.keywords).to eq(["Peanut Butter Oatmeal Chocolate Chip Cookies"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(3)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#body")
  end
end
