# frozen_string_literal: true

RSpec.describe "sunbasket.com" do
  subject(:recipe) { scrape_cassette("com/sunbasket", url: "https://sunbasket.com/recipe/black-bean-quinoa-burgers-with-sweet-potato-fries-1") }

  it "reads the title" do
    expect(recipe.title).to eq("Black bean–quinoa burgers with sweet potato fries")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "¼ cup rainbow quinoa",
      "2 organic sweet potatoes",
      "1 cup cooked black beans",
      "3 organic scallions",
      "Sunbasket vegan “cheese” blend (almond milk - cashew butter - granulated garlic - nutritional yeast - kosher salt - onion powder)",
      "Sunbasket burger blend (whole wheat panko - all-purpose flour - granulated garlic - coriander - cumin)",
      "1 head organic green leaf or other lettuce",
      "2 vegan whole wheat buns",
      "2 ounces organic shredded carrots"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.25, unit: "cup", name: "rainbow quinoa" },
      { amount: 2.0, unit: nil, name: "organic sweet potatoes" },
      { amount: 1.0, unit: "cup", name: "cooked black beans" },
      { amount: 3.0, unit: nil, name: "organic scallions" },
      { amount: nil, unit: nil, name: "Sunbasket vegan “cheese” blend" },
      { amount: nil, unit: nil, name: "Sunbasket burger blend" },
      { amount: 1.0, unit: "head", name: "organic green leaf or other lettuce" },
      { amount: 2.0, unit: nil, name: "vegan whole wheat buns" },
      { amount: 2.0, unit: "ounces", name: "organic shredded carrots" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Cook the quinoa",
      "Prep and roast the sweet potato fries",
      "Prep the patties",
      "Cook the patties",
      "Prep the lettuce; toast the buns",
      "Serve"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Cook the quinoa\nPrep and roast the sweet potato fries\nPrep the patties\nCook the patties\nPrep the lettuce; toast the buns\nServe")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("sunbasket.com")
    expect(recipe.canonical_url).to eq("https://sunbasket.com/recipe/black-bean-quinoa-burgers-with-sweet-potato-fries-1")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Sunbasket")
    expect(recipe.description).to eq("This protein dream team, black beans and quinoa, make up our vegan burger, while cashew butter and nutritional yeast stand in for cheese.")
    expect(recipe.image).to eq("https://cdn.sunbasket.com/808313e9-312f-4c4f-b6a6-48c2cf1f9548.jpeg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.0)
    expect(recipe.ratings_count).to eq(1542)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "sugarContent" => "15g",
      "proteinContent" => "28g",
      "fiberContent" => "24g",
      "fatContent" => "22g",
      "cholesterolContent" => "0mg",
      "calories" => "780",
      "saturatedFatContent" => "3g",
      "sodiumContent" => "640mg"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "sugarContent", unit: "g", amount: 15.0 },
      { name: "proteinContent", unit: "g", amount: 28.0 },
      { name: "fiberContent", unit: "g", amount: 24.0 },
      { name: "fatContent", unit: "g", amount: 22.0 },
      { name: "cholesterolContent", unit: "mg", amount: 0.0 },
      { name: "calories", unit: nil, amount: 780.0 },
      { name: "saturatedFatContent", unit: "g", amount: 3.0 },
      { name: "sodiumContent", unit: "mg", amount: 640.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/join")
  end
end
