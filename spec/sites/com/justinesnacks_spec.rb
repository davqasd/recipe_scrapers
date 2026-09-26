# frozen_string_literal: true

RSpec.describe "justinesnacks.com" do
  subject(:recipe) { scrape_cassette("com/justinesnacks", url: "https://justinesnacks.com/grilled-swordfish-with-basil-pistachio-relish-and-tomato-salad/") }

  it "reads the title" do
    expect(recipe.title).to eq("Grilled Swordfish with Basil Pistachio Relish and Tomato Salad")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 large handful of basil (stems removed)",
      "1/4 cup pistachios",
      "3 cloves garlic",
      "1 lemon for juicing",
      "olive oil (as needed)",
      "salt (as needed)",
      "3 small golden heirloom tomatoes",
      "10 small cherry plums (or 3 plums)",
      "1/2 small red onion",
      "1 small handful fresh dill and mint",
      "salt and pepper to taste",
      "10 ounces swordfish (halved into two fillets)",
      "2 tablespoons avocado oil"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "handful", name: "basil" },
      { amount: 0.25, unit: "cup", name: "pistachios" },
      { amount: 3.0, unit: "cloves", name: "garlic" },
      { amount: 1.0, unit: nil, name: "lemon for juicing" },
      { amount: nil, unit: nil, name: "olive oil" },
      { amount: nil, unit: nil, name: "salt" },
      { amount: 3.0, unit: nil, name: "small golden heirloom tomatoes" },
      { amount: 10.0, unit: nil, name: "small cherry plums" },
      { amount: 0.5, unit: nil, name: "small red onion" },
      { amount: 1.0, unit: "handful", name: "fresh dill and mint" },
      { amount: nil, unit: nil, name: "salt and pepper to taste" },
      { amount: 10.0, unit: "ounces", name: "swordfish" },
      { amount: 2.0, unit: "tablespoons", name: "avocado oil" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Begin by making the basil relish. Finely chop the basil. Use your knife in a rocking motion to mince it into very small pieces, you want the herbs to be as fine as possible.",
      "Add the pistachios to the cutting board and chop them into the basil, leaving no piece larger than the tip of a pencil eraser.",
      "Add the basil and pistachios to a bowl. Grate in the garlic and squeeze in the juice from one lemon. Pour in a generous glug of olive oil, stir and season with salt to taste. You want the mixture to be thick but still viscous, like an herby salsa. Set this aside.",
      "Remove the stems from the tomatoes and cut them into large pieces. I prefer slices. Do the same with the cherry plums. Add both to a large bowl.",
      "Thinly slice the red onion, tear the mint and dill with your hands. Add both of these into the bowl with the tomatoes and cherry plums and gently toss everything together. Add a drizzle of good olive oil and salt and pepper to taste. This salad is nothing fancy, I just like to let the ingredients shine.",
      "Lastly, bring a cast iron or grill pan to medium heat. Add in the avocado oil. While the oil is heating up, season the swordfish fillets with salt and pepper on each side. Grill the swordfish for 5-6 minutes, or until it releases from the pan. Then flip and cook for an additional 3-4 minutes.",
      "To serve, add a heaping portion of the salad to a plate, then add the swordfish. Top the swordfish with the basil pistachio relish and enjoy with a very crispy glass of white wine."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Begin by making the basil relish. Finely chop the basil. Use your knife in a rocking motion to mince it into very small pieces, you want the herbs to be as fine as possible.\nAdd the pistachios to the cutting board and chop them into the basil, leaving no piece larger than the tip of a pencil eraser.\nAdd the basil and pistachios to a bowl. Grate in the garlic and squeeze in the juice from one lemon. Pour in a generous glug of olive oil, stir and season with salt to taste. You want the mixture to be thick but still viscous, like an herby salsa. Set this aside.\nRemove the stems from the tomatoes and cut them into large pieces. I prefer slices. Do the same with the cherry plums. Add both to a large bowl.\nThinly slice the red onion, tear the mint and dill with your hands. Add both of these into the bowl with the tomatoes and cherry plums and gently toss everything together. Add a drizzle of good olive oil and salt and pepper to taste. This salad is nothing fancy, I just like to let the ingredients shine.\nLastly, bring a cast iron or grill pan to medium heat. Add in the avocado oil. While the oil is heating up, season the swordfish fillets with salt and pepper on each side. Grill the swordfish for 5-6 minutes, or until it releases from the pan. Then flip and cook for an additional 3-4 minutes.\nTo serve, add a heaping portion of the salad to a plate, then add the swordfish. Top the swordfish with the basil pistachio relish and enjoy with a very crispy glass of white wine.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("justinesnacks.com")
    expect(recipe.canonical_url).to eq("https://justinesnacks.com/grilled-swordfish-with-basil-pistachio-relish-and-tomato-salad/")
    expect(recipe.site_name).to eq("Justine Snacks")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Justine Doiron")
    expect(recipe.description).to eq("This is the kind of salad I made when I'm not in the mood to make an involved salad. It's easy, unique, and has just the amount of textures and flavors to be something I want to eat again and again. Add in rich and simple grilled swordfish and dinner is fully served.")
    expect(recipe.image).to eq("https://justinesnacks.com/wp-content/uploads/2022/07/swordfish-with-basil-relish-.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq(["heirloom tomatoes", "swordfish", "tomato salad"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
