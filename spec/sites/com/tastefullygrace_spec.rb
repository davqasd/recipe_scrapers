# frozen_string_literal: true

RSpec.describe "tastefullygrace.com" do
  subject(:recipe) { scrape_cassette("com/tastefullygrace", url: "https://tastefullygrace.com/baguette-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Easiest French Baguette Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 cups bread flour (plus more for your working surface)",
      "1 ¼ cups water",
      "2 ¼ teaspoons instant yeast (1 packet)",
      "1 ¼ teaspoons salt"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "cups", name: "bread flour" },
      { amount: 1.25, unit: "cups", name: "water" },
      { amount: 2.25, unit: "teaspoons", name: "instant yeast" },
      { amount: 1.25, unit: "teaspoons", name: "salt" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In the bowl of a stand mixer, combine flour, yeast (make sure no yeast gets stuck in the little packet), and salt using the whisk attachment.",
      "Microwave water until it reaches 120-130℉. Use a thermometer to stir and then test water every 15 seconds or so until temperature is reached.",
      "Switch to the dough hook attachment, and add the warm water in a steady stream on low speed (speed 2). Knead dough on this low speed for 5 minutes. Not to worry; dough will be very wet and sticky!",
      "Lightly grease a bowl with flavorless oil. Flour your hands and place the sticky ball of dough in the greased bowl. It’s okay; dough will stick to floured hands!",
      "Seal bowl shut with plastic wrap and lay a clean kitchen towel over the top of the bowl. Place in a 75-80℉, dark space for 1 hour to rise. If space is not warm or dark, your dough will have trouble rising. See notes below for ideas on where to rise.",
      "Flip a large baking sheet upside down, lay a piece parchment paper on it, and lightly flour the parchment.",
      "Remove plastic wrap and towel after the hour (dough should have risen to about double its size), and deflate dough with your fist. Flour your hands and divide dough into 2 even balls. Stretch balls into long baguette shapes, letting gravity help the dough stretch to shape. Both baguettes should be slightly thinner than you’d like them to be when they’re baked. Place baguettes on the upside down, lined baking sheet, as far apart as possible.",
      "Lay kitchen towel over the baguettes and let rise in a 75-80℉, dark space for 30 more minutes. Dough will rise more!",
      "Preheat oven fully, to 450 degrees. Make a few long, shallow, diagonal slashes at about 45 degree angles on each baguette using a sharp knife.",
      "Bake baguettes on the upside down, parchment lined baking sheet at 450℉ for 16-20 minutes, or until crust is golden and the baguettes are hollow sounding when tapped. Place on a wire rack to cool, or enjoy!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In the bowl of a stand mixer, combine flour, yeast (make sure no yeast gets stuck in the little packet), and salt using the whisk attachment.\nMicrowave water until it reaches 120-130℉. Use a thermometer to stir and then test water every 15 seconds or so until temperature is reached.\nSwitch to the dough hook attachment, and add the warm water in a steady stream on low speed (speed 2). Knead dough on this low speed for 5 minutes. Not to worry; dough will be very wet and sticky!\nLightly grease a bowl with flavorless oil. Flour your hands and place the sticky ball of dough in the greased bowl. It’s okay; dough will stick to floured hands!\nSeal bowl shut with plastic wrap and lay a clean kitchen towel over the top of the bowl. Place in a 75-80℉, dark space for 1 hour to rise. If space is not warm or dark, your dough will have trouble rising. See notes below for ideas on where to rise.\nFlip a large baking sheet upside down, lay a piece parchment paper on it, and lightly flour the parchment.\nRemove plastic wrap and towel after the hour (dough should have risen to about double its size), and deflate dough with your fist. Flour your hands and divide dough into 2 even balls. Stretch balls into long baguette shapes, letting gravity help the dough stretch to shape. Both baguettes should be slightly thinner than you’d like them to be when they’re baked. Place baguettes on the upside down, lined baking sheet, as far apart as possible.\nLay kitchen towel over the baguettes and let rise in a 75-80℉, dark space for 30 more minutes. Dough will rise more!\nPreheat oven fully, to 450 degrees. Make a few long, shallow, diagonal slashes at about 45 degree angles on each baguette using a sharp knife.\nBake baguettes on the upside down, parchment lined baking sheet at 450℉ for 16-20 minutes, or until crust is golden and the baguettes are hollow sounding when tapped. Place on a wire rack to cool, or enjoy!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("tastefullygrace.com")
    expect(recipe.canonical_url).to eq("https://tastefullygrace.com/baguette-recipe/")
    expect(recipe.site_name).to eq("Tastefully Grace")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Grace Vallo")
    expect(recipe.description).to eq("Baguette and bread recipes in general are usually synonymous with “difficult to make.” This French baguette recipe is the easiest on the internet, while remaining fantastically delicious.")
    expect(recipe.image).to eq("https://tastefullygrace.com/wp-content/uploads/2023/07/Baguette-Recipe-scaled.jpg")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("French")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(140)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq(["any season"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(8)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "servingSize" => "1 baguette",
      "calories" => "721 kcal",
      "carbohydrateContent" => "142 g",
      "proteinContent" => "28 g",
      "fatContent" => "4 g",
      "saturatedFatContent" => "1 g",
      "sodiumContent" => "1471 mg",
      "fiberContent" => "8 g",
      "sugarContent" => "1 g",
      "unsaturatedFatContent" => "2 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "servingSize", unit: "baguette", amount: 1.0 },
      { name: "calories", unit: "kcal", amount: 721.0 },
      { name: "carbohydrateContent", unit: "g", amount: 142.0 },
      { name: "proteinContent", unit: "g", amount: 28.0 },
      { name: "fatContent", unit: "g", amount: 4.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "sodiumContent", unit: "mg", amount: 1471.0 },
      { name: "fiberContent", unit: "g", amount: 8.0 },
      { name: "sugarContent", unit: "g", amount: 1.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 2.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
