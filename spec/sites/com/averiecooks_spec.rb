# frozen_string_literal: true

RSpec.describe "averiecooks.com" do
  subject(:recipe) { scrape_cassette("com/averiecooks", url: "https://www.averiecooks.com/ravioli-lasagna/") }

  it "reads the title" do
    expect(recipe.title).to eq("Ravioli Lasagna")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 pound extra lean ground beef",
      "3 cloves garlic (finely minced (or use garlic powder, to taste))",
      "24 ounces marinara sauce",
      "1 teaspoon Italian seasoning",
      "1 teaspoon onion powder (or to taste)",
      "1 teaspoon salt (or to taste)",
      "1/2 teaspoon freshly ground black pepper (or to taste)",
      "25 ounces ravioli (divided, any variety (if using frozen ravioli, make sure it's thawed; I used cheese or try beef, spinach, etc.))",
      "2 cups shredded mozzarella cheese (divided)",
      "½ cup grated Parmesan cheese (plus more for garnishing if desired)",
      "Fresh herbs (optional for garnishing (parsley, basil, or your favorite))"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "pound", name: "extra lean ground beef" },
      { amount: 3.0, unit: "cloves", name: "garlic" },
      { amount: 24.0, unit: "ounces", name: "marinara sauce" },
      { amount: 1.0, unit: "teaspoon", name: "Italian seasoning" },
      { amount: 1.0, unit: "teaspoon", name: "onion powder" },
      { amount: 1.0, unit: "teaspoon", name: "salt" },
      { amount: 0.5, unit: "teaspoon", name: "freshly ground black pepper" },
      { amount: 25.0, unit: "ounces", name: "ravioli" },
      { amount: 2.0, unit: "cups", name: "shredded mozzarella cheese" },
      { amount: 0.5, unit: "cup", name: "grated Parmesan cheese" },
      { amount: nil, unit: nil, name: "Fresh herbs" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 375F, spray a 9x13-inch baking dish or casserole dish with cooking spray; set aside.",
      "To a large skillet, add the ground beef and cook over medium-high heat to brown and cook it through; crumble the beef as it cooks.",
      "As the beef is finishing cooking, add the garlic, and cook for 1 minute or until fragrant; stir nearly constantly.",
      "Add the marinara sauce, Italian seasoning, onion powder, salt, pepper, and stir to combine. Simmer for about 3-4 minutes, or until warmed through; stir occasionally.",
      "Add about 1 to 1 1/2 cups meat sauce to the bottom of the casserole dish and spread it out.",
      "Evenly top with HALF the ravioli in an even, flat layer.",
      "Evenly top with HALF the remaining meat sauce and spread it gently.",
      "Evenly top with HALF the mozzarella cheese. And the remaining ravioli. Tip - If you have more ravioli than your casserole dish has room for, I personally wouldn't overlap them or pile them too much on top of each other.",
      "Evenly top with the remaining meat sauce and spread it gently.",
      "Evenly top with the remaining mozzarella.",
      "Evenly top with all the Parmesan cheese.",
      "Cover tightly with foil.Make-Ahead: If you're making this in advance, stop here, cover tightly with foil, and refrigerate up to 48 hours, or until you're ready to bake it off. Make sure to take the casserole dish out of the fridge ONE HOUR before you're ready to bake it. Don't bake with a fridge-cold baking dish because it'll throw off the baking time and the results.",
      "Bake covered for 35 minutes.",
      "Remove the foil, and bake uncovered for about 10-15 minutes, or until the cheese on top is as lightly golden browned as desired and the casserole is bubbly at the edges.",
      "Allow it to rest for about 10-15 minutes before optionally garnishing as desired, slicing and serving (so it's not quite as messy or challenging to slice)."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 375F, spray a 9x13-inch baking dish or casserole dish with cooking spray; set aside.\nTo a large skillet, add the ground beef and cook over medium-high heat to brown and cook it through; crumble the beef as it cooks.\nAs the beef is finishing cooking, add the garlic, and cook for 1 minute or until fragrant; stir nearly constantly.\nAdd the marinara sauce, Italian seasoning, onion powder, salt, pepper, and stir to combine. Simmer for about 3-4 minutes, or until warmed through; stir occasionally.\nAdd about 1 to 1 1/2 cups meat sauce to the bottom of the casserole dish and spread it out.\nEvenly top with HALF the ravioli in an even, flat layer.\nEvenly top with HALF the remaining meat sauce and spread it gently.\nEvenly top with HALF the mozzarella cheese. And the remaining ravioli. Tip - If you have more ravioli than your casserole dish has room for, I personally wouldn't overlap them or pile them too much on top of each other.\nEvenly top with the remaining meat sauce and spread it gently.\nEvenly top with the remaining mozzarella.\nEvenly top with all the Parmesan cheese.\nCover tightly with foil.Make-Ahead: If you're making this in advance, stop here, cover tightly with foil, and refrigerate up to 48 hours, or until you're ready to bake it off. Make sure to take the casserole dish out of the fridge ONE HOUR before you're ready to bake it. Don't bake with a fridge-cold baking dish because it'll throw off the baking time and the results.\nBake covered for 35 minutes.\nRemove the foil, and bake uncovered for about 10-15 minutes, or until the cheese on top is as lightly golden browned as desired and the casserole is bubbly at the edges.\nAllow it to rest for about 10-15 minutes before optionally garnishing as desired, slicing and serving (so it's not quite as messy or challenging to slice).")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("averiecooks.com")
    expect(recipe.canonical_url).to eq("https://www.averiecooks.com/ravioli-lasagna/")
    expect(recipe.site_name).to eq("Averie Cooks")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Averie Sunshine")
    expect(recipe.description).to eq("🍝 Made with ravioli rather than traditional lasagna noodles and is a comfort food family favorite that's ready in 1 hour! There's ground beef, marinara sauce, and it's topped with both mozzarella and Parmesan cheese! Easy to prep in advance and it freezes well for a planned freezer stash!")
    expect(recipe.image).to eq("https://www.averiecooks.com/wp-content/uploads/2026/04/raviolilasagna-15.jpg")
    expect(recipe.category).to eq("Dinner")
    expect(recipe.cuisine).to eq("Italian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(50)
    expect(recipe.keywords).to eq([
      "ground beef ravioli lasagna",
      "ravioli lasagna",
      "ravioli lasagna with ground beef"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(3)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 serving",
      "calories" => "507 kcal",
      "carbohydrateContent" => "43 g",
      "proteinContent" => "34 g",
      "fatContent" => "22 g",
      "saturatedFatContent" => "9 g",
      "transFatContent" => "0.2 g",
      "cholesterolContent" => "111 mg",
      "sodiumContent" => "1563 mg",
      "fiberContent" => "4 g",
      "sugarContent" => "5 g",
      "unsaturatedFatContent" => "5 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "serving", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 507.0 },
      { name: "carbohydrateContent", unit: "g", amount: 43.0 },
      { name: "proteinContent", unit: "g", amount: 34.0 },
      { name: "fatContent", unit: "g", amount: 22.0 },
      { name: "saturatedFatContent", unit: "g", amount: 9.0 },
      { name: "transFatContent", unit: "g", amount: 0.2 },
      { name: "cholesterolContent", unit: "mg", amount: 111.0 },
      { name: "sodiumContent", unit: "mg", amount: 1563.0 },
      { name: "fiberContent", unit: "g", amount: 4.0 },
      { name: "sugarContent", unit: "g", amount: 5.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 5.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://statcounter.com/")
  end
end
