# frozen_string_literal: true

RSpec.describe "sizzlefish.com" do
  subject(:recipe) { scrape_cassette("com/sizzlefish", url: "https://www.sizzlefish.com/blogs/halibut/sheet-pan-baked-halibut-with-potatoes-and-green-beans") }

  it "reads the title" do
    expect(recipe.title).to eq("Sheet Pan Baked Halibut with Potatoes and Green Beans")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 Sizzlefish Halibut Fillets",
      "2 TBSP olive oil",
      "2 tsp Italian Seasoning",
      "1/2 lb Baby Yukon Gold Potatoes, cut in half",
      "1 large shallot, sliced",
      "2 Garlic Cloves, chopped",
      "1 lb Fresh Green Beans, trimmed",
      "Kosher Salt, to taste",
      "Freshly Ground Black Pepper, to taste",
      "2 TBSP Fresh Lemon Juice",
      "1 TBSP Lemon Zest"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "Sizzlefish Halibut Fillets" },
      { amount: 2.0, unit: "TBSP", name: "olive oil" },
      { amount: 2.0, unit: "tsp", name: "Italian Seasoning" },
      { amount: 0.5, unit: "lb", name: "Baby Yukon Gold Potatoes, cut in half" },
      { amount: 1.0, unit: nil, name: "large shallot, sliced" },
      { amount: 2.0, unit: nil, name: "Garlic Cloves, chopped" },
      { amount: 1.0, unit: "lb", name: "Fresh Green Beans, trimmed" },
      { amount: nil, unit: nil, name: "Kosher Salt, to taste" },
      { amount: nil, unit: nil, name: "Freshly Ground Black Pepper, to taste" },
      { amount: 2.0, unit: "TBSP", name: "Fresh Lemon Juice" },
      { amount: 1.0, unit: "TBSP", name: "Lemon Zest" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 425°F. Line a sheet pan with parchment paper.",
      "In a small bowl, combine the olive oil and Italian seasonings.",
      "Place the potatoes, shallots and garlic on the parchment lined sheet pan. Toss them with half of the herb oil mixture. Arrange the potatoes cut side down making sure to leave space between then to brown evenly.",
      "Place the pan in the preheated oven and bake for 15 to 20 minutes. The potatoes should start to brown on the cut side.",
      "Next remove the pan from oven. Add the green beans to the sheet pan. Toss to combine.",
      "Place the halibut fillet on the sheet pan surrounding them with vegetables. Brush the halibut fillets with the remaining oil mixture and bake an addition 15 to 20 minutes or until potatoes are golden brown and tender. The halibut should be between 130 to 135 degrees F."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 425°F. Line a sheet pan with parchment paper.\nIn a small bowl, combine the olive oil and Italian seasonings.\nPlace the potatoes, shallots and garlic on the parchment lined sheet pan. Toss them with half of the herb oil mixture. Arrange the potatoes cut side down making sure to leave space between then to brown evenly.\nPlace the pan in the preheated oven and bake for 15 to 20 minutes. The potatoes should start to brown on the cut side.\nNext remove the pan from oven. Add the green beans to the sheet pan. Toss to combine.\nPlace the halibut fillet on the sheet pan surrounding them with vegetables. Brush the halibut fillets with the remaining oil mixture and bake an addition 15 to 20 minutes or until potatoes are golden brown and tender. The halibut should be between 130 to 135 degrees F.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("sizzlefish.com")
    expect(recipe.canonical_url).to eq("https://www.sizzlefish.com/blogs/halibut/sheet-pan-baked-halibut-with-potatoes-and-green-beans")
    expect(recipe.site_name).to eq("Sizzlefish")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Sarena")
    expect(recipe.description).to eq("Minimum clean up with maximum flavor, this recipe for Sheet Pan Baked Halibut with Potatoes and Green Beans is the perfect one dish meal!White, flaky, delicious, and nutritious, Sizzlefish wild caught halibut has it all. Loaded with vitamins, minerals and omega-3 fatty acids, halibut packs a heart healthy punch to any meal. This light, elegant, lean fish also adds a healthy dose of protein to mealtime. This firm, yet tender flaky fish is perfect for this easy sheet pan meal.We want easy, but we also want delicious and nutritious. We can have it all with this incredibly easy recipe that requires very little hands-on time, while offering maximum deliciousness. This meal is incredibly flexible when it comes to seasonings. too. We went with a mix of dried Italian herbs, but a mix of fresh herbs work well here, when they are in season. We love one pan meals for not only the ease, but also because we love how the mix of flavors and textures compliment each other so well. The creamy golden roasted potatoes mixed with the crisp tender fresh green beans next to moist tender halibut perfectly seasoned with olive oil and herbs brightened up with a fresh squeeze of lemon juice and zest really is a meal that is good for the soul. We made this recipe for two, but it can easily be made for a bigger crowd if need be. Cozy up with a good book and a glass of wine while dinner cooks. This is the perfect no work, no stress meal!")
    expect(recipe.image).to eq("https://images.getrecipekit.com/20220517183237-sheet-pan-halibut-recipe_1000x.webp?aspect_ratio=16:9&quality=90&")
    expect(recipe.category).to eq("Entree")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(50)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(40)
    expect(recipe.keywords).to eq([
      "Sheet Pan Halibut",
      "baked",
      "halibut",
      "alaska",
      "alaskan",
      "seafood",
      "sizzlefish",
      "protein",
      "healthy",
      "keto",
      "whole30",
      "paleo",
      "prime"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(52)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "servingSize" => "2", "calories" => "138" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: nil, amount: 2.0 },
      { name: "calories", unit: nil, amount: 138.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#MainContent")
  end
end
