# frozen_string_literal: true

RSpec.describe "theplantbasedschool.com" do
  subject(:recipe) { scrape_cassette("com/theplantbasedschool", url: "https://theplantbasedschool.com/easy-cauliflower-recipes/") }

  it "reads the title" do
    expect(recipe.title).to eq("15 Easy cauliflower recipes")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 large cauliflower (about 2½ pounds or 1.2 kg)",
      "1 tablespoons extra virgin olive oil",
      "½ teaspoon salt",
      "¼ teaspoon black pepper",
      "4 wedges lemon",
      "1 handful flat-leaf parsley",
      "1 pinch red pepper flakes"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "large cauliflower" },
      { amount: 1.0, unit: "tablespoons", name: "extra virgin olive oil" },
      { amount: 0.5, unit: "teaspoon", name: "salt" },
      { amount: 0.25, unit: "teaspoon", name: "black pepper" },
      { amount: 4.0, unit: nil, name: "wedges lemon" },
      { amount: 1.0, unit: "handful", name: "flat-leaf parsley" },
      { amount: 1.0, unit: "pinch", name: "red pepper flakes" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "cut off florets",
      "Preheat the oven to 400°F or 200°C. Line a baking sheet with parchment paper.Rinse the head of the cauliflower and pat it dry with a kitchen cloth. Discard the leaves and the stem, then separate the florets with a paring knife.",
      "season with olive oil",
      "Season with extra virgin olive oil, salt, and black pepper and toss with your hands; then arrange the florets on a single layer without overlapping.",
      "bake",
      "Bake at 400°F or 200°C for 20 minutes, then turn the florets around with a spatula and bake for another 10 minutes, or until browned outside and tender-crisp.",
      "serve",
      "Transfer onto a serving platter and optionally serve the baked cauliflower with a squeeze of lemon juice, a sprinkle of finely chopped flat-leaf parsley, and a pinch of red pepper flakes."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 4],
        ["FOR SERVING", 3]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("cut off florets\nPreheat the oven to 400°F or 200°C. Line a baking sheet with parchment paper.Rinse the head of the cauliflower and pat it dry with a kitchen cloth. Discard the leaves and the stem, then separate the florets with a paring knife.\nseason with olive oil\nSeason with extra virgin olive oil, salt, and black pepper and toss with your hands; then arrange the florets on a single layer without overlapping.\nbake\nBake at 400°F or 200°C for 20 minutes, then turn the florets around with a spatula and bake for another 10 minutes, or until browned outside and tender-crisp.\nserve\nTransfer onto a serving platter and optionally serve the baked cauliflower with a squeeze of lemon juice, a sprinkle of finely chopped flat-leaf parsley, and a pinch of red pepper flakes.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("theplantbasedschool.com")
    expect(recipe.canonical_url).to eq("https://theplantbasedschool.com/easy-cauliflower-recipes/")
    expect(recipe.site_name).to eq("The Plant Based School")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Nico Pallotta")
    expect(recipe.description).to eq("These quick and easy cauliflower recipes are great as side dishes, mains, and appetizers. One of the easiest way to cook cauliflower is roasted the cauliflower florets.It's delicious on its own, or you can use it to make other delicious cauliflower-based recipes, such as our scrumptious roasted cauliflower pasta and cauliflower salad.")
    expect(recipe.image).to eq("https://theplantbasedschool.com/wp-content/uploads/2022/12/easy-Cauliflower-recipes-.jpg")
    expect(recipe.category).to eq("Side dish")
    expect(recipe.cuisine).to eq("International")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["Cauliflower"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(3)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "107 kcal",
      "carbohydrateContent" => "15 g",
      "proteinContent" => "6 g",
      "fatContent" => "4 g",
      "saturatedFatContent" => "1 g",
      "fiberContent" => "6 g",
      "sugarContent" => "6 g",
      "unsaturatedFatContent" => "3.5 g",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 107.0 },
      { name: "carbohydrateContent", unit: "g", amount: 15.0 },
      { name: "proteinContent", unit: "g", amount: 6.0 },
      { name: "fatContent", unit: "g", amount: 4.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.0 },
      { name: "fiberContent", unit: "g", amount: 6.0 },
      { name: "sugarContent", unit: "g", amount: 6.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 3.5 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
