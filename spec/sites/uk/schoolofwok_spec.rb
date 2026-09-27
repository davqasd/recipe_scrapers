# frozen_string_literal: true

RSpec.describe "schoolofwok.co.uk" do
  subject(:recipe) { scrape_cassette("uk/schoolofwok", url: "https://schoolofwok.co.uk/tips-and-recipes/beef-rendang-recipe") }

  it "reads the title" do
    expect(recipe.title).to eq("Beef Rendang – Slow-Cooked Indonesian Curry with Deep Coconut & Spice")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "800g-1kg beef shin, cut into large chunky pieces",
      "400ml full-fat coconut milk",
      "2-3 lime leaves, stem removed",
      "1 small cinnamon stick",
      "3-4 cloves",
      "10-15 dried red chillies, soaked and deseeded",
      "1-2 fresh red chillies",
      "2 stalks lemongrass, finely sliced",
      "1 thumb-sized piece galangal",
      "1 thumb-sized piece ginger",
      "1 small piece fresh turmeric (or 1 teaspoon ground turmeric)",
      "4-5 Thai shallots",
      "4 garlic cloves",
      "1/4 teaspoon salt",
      "80g desiccated coconut",
      "1 teaspoon palm sugar",
      "1 teaspoon tamarind paste",
      "Pinch salt"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 800.0, unit: nil, name: "g-1kg beef shin, cut into large chunky pieces" },
      { amount: 400.0, unit: "ml", name: "full-fat coconut milk" },
      { amount: 2.0, unit: nil, name: "lime leaves, stem removed" },
      { amount: 1.0, unit: nil, name: "small cinnamon stick" },
      { amount: 3.0, unit: "cloves", name: nil },
      { amount: 10.0, unit: nil, name: "dried red chillies, soaked and deseeded" },
      { amount: 1.0, unit: nil, name: "fresh red chillies" },
      { amount: 2.0, unit: "stalks", name: "lemongrass, finely sliced" },
      { amount: 1.0, unit: nil, name: "thumb-sized piece galangal" },
      { amount: 1.0, unit: nil, name: "thumb-sized piece ginger" },
      { amount: 1.0, unit: "piece", name: "fresh turmeric" },
      { amount: 4.0, unit: nil, name: "Thai shallots" },
      { amount: 4.0, unit: nil, name: "garlic cloves" },
      { amount: 0.25, unit: "teaspoon", name: "salt" },
      { amount: 80.0, unit: "g", name: "desiccated coconut" },
      { amount: 1.0, unit: "teaspoon", name: "palm sugar" },
      { amount: 1.0, unit: "teaspoon", name: "tamarind paste" },
      { amount: 1.0, unit: "Pinch", name: "salt" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Soak the dried red chillies in hot water for 10 minutes. Drain and deseed. Using a pestle and mortar, pound the dried chillies with the salt first, then gradually add the fresh chillies, lemongrass, galangal, ginger, turmeric, shallots and garlic. Pound firmly for 15-20 minutes until smooth and deeply fragrant.",
      "Toast the desiccated coconut in a dry pan over medium heat, stirring constantly until golden brown. Transfer to a pestle and mortar and grind into a thick paste to create the kerasik.",
      "Place the beef into a heavy-based pot or cast iron wok and pour over the coconut milk. Bring to a gentle boil. Add the curry paste, kerasik, lime leaves, cinnamon and cloves and stir thoroughly.",
      "Reduce to a low simmer and cook gently for around 2.5 hours, stirring occasionally as the liquid reduces.",
      "As the coconut milk cooks down, it will begin to split and release its oil. Continue cooking until the oil separates and starts frying and caramelising the paste and beef.",
      "Add the palm sugar, tamarind and a pinch of salt. Stir well and cook for a further 20-30 minutes, stirring more frequently to prevent catching.",
      "The rendang is ready when the sauce is thick, dark and almost dry, and the beef is tender but still holding its shape. Serve with steamed rice and a sharp pickle to balance the richness."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 5],
        ["The Curry Paste", 9],
        ["The Kerasik", 1],
        ["The Final Seasoning", 3]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Soak the dried red chillies in hot water for 10 minutes. Drain and deseed. Using a pestle and mortar, pound the dried chillies with the salt first, then gradually add the fresh chillies, lemongrass, galangal, ginger, turmeric, shallots and garlic. Pound firmly for 15-20 minutes until smooth and deeply fragrant.\nToast the desiccated coconut in a dry pan over medium heat, stirring constantly until golden brown. Transfer to a pestle and mortar and grind into a thick paste to create the kerasik.\nPlace the beef into a heavy-based pot or cast iron wok and pour over the coconut milk. Bring to a gentle boil. Add the curry paste, kerasik, lime leaves, cinnamon and cloves and stir thoroughly.\nReduce to a low simmer and cook gently for around 2.5 hours, stirring occasionally as the liquid reduces.\nAs the coconut milk cooks down, it will begin to split and release its oil. Continue cooking until the oil separates and starts frying and caramelising the paste and beef.\nAdd the palm sugar, tamarind and a pinch of salt. Stir well and cook for a further 20-30 minutes, stirring more frequently to prevent catching.\nThe rendang is ready when the sauce is thick, dark and almost dry, and the beef is tender but still holding its shape. Serve with steamed rice and a sharp pickle to balance the richness.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("schoolofwok.co.uk")
    expect(recipe.canonical_url).to eq("https://schoolofwok.co.uk/tips-and-recipes/beef-rendang-recipe")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to be_nil
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Beef Rendang – Slow-Cooked Indonesian Curry with Deep Coconut & Spice")
    expect(recipe.image).to be_nil
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
    expect(recipe.links).to include("/events")
  end
end
