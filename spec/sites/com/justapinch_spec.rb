# frozen_string_literal: true

RSpec.describe "justapinch.com" do
  subject(:recipe) { scrape_cassette("com/justapinch", url: "https://www.justapinch.com/recipes/dessert/other-dessert/nuns-puffs-with-honey.html") }

  it "reads the title" do
    expect(recipe.title).to eq("Nun's Puffs With Honey")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1/2 cup(s) butter",
      "1 cup(s) milk",
      "3/4 cup(s) all-purpose flour",
      "4 large eggs",
      "1 tablespoon(s) granulated sugar",
      "12 teaspoon(s) honey"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.5, unit: "cup", name: "butter" },
      { amount: 1.0, unit: "cup", name: "milk" },
      { amount: 0.75, unit: "cup", name: "all-purpose flour" },
      { amount: 4.0, unit: nil, name: "large eggs" },
      { amount: 1.0, unit: "tablespoon", name: "granulated sugar" },
      { amount: 12.0, unit: "teaspoon", name: "honey" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 375 degrees F. Generously grease 12 muffin cups, including the edges and around the top; set aside.",
      "In a medium saucepan, melt butter; add milk. Bring to a boil.",
      "Add flour all at once, stirring vigorously.",
      "Cook and stir until the mixture forms a ball that does not separate. Remove from heat; cool for 5 minutes. Very important to let it cool.",
      "Add the eggs, one at a time, beating with a wooden spoon after each addition.",
      "Mix until smooth.",
      "Divide the dough evenly among prepared muffin cups, filling each cup about 2/3 full.",
      "Sprinkle with sugar.",
      "Bake about 30 minutes or until golden and puffy.",
      "Allow to cool for 5 minutes and then remove from the pan.",
      "Drizzle each with about 1 tsp of honey. Serve immediately."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 375 degrees F. Generously grease 12 muffin cups, including the edges and around the top; set aside.\nIn a medium saucepan, melt butter; add milk. Bring to a boil.\nAdd flour all at once, stirring vigorously.\nCook and stir until the mixture forms a ball that does not separate. Remove from heat; cool for 5 minutes. Very important to let it cool.\nAdd the eggs, one at a time, beating with a wooden spoon after each addition.\nMix until smooth.\nDivide the dough evenly among prepared muffin cups, filling each cup about 2/3 full.\nSprinkle with sugar.\nBake about 30 minutes or until golden and puffy.\nAllow to cool for 5 minutes and then remove from the pan.\nDrizzle each with about 1 tsp of honey. Serve immediately.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("justapinch.com")
    expect(recipe.canonical_url).to eq("https://www.justapinch.com/recipes/dessert/other-dessert/nuns-puffs-with-honey.html")
    expect(recipe.site_name).to eq("Just A Pinch Recipes")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Jillian Santiago")
    expect(recipe.description).to eq("These little puffs of goodness are wonderful. When they come out of the oven, they look similar to a popover, but they have an egg-like texture that's light and airy. The sprinkle of sugar gets crunchy and caramelized when baking. The drizzle of honey right before serving adds an extra pop of flavor. Made with a choux pastry, they're a light dessert that's impressive enough for a party or a quick treat for your family.")
    expect(recipe.image).to eq("https://lh3.googleusercontent.com/cmRvaFMR92MlBGKScv5kqaCuJ9H1iHbKLxvcZagYI_hBx91MUQqeq-Iozc-qd1TpuwJC8JE6pYt6NF4sJt_67_iVkynDHsVgzFE8Se0fOZGVlN41kHm1=s600")
    expect(recipe.category).to eq("Other Desserts")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["recipe", "American", "Other Desserts", "Bake"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "157 kcal",
      "carbohydrateContent" => "14 g",
      "cholesterolContent" => "85 mg",
      "fatContent" => "10 g",
      "fiberContent" => "0 g",
      "proteinContent" => "4 g",
      "saturatedFatContent" => "6 g",
      "sodiumContent" => "93 mg",
      "sugarContent" => "8 g",
      "unsaturatedFatContent" => "4 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 157.0 },
      { name: "carbohydrateContent", unit: "g", amount: 14.0 },
      { name: "cholesterolContent", unit: "mg", amount: 85.0 },
      { name: "fatContent", unit: "g", amount: 10.0 },
      { name: "fiberContent", unit: "g", amount: 0.0 },
      { name: "proteinContent", unit: "g", amount: 4.0 },
      { name: "saturatedFatContent", unit: "g", amount: 6.0 },
      { name: "sodiumContent", unit: "mg", amount: 93.0 },
      { name: "sugarContent", unit: "g", amount: 8.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 4.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#comments")
  end
end
