# frozen_string_literal: true

RSpec.describe "donnahay.com.au" do
  subject(:recipe) { scrape_cassette("au/donnahay", url: "https://www.donnahay.com.au/recipes/dinner/olive-and-parmesan-crusted-chicken-schnitzel") }

  it "reads the title" do
    expect(recipe.title).to eq("olive and parmesan-crusted chicken schnitzel")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 x 180g (6½ oz) chicken breast fillets, trimmed and halved lengthwise",
      "⅓ cup (75g/2¾ oz) store-bought olive tapenade",
      "4 cups (280g/10 oz) fresh sourdough breadcrumbs",
      "1 cup (80g/2¾ oz) finely grated parmesan",
      "¼ cup (5g/⅛ oz) torn oregano leaves",
      "cracked black pepper",
      "extra virgin olive oil, for drizzling",
      "lemon wedges, rocket (arugula) leaves, sliced heirloom tomatoes and olives, to serve"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: nil, name: "x 180g chicken breast fillets, trimmed and halved lengthwise" },
      { amount: 0.33, unit: "cup", name: "store-bought olive tapenade" },
      { amount: 4.0, unit: "cups", name: "fresh sourdough breadcrumbs" },
      { amount: 1.0, unit: "cup", name: "finely grated parmesan" },
      { amount: 0.25, unit: "cup", name: "torn oregano leaves" },
      { amount: nil, unit: nil, name: "cracked black pepper" },
      { amount: nil, unit: nil, name: "extra virgin olive oil, for drizzling" },
      { amount: nil, unit: nil, name: "lemon wedges, rocket leaves, sliced heirloom tomatoes and olives, to serve" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven grill (broiler) to high.",
      "Place the chicken on a baking tray lined with non-stick baking paper. Spread each chicken fillet with olive tapenade.",
      "Combine the breadcrumbs, parmesan, oregano and pepper. Top each chicken fillet with the breadcrumb mixture and press to coat.",
      "Drizzle generously with oil, then grill for 10–12 minutes or until golden and cooked through.",
      "Serve the schnitzels with lemon wedges and a salad of rocket, tomato and olives. Serves 4"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven grill (broiler) to high.\nPlace the chicken on a baking tray lined with non-stick baking paper. Spread each chicken fillet with olive tapenade.\nCombine the breadcrumbs, parmesan, oregano and pepper. Top each chicken fillet with the breadcrumb mixture and press to coat.\nDrizzle generously with oil, then grill for 10–12 minutes or until golden and cooked through.\nServe the schnitzels with lemon wedges and a salad of rocket, tomato and olives. Serves 4")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("donnahay.com.au")
    expect(recipe.canonical_url).to eq("https://www.donnahay.com.au/recipes/dinner/olive-and-parmesan-crusted-chicken-schnitzel")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("en")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Pack more flavour into your schnitzel with a layer of olive tapenade and a crunchy parmesan crumb. Then it all goes under the grill to create the crispiest golden crust that makes this such an irresistible dinner. Plus, it’s all ready in less than 20 minutes!")
    expect(recipe.image).to eq("https://cdn.donnahaycdn.com.au/images/content-images/olive_and_parmesan-crusted_chicken_schnitzel.jpg")
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
    expect(recipe.links).to include("#store-nav-mob")
  end
end
