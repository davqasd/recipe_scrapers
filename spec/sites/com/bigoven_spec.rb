# frozen_string_literal: true

RSpec.describe "bigoven.com" do
  subject(:recipe) { scrape_cassette("com/bigoven", url: "https://bigoven.com/recipe/roasted-shaved-corn-salad-with-steak/3224315") }

  it "reads the title" do
    expect(recipe.title).to eq("Roasted Shaved Corn Salad with Steak")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 tbsp soy sauce",
      "1 tbsp lime juice",
      "1 garlic clove minced",
      "1 tbsp olive oil",
      "12 oz skirt steak",
      "Kernels shaved from 2 ears fresh corn",
      "1 cup cherry tomatoes on the vine",
      "2 tbsp olive oil divided",
      "1/4 tsp salt",
      "1/4 tsp chili powder",
      "Salt and freshly ground black pepper to taste",
      "3 cups frisée greens",
      "1/4 cup Cotija cheese crumbled",
      "2 tbsp coarsely chopped fresh cilantro"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "tbsp", name: "soy sauce" },
      { amount: 1.0, unit: "tbsp", name: "lime juice" },
      { amount: 1.0, unit: nil, name: "garlic clove minced" },
      { amount: 1.0, unit: "tbsp", name: "olive oil" },
      { amount: 12.0, unit: "oz", name: "skirt steak" },
      { amount: nil, unit: nil, name: "Kernels shaved from 2 ears fresh corn" },
      { amount: 1.0, unit: "cup", name: "cherry tomatoes on the vine" },
      { amount: 2.0, unit: "tbsp", name: "olive oil divided" },
      { amount: 0.25, unit: "tsp", name: "salt" },
      { amount: 0.25, unit: "tsp", name: "chili powder" },
      { amount: nil, unit: nil, name: "Salt and freshly ground black pepper to taste" },
      { amount: 3.0, unit: "cups", name: "frisée greens" },
      { amount: 0.25, unit: "cup", name: "Cotija cheese crumbled" },
      { amount: 2.0, unit: "tbsp", name: "coarsely chopped fresh cilantro" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large bowl, whisk together the soy sauce, lime juice, garlic, and olive oil. Add the skirt steak and turn to coat.",
      "Let marinate at room temperature for 30 minutes.",
      "Preheat the oven to 425°F. Line two baking sheets with parchment paper.",
      "To prepare the corn, firmly hold each corn cob upright on a flat cutting board with the base flush against the surface. Using a very sharp knife, carefully shave down the sides of the cob, cutting as close to the cob as possible. The goal is to remove large sheets of kernels with several rows still attached rather than individual kernels.",
      "Arrange the shaved corn pieces on one prepared baking sheet. Drizzle with 1 tablespoon olive oil and season with the salt and chili powder. Toss gently to coat.",
      "Place the cherry tomatoes on the vine on the second baking sheet. Drizzle with the remaining 1 tablespoon olive oil and season lightly with salt and freshly ground black pepper.",
      "Roast both baking sheets for 15 minutes, or until the corn is lightly charred around the edges and the tomatoes have softened, slightly collapsed, and become rich and jammy in the center.",
      "While the vegetables roast, remove the steak from the marinade and thoroughly pat dry with paper towels.",
      "Discard the marinade. Season lightly with salt and pepper.",
      "Heat a heavy skillet or cast-iron pan over medium-high to high heat until very hot. Add the steak and sear for 2 to 4 minutes per side, depending on thickness and desired doneness. Avoid moving the steak while it cooks to develop a deep, flavorful crust.",
      "Transfer the steak to a cutting board and let rest for 5 minutes. Slice thinly against the grain.",
      "Divide the frisée greens between two serving plates. Top with the roasted corn and tomatoes. Arrange the sliced steak over the salad and finish with Cotija cheese and cilantro.",
      "Serve immediately and enjoy."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["For the Marinade", 4],
        ["For the Salad", 10]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large bowl, whisk together the soy sauce, lime juice, garlic, and olive oil. Add the skirt steak and turn to coat.\nLet marinate at room temperature for 30 minutes.\nPreheat the oven to 425°F. Line two baking sheets with parchment paper.\nTo prepare the corn, firmly hold each corn cob upright on a flat cutting board with the base flush against the surface. Using a very sharp knife, carefully shave down the sides of the cob, cutting as close to the cob as possible. The goal is to remove large sheets of kernels with several rows still attached rather than individual kernels.\nArrange the shaved corn pieces on one prepared baking sheet. Drizzle with 1 tablespoon olive oil and season with the salt and chili powder. Toss gently to coat.\nPlace the cherry tomatoes on the vine on the second baking sheet. Drizzle with the remaining 1 tablespoon olive oil and season lightly with salt and freshly ground black pepper.\nRoast both baking sheets for 15 minutes, or until the corn is lightly charred around the edges and the tomatoes have softened, slightly collapsed, and become rich and jammy in the center.\nWhile the vegetables roast, remove the steak from the marinade and thoroughly pat dry with paper towels.\nDiscard the marinade. Season lightly with salt and pepper.\nHeat a heavy skillet or cast-iron pan over medium-high to high heat until very hot. Add the steak and sear for 2 to 4 minutes per side, depending on thickness and desired doneness. Avoid moving the steak while it cooks to develop a deep, flavorful crust.\nTransfer the steak to a cutting board and let rest for 5 minutes. Slice thinly against the grain.\nDivide the frisée greens between two serving plates. Top with the roasted corn and tomatoes. Arrange the sliced steak over the salad and finish with Cotija cheese and cilantro.\nServe immediately and enjoy.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("bigoven.com")
    expect(recipe.canonical_url).to eq("https://www.bigoven.com/recipe/roasted-shaved-corn-salad-with-steak/3224315")
    expect(recipe.site_name).to eq("BigOven.com")
    expect(recipe.language).to eq("en")
    expect(recipe.author).to eq("BigOvenEditorial")
    expect(recipe.description).to eq("This steak salad is loaded with juicy skirt steak, sweet roasted corn, and blistered tomatoes for an easy meal that's full of fresh summer flavor. Topped with Cotija cheese and fresh cilantro, it's a simple, satisfying dinner that's perfect for warm evenings or weekend cookouts.")
    expect(recipe.image).to eq("https://bigoven-res.cloudinary.com/image/upload/f_auto,q_auto/h_640,w_640,c_fill/roasted-shaved-corn-salad-with-bcafed.jpg")
    expect(recipe.category).to eq("Salad")
    expect(recipe.cuisine).to eq("not set")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(70)
    expect(recipe.prep_time).to eq(25)
    expect(recipe.cook_time).to eq(45)
    expect(recipe.keywords).to eq(["white meat free", "contains cheese", "contains red meat", "contains gluten", "contains dairy"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "0 calories",
      "fatContent" => "0 g",
      "carbohydrateContent" => "0 g",
      "cholesterolContent" => "0 mg",
      "fiberContent" => "0 g",
      "proteinContent" => "0 g",
      "saturatedFatContent" => "0 g",
      "servingSize" => "1 1 Recipe (0g)",
      "sodiumContent" => "0 mg",
      "sugarContent" => "0 g",
      "transFatContent" => "0 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 0.0 },
      { name: "fatContent", unit: "g", amount: 0.0 },
      { name: "carbohydrateContent", unit: "g", amount: 0.0 },
      { name: "cholesterolContent", unit: "mg", amount: 0.0 },
      { name: "fiberContent", unit: "g", amount: 0.0 },
      { name: "proteinContent", unit: "g", amount: 0.0 },
      { name: "saturatedFatContent", unit: "g", amount: 0.0 },
      { name: "servingSize", unit: nil, amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 0.0 },
      { name: "sugarContent", unit: "g", amount: 0.0 },
      { name: "transFatContent", unit: "g", amount: 0.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#reviews-section")
  end
end
