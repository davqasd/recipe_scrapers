# frozen_string_literal: true

RSpec.describe "recipetineats.com" do
  subject(:recipe) { scrape_cassette("com/recipetineats", url: "https://www.recipetineats.com/crispy-potato-straws-pommes-paille/") }

  it "reads the title" do
    expect(recipe.title).to eq("Crispy potato straws (Pommes Paille)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 potato (Aus: Sebago, US: russet, UK: Maris Piper), or other starchy or all-rounder potato (Note 1)",
      "1 1/2 - 2 cups vegetable oil (canola, sunflower or peanut oil)",
      "Sea salt flakes (, crushed with fingers into a powder)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "potato, or other starchy or all-rounder potato" },
      { amount: 1.5, unit: "cups", name: "vegetable oil" },
      { amount: nil, unit: nil, name: "Sea salt flakes" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Shred - Finely julienne the potato using a julienne mandoline, 2-4 mm / 1/16 - 1/8\" thick. (Note 2)",
      "Rinse - Place potato in a bowl of water and rinse, changing the water as needed, until the water is clear. Drain in a colander. (Potato can be kept in water overnight in the fridge).",
      "Dry - Spread on tea towels then pat dry. If time permits, spread out and air dry for 1 hour+. (Drier potato = less oil bubbling + crispier fries).",
      "Heat the oil in a saucepan over high heat to 180°C/350°F, ensuring there is 10 cm/4\" clearance above the oil surface (the oil bubbles up).",
      "Add potato into oil - SLOWLY scatter potato across the surface of the oil (don't dump in once place). ⚠️The oil will bubble up to ~7cm/3\", so add potato slowly, and you can pause until the bubbles subside before adding more. (Note 3 for cooking tips)",
      "Fry for 1 1/2 - 2 minutes, using chopsticks (or similar) to stir once or twice. Once light golden and crisp, scoop out and drain on paper towels. (It goes more golden as it drains). Repeat with remaining potato.",
      "Season - Carefully slide the fries into a bowl. Sprinkle with salt and gently toss. Serve immediately while warm, or cool.",
      "Serve in bowls for munching, as a garnish like for Beef Tataki or serve a mound alongside a juicy steak or other protein (see in post for more ideas)."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Shred - Finely julienne the potato using a julienne mandoline, 2-4 mm / 1/16 - 1/8\" thick. (Note 2)\nRinse - Place potato in a bowl of water and rinse, changing the water as needed, until the water is clear. Drain in a colander. (Potato can be kept in water overnight in the fridge).\nDry - Spread on tea towels then pat dry. If time permits, spread out and air dry for 1 hour+. (Drier potato = less oil bubbling + crispier fries).\nHeat the oil in a saucepan over high heat to 180°C/350°F, ensuring there is 10 cm/4\" clearance above the oil surface (the oil bubbles up).\nAdd potato into oil - SLOWLY scatter potato across the surface of the oil (don't dump in once place). ⚠️The oil will bubble up to ~7cm/3\", so add potato slowly, and you can pause until the bubbles subside before adding more. (Note 3 for cooking tips)\nFry for 1 1/2 - 2 minutes, using chopsticks (or similar) to stir once or twice. Once light golden and crisp, scoop out and drain on paper towels. (It goes more golden as it drains). Repeat with remaining potato.\nSeason - Carefully slide the fries into a bowl. Sprinkle with salt and gently toss. Serve immediately while warm, or cool.\nServe in bowls for munching, as a garnish like for Beef Tataki or serve a mound alongside a juicy steak or other protein (see in post for more ideas).")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("recipetineats.com")
    expect(recipe.canonical_url).to eq("https://www.recipetineats.com/crispy-potato-straws-pommes-paille/")
    expect(recipe.site_name).to eq("RecipeTin Eats")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Nagi")
    expect(recipe.description).to eq("Recipe video above. 1 x 300g/10oz potato will make about 3 heaped cups of fries (lightly packed).")
    expect(recipe.image).to eq("https://www.recipetineats.com/tachyon/2024/07/Crispy-potato-straws-Pommes-Paille_6.jpg")
    expect(recipe.category).to eq("Sides")
    expect(recipe.cuisine).to eq("French")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("1 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq(["matchstick fries", "pommes pailles", "potato straws", "shoestring fries"])
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
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
