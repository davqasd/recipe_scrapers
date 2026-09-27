# frozen_string_literal: true

RSpec.describe "kingarthurbaking.com" do
  subject(:recipe) { scrape_cassette("com/kingarthurbaking", url: "https://www.kingarthurbaking.com/recipes/100-whole-wheat-zucchini-chocolate-chip-bread-recipe") }

  it "reads the title" do
    expect(recipe.title).to eq("100% Whole Wheat Zucchini Chocolate Chip Bread")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 large eggs",
      "1/3 cup (114g) molasses or honey",
      "1/2 cup (99g) vegetable oil",
      "1/3 cup (71g) light brown sugar or dark brown sugar, packed",
      "1 teaspoon King Arthur Pure Vanilla Extract",
      "2 cups (226g) King Arthur Golden Wheat Flour",
      "1 teaspoon table salt",
      "1/2 teaspoon baking soda",
      "1/2 teaspoon baking powder",
      "1 teaspoon ground cinnamon",
      "2 cups (242 to 300g) shredded, unpeeled zucchini (about 1 small/medium zucchini)",
      "1 cup (170g) chocolate chips",
      "3/4 cup (85g) chopped walnuts, optional"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "large eggs" },
      { amount: 0.33, unit: "cup", name: "molasses or honey" },
      { amount: 0.5, unit: "cup", name: "vegetable oil" },
      { amount: 0.33, unit: "cup", name: "light brown sugar or dark brown sugar, packed" },
      { amount: 1.0, unit: "teaspoon", name: "King Arthur Pure Vanilla Extract" },
      { amount: 2.0, unit: "cups", name: "King Arthur Golden Wheat Flour" },
      { amount: 1.0, unit: "teaspoon", name: "table salt" },
      { amount: 0.5, unit: "teaspoon", name: "baking soda" },
      { amount: 0.5, unit: "teaspoon", name: "baking powder" },
      { amount: 1.0, unit: "teaspoon", name: "ground cinnamon" },
      { amount: 2.0, unit: "cups", name: "shredded, unpeeled zucchini" },
      { amount: 1.0, unit: "cup", name: "chocolate chips" },
      { amount: 0.75, unit: "cup", name: "chopped walnuts, optional" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 350°F; lightly grease a 9\" x 5\" loaf pan.",
      "In a large mixing bowl, beat the eggs, molasses or honey, oil, sugar, and vanilla until smooth.",
      "Add the flour, salt, baking soda, baking powder, and cinnamon, mixing until well combined.",
      "Stir in the zucchini, chocolate chips, and nuts.",
      "Pour the batter into the prepared pan.",
      "Bake the bread for 55 to 60 minutes, until the loaf tests done (a toothpick or cake tester inserted into the center will come out clean, save for perhaps a smear of chocolate).",
      "Remove the bread from the oven, and let it cool for 10 to 15 minutes before turning it out of the pan onto a rack.",
      "Cool completely before slicing; store well-wrapped, at room temperature."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 350°F; lightly grease a 9\" x 5\" loaf pan.\nIn a large mixing bowl, beat the eggs, molasses or honey, oil, sugar, and vanilla until smooth.\nAdd the flour, salt, baking soda, baking powder, and cinnamon, mixing until well combined.\nStir in the zucchini, chocolate chips, and nuts.\nPour the batter into the prepared pan.\nBake the bread for 55 to 60 minutes, until the loaf tests done (a toothpick or cake tester inserted into the center will come out clean, save for perhaps a smear of chocolate).\nRemove the bread from the oven, and let it cool for 10 to 15 minutes before turning it out of the pan onto a rack.\nCool completely before slicing; store well-wrapped, at room temperature.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("kingarthurbaking.com")
    expect(recipe.canonical_url).to eq("https://www.kingarthurbaking.com/recipes/100-whole-wheat-zucchini-chocolate-chip-bread-recipe")
    expect(recipe.site_name).to eq("King Arthur Baking")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("PJ Hamel")
    expect(recipe.description).to eq("Facing a zucchini surplus? This moist, dense bread, with its mild hint of cinnamon, offers a sweet surprise: chocolate chips. Never thought of adding chocolate chips to zucchini bread? Give it a try; the rich flavor of chocolate marries perfectly with the earthiness of zucchini and brown sugar.")
    expect(recipe.image).to eq("https://www.kingarthurbaking.com/sites/default/files/2019-08/100-percent-whole-wheat-zucchini-chocolate-chip-bread_1.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("16 servings")
    expect(recipe.total_time).to eq(70)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(60)
    expect(recipe.keywords).to eq(["Quick Bread;;Chocolate;;Whole Grain;;Quick & easy;;Dairy-free;;Whole Grain"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.6)
    expect(recipe.ratings_count).to eq(71)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 slice (72g)",
      "calories" => "210 calories",
      "carbohydrateContent" => "27g",
      "cholesterolContent" => "25mg",
      "fiberContent" => "1g",
      "proteinContent" => "4g",
      "sodiumContent" => "210mg",
      "sugarContent" => "15g",
      "fatContent" => "11g",
      "saturatedFatContent" => "3g",
      "transFatContent" => "0g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "slice", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 210.0 },
      { name: "carbohydrateContent", unit: "g", amount: 27.0 },
      { name: "cholesterolContent", unit: "mg", amount: 25.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "proteinContent", unit: "g", amount: 4.0 },
      { name: "sodiumContent", unit: "mg", amount: 210.0 },
      { name: "sugarContent", unit: "g", amount: 15.0 },
      { name: "fatContent", unit: "g", amount: 11.0 },
      { name: "saturatedFatContent", unit: "g", amount: 3.0 },
      { name: "transFatContent", unit: "g", amount: 0.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
