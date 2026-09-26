# frozen_string_literal: true

RSpec.describe "cloudykitchen.com" do
  subject(:recipe) { scrape_cassette("com/cloudykitchen", url: "https://cloudykitchen.com/blog/how-to-make-pie-crust/") }

  it "reads the title" do
    expect(recipe.title).to eq("All Butter Pie Crust: A Beginner's Guide")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "375g all-purpose flour",
      "Pinch of Salt",
      "225g cold unsalted butter, cut into cubes",
      "240g cold water",
      "1 cup ice",
      "60g Apple cider vinegar"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 375.0, unit: "g", name: "all-purpose flour" },
      { amount: 1.0, unit: "Pinch", name: "Salt" },
      { amount: 225.0, unit: "g", name: "cold unsalted butter, cut into cubes" },
      { amount: 240.0, unit: "g", name: "cold water" },
      { amount: 1.0, unit: "cup", name: "ice" },
      { amount: 60.0, unit: "g", name: "Apple cider vinegar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Place flour and salt into a large bowl",
      ". Cut butter into chunks, and add to the flour. Toss lightly to coat.",
      "Incorporate the butter",
      "Working quickly, using a pastry blender or your thumb and fingers, cut the butter into the flour mixture until there are only large pea-sized chunks left. You want a few lumps of butter remaining to keep the pastry nice and tender.",
      "Add the water and mix the pie dough",
      "Combine ice, water and cider vinegar in a bowl. Sprinkle a few tablespoons of the ice water into the flour and butter mixture, and using a stiff spatula or your hands, mix in well. Continue adding water a tablespoon at a time ( I usually start with about 120g liquid, mix that in, then go from there and add additional liquid as needed) until you have a dough that holds together well, but is not too wet.",
      "Shape the pie dough",
      "Squeeze together with your fingertips to make a homogenous dough. Shape into a rectangle, Rest in the fridge for one hour.",
      "Laminate the pie dough",
      "Roll out the dough on a floured surface into a rectangle, fold it in thirds like a letter, then roll again and repeat the folding. Repeat this process one more time. Divide the dough into two pieces, and shape each into a disc by folding the edges under. Rewrap tightly in plastic, and rest for at least two hours, or preferably overnight, before using. Store pie crust in the fridge for up to 3 days, or in the freezer for up to 3 months."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Place flour and salt into a large bowl\n. Cut butter into chunks, and add to the flour. Toss lightly to coat.\nIncorporate the butter\nWorking quickly, using a pastry blender or your thumb and fingers, cut the butter into the flour mixture until there are only large pea-sized chunks left. You want a few lumps of butter remaining to keep the pastry nice and tender.\nAdd the water and mix the pie dough\nCombine ice, water and cider vinegar in a bowl. Sprinkle a few tablespoons of the ice water into the flour and butter mixture, and using a stiff spatula or your hands, mix in well. Continue adding water a tablespoon at a time ( I usually start with about 120g liquid, mix that in, then go from there and add additional liquid as needed) until you have a dough that holds together well, but is not too wet.\nShape the pie dough\nSqueeze together with your fingertips to make a homogenous dough. Shape into a rectangle, Rest in the fridge for one hour.\nLaminate the pie dough\nRoll out the dough on a floured surface into a rectangle, fold it in thirds like a letter, then roll again and repeat the folding. Repeat this process one more time. Divide the dough into two pieces, and shape each into a disc by folding the edges under. Rewrap tightly in plastic, and rest for at least two hours, or preferably overnight, before using. Store pie crust in the fridge for up to 3 days, or in the freezer for up to 3 months.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cloudykitchen.com")
    expect(recipe.canonical_url).to eq("https://cloudykitchen.com/blog/how-to-make-pie-crust/")
    expect(recipe.site_name).to eq("Cloudy Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Erin Clarkson")
    expect(recipe.description).to eq("Think you can't bake the most buttery, flaky pie crust home? Think again, because yes you can! Learn how to make the most perfectly flaky and tender all-butter pie crust in your own kitchen using a series of simple, easy folds, a technique called lamination. It's my secret for an ultra-flaky pie crust that's easy to work with, doesn't crumble, or leak. Made without vegetable shortening, my homemade pie crust has been tested, and perfected over many, many months. It's foolproof!")
    expect(recipe.image).to eq("https://cloudykitchen.com/wp-content/uploads/2021/11/latticed-apple-pie-225x225.jpg")
    expect(recipe.category).to eq("Pie")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to eq("Baking")
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(120)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Pie Crust", "Pie", "Easy pie crust", "pie crust recipe", "pie dough"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(62)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://cloudykitchen.com/")
  end
end
