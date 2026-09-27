# frozen_string_literal: true

RSpec.describe "kennymcgovern.com" do
  subject(:recipe) { scrape_cassette("com/kennymcgovern", url: "https://kennymcgovern.com/slow-cooked-lamb-for-indian-curry-dishes-indian-restaurant-style") }

  it "reads the title" do
    expect(recipe.title).to eq("Lamb For Indian Curry Dishes (Indian Takeaway Style)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1/2 teaspoon cumin seeds",
      "1/2 teaspoon coriander seeds",
      "1/4 teaspoon black peppercorns",
      "2 green cardamom pods, crushed",
      "2 cloves",
      "1/4 cinnamon stick or cassia bark",
      "1 Indian bay leaf (Tej Patta)",
      "1/4 teaspoon garam masala",
      "1/4 teaspoon smoked paprika",
      "1/2 teaspoon turmeric",
      "1/4 teaspoon beetroot powder",
      "Pinch dried fenugreek leaves (methi)",
      "1/2 teaspoon sea salt",
      "50 millilitres sunflower oil",
      "200 millilitres water",
      "400 grams leg of lamb, diced"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.5, unit: "teaspoon", name: "cumin seeds" },
      { amount: 0.5, unit: "teaspoon", name: "coriander seeds" },
      { amount: 0.25, unit: "teaspoon", name: "black peppercorns" },
      { amount: 2.0, unit: nil, name: "green cardamom pods, crushed" },
      { amount: 2.0, unit: "cloves", name: nil },
      { amount: 0.25, unit: nil, name: "cinnamon stick or cassia bark" },
      { amount: 1.0, unit: nil, name: "Indian bay leaf" },
      { amount: 0.25, unit: "teaspoon", name: "garam masala" },
      { amount: 0.25, unit: "teaspoon", name: "smoked paprika" },
      { amount: 0.5, unit: "teaspoon", name: "turmeric" },
      { amount: 0.25, unit: "teaspoon", name: "beetroot powder" },
      { amount: 1.0, unit: "Pinch", name: "dried fenugreek leaves" },
      { amount: 0.5, unit: "teaspoon", name: "sea salt" },
      { amount: 50.0, unit: "millilitres", name: "sunflower oil" },
      { amount: 200.0, unit: "millilitres", name: "water" },
      { amount: 400.0, unit: "grams", name: "leg of lamb, diced" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a pot or large frying pan, add 1/2 teaspoon cumin seeds, 1/2 teaspoon coriander seeds, 1/4 teaspoon black peppercorns, 2 green cardamom pods, crushed, 2 cloves, 1/4 cinnamon stick or cassia bark, 1 Indian bay leaf (Tej Patta), 1/4 teaspoon garam masala, 1/4 teaspoon smoked paprika, 1/2 teaspoon turmeric, 1/4 teaspoon beetroot powder, Pinch dried fenugreek leaves (methi), 1/2 teaspoon sea salt, 50 millilitres sunflower oil and 200 millilitres water. Bring to the boil, mix well and reduce the heat to medium. Allow the spices to simmer in the oil and water for 5 minutes.",
      "Add 400 grams leg of lamb, diced. Reduce the heat to low and simmer for 45 minutes, or until the lamb pieces are tender. Remove from the heat and set aside to cool (leave the lamb in the spiced stock as it cools). Strain the lamb and discard the stock. The cooked lamb pieces are now ready to use in your favourite Indian curry dishes."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a pot or large frying pan, add 1/2 teaspoon cumin seeds, 1/2 teaspoon coriander seeds, 1/4 teaspoon black peppercorns, 2 green cardamom pods, crushed, 2 cloves, 1/4 cinnamon stick or cassia bark, 1 Indian bay leaf (Tej Patta), 1/4 teaspoon garam masala, 1/4 teaspoon smoked paprika, 1/2 teaspoon turmeric, 1/4 teaspoon beetroot powder, Pinch dried fenugreek leaves (methi), 1/2 teaspoon sea salt, 50 millilitres sunflower oil and 200 millilitres water. Bring to the boil, mix well and reduce the heat to medium. Allow the spices to simmer in the oil and water for 5 minutes.\nAdd 400 grams leg of lamb, diced. Reduce the heat to low and simmer for 45 minutes, or until the lamb pieces are tender. Remove from the heat and set aside to cool (leave the lamb in the spiced stock as it cools). Strain the lamb and discard the stock. The cooked lamb pieces are now ready to use in your favourite Indian curry dishes.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("kennymcgovern.com")
    expect(recipe.canonical_url).to eq("https://kennymcgovern.com/slow-cooked-lamb-for-indian-curry-dishes-indian-restaurant-style")
    expect(recipe.site_name).to eq("Kenny McGovern")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Kenny McGovern")
    expect(recipe.description).to eq("Make curry night easy with this restaurant style slow cooked lamb for Indian curry dishes recipe, perfect for adding to takeaway style curries.")
    expect(recipe.image).to eq("https://kennymcgovern.com/wp-content/uploads/2025/08/Indian-Takeaway-Style-Slow-Cooked-Lamb-For-Curry-Dishes-Recipe.png")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("Indian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("3 servings")
    expect(recipe.total_time).to eq(55)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(45)
    expect(recipe.keywords).to eq(["indian curry", "lamb curry", "indian lamb curry", "slow cooked lamb"])
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
    expect(recipe.links).to include("#main")
  end
end
