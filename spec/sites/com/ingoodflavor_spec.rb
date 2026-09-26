# frozen_string_literal: true

RSpec.describe "ingoodflavor.com" do
  subject(:recipe) { scrape_cassette("com/ingoodflavor", url: "https://ingoodflavor.com/2017/10/25/cheesy-linguica-and-potato-bake/") }

  it "reads the title" do
    expect(recipe.title).to eq("Cheesy Linguica and Potato Bake")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 tbsp. extra virgin olive oil",
      "2 cups chopped onions",
      "2 cloves garlic, minced",
      "2 (about 14 -16 oz each) packages ground Portuguese linguica",
      "4 (15 oz.) cans sliced potatoes, drained well and coarsely chopped",
      "3/4 tsp. Lawry's Seasoned Salt",
      "1/2 tsp. black pepper",
      "10 oz. (about 5 cups) shredded sharp cheddar cheese"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "tbsp", name: "extra virgin olive oil" },
      { amount: 2.0, unit: "cups", name: "chopped onions" },
      { amount: 2.0, unit: "cloves", name: "garlic, minced" },
      { amount: 2.0, unit: "packages", name: "ground Portuguese linguica" },
      { amount: 4.0, unit: "cans", name: "sliced potatoes, drained well and coarsely chopped" },
      { amount: 0.75, unit: "tsp", name: "Lawry's Seasoned Salt" },
      { amount: 0.5, unit: "tsp", name: "black pepper" },
      { amount: 10.0, unit: "oz", name: "shredded sharp cheddar cheese" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat oven to 375 degrees F.",
      "Add olive oil to a preheated large skillet on medium heat. Add onion and garlic. Cook for 4 minutes, stirring frequently. Add ground linguica, breaking up chunks with a wooden spatula. Cook, stirring frequently, for 3 minutes. Add sliced potatoes, seasoned salt, and black pepper. Cook, stirring frequently, for 3 minutes.",
      "Spray a 9\" x 13\" baking dish with cooking spray. Spread 1/3 of the potato mixture on the bottom. Add 1/3 of the cheese. Repeat layering 1/3 of potatoes and 1/3 of cheese two more times, ending with the cheese.",
      "Bake on the top half of the oven for 15-20 minutes or until the cheese is bubbly."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat oven to 375 degrees F.\nAdd olive oil to a preheated large skillet on medium heat. Add onion and garlic. Cook for 4 minutes, stirring frequently. Add ground linguica, breaking up chunks with a wooden spatula. Cook, stirring frequently, for 3 minutes. Add sliced potatoes, seasoned salt, and black pepper. Cook, stirring frequently, for 3 minutes.\nSpray a 9\" x 13\" baking dish with cooking spray. Spread 1/3 of the potato mixture on the bottom. Add 1/3 of the cheese. Repeat layering 1/3 of potatoes and 1/3 of cheese two more times, ending with the cheese.\nBake on the top half of the oven for 15-20 minutes or until the cheese is bubbly.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("ingoodflavor.com")
    expect(recipe.canonical_url).to eq("https://ingoodflavor.com/cheesy-linguica-and-potato-bake/")
    expect(recipe.site_name).to eq("In Good Flavor")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("In Good Flavor")
    expect(recipe.description).to eq("This Cheesy Linguica and Potato Bake has ground Portuguese linguica, tender potatoes, and gooey shredded cheese. It’s hearty, comforting, and perfect for breakfast, brunch, or any time of day.")
    expect(recipe.image).to eq("https://ingoodflavor.com/wp-content/uploads/2023/09/LinguicaPotatoBake-IMG_4226-Feat-scaled.jpg")
    expect(recipe.category).to eq("Breakfast")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to eq("Stovetop Cooked")
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq([
      "Cheesy linguica and potato bake",
      "Hearty weekend brunch ideas",
      "cheesy linguica and potato",
      "cheesy sausage potato bake",
      "linguica and potato bake",
      "sausage breakfast casserole"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "calories" => "300 cal" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 300.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
