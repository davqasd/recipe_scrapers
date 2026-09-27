# frozen_string_literal: true

RSpec.describe "gourmettraveller.com.au" do
  subject(:recipe) { scrape_cassette("au/gourmettraveller", url: "https://www.gourmettraveller.com.au/recipe/fast-recipes/cambodian-lort-cha-20407/") }

  it "reads the title" do
    expect(recipe.title).to eq("Cambodian lort cha")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2½ tbsp each oyster sauce and dark soy sauce",
      "2 tbsp fish sauce",
      "1 tsp caster sugar",
      "1 pork tenderloin (about 450gm), halved lengthways, thinly sliced",
      "2 tsp cornflour",
      "125 ml (1/3 cup) peanut oil",
      "2 garlic cloves, crushed",
      "1 tbsp finely grated ginger",
      "500 gm fresh wide rice noodles, at room temperature for best results",
      "1 bunch (1½ cups) garlic shoots, cut into 6cm lengths, loosely packed",
      "1 bunch gai lan, stalks cut into 6cm lengths (thicker stalks halved lengthways), leaves shredded",
      "Fried eggs, bean sprouts, lime halves and crisp chilli oil, to serve"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.5, unit: "tbsp", name: "each oyster sauce and dark soy sauce" },
      { amount: 2.0, unit: "tbsp", name: "fish sauce" },
      { amount: 1.0, unit: "tsp", name: "caster sugar" },
      { amount: 1.0, unit: nil, name: "pork tenderloin, halved lengthways, thinly sliced" },
      { amount: 2.0, unit: "tsp", name: "cornflour" },
      { amount: 125.0, unit: "ml", name: "peanut oil" },
      { amount: 2.0, unit: nil, name: "garlic cloves, crushed" },
      { amount: 1.0, unit: "tbsp", name: "finely grated ginger" },
      { amount: 500.0, unit: nil, name: "gm fresh wide rice noodles, at room temperature for best results" },
      { amount: 1.0, unit: "bunch", name: "garlic shoots, cut into 6cm lengths, loosely packed" },
      { amount: 1.0, unit: "bunch", name: "gai lan, stalks cut into 6cm lengths, leaves shredded" },
      { amount: nil, unit: nil, name: "Fried eggs, bean sprouts, lime halves and crisp chilli oil, to serve" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "1.",
      "For sauce, combine sauces and sugar in a small bowl and set aside.",
      "2.",
      "Place pork, cornflour and 60ml of the sauce mixture in a bowl, stir to coat and marinate for 15 minutes.",
      "3.",
      "In two batches, heat 1 tbsp oil in a large wok or large deep non-stick frying pan to high heat. Add half of the garlic, ginger and pork and in two batches stir-fry until pork is just cooked through and lightly charred, transfer to a plate. Return wok to high heat, add 1 tbsp oil, half of the noodles and stir-fry until soft and slightly charred (2-3 minutes), transfer to plate with pork.",
      "4.",
      "Wipe wok clean and return to high heat. Add remaining oil with garlic shoots and gai lan and stir-fry until wilted (1-2 minutes). Return pork, noodles, remaining sauce mixture and 2 tbsp water to wok, stir-fry until heated through (1-2 minutes).",
      "5.",
      "Divide among bowls, top with fried egg and serve with bean sprouts, lime halves, and chilli oil on the side."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("1.\nFor sauce, combine sauces and sugar in a small bowl and set aside.\n2.\nPlace pork, cornflour and 60ml of the sauce mixture in a bowl, stir to coat and marinate for 15 minutes.\n3.\nIn two batches, heat 1 tbsp oil in a large wok or large deep non-stick frying pan to high heat. Add half of the garlic, ginger and pork and in two batches stir-fry until pork is just cooked through and lightly charred, transfer to a plate. Return wok to high heat, add 1 tbsp oil, half of the noodles and stir-fry until soft and slightly charred (2-3 minutes), transfer to plate with pork.\n4.\nWipe wok clean and return to high heat. Add remaining oil with garlic shoots and gai lan and stir-fry until wilted (1-2 minutes). Return pork, noodles, remaining sauce mixture and 2 tbsp water to wok, stir-fry until heated through (1-2 minutes).\n5.\nDivide among bowls, top with fried egg and serve with bean sprouts, lime halves, and chilli oil on the side.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("gourmettraveller.com.au")
    expect(recipe.canonical_url).to eq("https://www.gourmettraveller.com.au/recipe/fast-recipes/cambodian-lort-cha-20407/")
    expect(recipe.site_name).to eq("Gourmet Traveller")
    expect(recipe.language).to eq("en-AU")
    expect(recipe.author).to eq("Cordelia Williamson")
    expect(recipe.description).to eq("This bowl of noodles is a balm for the soul.")
    expect(recipe.image).to eq("https://api.photon.aremedia.net.au/wp-content/uploads/sites/10/Gt/2022/10/26/20407/WEB_Cambodian-Lort-cha.jpg?fit=1200%2C1000&format=auto")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(15)
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
    expect(recipe.links).to include("#primary")
  end
end
