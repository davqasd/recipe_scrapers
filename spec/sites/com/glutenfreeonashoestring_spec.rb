# frozen_string_literal: true

RSpec.describe "glutenfreeonashoestring.com" do
  subject(:recipe) { scrape_cassette("com/glutenfreeonashoestring", url: "https://glutenfreeonashoestring.com/caputo-fioreglut-pizza-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Caputo Fioreglut Pizza Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 1/8 cups Caputo Fioreglut gluten free flour",
      "1 teaspoon instant yeast",
      "3/4 teaspoon granulated sugar",
      "1/2 teaspoon kosher salt",
      "5 1/4 ounces warm water",
      "1 tablespoon extra virgin olive oil (plus more for handling and brushing)",
      "Your favorite pizza toppings (sauce, shredded or sliced mozzarella cheese)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.13, unit: "cups", name: "Caputo Fioreglut gluten free flour" },
      { amount: 1.0, unit: "teaspoon", name: "instant yeast" },
      { amount: 0.75, unit: "teaspoon", name: "granulated sugar" },
      { amount: 0.5, unit: "teaspoon", name: "kosher salt" },
      { amount: 5.25, unit: "ounces", name: "warm water" },
      { amount: 1.0, unit: "tablespoon", name: "extra virgin olive oil" },
      { amount: nil, unit: nil, name: "Your favorite pizza toppings" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "To make the pizza dough.",
      "In the bowl of your stand mixer fitted with the paddle attachment, place the flour, yeast, and sugar. Whisk to combine with a separate, handheld whisk. Add the salt, and whisk again to combine well.",
      "Add the water and olive oil, and mix very slowly until the flour is absorbed into the liquid. The mixture will be lumpy",
      "Raise the mixer to medium-high speed in your stand mixer until the dough becomes sticky and smooth (about 3 minutes).",
      "Oil a medium-size bowl, and scrape the pizza dough into the bowl.",
      "Using very well-oiled hands, loosely shape the dough into a round.",
      "Cover the bowl tightly with plastic and place in a draft-free location until nearly doubled in size. That will take longer in cool, dry environments and less time in warm, moist places.",
      "To bake the pizza.",
      "When you’re ready to make the pizza, place a pizza stone or overturned rimmed baking sheet in the oven and preheat it to 450°F.",
      "Place a 14-inch round nonstick pizza baking pan or a large piece of parchment paper in front of you on a flat surface",
      "The dough will be super soft, and should only be handled once you’ve coated your hands in olive oil. Turn the dough out onto the center of the pan or paper.",
      "Working from the center of the dough out to the edges, begin to press it into a round about 14-inches in diameter.",
      "Create a smooth, slightly raised edge around the perimeter of the dough by pressing the edges with one hand toward the palm of your other.",
      "Brush the shaped dough with more oil, concentrating it on the edges.",
      "Transfer the shaped and topped dough, still on the pizza baking sheet or parchment paper, to a pizza peel or other flat surface like a cutting board, and transfer it to the hot oven.",
      "Bake for 5 to 6 minutes, or until the crust seems set all the way to the center and the edges have expanded in size.",
      "Remove the pan from the oven, top the dough with sauce, cheese, and any other toppings you like best, and return the pizza on the pan or paper to the oven.",
      "Bake until the has begun to crisp on the underside, is lightly brown on the edges, and the cheese is brown and bubbling (about 5 minutes).",
      "Remove from the oven, allow to set for just a few minutes, then slice and serve hot."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("To make the pizza dough.\nIn the bowl of your stand mixer fitted with the paddle attachment, place the flour, yeast, and sugar. Whisk to combine with a separate, handheld whisk. Add the salt, and whisk again to combine well.\nAdd the water and olive oil, and mix very slowly until the flour is absorbed into the liquid. The mixture will be lumpy\nRaise the mixer to medium-high speed in your stand mixer until the dough becomes sticky and smooth (about 3 minutes).\nOil a medium-size bowl, and scrape the pizza dough into the bowl.\nUsing very well-oiled hands, loosely shape the dough into a round.\nCover the bowl tightly with plastic and place in a draft-free location until nearly doubled in size. That will take longer in cool, dry environments and less time in warm, moist places.\nTo bake the pizza.\nWhen you’re ready to make the pizza, place a pizza stone or overturned rimmed baking sheet in the oven and preheat it to 450°F.\nPlace a 14-inch round nonstick pizza baking pan or a large piece of parchment paper in front of you on a flat surface\nThe dough will be super soft, and should only be handled once you’ve coated your hands in olive oil. Turn the dough out onto the center of the pan or paper.\nWorking from the center of the dough out to the edges, begin to press it into a round about 14-inches in diameter.\nCreate a smooth, slightly raised edge around the perimeter of the dough by pressing the edges with one hand toward the palm of your other.\nBrush the shaped dough with more oil, concentrating it on the edges.\nTransfer the shaped and topped dough, still on the pizza baking sheet or parchment paper, to a pizza peel or other flat surface like a cutting board, and transfer it to the hot oven.\nBake for 5 to 6 minutes, or until the crust seems set all the way to the center and the edges have expanded in size.\nRemove the pan from the oven, top the dough with sauce, cheese, and any other toppings you like best, and return the pizza on the pan or paper to the oven.\nBake until the has begun to crisp on the underside, is lightly brown on the edges, and the cheese is brown and bubbling (about 5 minutes).\nRemove from the oven, allow to set for just a few minutes, then slice and serve hot.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("glutenfreeonashoestring.com")
    expect(recipe.canonical_url).to eq("https://glutenfreeonashoestring.com/caputo-fioreglut-pizza-recipe/")
    expect(recipe.site_name).to eq("Gluten Free on a Shoestring")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Nicole Hunn")
    expect(recipe.description).to eq("This Caputo Fioreglut pizza recipe makes chewy pizza that bends and folds! Learn how to use this flour blend to make great pizza at home.")
    expect(recipe.image).to eq("https://glutenfreeonashoestring.com/wp-content/uploads/2024/02/Caputo-Fioreglut-pizza-recipe-600x600-1.jpg")
    expect(recipe.category).to eq("Pizza")
    expect(recipe.cuisine).to eq("Italian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("1 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq(["Caputo Fioreglut pizza recipe"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.85)
    expect(recipe.ratings_count).to eq(20)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
