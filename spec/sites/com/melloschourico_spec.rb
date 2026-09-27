# frozen_string_literal: true

RSpec.describe "melloschourico.com" do
  subject(:recipe) { scrape_cassette("com/melloschourico", url: "https://www.melloschourico.com/recipes/portuguese-roasted-chourico-and-potatoes") }

  it "reads the title" do
    expect(recipe.title).to eq("Portuguese Roasted Chourico & Potatoes")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2-1/2 to 3 lbs egg-sized potatoes (peeled)",
      "3/4 cup peanut oil",
      "2 tsp of Portuguese paprika (colourau)",
      "1 cup white wine",
      "2 medium sized onions (chopped)",
      "6 cloves of garlic (chopped)",
      "2 bay leaves",
      "Chicken broth",
      "2 tbs tomato paste",
      "4 links of chouriço (about 2 lbs)",
      "Salt and pepper to taste"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "to 3 lbs egg-sized potatoes" },
      { amount: 0.75, unit: "cup", name: "peanut oil" },
      { amount: 2.0, unit: "tsp", name: "Portuguese paprika" },
      { amount: 1.0, unit: "cup", name: "white wine" },
      { amount: 2.0, unit: nil, name: "medium sized onions" },
      { amount: 6.0, unit: "cloves", name: "garlic" },
      { amount: 2.0, unit: nil, name: "bay leaves" },
      { amount: nil, unit: nil, name: "Chicken broth" },
      { amount: 2.0, unit: "tbs", name: "tomato paste" },
      { amount: 4.0, unit: nil, name: "links of chouriço" },
      { amount: nil, unit: nil, name: "Salt and pepper to taste" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 500°F.",
      "Peel the potatoes and place them in a bowl of water while you prepare the other ingredients. Mix the paprika in the peanut oil, blend it well. Set aside.",
      "In a roasting pan (I use a 9\" x 13\" x 2\" Pyrex), add the wine, onions, garlic, bay leaves and tomato paste. Be sure to blend all the ingredients well.",
      "Space out the chourico links in the roasting pan, then the potatoes equally around and between them. Drizzle all of the peanut oil/paprika mixture over the potatoes. Add as much chicken broth as needed until the liquid just over half covers the potatoes.",
      "Place it in the oven until it reaches a boil. Then reduce the temperature to 350°F and continue cooking another 30 minutes.",
      "Turn the potatoes and chourico over, then replace the pan in the oven and continue cooking another 15 to 30 minutes until the potatoes are tender.",
      "Remove from the oven allow to cool for 5 minutes. Then cut up chourico and return to pan. Coat all in the juices.",
      "Serve with a hearty red wine and a good crusty bread."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 500°F.\nPeel the potatoes and place them in a bowl of water while you prepare the other ingredients. Mix the paprika in the peanut oil, blend it well. Set aside.\nIn a roasting pan (I use a 9\" x 13\" x 2\" Pyrex), add the wine, onions, garlic, bay leaves and tomato paste. Be sure to blend all the ingredients well.\nSpace out the chourico links in the roasting pan, then the potatoes equally around and between them. Drizzle all of the peanut oil/paprika mixture over the potatoes. Add as much chicken broth as needed until the liquid just over half covers the potatoes.\nPlace it in the oven until it reaches a boil. Then reduce the temperature to 350°F and continue cooking another 30 minutes.\nTurn the potatoes and chourico over, then replace the pan in the oven and continue cooking another 15 to 30 minutes until the potatoes are tender.\nRemove from the oven allow to cool for 5 minutes. Then cut up chourico and return to pan. Coat all in the juices.\nServe with a hearty red wine and a good crusty bread.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("melloschourico.com")
    expect(recipe.canonical_url).to eq("https://www.melloschourico.com/recipes/portuguese-roasted-chourico-and-potatoes")
    expect(recipe.site_name).to eq("Mello's Chourico & Linguica")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Created for Mello's Chourico courtesy of choponionsboilwater.com")
    expect(recipe.image).to eq("http://static1.squarespace.com/static/5b71a5e74cde7a0377ed060d/6085c856ccc2a078c8f921b9/6085e9246252291f4b202340/1619879781874/Portuguese+Roasted+Chourico+and+Potatoes.jpg?format=1500w")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("/")
  end
end
