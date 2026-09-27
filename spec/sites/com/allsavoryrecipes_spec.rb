# frozen_string_literal: true

RSpec.describe "allsavoryrecipes.com" do
  subject(:recipe) { scrape_cassette("com/allsavoryrecipes", url: "https://allsavoryrecipes.com/crepe-style-savory-pancakes-with-cheese-and-sucuk/") }

  it "reads the title" do
    expect(recipe.title).to eq("Crepe-style Savory Pancakes with Cheese and Sucuk")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 large eggs 150 g",
      "2 cups milk 480 ml",
      "1 cup water 240 ml",
      "1/4 cup vegetable oil 60 ml",
      "1/2 teaspoon salt 3 g",
      "2 cups all-purpose flour 240 g",
      "1 tablespoon fresh parsley (chopped 5 g)",
      "1 cup grated kashar cheese (or similar semi-hard melting cheese 120 g)",
      "4 ounces sucuk (Turkish garlic sausage, diced 112 g)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: nil, name: "large eggs 150 g" },
      { amount: 2.0, unit: "cups", name: "milk 480 ml" },
      { amount: 1.0, unit: "cup", name: "water 240 ml" },
      { amount: 0.25, unit: "cup", name: "vegetable oil 60 ml" },
      { amount: 0.5, unit: "teaspoon", name: "salt 3 g" },
      { amount: 2.0, unit: "cups", name: "all-purpose flour 240 g" },
      { amount: 1.0, unit: "tablespoon", name: "fresh parsley" },
      { amount: 1.0, unit: "cup", name: "grated kashar cheese" },
      { amount: 4.0, unit: "ounces", name: "sucuk" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Prepare the Batter",
      "In a large bowl, combine eggs, milk, water, vegetable oil, salt, flour, and chopped parsley. Whisk until the batter is smooth and free of lumps.",
      "Cook the Crepes",
      "Heat a non-stick pan over medium heat. Ladle approximately 1/4 cup of batter into the hot pan, immediately tilting the pan to spread the batter thinly and evenly into a round crepe. Cook for 1-2 minutes until the edges are set and small bubbles appear on the surface. Flip and cook the other side until golden brown with light dark spots.",
      "Fill and Fold",
      "While the crepe is still in the pan, place a generous amount of grated kashar cheese and diced sucuk onto one half of the cooked crepe. Fold the crepe over the filling to create a half-moon shape, gently pressing down to seal.",
      "Finish and Serve",
      "Continue cooking the folded crepe for another 1-2 minutes, flipping occasionally, until the cheese is fully melted and the sucuk is heated through. Carefully transfer the finished crepe to a serving board. Repeat with the remaining batter and filling. Serve warm, pulling open to reveal the melted cheese and savory filling."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["For the Crepe Batter", 7],
        ["For the Filling", 2]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Prepare the Batter\nIn a large bowl, combine eggs, milk, water, vegetable oil, salt, flour, and chopped parsley. Whisk until the batter is smooth and free of lumps.\nCook the Crepes\nHeat a non-stick pan over medium heat. Ladle approximately 1/4 cup of batter into the hot pan, immediately tilting the pan to spread the batter thinly and evenly into a round crepe. Cook for 1-2 minutes until the edges are set and small bubbles appear on the surface. Flip and cook the other side until golden brown with light dark spots.\nFill and Fold\nWhile the crepe is still in the pan, place a generous amount of grated kashar cheese and diced sucuk onto one half of the cooked crepe. Fold the crepe over the filling to create a half-moon shape, gently pressing down to seal.\nFinish and Serve\nContinue cooking the folded crepe for another 1-2 minutes, flipping occasionally, until the cheese is fully melted and the sucuk is heated through. Carefully transfer the finished crepe to a serving board. Repeat with the remaining batter and filling. Serve warm, pulling open to reveal the melted cheese and savory filling.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("allsavoryrecipes.com")
    expect(recipe.canonical_url).to eq("https://allsavoryrecipes.com/crepe-style-savory-pancakes-with-cheese-and-sucuk/")
    expect(recipe.site_name).to eq("allsavoryrecipes.com")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Emma Harper")
    expect(recipe.description).to eq("These savory crepe-style pancakes are filled with melted cheese and spicy sucuk, offering a delightful and satisfying meal perfect for any time of day.")
    expect(recipe.image).to eq("https://allsavoryrecipes.com/wp-content/uploads/2026/09/crepe-style-savory-pancakes-with-cheese-and-sucuk-featured-1789568191369.webp")
    expect(recipe.category).to eq("Appetizer")
    expect(recipe.cuisine).to eq("Mediterranean")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "225 kcal",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 225.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
