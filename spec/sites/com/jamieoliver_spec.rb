# frozen_string_literal: true

RSpec.describe "jamieoliver.com" do
  subject(:recipe) { scrape_cassette("com/jamieoliver", url: "https://www.jamieoliver.com/recipes/fish/fabulous-fish-stew/") }

  it "reads the title" do
    expect(recipe.title).to eq("Fabulous fish stew")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cloves of garlic, peeled",
      "optional: a small pinch of saffron",
      "sea salt and freshly ground black pepper",
      "250ml low fat mayonnaise",
      "lemon juice",
      "12 mussels",
      "20 clams",
      "olive oil",
      "a small wineglass of white wine",
      "1 x 400g tin good-quality plum tomatoes",
      "2 small fillets of sea bass or bream, cut in half",
      "2 small fillets of red mullet or snapper, cut in half",
      "2 small fillets of monkfish or other firm white fish",
      "4 langoustines or tiger prawns, shell on",
      "2 thick slices of crusty bread",
      "a small handful of fennel tops",
      "extra virgin olive oil",
      "a small bunch of fresh basil, leaves picked and stalks chopped"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cloves", name: "garlic, peeled" },
      { amount: 1.0, unit: "pinch", name: "saffron" },
      { amount: nil, unit: nil, name: "sea salt and freshly ground black pepper" },
      { amount: 250.0, unit: "ml", name: "low fat mayonnaise" },
      { amount: nil, unit: nil, name: "lemon juice" },
      { amount: 12.0, unit: nil, name: "mussels" },
      { amount: 20.0, unit: nil, name: "clams" },
      { amount: nil, unit: nil, name: "olive oil" },
      { amount: nil, unit: nil, name: "a small wineglass of white wine" },
      { amount: 1.0, unit: nil, name: "x 400g tin good-quality plum tomatoes" },
      { amount: 2.0, unit: nil, name: "small fillets of sea bass or bream, cut in half" },
      { amount: 2.0, unit: nil, name: "small fillets of red mullet or snapper, cut in half" },
      { amount: 2.0, unit: nil, name: "small fillets of monkfish or other firm white fish" },
      { amount: 4.0, unit: nil, name: "langoustines or tiger prawns, shell on" },
      { amount: 2.0, unit: nil, name: "thick slices of crusty bread" },
      { amount: 1.0, unit: "handful", name: "fennel tops" },
      { amount: nil, unit: nil, name: "extra virgin olive oil" },
      { amount: 1.0, unit: "bunch", name: "fresh basil, leaves picked and stalks chopped" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "It’s worth trying to get hold of saffron for this one – it’s available from most delis and good supermarkets. It’s not cheap, but bear in mind you won’t need much at all to spice up a dish. Make sure you use a wide pan so all the fish is in contact with the tomatoey broth. If you haven’t got one, try using a high-sided roasting tray instead, with another tray as a lid.",
      "To make the saffron aïoli, smash a clove of garlic, a tiny squeeze of lemon juice, and the saffron (if using) with a small pinch of salt in a pestle and mortar or a Flavour Shaker™ until it turns into a mush. Add a tablespoon of mayonnaise and pound again. Stir in the rest of the mayo. Taste and season with a little more lemon juice, salt and pepper.",
      "Give the mussels and clams a good wash in plenty of clean cold water and scrub any dirty ones lightly with a scrubbing brush, pulling off any beardy bits. If there are any that aren’t tightly closed, give them a sharp tap. If they don’t close up, throw them away.",
      "Heat a large, wide saucepan or stewing pot and pour in a splash of olive oil. Slice up the rest of the garlic and fry it in the oil until lightly golden. Add the wine and the tomatoes and the basil stalks and bring to the boil. Simmer gently for 10 to 15 minutes, until the liquid has reduced a little.",
      "Add all your fish and shellfish in a single layer and season with salt and pepper. Push the fish down into the liquid and put the lid on. Cook gently for about 10 minutes or until all the clams and mussels have opened and the fish fillets and langoustines or prawns are cooked through. (Discard any clams or mussels that don’t open.)",
      "Toast the bread on a hot griddle pan and get out the serving bowls. Put a piece of toast in each bowl and ladle the soup over the top, making sure the fish is divided more or less evenly. Top each bowl with some fennel tops, basil leaves, a drizzle of extra virgin olive oil and a big blob of saffron aïoli."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("It’s worth trying to get hold of saffron for this one – it’s available from most delis and good supermarkets. It’s not cheap, but bear in mind you won’t need much at all to spice up a dish. Make sure you use a wide pan so all the fish is in contact with the tomatoey broth. If you haven’t got one, try using a high-sided roasting tray instead, with another tray as a lid.\nTo make the saffron aïoli, smash a clove of garlic, a tiny squeeze of lemon juice, and the saffron (if using) with a small pinch of salt in a pestle and mortar or a Flavour Shaker™ until it turns into a mush. Add a tablespoon of mayonnaise and pound again. Stir in the rest of the mayo. Taste and season with a little more lemon juice, salt and pepper.\nGive the mussels and clams a good wash in plenty of clean cold water and scrub any dirty ones lightly with a scrubbing brush, pulling off any beardy bits. If there are any that aren’t tightly closed, give them a sharp tap. If they don’t close up, throw them away.\nHeat a large, wide saucepan or stewing pot and pour in a splash of olive oil. Slice up the rest of the garlic and fry it in the oil until lightly golden. Add the wine and the tomatoes and the basil stalks and bring to the boil. Simmer gently for 10 to 15 minutes, until the liquid has reduced a little.\nAdd all your fish and shellfish in a single layer and season with salt and pepper. Push the fish down into the liquid and put the lid on. Cook gently for about 10 minutes or until all the clams and mussels have opened and the fish fillets and langoustines or prawns are cooked through. (Discard any clams or mussels that don’t open.)\nToast the bread on a hot griddle pan and get out the serving bowls. Put a piece of toast in each bowl and ladle the soup over the top, making sure the fish is divided more or less evenly. Top each bowl with some fennel tops, basil leaves, a drizzle of extra virgin olive oil and a big blob of saffron aïoli.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("jamieoliver.com")
    expect(recipe.canonical_url).to eq("https://www.jamieoliver.com/recipes/fish/fabulous-fish-stew/")
    expect(recipe.site_name).to eq("Jamie Oliver")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Jamie Oliver")
    expect(recipe.description).to eq("Sometimes there is nothing better than a fish stew and this little number certainly won't disappoint; treat yourself to this beautiful fish stew recipe.")
    expect(recipe.image).to eq("https://asset.jamieoliver.com/images/cq7w2e71/production/2289b78400e95ffc7bc7228a33c38565a028f099-973x1300.jpg/2289b78400e95ffc7bc7228a33c38565a028f099-973x1300.webp?rect=0,164,973,973&w=1200&h=1200&fm=webp&q=75&fit=crop&auto=format")
    expect(recipe.category).to eq("Fish")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to eq(45)
    expect(recipe.keywords).to eq(["stew", "fish", "mussels", "fish stew", "Course", "Mains", "Dish Type", "Stew", "Main Ingredient", "Fish", "Method", "Occasion", "Dinner for two", "Christmas", "Aussie Christmas", "Dinner Party", "christmas dinner", "Valentine's Day"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "470 calories",
      "carbohydrateContent" => "26.9 g",
      "fatContent" => "17.2 g",
      "proteinContent" => "42.2 g",
      "saturatedFatContent" => "2.1 g",
      "sugarContent" => "5.3 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 470.0 },
      { name: "carbohydrateContent", unit: "g", amount: 26.9 },
      { name: "fatContent", unit: "g", amount: 17.2 },
      { name: "proteinContent", unit: "g", amount: 42.2 },
      { name: "saturatedFatContent", unit: "g", amount: 2.1 },
      { name: "sugarContent", unit: "g", amount: 5.3 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#review-panel")
  end
end
