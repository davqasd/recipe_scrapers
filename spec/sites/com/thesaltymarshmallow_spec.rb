# frozen_string_literal: true

RSpec.describe "thesaltymarshmallow.com" do
  subject(:recipe) { scrape_cassette("com/thesaltymarshmallow", url: "https://thesaltymarshmallow.com/cream-cheese-cookies/") }

  it "reads the title" do
    expect(recipe.title).to eq("Cream Cheese Cookies")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 Cup Granulated Sugar",
      "1/2 Cup 1 Stick Salted Butter, at room temperature",
      "4 Ounces Cream Cheese (at room temperature)",
      "1 Large Egg",
      "1 teaspoon Vanilla Extract",
      "2 Cups All Purpose Flour",
      "½ teaspoon Baking Powder",
      "¼ teaspoon Salt",
      "Powdered Sugar (for dusting)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "Cup", name: "Granulated Sugar" },
      { amount: 0.5, unit: "Cup", name: "Salted Butter, at room temperature" },
      { amount: 4.0, unit: "Ounces", name: "Cream Cheese" },
      { amount: 1.0, unit: nil, name: "Large Egg" },
      { amount: 1.0, unit: "teaspoon", name: "Vanilla Extract" },
      { amount: 2.0, unit: "Cups", name: "All Purpose Flour" },
      { amount: 0.5, unit: "teaspoon", name: "Baking Powder" },
      { amount: 0.25, unit: "teaspoon", name: "Salt" },
      { amount: nil, unit: nil, name: "Powdered Sugar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 375 degrees Fahrenheit and line 2 12x16 inch baking pans with parchment paper and set aside.",
      "Beat the sugar and butter in a large bowl then beat in the cream cheese until smooth.",
      "Beat in the egg and vanilla then stir in the flour, baking powder and salt.",
      "Using a one-inch cookie scoop or your hands, form one-inch balls from the mixture and place them on the baking pan, evenly spaced. (These cookies don’t rise much so you can place them around 1 inch apart from each other.)",
      "Bake for 9-11 minutes or until the tops have dried out and the bottoms are golden brown.",
      "Let them cool on the pan for 5-10 minutes while you bake the remaining cookies in the same way on the other prepared pan.",
      "Serve with a dusting of powdered sugar if you like."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 375 degrees Fahrenheit and line 2 12x16 inch baking pans with parchment paper and set aside.\nBeat the sugar and butter in a large bowl then beat in the cream cheese until smooth.\nBeat in the egg and vanilla then stir in the flour, baking powder and salt.\nUsing a one-inch cookie scoop or your hands, form one-inch balls from the mixture and place them on the baking pan, evenly spaced. (These cookies don’t rise much so you can place them around 1 inch apart from each other.)\nBake for 9-11 minutes or until the tops have dried out and the bottoms are golden brown.\nLet them cool on the pan for 5-10 minutes while you bake the remaining cookies in the same way on the other prepared pan.\nServe with a dusting of powdered sugar if you like.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thesaltymarshmallow.com")
    expect(recipe.canonical_url).to eq("https://thesaltymarshmallow.com/cream-cheese-cookies/")
    expect(recipe.site_name).to eq("The Salty Marshmallow")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Nichole")
    expect(recipe.description).to eq("Cream Cheese Cookies are decadent and so easy to make. Light and crispy outside, creamy inside - these homemade cookies check all the right boxes. Leave some out for Santa or keep them all to yourself!")
    expect(recipe.image).to eq("https://thesaltymarshmallow.com/wp-content/uploads/2022/12/cream-cheese-cookies-featured.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("35 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq(["cream cheese cookies"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(6)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
