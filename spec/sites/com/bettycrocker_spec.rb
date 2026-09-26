# frozen_string_literal: true

RSpec.describe "bettycrocker.com" do
  subject(:recipe) { scrape_cassette("com/bettycrocker", url: "https://www.bettycrocker.com/recipes/eclair-bars/0cb1d3f0-f074-400b-aa5a-5e729102c4ec") }

  it "reads the title" do
    expect(recipe.title).to eq("Éclair Bars")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 can (8 oz) refrigerated Pillsbury™ Original Crescent Dough Sheet",
      "2 boxes (3.4 oz each) Jell-O™ vanilla-flavor instant pudding & pie filling mix",
      "3 cups cold half-and-half",
      "1 1/2 cups semisweet chocolate chips",
      "3/4 cup heavy whipping cream"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "can", name: "refrigerated Pillsbury™ Original Crescent Dough Sheet" },
      { amount: 2.0, unit: "boxes", name: "Jell-O™ vanilla-flavor instant pudding & pie filling mix" },
      { amount: 3.0, unit: "cups", name: "cold half-and-half" },
      { amount: 1.5, unit: "cups", name: "semisweet chocolate chips" },
      { amount: 0.75, unit: "cup", name: "heavy whipping cream" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Step 1",
      "Heat oven to 375°F. Spray bottom only of 13x9-inch pan with cooking spray.",
      "Step 2",
      "Unroll crescent dough; press in bottom of pan. Bake 12 to 14 minutes or until golden brown and baked through. Remove from oven to cooling rack; cool 20 minutes.",
      "Step 3",
      "In medium bowl, beat dry pudding mixes and half-and-half with whisk about 2 minutes or until thick. Spread over cooled bar base.",
      "Step 4",
      "In medium microwavable bowl, microwave chocolate chips and whipping cream uncovered on High 1 minute; stir. Microwave 30 seconds; stir until smooth. Carefully spread mixture on top of pudding layer. Refrigerate about 4 hours or until cooled completely.",
      "Step 5",
      "When ready to serve, using a sharp knife and up-and-down sawing motion for cleaner cuts, cut into 6 rows by 4 rows. Store covered in refrigerator."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Step 1\nHeat oven to 375°F. Spray bottom only of 13x9-inch pan with cooking spray.\nStep 2\nUnroll crescent dough; press in bottom of pan. Bake 12 to 14 minutes or until golden brown and baked through. Remove from oven to cooling rack; cool 20 minutes.\nStep 3\nIn medium bowl, beat dry pudding mixes and half-and-half with whisk about 2 minutes or until thick. Spread over cooled bar base.\nStep 4\nIn medium microwavable bowl, microwave chocolate chips and whipping cream uncovered on High 1 minute; stir. Microwave 30 seconds; stir until smooth. Carefully spread mixture on top of pudding layer. Refrigerate about 4 hours or until cooled completely.\nStep 5\nWhen ready to serve, using a sharp knife and up-and-down sawing motion for cleaner cuts, cut into 6 rows by 4 rows. Store covered in refrigerator.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("bettycrocker.com")
    expect(recipe.canonical_url).to eq("https://www.bettycrocker.com/recipes/eclair-bars/0cb1d3f0-f074-400b-aa5a-5e729102c4ec")
    expect(recipe.site_name).to eq("Betty Crocker")
    expect(recipe.language).to eq("en-us")
    expect(recipe.author).to eq("Betty Crocker Kitchens")
    expect(recipe.description).to eq("We turned the classic, cream-filled French pastry into an oh-so-easy bar! With a flaky crescent base, a layer of silky vanilla pudding and a topping of rich chocolate ganache, this is a special dessert that’s guaranteed to impress.")
    expect(recipe.image).to eq("https://mojo.generalmills.com/api/public/content/soxzlW4wykCctkAYPLGPTA_gmi_hi_res_jpeg.jpeg?v=89e8f65e&t=466b54bb264e48b199fc8e83ef1136b4")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("24 servings")
    expect(recipe.total_time).to eq(290)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq([
      "european",
      "french",
      "chill",
      "dessert",
      "baking",
      "pan",
      "desserts",
      "&",
      "treats",
      "bar",
      "dough",
      "crescent",
      "flavors",
      "extracts",
      "vanilla",
      "chocolate",
      "chips",
      "chunks"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "180 calories",
      "cholesterolContent" => "20 milligrams",
      "fiberContent" => "0 grams",
      "proteinContent" => "2 grams",
      "saturatedFatContent" => "6 grams",
      "sodiumContent" => "210 milligrams",
      "sugarContent" => "14 grams",
      "carbohydrateContent" => "21 grams",
      "fatContent" => "10 grams",
      "transFatContent" => "0 grams",
      "servingSize" => "1 Bar"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 180.0 },
      { name: "cholesterolContent", unit: "mg", amount: 20.0 },
      { name: "fiberContent", unit: "g", amount: 0.0 },
      { name: "proteinContent", unit: "g", amount: 2.0 },
      { name: "saturatedFatContent", unit: "g", amount: 6.0 },
      { name: "sodiumContent", unit: "mg", amount: 210.0 },
      { name: "sugarContent", unit: "g", amount: 14.0 },
      { name: "carbohydrateContent", unit: "g", amount: 21.0 },
      { name: "fatContent", unit: "g", amount: 10.0 },
      { name: "transFatContent", unit: "g", amount: 0.0 },
      { name: "servingSize", unit: "Bar", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-layout-content")
  end
end
