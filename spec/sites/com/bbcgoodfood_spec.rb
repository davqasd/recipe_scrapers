# frozen_string_literal: true

RSpec.describe "bbcgoodfood.com" do
  subject(:recipe) { scrape_cassette("com/bbcgoodfood", url: "https://www.bbcgoodfood.com/recipes/summer-meatballs-spaghetti") }

  it "reads the title" do
    expect(recipe.title).to eq("Summer meatballs & spaghetti")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 tbsp olive oil",
      "1 onion finely chopped",
      "2 garlic cloves crushed",
      "1 tsp fennel seeds",
      "250g pork mince",
      "large handful parsley leaves chopped, stalks finely chopped",
      "1 large courgette peeled into ribbons all around the edge, centre grated or finely chopped",
      "200g spaghetti",
      "½ a lemon zested and juiced",
      "grated parmesan to serve"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "tbsp", name: "olive oil" },
      { amount: 1.0, unit: nil, name: "onion finely chopped" },
      { amount: 2.0, unit: nil, name: "garlic cloves crushed" },
      { amount: 1.0, unit: "tsp", name: "fennel seeds" },
      { amount: 250.0, unit: "g", name: "pork mince" },
      { amount: 1.0, unit: "handful", name: "parsley leaves chopped, stalks finely chopped" },
      { amount: 1.0, unit: nil, name: "large courgette peeled into ribbons all around the edge, centre grated or finely chopped" },
      { amount: 200.0, unit: "g", name: "spaghetti" },
      { amount: 0.5, unit: nil, name: "lemon zested and juiced" },
      { amount: nil, unit: nil, name: "grated parmesan to serve" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Heat ½ tbsp of the olive oil in a large frying pan over a medium heat. Add the onion and soften for 5 mins, then add the garlic and fennel and cook for 2 mins longer. Tip into a bowl. Add the pork mince, parsley stalks and grated courgette to the bowl, season well, mix, and shape into 10 meatballs. Heat the remaining oil in the frying pan, add the meatballs and fry for 5-8 mins, turning occasionally, until golden brown and cooked through. Set the pan aside.",
      "Bring a pan of salted water to the boil and cook the spaghetti for 1 min less than pack instructions. Using tongs, transfer the pasta to the pan of meatballs, sloshing in some of the cooking water as you go. Add the courgette ribbons to the pan and put it back over the heat. Toss the pasta and meatballs with the courgette ribbons in the pan with a ladleful of pasta water and add the lemon juice. Season well, tip into bowls and scatter over the chopped parsley leaves, lemon zest and a generous grating of parmesan."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Heat ½ tbsp of the olive oil in a large frying pan over a medium heat. Add the onion and soften for 5 mins, then add the garlic and fennel and cook for 2 mins longer. Tip into a bowl. Add the pork mince, parsley stalks and grated courgette to the bowl, season well, mix, and shape into 10 meatballs. Heat the remaining oil in the frying pan, add the meatballs and fry for 5-8 mins, turning occasionally, until golden brown and cooked through. Set the pan aside.\nBring a pan of salted water to the boil and cook the spaghetti for 1 min less than pack instructions. Using tongs, transfer the pasta to the pan of meatballs, sloshing in some of the cooking water as you go. Add the courgette ribbons to the pan and put it back over the heat. Toss the pasta and meatballs with the courgette ribbons in the pan with a ladleful of pasta water and add the lemon juice. Season well, tip into bowls and scatter over the chopped parsley leaves, lemon zest and a generous grating of parmesan.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("bbcgoodfood.com")
    expect(recipe.canonical_url).to eq("https://www.bbcgoodfood.com/recipes/summer-meatballs-spaghetti")
    expect(recipe.site_name).to eq("Good Food")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("Elena Silcock")
    expect(recipe.description).to eq("Make a quick and easy meal for two with these pork meatballs, served with spaghetti, courgette ribbons, lemon and parmesan – perfect for summer evenings")
    expect(recipe.image).to eq("https://images.immediate.co.uk/production/volatile/sites/30/2020/08/summer-meatballs-spaghetti-bd04f10.jpg?resize=440,400")
    expect(recipe.category).to eq("Dinner, Main course, Supper")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq([
      "Courgette",
      "Easy",
      "Elena Silcock",
      "Fibre",
      "Meatballs",
      "Midweek meals",
      "Quick",
      "Spaghetti"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "726 calories",
      "fatContent" => "25 grams fat",
      "saturatedFatContent" => "6 grams saturated fat",
      "carbohydrateContent" => "82 grams carbohydrates",
      "sugarContent" => "8 grams sugar",
      "fiberContent" => "7 grams fiber",
      "proteinContent" => "39 grams protein",
      "sodiumContent" => "0.2 milligram of sodium"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 726.0 },
      { name: "fatContent", unit: "g", amount: 25.0 },
      { name: "saturatedFatContent", unit: "g", amount: 6.0 },
      { name: "carbohydrateContent", unit: "g", amount: 82.0 },
      { name: "sugarContent", unit: "g", amount: 8.0 },
      { name: "fiberContent", unit: "g", amount: 7.0 },
      { name: "proteinContent", unit: "g", amount: 39.0 },
      { name: "sodiumContent", unit: "mg", amount: 0.2 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#site-main")
  end
end
