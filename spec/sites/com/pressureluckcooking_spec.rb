# frozen_string_literal: true

RSpec.describe "pressureluckcooking.com" do
  subject(:recipe) { scrape_cassette("com/pressureluckcooking", url: "https://pressureluckcooking.com/instant-pot-jeffreys-favorite-chicken/") }

  it "reads the title" do
    expect(recipe.title).to eq("Instant Pot Jeffrey's Favorite Chicken")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 1/2 - 2 pounds boneless, skinless chicken cutlets (breasts sliced into 1/4-inch thick fillets)",
      "1/4 cup of one of the following: all-purpose flour, whole wheat flour, coconut flour, or quinoa flour (with a few pinches garlic powder, peppers and salt mixed in with a fork)",
      "1/4 cup extra-virgin olive oil",
      "2 teaspoons ghee or 1 tablespoon salted butter, divided (see Jeff's Tips)",
      "2 large shallots, diced",
      "8 ounces baby bella or white mushrooms, sliced",
      "6 cloves (2 tablespoons) garlic, minced or pressed",
      "1/2 cup dry white wine (like a sauvignon blanc) or additional broth",
      "Juice of 1/2 lemon",
      "1/2 cup low-sodium chicken broth",
      "1 teaspoon Italian seasoning",
      "1 teaspoon seasoned salt",
      "5-8 ounces baby spinach",
      "1 tablespoon cornstarch + 1 tablespoon cold water",
      "1/4 cup any milk of your choice (or an unsweetened nondairy milk such as almond, oat or soy)",
      "1 (10-ounce) jar sun-dried tomatoes, drained and roughly chopped",
      "1 (14-ounce) can artichoke hearts, drained and chopped"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.5, unit: "pounds", name: "boneless, skinless chicken cutlets" },
      { amount: 0.25, unit: "cup", name: "one of the following: all-purpose flour, whole wheat flour, coconut flour, or quinoa flour" },
      { amount: 0.25, unit: "cup", name: "extra-virgin olive oil" },
      { amount: 2.0, unit: "teaspoons", name: "ghee or 1 tablespoon salted butter, divided" },
      { amount: 2.0, unit: nil, name: "large shallots, diced" },
      { amount: 8.0, unit: "ounces", name: "baby bella or white mushrooms, sliced" },
      { amount: 6.0, unit: "cloves", name: "garlic, minced or pressed" },
      { amount: 0.5, unit: "cup", name: "dry white wine or additional broth" },
      { amount: nil, unit: nil, name: "Juice of 1/2 lemon" },
      { amount: 0.5, unit: "cup", name: "low-sodium chicken broth" },
      { amount: 1.0, unit: "teaspoon", name: "Italian seasoning" },
      { amount: 1.0, unit: "teaspoon", name: "seasoned salt" },
      { amount: 5.0, unit: "ounces", name: "baby spinach" },
      { amount: 1.0, unit: "tablespoon", name: "cornstarch + 1 tablespoon cold water" },
      { amount: 0.25, unit: "cup", name: "any milk of your choice" },
      { amount: 1.0, unit: "jar", name: "sun-dried tomatoes, drained and roughly chopped" },
      { amount: 1.0, unit: "can", name: "artichoke hearts, drained and chopped" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Dredge the chicken cutlets in the flour mixture so they're lightly coated and set aside on a plate.",
      "Add the olive oil and half the butter/ghee, hit Sauté and Adjust to the More or High setting. After 3 minutes of heating, add the chicken to the pot in batches and sear on each side for about 45-60 seconds, until just ever so lightly browned. Use tongs to remove and rest the seared on a plate.",
      "Add the remaining half of butter/ghee. (NOTE: If the olive oil is totally gone from searing the chicken, you can add 1 additional tablespoon). Once the butter's melted, add the shallots and mushrooms and sauté for 2 minutes. Add the garlic and sauté for 1 minute longer.",
      "Add the wine (or additional 1/2 cup of broth) and lemon juice and simmer for 2 minutes, scraping the bottom of the pot to loosen any browned bits so it's nice and smooth.",
      "Add the broth, Italian seasoning, seasoned salt and stir. Return the seared chicken to the pot and top with the spinach (if it seems piled high, don't worry. It cooks down to nothing).",
      "Secure the lid, movie the valve to the sealing position, and hit Cancel followed by Pressure Cook or Manual at High Pressure for 5 minutes. Quick release when done. Using tongs, transfer the chicken to a serving dish.",
      "Mix together the cornstarch and water to form a slurry.",
      "Hit Cancel followed by Sauté and Adjust to the More or High setting. Stir in the slurry and it will thicken the sauce immediately. Stir in the milk, sun-dried tomatoes and artichokes. Hit Cancel to turn the pot off.",
      "Ladle the sauce over the chicken and serve!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Dredge the chicken cutlets in the flour mixture so they're lightly coated and set aside on a plate.\nAdd the olive oil and half the butter/ghee, hit Sauté and Adjust to the More or High setting. After 3 minutes of heating, add the chicken to the pot in batches and sear on each side for about 45-60 seconds, until just ever so lightly browned. Use tongs to remove and rest the seared on a plate.\nAdd the remaining half of butter/ghee. (NOTE: If the olive oil is totally gone from searing the chicken, you can add 1 additional tablespoon). Once the butter's melted, add the shallots and mushrooms and sauté for 2 minutes. Add the garlic and sauté for 1 minute longer.\nAdd the wine (or additional 1/2 cup of broth) and lemon juice and simmer for 2 minutes, scraping the bottom of the pot to loosen any browned bits so it's nice and smooth.\nAdd the broth, Italian seasoning, seasoned salt and stir. Return the seared chicken to the pot and top with the spinach (if it seems piled high, don't worry. It cooks down to nothing).\nSecure the lid, movie the valve to the sealing position, and hit Cancel followed by Pressure Cook or Manual at High Pressure for 5 minutes. Quick release when done. Using tongs, transfer the chicken to a serving dish.\nMix together the cornstarch and water to form a slurry.\nHit Cancel followed by Sauté and Adjust to the More or High setting. Stir in the slurry and it will thicken the sauce immediately. Stir in the milk, sun-dried tomatoes and artichokes. Hit Cancel to turn the pot off.\nLadle the sauce over the chicken and serve!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("pressureluckcooking.com")
    expect(recipe.canonical_url).to eq("https://pressureluckcooking.com/instant-pot-jeffreys-favorite-chicken/")
    expect(recipe.site_name).to eq("Pressure Luck Cooking")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Jeffrey")
    expect(recipe.description).to eq("A fervent believer in giving folks what they ask for, I recently polled my readers for the next dish they wanted me to make. The winner was chicken and I felt it only fitting to finally put one of my favorite recipes that in my Lighter (blue) book on the blog. In fact, it's called Jeffrey's Favorite Chicken for a reason and seeing how it's tender cutlets in a light, yet rich and hearty lemon-wine sauce loaded with mushrooms, spinach, artichokes and sun-dried tomatoes, can you blame me? It can also easily be keto, paleo, gluten-free and dairy-free (see Jeff's Tips).")
    expect(recipe.image).to eq("https://pressureluckcooking.com/wp-content/uploads/2023/01/Jeffreys-Favorite-Chicken-IG-1-scaled-720x720.jpg")
    expect(recipe.category).to eq("Poultry")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(5)
    expect(recipe.keywords).to eq(["Jeffrey's Favorite Chicken", "Instant Pot", "Pressure Luck"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(["GlutenFreeDiet"])
    expect(recipe.ratings).to eq(4.4)
    expect(recipe.ratings_count).to eq(48)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-nav-primary")
  end
end
