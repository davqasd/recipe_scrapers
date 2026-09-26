# frozen_string_literal: true

RSpec.describe "forksoverknives.com" do
  subject(:recipe) { scrape_cassette("com/forksoverknives", url: "https://www.forksoverknives.com/recipes/vegan-pasta-noodles/butternut-mac-and-cheese-broccoli/") }

  it "reads the title" do
    expect(recipe.title).to eq("Butternut Squash Mac and Cheese with Broccoli")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 medium butternut squash (1¾ lb.)",
      "1 tablespoon extra-virgin olive oil (optional, learn more)",
      "1 onion, finely chopped (1 cup)",
      "4 cloves garlic, minced",
      "½ teaspoon finely chopped fresh thyme",
      "1 cup unsweetened, unflavored plant milk",
      "2 tablespoons nutritional yeast",
      "1 tablespoon white wine vinegar",
      "½ teaspoon sea salt",
      "⅛ teaspoon freshly ground black pepper",
      "3 cups dried whole grain penne pasta (8 oz.)",
      "3 cups small broccoli florets",
      "Fresh basil leaves"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "medium butternut squash" },
      { amount: 1.0, unit: "tablespoon", name: "extra-virgin olive oil" },
      { amount: 1.0, unit: nil, name: "onion, finely chopped" },
      { amount: 4.0, unit: "cloves", name: "garlic, minced" },
      { amount: 0.5, unit: "teaspoon", name: "finely chopped fresh thyme" },
      { amount: 1.0, unit: "cup", name: "unsweetened, unflavored plant milk" },
      { amount: 2.0, unit: "tablespoons", name: "nutritional yeast" },
      { amount: 1.0, unit: "tablespoon", name: "white wine vinegar" },
      { amount: 0.5, unit: "teaspoon", name: "sea salt" },
      { amount: 0.13, unit: "teaspoon", name: "freshly ground black pepper" },
      { amount: 3.0, unit: "cups", name: "dried whole grain penne pasta" },
      { amount: 3.0, unit: "cups", name: "small broccoli florets" },
      { amount: nil, unit: nil, name: "Fresh basil leaves" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Peel squash; halve squash and remove seeds. Cut squash into large pieces. Place squash pieces in a steamer basket in a large pan. Add water to saucepan to just below basket. Bring to boiling. Steam, covered, about 12 minutes or until tender.",
      "For oil-free: Heat a medium saucepan over medium. Add onion, garlic, thyme, and ¼ cup water to pan. Cook about 6 minutes or until onion is tender, stirring occasionally and adding water, 1 to 2 tablespoons. at a time, as needed to prevent sticking. (If using oil: In a medium saucepan, heat olive oil, then add onion, garlic, and thyme. Cook about 6 minutes or until onion is tender, stirring occasionally.)",
      "Transfer onion mixture to a blender. Add squash and the next five ingredients (through pepper). Cover and blend until smooth. Pour squash mixture into a large saucepan.",
      "Cook pasta according to package directions, adding broccoli the last 5 minutes of cooking; drain. Add drained pasta and broccoli to squash mixture; toss to coat. Serve warm topped with fresh basil."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Peel squash; halve squash and remove seeds. Cut squash into large pieces. Place squash pieces in a steamer basket in a large pan. Add water to saucepan to just below basket. Bring to boiling. Steam, covered, about 12 minutes or until tender.\nFor oil-free: Heat a medium saucepan over medium. Add onion, garlic, thyme, and ¼ cup water to pan. Cook about 6 minutes or until onion is tender, stirring occasionally and adding water, 1 to 2 tablespoons. at a time, as needed to prevent sticking. (If using oil: In a medium saucepan, heat olive oil, then add onion, garlic, and thyme. Cook about 6 minutes or until onion is tender, stirring occasionally.)\nTransfer onion mixture to a blender. Add squash and the next five ingredients (through pepper). Cover and blend until smooth. Pour squash mixture into a large saucepan.\nCook pasta according to package directions, adding broccoli the last 5 minutes of cooking; drain. Add drained pasta and broccoli to squash mixture; toss to coat. Serve warm topped with fresh basil.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("forksoverknives.com")
    expect(recipe.canonical_url).to eq("https://www.forksoverknives.com/recipes/vegan-pasta-noodles/butternut-mac-and-cheese-broccoli/")
    expect(recipe.site_name).to eq("Forks Over Knives")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Courtney Davison")
    expect(recipe.description).to eq("Spiced butternut squash blended with nutritional yeast and plant milk makes a rich sauce for this vegan mac and cheese with broccoli. Get the recipe!")
    expect(recipe.image).to eq("https://www.forksoverknives.com/wp-content/uploads/butternut-broccoli-mac-and-cheese-wordpress.jpg")
    expect(recipe.category).to eq("Vegan Noodles & Pasta Recipes")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 items")
    expect(recipe.total_time).to eq(60)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "490 calories",
      "carbohydrateContent" => "104 grams",
      "fatContent" => "5 grams",
      "fiberContent" => "10 grams",
      "proteinContent" => "22 grams",
      "servingSize" => "2 cups",
      "sodiumContent" => "651 grams",
      "sugarContent" => "12 grams"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 490.0 },
      { name: "carbohydrateContent", unit: "g", amount: 104.0 },
      { name: "fatContent", unit: "g", amount: 5.0 },
      { name: "fiberContent", unit: "g", amount: 10.0 },
      { name: "proteinContent", unit: "g", amount: 22.0 },
      { name: "servingSize", unit: "cups", amount: 2.0 },
      { name: "sodiumContent", unit: "g", amount: 651.0 },
      { name: "sugarContent", unit: "g", amount: 12.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
