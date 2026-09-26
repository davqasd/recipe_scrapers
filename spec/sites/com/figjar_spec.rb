# frozen_string_literal: true

RSpec.describe "figjar.com" do
  subject(:recipe) { scrape_cassette("com/figjar", url: "https://www.figjar.com/creamy-chipotle-chicken-pasta/") }

  it "reads the title" do
    expect(recipe.title).to eq("Creamy Chipotle Chicken Pasta")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "16 oz box of dry ziti or rigatoni pasta",
      "3 tbsp salted butter",
      "1 lb chicken tenderloins, see notes about seasoning the chicken",
      "1 large poblano pepper, chopped",
      "1 sm/med yellow onion, chopped",
      "2 cloves garlic, minced",
      "3 tbsp honey",
      "2 cups half & half",
      "2 chipotle peppers in adobo, minced",
      "2 tbsp adobo sauce",
      "1 cup shredded cheddar cheese",
      "3/4 cup grated parmesan cheese",
      "2 cups frozen peas",
      "salt and pepper"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 16.0, unit: "oz", name: "box of dry ziti or rigatoni pasta" },
      { amount: 3.0, unit: "tbsp", name: "salted butter" },
      { amount: 1.0, unit: "lb", name: "chicken tenderloins, see notes about seasoning the chicken" },
      { amount: 1.0, unit: nil, name: "large poblano pepper, chopped" },
      { amount: 1.0, unit: nil, name: "sm/med yellow onion, chopped" },
      { amount: 2.0, unit: "cloves", name: "garlic, minced" },
      { amount: 3.0, unit: "tbsp", name: "honey" },
      { amount: 2.0, unit: "cups", name: "half & half" },
      { amount: 2.0, unit: nil, name: "chipotle peppers in adobo, minced" },
      { amount: 2.0, unit: "tbsp", name: "adobo sauce" },
      { amount: 1.0, unit: "cup", name: "shredded cheddar cheese" },
      { amount: 0.75, unit: "cup", name: "grated parmesan cheese" },
      { amount: 2.0, unit: "cups", name: "frozen peas" },
      { amount: nil, unit: nil, name: "salt and pepper" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Place a large pot of water over high heat, covered. Cook pasta in boiling water according to package directions, but toss a palmful of salt into the water right before adding the pasta.",
      "Heat a large cast iron skillet over medium heat for 3-4 minutes. Add 2 tbsp salted butter. Once melted, add the chicken tenders, sprinkle with salt and pepper and cook on each side for 3-4 minutes. Until golden and an internal temp of 165F is reached. Use a meat thermometer for this. Set the chicken aside on a plate (or just a piece of foil for easy clean up!).",
      "Return the skillet back to medium heat and add remaining 1 tbsp of butter. Add the onion and chopped poblano pepper. Sprinkle evenly with salt and pepper. Cook until tender, about 5-7 minutes. Turn heat down just a touch and add the minced garlic, stir and cook about 1 minute. Add the chipotle peppers and adobo sauce and stir.",
      "Add the half & half and honey, return heat back to medium, stir and cook until the sauce begins to thicken and bubble.",
      "Remove from the heat and stir in 1 tsp salt, 1/4 tsp pepper and both cheeses.",
      "Return skillet to low heat. Chop the chicken into pieces, add it along with the peas to the sauce and stir. Add the pasta and stir until pasta is fully coated. Taste and add more salt if desired.",
      "Top with chopped cilantro and cracked black pepper and enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Place a large pot of water over high heat, covered. Cook pasta in boiling water according to package directions, but toss a palmful of salt into the water right before adding the pasta.\nHeat a large cast iron skillet over medium heat for 3-4 minutes. Add 2 tbsp salted butter. Once melted, add the chicken tenders, sprinkle with salt and pepper and cook on each side for 3-4 minutes. Until golden and an internal temp of 165F is reached. Use a meat thermometer for this. Set the chicken aside on a plate (or just a piece of foil for easy clean up!).\nReturn the skillet back to medium heat and add remaining 1 tbsp of butter. Add the onion and chopped poblano pepper. Sprinkle evenly with salt and pepper. Cook until tender, about 5-7 minutes. Turn heat down just a touch and add the minced garlic, stir and cook about 1 minute. Add the chipotle peppers and adobo sauce and stir.\nAdd the half & half and honey, return heat back to medium, stir and cook until the sauce begins to thicken and bubble.\nRemove from the heat and stir in 1 tsp salt, 1/4 tsp pepper and both cheeses.\nReturn skillet to low heat. Chop the chicken into pieces, add it along with the peas to the sauce and stir. Add the pasta and stir until pasta is fully coated. Taste and add more salt if desired.\nTop with chopped cilantro and cracked black pepper and enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("figjar.com")
    expect(recipe.canonical_url).to eq("https://www.figjar.com/creamy-chipotle-chicken-pasta/")
    expect(recipe.site_name).to eq("The Fig Jar")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Becky Schmieg")
    expect(recipe.description).to eq("The combination of creamy cheese sauce and smoky chipotle peppers is a haunting one. It's one of those that is so good, you will be already be thinking about when you can eat it next before you've even finished your meal.")
    expect(recipe.image).to eq("https://www.figjar.com/wp-content/uploads/2024/01/creamy-chipotle-chicken-pasta-225x225.jpg")
    expect(recipe.category).to eq("main")
    expect(recipe.cuisine).to eq("american")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(50)
    expect(recipe.prep_time).to eq(25)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to eq(["creamy chipotle chicken pasta"])
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
    expect(recipe.links).to include("#main")
  end
end
