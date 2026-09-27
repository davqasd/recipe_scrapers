# frozen_string_literal: true

RSpec.describe "hellofresh.com" do
  subject(:recipe) { scrape_cassette("com/hellofresh", url: "https://www.hellofresh.com/recipes/low-lift-bbq-pulled-chicken-and-gouda-sandwiches-69793456bcdfd65d69c344cd") }

  it "reads the title" do
    expect(recipe.title).to eq("Low-Lift BBQ Pulled Chicken & Gouda Sandwiches Enjoy a head start with prepped ingredients & precooked chicken")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 unit Sliced Dill Pickle",
      "1 piece Smoky Ranch Salad Kit",
      "4 tablespoon BBQ Sauce",
      "8 ounce Sous Vide Chopped Chicken",
      "2 teaspoon White Wine Vinegar",
      "2 slice Gouda Cheese",
      "2 unit Brioche Buns",
      "1 tablespoon Southwest Spice Blend",
      "2 unit Potato Chips",
      "teaspoon (tsp) Salt",
      "teaspoon (tsp) Black Pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "unit Sliced Dill Pickle" },
      { amount: 1.0, unit: "piece", name: "Smoky Ranch Salad Kit" },
      { amount: 4.0, unit: "tablespoon", name: "BBQ Sauce" },
      { amount: 8.0, unit: "ounce", name: "Sous Vide Chopped Chicken" },
      { amount: 2.0, unit: "teaspoon", name: "White Wine Vinegar" },
      { amount: 2.0, unit: "slice", name: "Gouda Cheese" },
      { amount: 2.0, unit: nil, name: "unit Brioche Buns" },
      { amount: 1.0, unit: "tablespoon", name: "Southwest Spice Blend" },
      { amount: 2.0, unit: nil, name: "unit Potato Chips" },
      { amount: nil, unit: nil, name: "teaspoon Salt" },
      { amount: nil, unit: nil, name: "teaspoon Black Pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Place chicken in a small pot; using two forks (or your hands!), shred into smaller pieces. Add BBQ sauce, Southwest Spice Blend, a splash of vinegar (big splash for 4 servings), a splash of water, and a pinch of pepper. Stir to combine; cover with lid. Cook over medium heat, stirring occasionally, until warmed through, 4-5 minutes.",
      "Meanwhile, halve buns and toast until golden.",
      "Empty contents of salad kit into a large bowl; drizzle with as much dressing as you like, then toss to evenly coat.",
      "Add gouda to bottom buns and top with as much BBQ chicken as you like. Top with as much sliced pickle as you like. Close sandwiches and divide between plates. Serve with salad, potato chips, and any remaining sliced pickle on the side. TIP: Want extra crunch on your sandwiches? Add some potato chips!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Place chicken in a small pot; using two forks (or your hands!), shred into smaller pieces. Add BBQ sauce, Southwest Spice Blend, a splash of vinegar (big splash for 4 servings), a splash of water, and a pinch of pepper. Stir to combine; cover with lid. Cook over medium heat, stirring occasionally, until warmed through, 4-5 minutes.\nMeanwhile, halve buns and toast until golden.\nEmpty contents of salad kit into a large bowl; drizzle with as much dressing as you like, then toss to evenly coat.\nAdd gouda to bottom buns and top with as much BBQ chicken as you like. Top with as much sliced pickle as you like. Close sandwiches and divide between plates. Serve with salad, potato chips, and any remaining sliced pickle on the side. TIP: Want extra crunch on your sandwiches? Add some potato chips!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hellofresh.com")
    expect(recipe.canonical_url).to eq("https://www.hellofresh.com/recipes/low-lift-bbq-pulled-chicken-and-gouda-sandwiches-69793456bcdfd65d69c344cd")
    expect(recipe.site_name).to eq("HelloFresh")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Sara Heilman")
    expect(recipe.description).to eq("In developing Low-Lift suppers, our chefs used their tool kit of culinary hacks and fresh, flavorful ingredients to craft easy-cook meals that will fast-track you to dinner in under 10 minutes. Here, tender BBQ chicken with Southwest seasoning meets gouda on toasted brioche buns. Crispy ranch salad and potato chips add cool crunch for the ultimate flavor combo. Quick, delicious, and ready when you are!")
    expect(recipe.image).to eq("https://img.hellofresh.com/f_auto,fl_lossy,h_640,q_auto,w_1200/hellofresh_s3/image/HFUSRC_R18364A_Hero_QuickAssemblySaucyPulledPorkSandos_W17_unknown_slot_2026_Web-4f297116.jpg")
    expect(recipe.category).to eq("main course")
    expect(recipe.cuisine).to eq("North American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.051012387020981)
    expect(recipe.ratings_count).to eq(1741)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "990 kcal",
      "fatContent" => "50 g",
      "saturatedFatContent" => "13 g",
      "carbohydrateContent" => "92 g",
      "sugarContent" => "24 g",
      "proteinContent" => "41 g",
      "fiberContent" => "7 g",
      "cholesterolContent" => "120 mg",
      "sodiumContent" => "2150 mg"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 990.0 },
      { name: "fatContent", unit: "g", amount: 50.0 },
      { name: "saturatedFatContent", unit: "g", amount: 13.0 },
      { name: "carbohydrateContent", unit: "g", amount: 92.0 },
      { name: "sugarContent", unit: "g", amount: 24.0 },
      { name: "proteinContent", unit: "g", amount: 41.0 },
      { name: "fiberContent", unit: "g", amount: 7.0 },
      { name: "cholesterolContent", unit: "mg", amount: 120.0 },
      { name: "sodiumContent", unit: "mg", amount: 2150.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#page")
  end
end
