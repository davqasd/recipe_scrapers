# frozen_string_literal: true

RSpec.describe "sugarmaplefarmhouse.com" do
  subject(:recipe) { scrape_cassette("com/sugarmaplefarmhouse", url: "https://www.sugarmaplefarmhouse.com/bacon-mushroom-smothered-chicken/") }

  it "reads the title" do
    expect(recipe.title).to eq("Bacon & Mushroom Smothered Chicken")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "6 Tbsp. olive oil, divided",
      "1 lb. boneless chicken thighs (You can use ones with bones too.)",
      "1 shallot",
      "1/2 white onion",
      "3/4 cup white button mushrooms",
      "8 sliced of bacon, cooked",
      "1 cup heavy cream",
      "2.5 tsp. ground Italian seasoning (I use McCormick Italian Seasoning in a grinder)",
      "5 fresh sprigs of thyme",
      "2 Tbsp. fresh sage, chopped",
      "1/2 cup chicken broth",
      "Salt and pepper to taste",
      "Fresh parsley"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 6.0, unit: "Tbsp", name: "olive oil, divided" },
      { amount: 1.0, unit: "lb", name: "boneless chicken thighs" },
      { amount: 1.0, unit: nil, name: "shallot" },
      { amount: 0.5, unit: nil, name: "white onion" },
      { amount: 0.75, unit: "cup", name: "white button mushrooms" },
      { amount: 8.0, unit: nil, name: "sliced of bacon, cooked" },
      { amount: 1.0, unit: "cup", name: "heavy cream" },
      { amount: 2.5, unit: "tsp", name: "ground Italian seasoning" },
      { amount: 5.0, unit: nil, name: "fresh sprigs of thyme" },
      { amount: 2.0, unit: "Tbsp", name: "fresh sage, chopped" },
      { amount: 0.5, unit: "cup", name: "chicken broth" },
      { amount: nil, unit: nil, name: "Salt and pepper to taste" },
      { amount: nil, unit: nil, name: "Fresh parsley" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 350.",
      "In a pan on the stove over medium heat, add half of the olive oil and heath through.",
      "Season both sides of the chicken thighs with salt and pepper and then add them to the pan. Cook skin side down for about 4 min.",
      "Flip them and cook the other side about about 2 min.",
      "Remove the chicken from the pan and add it to a baking sheet lined with foil. Bake for 20 minutes.",
      "In the same pan that the chicken was in, add the other 3 Tbsp. of olive oil and heat through on LOW. Then add the shallot and onion and cook on low for about 5 minutes. Scrape brown bits as you go and stir regularly.",
      "Add in the mushrooms and cook for about 3 minutes until they are softened.",
      "Add in the cooked bacon and cook for about 2 minutes stirring frequently.",
      "Add in the heavy cream and then add in the Italian grinder seasonings. Simmer for about 3 min.",
      "Add in the fresh thyme sprigs and sage and continue to simmer.",
      "Add in the chicken broth and continue to simmer. You can cover it to help retain moisture but make sure to stir frequently.",
      "When the chicken is done add it back to the pan and spoon the sauce over the chicken.",
      "Serve immediately with additional salt and pepper to taste and fresh parsley."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 350.\nIn a pan on the stove over medium heat, add half of the olive oil and heath through.\nSeason both sides of the chicken thighs with salt and pepper and then add them to the pan. Cook skin side down for about 4 min.\nFlip them and cook the other side about about 2 min.\nRemove the chicken from the pan and add it to a baking sheet lined with foil. Bake for 20 minutes.\nIn the same pan that the chicken was in, add the other 3 Tbsp. of olive oil and heat through on LOW. Then add the shallot and onion and cook on low for about 5 minutes. Scrape brown bits as you go and stir regularly.\nAdd in the mushrooms and cook for about 3 minutes until they are softened.\nAdd in the cooked bacon and cook for about 2 minutes stirring frequently.\nAdd in the heavy cream and then add in the Italian grinder seasonings. Simmer for about 3 min.\nAdd in the fresh thyme sprigs and sage and continue to simmer.\nAdd in the chicken broth and continue to simmer. You can cover it to help retain moisture but make sure to stir frequently.\nWhen the chicken is done add it back to the pan and spoon the sauce over the chicken.\nServe immediately with additional salt and pepper to taste and fresh parsley.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("sugarmaplefarmhouse.com")
    expect(recipe.canonical_url).to eq("https://www.sugarmaplefarmhouse.com/bacon-mushroom-smothered-chicken/")
    expect(recipe.site_name).to eq("Sugar Maple Farmhouse")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Rachel")
    expect(recipe.description).to eq("This Bacon & Mushroom Smothered Chicken is fast enough for a week night meal, but also fancy enough and delicious enough to serve for guests!")
    expect(recipe.image).to eq("https://www.sugarmaplefarmhouse.com/app/uploads/2021-04-23_0012-scaled-scaled.jpg")
    expect(recipe.category).to eq("dinner")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(27)
    expect(recipe.keywords).to eq(["bacon and musroom smothered chicken", "smothered chicken"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.8)
    expect(recipe.ratings_count).to eq(5)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.sugarmaplefarmhouse.com/category/home/")
  end
end
