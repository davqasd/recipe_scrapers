# frozen_string_literal: true

RSpec.describe "tidymom.net" do
  subject(:recipe) { scrape_cassette("net/tidymom", url: "https://tidymom.net/chicken-bacon-ranch-pizza/") }

  it "reads the title" do
    expect(recipe.title).to eq("Chicken Bacon Ranch Pizza")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 pizza crust",
      "1 teaspoon olive oil",
      "1-2 teaspoons Italian seasoning",
      "1 teaspoon garlic powder",
      "2/3 cup ranch dressing",
      "1 tomato, sliced and diced",
      "1/4 cups green onion, chopped",
      "1½ cup shredded mozzarella cheese *(see notes)",
      "1½ cups shredded cheddar cheese *(see notes)",
      "1/4 cup Parmesan cheese",
      "1½ cup chopped or shredded cooked chicken *(see notes)",
      "4 slices of bacon, cooked and crumbled *(see notes)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "pizza crust" },
      { amount: 1.0, unit: "teaspoon", name: "olive oil" },
      { amount: 1.0, unit: "teaspoons", name: "Italian seasoning" },
      { amount: 1.0, unit: "teaspoon", name: "garlic powder" },
      { amount: 0.67, unit: "cup", name: "ranch dressing" },
      { amount: 1.0, unit: nil, name: "tomato, sliced and diced" },
      { amount: 0.25, unit: "cups", name: "green onion, chopped" },
      { amount: 1.5, unit: "cup", name: "shredded mozzarella cheese *" },
      { amount: 1.5, unit: "cups", name: "shredded cheddar cheese *" },
      { amount: 0.25, unit: "cup", name: "Parmesan cheese" },
      { amount: 1.5, unit: "cup", name: "chopped or shredded cooked chicken *" },
      { amount: 4.0, unit: "slices", name: "bacon, cooked and crumbled *" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 425° F",
      "Put the pizza crust on a pizza pan or pizza peel. Using a pastry brush, lightly brush the entire crust with olive oil and season with Italian seasoning and garlic powder.",
      "Evenly spread ranch dressing over the crust.",
      "Sprinkle with cheese then top with chicken, tomatoes, green onions, and bacon crumbs.",
      "Place the pizza* in the oven for 15-20 minutes or until cheese is melted and crust is golden. Let rest for several minutes, then cut and serve."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 425° F\nPut the pizza crust on a pizza pan or pizza peel. Using a pastry brush, lightly brush the entire crust with olive oil and season with Italian seasoning and garlic powder.\nEvenly spread ranch dressing over the crust.\nSprinkle with cheese then top with chicken, tomatoes, green onions, and bacon crumbs.\nPlace the pizza* in the oven for 15-20 minutes or until cheese is melted and crust is golden. Let rest for several minutes, then cut and serve.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("tidymom.net")
    expect(recipe.canonical_url).to eq("https://tidymom.net/chicken-bacon-ranch-pizza/")
    expect(recipe.site_name).to eq("TidyMom®")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("TidyMom")
    expect(recipe.description).to eq("Chicken, smokey bacon, creamy ranch, and lots of gooey melted cheese are the perfect combo to pile on a pizza crust!")
    expect(recipe.image).to eq("https://tidymom.net/blog/wp-content/uploads/2021/04/chicken-bacon-ranch-pizza-pic-480x480.jpg")
    expect(recipe.category).to eq("Main Dish")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "485 calories",
      "carbohydrateContent" => "36 grams carbohydrates",
      "cholesterolContent" => "61 milligrams cholesterol",
      "fatContent" => "29 grams fat",
      "fiberContent" => "2 grams fiber",
      "proteinContent" => "20 grams protein",
      "saturatedFatContent" => "10 grams saturated fat",
      "servingSize" => "1",
      "sodiumContent" => "893 milligrams sodium",
      "sugarContent" => "3 grams sugar",
      "transFatContent" => "0 grams trans fat",
      "unsaturatedFatContent" => "17 grams unsaturated fat"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 485.0 },
      { name: "carbohydrateContent", unit: "g", amount: 36.0 },
      { name: "cholesterolContent", unit: "mg", amount: 61.0 },
      { name: "fatContent", unit: "g", amount: 29.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "proteinContent", unit: "g", amount: 20.0 },
      { name: "saturatedFatContent", unit: "g", amount: 10.0 },
      { name: "servingSize", unit: nil, amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 893.0 },
      { name: "sugarContent", unit: "g", amount: 3.0 },
      { name: "transFatContent", unit: "g", amount: 0.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 17.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
