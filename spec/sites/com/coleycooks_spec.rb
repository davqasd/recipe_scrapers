# frozen_string_literal: true

RSpec.describe "coleycooks.com" do
  subject(:recipe) { scrape_cassette("com/coleycooks", url: "https://coleycooks.com/chicken-cutlets/") }

  it "reads the title" do
    expect(recipe.title).to eq("Best Ever Chicken Cutlets")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 cups homemade breadcrumbs or panko",
      "3 cloves garlic (finely minced or grated)",
      "2 tablespoons fresh Italian flat leaf parsley (finely minced )",
      "1/2 teaspoon dried Italian seasoning (optional)",
      "1 1/4 cup finely grated pecorino Romano or parmesan cheese (or both) (divided)",
      "kosher salt (to taste)",
      "freshly ground black pepper (to taste)",
      "3 large eggs",
      "1 cup all purpose flour",
      "2 lbs boneless skinless chicken breasts (thinly sliced)",
      "extra virgin olive oil (for frying)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "cups", name: "homemade breadcrumbs or panko" },
      { amount: 3.0, unit: "cloves", name: "garlic" },
      { amount: 2.0, unit: "tablespoons", name: "fresh Italian flat leaf parsley" },
      { amount: 0.5, unit: "teaspoon", name: "dried Italian seasoning" },
      { amount: 1.25, unit: "cup", name: "finely grated pecorino Romano or parmesan cheese" },
      { amount: nil, unit: nil, name: "kosher salt" },
      { amount: nil, unit: nil, name: "freshly ground black pepper" },
      { amount: 3.0, unit: nil, name: "large eggs" },
      { amount: 1.0, unit: "cup", name: "all purpose flour" },
      { amount: 2.0, unit: "lbs", name: "boneless skinless chicken breasts" },
      { amount: nil, unit: nil, name: "extra virgin olive oil" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Add the breadcrumbs, garlic, parsley, Italian seasoning, and 3/4 cup cheese to a medium shallow bowl. Season with salt and pepper, then use your fingers to mix it together, working the garlic into the breadcrumbs until evenly distributed.",
      "In another medium, shallow bowl, whisk together 3 eggs with 1/2 cup cheese, a pinch of salt and pepper and 1 tablespoon water until combined.",
      "Pour the flour into another shallow bowl or plate, season with salt and pepper and mix to combine.",
      "Take one piece of thinly sliced chicken and place it on a cutting board. Place a piece of plastic wrap over top, then use a meat mallet to pound it out to be about 1/2 inch thick. Repeat with the remaining chicken.",
      "Season each piece of chicken on both sides with salt and pepper.",
      "Set up the breading station so that the chicken is on the far left, then next to it the flour, then the egg, then the breadcrumbs, and then a landing plate or pan to hold the breaded chicken.",
      "Take a piece of chicken and dip it into the flour to coat on all sides, then tap off the excess (*See note).",
      "Next, dip it in the egg mixture and let the excess drip off.",
      "Transfer the chicken into the breadcrumbs. Be sure to press it down and move it around so that it's thoroughly coated. Place the chicken on the reserved plate, and repeat with the remaining pieces.",
      "Heat a generous amount of olive oil in a large, heavy bottomed saute pan over medium-high heat. Place 1-3 chicken breasts in at a time, depending on how many your pan can hold. Don't overcrowd the pan.",
      "Cook until golden brown on each side, then remove to a rack or paper towels to drain.",
      "Serve immediately, or place in a 250 degree F oven for up to 1 hour before serving to keep warm."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Add the breadcrumbs, garlic, parsley, Italian seasoning, and 3/4 cup cheese to a medium shallow bowl. Season with salt and pepper, then use your fingers to mix it together, working the garlic into the breadcrumbs until evenly distributed.\nIn another medium, shallow bowl, whisk together 3 eggs with 1/2 cup cheese, a pinch of salt and pepper and 1 tablespoon water until combined.\nPour the flour into another shallow bowl or plate, season with salt and pepper and mix to combine.\nTake one piece of thinly sliced chicken and place it on a cutting board. Place a piece of plastic wrap over top, then use a meat mallet to pound it out to be about 1/2 inch thick. Repeat with the remaining chicken.\nSeason each piece of chicken on both sides with salt and pepper.\nSet up the breading station so that the chicken is on the far left, then next to it the flour, then the egg, then the breadcrumbs, and then a landing plate or pan to hold the breaded chicken.\nTake a piece of chicken and dip it into the flour to coat on all sides, then tap off the excess (*See note).\nNext, dip it in the egg mixture and let the excess drip off.\nTransfer the chicken into the breadcrumbs. Be sure to press it down and move it around so that it's thoroughly coated. Place the chicken on the reserved plate, and repeat with the remaining pieces.\nHeat a generous amount of olive oil in a large, heavy bottomed saute pan over medium-high heat. Place 1-3 chicken breasts in at a time, depending on how many your pan can hold. Don't overcrowd the pan.\nCook until golden brown on each side, then remove to a rack or paper towels to drain.\nServe immediately, or place in a 250 degree F oven for up to 1 hour before serving to keep warm.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("coleycooks.com")
    expect(recipe.canonical_url).to eq("https://coleycooks.com/chicken-cutlets/")
    expect(recipe.site_name).to eq("Coley Cooks")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Nicole Gaffney")
    expect(recipe.description).to eq("This recipe for Italian breaded Chicken Cutlets is the BEST you'll ever have! There a few key secrets to getting that crispy outer coating just right.")
    expect(recipe.image).to eq("https://coleycooks.com/wp-content/uploads/2022/03/crispy-italian-breaded-chicken-cutlets-3.jpg")
    expect(recipe.category).to eq("chicken")
    expect(recipe.cuisine).to eq("Italian")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq([
      "best",
      "breaded",
      "chicken",
      "chicken parmesan",
      "crispy",
      "cutlets",
      "easy",
      "flavorful",
      "Italian",
      "milanese",
      "Panko",
      "parm"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.95)
    expect(recipe.ratings_count).to eq(219)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "489 kcal",
      "sugarContent" => "2 g",
      "sodiumContent" => "792 mg",
      "fatContent" => "14 g",
      "saturatedFatContent" => "5 g",
      "transFatContent" => "0.03 g",
      "carbohydrateContent" => "41 g",
      "fiberContent" => "2 g",
      "proteinContent" => "47 g",
      "cholesterolContent" => "197 mg",
      "unsaturatedFatContent" => "6 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 489.0 },
      { name: "sugarContent", unit: "g", amount: 2.0 },
      { name: "sodiumContent", unit: "mg", amount: 792.0 },
      { name: "fatContent", unit: "g", amount: 14.0 },
      { name: "saturatedFatContent", unit: "g", amount: 5.0 },
      { name: "transFatContent", unit: "g", amount: 0.03 },
      { name: "carbohydrateContent", unit: "g", amount: 41.0 },
      { name: "fiberContent", unit: "g", amount: 2.0 },
      { name: "proteinContent", unit: "g", amount: 47.0 },
      { name: "cholesterolContent", unit: "mg", amount: 197.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 6.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
