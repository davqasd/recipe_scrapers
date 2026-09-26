# frozen_string_literal: true

RSpec.describe "thekitchencommunity.org" do
  subject(:recipe) { scrape_cassette("org/thekitchencommunity", url: "https://thekitchencommunity.org/crock-pot-mac-and-cheese/") }

  it "reads the title" do
    expect(recipe.title).to eq("Our BEST Crock Pot Mac and Cheese Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 pound pasta",
      "2 1/3 cups of milk",
      "12 oz evaporated milk",
      "12 oz shredded sharp cheddar",
      "1 cup American cheese shredded",
      "1 1/4 teaspoon salt",
      "1/2 teaspoon pepper",
      "1/2 teaspoon dry ground mustard",
      "1/3 teaspoon garlic powder",
      "A sprinkle of cayenne pepper",
      "1/4 cup of butter"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "pound", name: "pasta" },
      { amount: 2.33, unit: "cups", name: "milk" },
      { amount: 12.0, unit: "oz", name: "evaporated milk" },
      { amount: 12.0, unit: "oz", name: "shredded sharp cheddar" },
      { amount: 1.0, unit: "cup", name: "American cheese shredded" },
      { amount: 1.25, unit: "teaspoon", name: "salt" },
      { amount: 0.5, unit: "teaspoon", name: "pepper" },
      { amount: 0.5, unit: "teaspoon", name: "dry ground mustard" },
      { amount: 0.33, unit: "teaspoon", name: "garlic powder" },
      { amount: 1.0, unit: "sprinkle", name: "cayenne pepper" },
      { amount: 0.25, unit: "cup", name: "butter" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Spray your crockpot with non-stick spray.",
      "Rinse your uncooked pasta in a strainer and drain out all the excess water.",
      "Add your uncooked pasta to your crockpot along with your milk, cheese, mustard, garlic, salt, pepper, and cayenne. Stir everything well so all the ingredients mix together and make sure the macaroni is in the liquid as much as possible.",
      "Add your cubed butter.",
      "Cover your crock pot and turn on the low heat and cook for 1 hour. Remove the lid and stir all your ingredients before replacing the lid. Check the consistency because your dish may be done or require an additional 1-2 hours.",
      "Check your dish every half hour if it is not done and remember to stir when checking your dish.",
      "You will know your mac and cheese is done if the pasta is tender and the liquid is thick and creamy. Once you remove the lid, keep in mind the sauce will thicken even more as the mac and cheese sits."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Spray your crockpot with non-stick spray.\nRinse your uncooked pasta in a strainer and drain out all the excess water.\nAdd your uncooked pasta to your crockpot along with your milk, cheese, mustard, garlic, salt, pepper, and cayenne. Stir everything well so all the ingredients mix together and make sure the macaroni is in the liquid as much as possible.\nAdd your cubed butter.\nCover your crock pot and turn on the low heat and cook for 1 hour. Remove the lid and stir all your ingredients before replacing the lid. Check the consistency because your dish may be done or require an additional 1-2 hours.\nCheck your dish every half hour if it is not done and remember to stir when checking your dish.\nYou will know your mac and cheese is done if the pasta is tender and the liquid is thick and creamy. Once you remove the lid, keep in mind the sauce will thicken even more as the mac and cheese sits.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thekitchencommunity.org")
    expect(recipe.canonical_url).to eq("https://thekitchencommunity.org/crock-pot-mac-and-cheese/")
    expect(recipe.site_name).to eq("The Kitchen Community")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Cassie Marshall")
    expect(recipe.description).to eq("Simply the BEST Crockpot Mac and Cheese recipe out there. Give it a try!Don't cook the noodles for this recipe, just throw in your milk, cheese, and seasonings together in the slow cooker and you'll have a delicious family meal ready in no time!")
    expect(recipe.image).to eq("https://thekitchencommunity.org/wp-content/uploads/2022/01/shutterstock_556523302-1200x802.jpg")
    expect(recipe.category).to eq("Side Dish")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(125)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["crockpot mac and cheese"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(25)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "calories" => "574 kcal", "servingSize" => "1 serving" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 574.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
