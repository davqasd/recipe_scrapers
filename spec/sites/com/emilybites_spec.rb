# frozen_string_literal: true

RSpec.describe "emilybites.com" do
  subject(:recipe) { scrape_cassette("com/emilybites", url: "https://emilybites.com/2026/04/creamy-tomato-pasta-with-ham.html") }

  it "reads the title" do
    expect(recipe.title).to eq("Creamy Tomato Pasta with Ham")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 tablespoon olive oil",
      "⅓ cup chopped onion",
      "4 oz sliced mushrooms (I used Baby Bellas)",
      "2 garlic cloves (minced)",
      "½ - 1 teaspoon crushed red pepper flakes (depending on how much spice you like)",
      "8 oz cubed ham (found by bacon or deli meat, I used Hormel Cure 81 Cubed Ham)",
      "24.5 oz jar of tomato passata/puree (such as Mutti)",
      "½ teaspoon salt",
      "1 lb medium-sized shaped pasta ((such as penne, orecchiette, fusilli, farfalle, cavatappi, shells) )",
      "2 oz Parmesan cheese (finely shredded)",
      "¾ cup fat free half and half creamer"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "tablespoon", name: "olive oil" },
      { amount: 0.33, unit: "cup", name: "chopped onion" },
      { amount: 4.0, unit: "oz", name: "sliced mushrooms" },
      { amount: 2.0, unit: nil, name: "garlic cloves" },
      { amount: 0.5, unit: "teaspoon", name: "crushed red pepper flakes" },
      { amount: 8.0, unit: "oz", name: "cubed ham" },
      { amount: 24.5, unit: "oz", name: "jar of tomato passata/puree" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 1.0, unit: "lb", name: "medium-sized shaped pasta" },
      { amount: 2.0, unit: "oz", name: "Parmesan cheese" },
      { amount: 0.75, unit: "cup", name: "fat free half and half creamer" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Fill a large pot with around 4-6 quarts of salted water and place over high heat to bring to a boil.",
      "While the water is heating, drizzle the olive oil into a large sauté pan and bring over medium heat. When the oil is hot, add the chopped onion and sliced mushrooms and stir to coat with the oil. Spread the vegetables out and sprinkle with a little salt. Cook, stirring often, for about 3 minutes until softened. Add the garlic and red pepper flakes and stir together. Cook for another 30-60 seconds until the garlic is fragrant and then add the cubed ham. Stir the contents of the pan and cook for another 2 minutes.",
      "Add the tomato puree from the jar to the ham mixture. Scoop ¼ cup of the boiling salted water from the pot and pour it into the puree jar. Put the lid back on and shake it to loosen any remaining puree. Remove the lid and pour the tomato water into the pan with the rest of the sauce. Add the ½ teaspoon of salt and stir. Increase the heat to medium-high until the mixture begins to boil, then reduce the heat to medium-low to simmer. Simmer uncovered for 10 minutes, stirring occasionally.",
      "When the sauce begins simmering, add the pasta to the boiling water in the pot and cook following the package directions. Drain in a colander.",
      "Remove the pan with the sauce from heat and stir in the shredded parmesan cheese until melted into the sauce. Slowly stir in the half and half until fully combined and then add the drained pasta and stir together until coated."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Fill a large pot with around 4-6 quarts of salted water and place over high heat to bring to a boil.\nWhile the water is heating, drizzle the olive oil into a large sauté pan and bring over medium heat. When the oil is hot, add the chopped onion and sliced mushrooms and stir to coat with the oil. Spread the vegetables out and sprinkle with a little salt. Cook, stirring often, for about 3 minutes until softened. Add the garlic and red pepper flakes and stir together. Cook for another 30-60 seconds until the garlic is fragrant and then add the cubed ham. Stir the contents of the pan and cook for another 2 minutes.\nAdd the tomato puree from the jar to the ham mixture. Scoop ¼ cup of the boiling salted water from the pot and pour it into the puree jar. Put the lid back on and shake it to loosen any remaining puree. Remove the lid and pour the tomato water into the pan with the rest of the sauce. Add the ½ teaspoon of salt and stir. Increase the heat to medium-high until the mixture begins to boil, then reduce the heat to medium-low to simmer. Simmer uncovered for 10 minutes, stirring occasionally.\nWhen the sauce begins simmering, add the pasta to the boiling water in the pot and cook following the package directions. Drain in a colander.\nRemove the pan with the sauce from heat and stir in the shredded parmesan cheese until melted into the sauce. Slowly stir in the half and half until fully combined and then add the drained pasta and stir together until coated.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("emilybites.com")
    expect(recipe.canonical_url).to eq("https://emilybites.com/2026/04/creamy-tomato-pasta-with-ham.html")
    expect(recipe.site_name).to eq("Emily Bites")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Emily Bites")
    expect(recipe.description).to eq("This Creamy Tomato Pasta with Ham is a flavorful, family-friendly meal that’s perfect for weeknights!")
    expect(recipe.image).to eq("https://emilybites.com/wp-content/uploads/2026/04/Creamy-Tomato-Pasta-with-Ham-5b.jpg")
    expect(recipe.category).to eq("Main Course")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(25)
    expect(recipe.keywords).to eq(["Creamy Tomato Sauce", "Easy WW Dinner", "Passata", "WW Pasta"])
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
    expect(recipe.links).to include("#content")
  end
end
