# frozen_string_literal: true

RSpec.describe "ohsheglows.com" do
  subject(:recipe) { scrape_cassette("com/ohsheglows", url: "https://ohsheglows.com/my-new-cookbook-oh-she-glows-salads-is-here/") }

  it "reads the title" do
    expect(recipe.title).to eq("Warm and Cozy Roasted Mediterranean Lentil Salad")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 medium (690 g total) yellow potatoes, peeled",
      "1 large or 2 small (290 g total) zucchini",
      "2 medium (400 g total) red bell peppers, seeded",
      "1 pint (283 g) grape tomatoes*",
      "3 tablespoons (45 mL) extra-virgin olive oil",
      "Fine sea salt and freshly ground black pepper",
      "1 batch Zesty Lemon, Dill, and Oregano Dressing",
      "1½ cups (250 g) cooked brown lentils, drained and rinsed**",
      "½ cup packed (19 g) fresh dill, minced",
      "½ cup packed (15 g) fresh basil leaves, finely chopped",
      "½ cup (80 g) oil-packed sun-dried tomatoes, drained and finely chopped",
      "Dressed baby romaine or butter lettuce",
      "Drizzle of runny tahini",
      "Squeeze of fresh lemon juice (for those who love it extra tangy)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: nil, name: "medium yellow potatoes, peeled" },
      { amount: 1.0, unit: nil, name: "large or 2 small zucchini" },
      { amount: 2.0, unit: nil, name: "medium red bell peppers, seeded" },
      { amount: 1.0, unit: "pint", name: "grape tomatoes*" },
      { amount: 3.0, unit: "tablespoons", name: "extra-virgin olive oil" },
      { amount: nil, unit: nil, name: "Fine sea salt and freshly ground black pepper" },
      { amount: 1.0, unit: "batch", name: "Zesty Lemon, Dill, and Oregano Dressing" },
      { amount: 1.5, unit: "cups", name: "cooked brown lentils, drained and rinsed**" },
      { amount: 0.5, unit: "cup", name: "packed fresh dill, minced" },
      { amount: 0.5, unit: "cup", name: "packed fresh basil leaves, finely chopped" },
      { amount: 0.5, unit: "cup", name: "oil-packed sun-dried tomatoes, drained and finely chopped" },
      { amount: nil, unit: nil, name: "Dressed baby romaine or butter lettuce" },
      { amount: 1.0, unit: "Drizzle", name: "runny tahini" },
      { amount: nil, unit: nil, name: "Squeeze of fresh lemon juice" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Position the racks in the upper and lower thirds of the oven and preheat to 400°F (200°C). Line 2 large rimmed baking sheets with parchment paper.",
      "Chop the peeled potatoes, zucchini, and bell peppers into ¾-inch (2 cm) pieces, adding them to the 2 prepared baking sheets as you go (you should have 4 cups potatoes, 2 cups zucchini, and 3 heaping cups bell peppers). Cut the grape tomatoes in half, adding them to the baking sheets (you should have 1¾ cups).",
      "Sprinkle each sheet of veggies with half of the olive oil and toss until thoroughly coated. Season generously with salt and pepper. Spread in an even layer.",
      "Roast the veggies, uncovered, for 30 to 40 minutes, until fork-tender and golden, flipping the veggies and rotating the pans from upper to lower and back to front halfway through roasting.",
      "Meanwhile, make the Zesty Lemon, Dill, and Oregano Dressing.",
      "Prepare the lentils, dill, basil, and sun-dried tomatoes, adding them to a large bowl as you go. When the veggies are finished roasting, add them to the bowl and toss until well combined. Season to taste with salt and pepper.",
      "Assemble: Gather 4 large bowls. Divide the salad among the bowls (about 1¾ cups per bowl). Drizzle 3 generous tablespoons of dressing on top of each salad. Serve warm. I love to serve this warm salad over a bowl of dressed baby romaine lettuce, and then I drizzle runny tahini, more dressing, and sometimes a squeeze of fresh lemon on top."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Position the racks in the upper and lower thirds of the oven and preheat to 400°F (200°C). Line 2 large rimmed baking sheets with parchment paper.\nChop the peeled potatoes, zucchini, and bell peppers into ¾-inch (2 cm) pieces, adding them to the 2 prepared baking sheets as you go (you should have 4 cups potatoes, 2 cups zucchini, and 3 heaping cups bell peppers). Cut the grape tomatoes in half, adding them to the baking sheets (you should have 1¾ cups).\nSprinkle each sheet of veggies with half of the olive oil and toss until thoroughly coated. Season generously with salt and pepper. Spread in an even layer.\nRoast the veggies, uncovered, for 30 to 40 minutes, until fork-tender and golden, flipping the veggies and rotating the pans from upper to lower and back to front halfway through roasting.\nMeanwhile, make the Zesty Lemon, Dill, and Oregano Dressing.\nPrepare the lentils, dill, basil, and sun-dried tomatoes, adding them to a large bowl as you go. When the veggies are finished roasting, add them to the bowl and toss until well combined. Season to taste with salt and pepper.\nAssemble: Gather 4 large bowls. Divide the salad among the bowls (about 1¾ cups per bowl). Drizzle 3 generous tablespoons of dressing on top of each salad. Serve warm. I love to serve this warm salad over a bowl of dressed baby romaine lettuce, and then I drizzle runny tahini, more dressing, and sometimes a squeeze of fresh lemon on top.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("ohsheglows.com")
    expect(recipe.canonical_url).to eq("https://ohsheglows.com/my-new-cookbook-oh-she-glows-salads-is-here/")
    expect(recipe.site_name).to eq("Oh She Glows")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Angela Liddon")
    expect(recipe.description).to eq("This warm salad is so cozy on cool, rainy days in spring and summer, and on crisp nights in fall and winter. I love how the hydrating zucchini, sweet grape tomatoes, crispy yellow potatoes, and zippy bell peppers transform during roasting into a slightly caramelized, rich, and warming salad that contrasts so deliciously with the invigorating Zesty Lemon, Dill, and Oregano Dressing (page 239, Oh She Glows Salads). My favourite way to enjoy this salad is spooned over a bed of dressed baby romaine lettuce. Right before digging in, I always give it a drizzle of runny tahini and a squeeze of fresh lemon juice to take it over the top! It's also delicious paired with toasted pita bread for scooping, piled high on my Garlic-Infused Olive Oil Crostini (page 249, Oh She Glows Salads), or topped with cubes of my tangy Vegan Feta Cheese (page 259, Oh She Glows Salads).")
    expect(recipe.image).to eq("https://theglowspot.com/wp-content/uploads/sites/2/2026/04/Warm-Cozy-Roasted-Mediterranean-Lentil-Salad4608_app_2.jpg")
    expect(recipe.category).to eq("Vegan")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 items")
    expect(recipe.total_time).to eq(65)
    expect(recipe.prep_time).to eq(35)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["Vegan", "Gluten-Free", "Grain-Free", "Nut-Free", "Soy-Free", "Kid Friendly"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to eq(%w[GlutenFreeDiet VeganDiet VegetarianDiet])
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(2)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-content")
  end
end
