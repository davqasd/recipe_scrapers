# frozen_string_literal: true

RSpec.describe "poppycooks.com" do
  subject(:recipe) { scrape_cassette("com/poppycooks", url: "https://www.poppycooks.com/recipes/chicken-katsu-curry/") }

  it "reads the title" do
    expect(recipe.title).to eq("Chicken Katsu Curry")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 brown onion, chopped",
      "2 cloves garlic, grated",
      "1 carrot, peeled and grated",
      "1 apple, peeled and grated",
      "1 thumb sized piece of ginger, peeled and grated",
      "1 tbsp curry powder",
      "½ tbsp turmeric powder",
      "1 tbsp plain flour for the sauce, 2 tbsp for the chicken",
      "1 tin full fat coconut milk",
      "1 tbsp palm sugar, chopped (or honey if you can’t find palm sugar)",
      "Soy sauce to season",
      "2 chicken breasts",
      "1 large egg, beaten",
      "100g panko breadcrumbs"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "brown onion, chopped" },
      { amount: 2.0, unit: "cloves", name: "garlic, grated" },
      { amount: 1.0, unit: nil, name: "carrot, peeled and grated" },
      { amount: 1.0, unit: nil, name: "apple, peeled and grated" },
      { amount: 1.0, unit: "thumb", name: "sized piece of ginger, peeled and grated" },
      { amount: 1.0, unit: "tbsp", name: "curry powder" },
      { amount: 0.5, unit: "tbsp", name: "turmeric powder" },
      { amount: 1.0, unit: "tbsp", name: "plain flour for the sauce, 2 tbsp for the chicken" },
      { amount: 1.0, unit: "tin", name: "full fat coconut milk" },
      { amount: 1.0, unit: "tbsp", name: "palm sugar, chopped" },
      { amount: nil, unit: nil, name: "Soy sauce to season" },
      { amount: 2.0, unit: nil, name: "chicken breasts" },
      { amount: 1.0, unit: nil, name: "large egg, beaten" },
      { amount: 100.0, unit: "g", name: "panko breadcrumbs" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Dry fry the curry powder and turmeric in a saucepan over a medium heat until fragrant, then chuck in the onions, carrot, apple, ginger and garlic to fry off with a drizzle of oil. Allow to cook for 10 minutes until soft.",
      "Add in the flour for the sauce and cook out. Make the chicken stock cube up with boiling water to 500ml/1 pint and pour it all in with the coconut milk and palm sugar. Leave this to simmer away for about 30-45 minutes until slightly thickened.",
      "Slice your chicken breasts lengthways down the middle to get 4 flat breast pieces. Season your flour, then coat the chicken with flour, egg and finally breadcrumbs. Preheat a pan with a good glug of vegetable oil to shallow fry your chicken in.",
      "Fry off the chicken until golden brown and crispy on both sides. Check your chicken is cooked through either by cutting into it or use a temperature probe. Leave the chicken to rest while you finish the sauce.",
      "Pour the sauce into a new saucepan through a fine sieve and push all of the juices out with the back of a spoon.",
      "Serve up with rice, chilli oil and plenty of the sauce over the top."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Dry fry the curry powder and turmeric in a saucepan over a medium heat until fragrant, then chuck in the onions, carrot, apple, ginger and garlic to fry off with a drizzle of oil. Allow to cook for 10 minutes until soft.\nAdd in the flour for the sauce and cook out. Make the chicken stock cube up with boiling water to 500ml/1 pint and pour it all in with the coconut milk and palm sugar. Leave this to simmer away for about 30-45 minutes until slightly thickened.\nSlice your chicken breasts lengthways down the middle to get 4 flat breast pieces. Season your flour, then coat the chicken with flour, egg and finally breadcrumbs. Preheat a pan with a good glug of vegetable oil to shallow fry your chicken in.\nFry off the chicken until golden brown and crispy on both sides. Check your chicken is cooked through either by cutting into it or use a temperature probe. Leave the chicken to rest while you finish the sauce.\nPour the sauce into a new saucepan through a fine sieve and push all of the juices out with the back of a spoon.\nServe up with rice, chilli oil and plenty of the sauce over the top.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("poppycooks.com")
    expect(recipe.canonical_url).to eq("https://www.poppycooks.com/recipes/chicken-katsu-curry/")
    expect(recipe.site_name).to eq("Poppy Cooks")
    expect(recipe.language).to eq("en-GB")
    expect(recipe.author).to eq("Poppy Cooks")
    expect(recipe.description).to eq("Discover our delectable Chicken Katsu Curry recipe, including an ingredients list, method and top tips. Give it a try and let us know what you think!")
    expect(recipe.image).to eq("https://www.poppycooks.com/wp-content/uploads/2024/07/Screenshot-2024-03-13-at-13.41.19.png")
    expect(recipe.category).to eq("Main")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#fl-main-content")
  end
end
