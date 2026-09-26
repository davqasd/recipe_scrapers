# frozen_string_literal: true

RSpec.describe "bakerbynature.com" do
  subject(:recipe) { scrape_cassette("com/bakerbynature", url: "https://bakerbynature.com/broccoli-and-cheddar-twice-baked-potatoes/") }

  it "reads the title" do
    expect(recipe.title).to eq("Broccoli and Cheddar Twice-Baked Potatoes")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 medium russet potatoes (washed and dried )",
      "2 teaspoons olive oil",
      "4 Tablespoons (57g) salted butter (very soft )",
      "1/2 cup (113g) non-fat Greek yogurt",
      "1/3 cup (76ml) buttermilk",
      "3/4 teaspoon salt",
      "1/2 teaspoon pepper",
      "3/4 teaspoon dried chives",
      "3/4 teaspoon garlic powder",
      "1/2 teaspoon onion powder",
      "1/2 teaspoon dried onion flakes",
      "1/2 teaspoon dried dill weed",
      "1/2 teaspoon paprika",
      "1 and 1/2 cups cooked broccoli (chopped into bite-size pieces, divided )",
      "2 cups cheddar cheese (shredded, divided )"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: nil, name: "medium russet potatoes" },
      { amount: 2.0, unit: "teaspoons", name: "olive oil" },
      { amount: 4.0, unit: "Tablespoons", name: "salted butter" },
      { amount: 0.5, unit: "cup", name: "non-fat Greek yogurt" },
      { amount: 0.33, unit: "cup", name: "buttermilk" },
      { amount: 0.75, unit: "teaspoon", name: "salt" },
      { amount: 0.5, unit: "teaspoon", name: "pepper" },
      { amount: 0.75, unit: "teaspoon", name: "dried chives" },
      { amount: 0.75, unit: "teaspoon", name: "garlic powder" },
      { amount: 0.5, unit: "teaspoon", name: "onion powder" },
      { amount: 0.5, unit: "teaspoon", name: "dried onion flakes" },
      { amount: 0.5, unit: "teaspoon", name: "dried dill weed" },
      { amount: 0.5, unit: "teaspoon", name: "paprika" },
      { amount: 1.5, unit: "cups", name: "cooked broccoli" },
      { amount: 2.0, unit: "cups", name: "cheddar cheese" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 400 degrees (F). Line a small baking sheet with parchment paper; set aside.",
      "Place potatoes in a small baking dish and bake for 1 hour, or until soft.",
      "Remove from oven and set aside to cool. Once the potatoes are cool enough to safely handle, slice each one in half, lengthwise. Scoop out the potato pulp and place it into a large bowl, being careful to leave the skins intact. Rub the outsides of the potato skins with a little olive oil. Place the skins on the prepared baking sheet and set aside.",
      "Add the butter to the potato pulp and mash - using an electric mixer or a potato masher - until fairly smooth; add Greek yogurt, buttermilk, salt, pepper, chives, garlic powder, onion powder, dried onion flakes, dill weed, paprika, broccoli and 3/4 cup of the cheese.",
      "Divide the filling evenly among the potato shells then top with remaining cheese. Bake for 20-25 minutes or until the cheese is melted and the potatoes are heated through. Serve at once!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 400 degrees (F). Line a small baking sheet with parchment paper; set aside.\nPlace potatoes in a small baking dish and bake for 1 hour, or until soft.\nRemove from oven and set aside to cool. Once the potatoes are cool enough to safely handle, slice each one in half, lengthwise. Scoop out the potato pulp and place it into a large bowl, being careful to leave the skins intact. Rub the outsides of the potato skins with a little olive oil. Place the skins on the prepared baking sheet and set aside.\nAdd the butter to the potato pulp and mash - using an electric mixer or a potato masher - until fairly smooth; add Greek yogurt, buttermilk, salt, pepper, chives, garlic powder, onion powder, dried onion flakes, dill weed, paprika, broccoli and 3/4 cup of the cheese.\nDivide the filling evenly among the potato shells then top with remaining cheese. Bake for 20-25 minutes or until the cheese is melted and the potatoes are heated through. Serve at once!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("bakerbynature.com")
    expect(recipe.canonical_url).to eq("https://bakerbynature.com/broccoli-and-cheddar-twice-baked-potatoes/")
    expect(recipe.site_name).to eq("Baker by Nature")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Ashley Manila")
    expect(recipe.description).to eq("Broccoli and Cheddar Twice-Baked Potatoes are the epitome of comfort food! Add a salad to make them a full meal.")
    expect(recipe.image).to eq("https://bakerbynature.com/wp-content/uploads/2016/01/IMG_3847-5-2.jpg")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(110)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(90)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.85)
    expect(recipe.ratings_count).to eq(19)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
