# frozen_string_literal: true

RSpec.describe "justalittlebitofbacon.com" do
  subject(:recipe) { scrape_cassette("com/justalittlebitofbacon", url: "https://www.justalittlebitofbacon.com/my-perfect-pina-colada-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("My Perfect Pina Colada Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 8 oz cans pineapple chunks in juice",
      "3 oz cream of coconut, (preferably Coco Lopez)",
      "3 oz coconut cream, (unsweetened)",
      "6 oz rum",
      "ice to fill the glasses",
      "pineapple slices and maraschino cherries for garnish, (optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cans", name: "pineapple chunks in juice" },
      { amount: 3.0, unit: "oz", name: "cream of coconut" },
      { amount: 3.0, unit: "oz", name: "coconut cream" },
      { amount: 6.0, unit: "oz", name: "rum" },
      { amount: nil, unit: nil, name: "ice to fill the glasses" },
      { amount: nil, unit: nil, name: "pineapple slices and maraschino cherries for garnish" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Puree the pineapple chunks until smooth. Pour the pureed pineapple through a fine, mesh strainer to remove the pulp. You will have about 12 oz of juice left.",
      "Add the strained juice, cream of coconut, coconut cream, and rum to the blender and puree until smooth.",
      "Divide ice among 4 glasses and then pour in the pina colada. Garnish with pineapple slices, maraschino cherries, and little umbrellas if you wish."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Puree the pineapple chunks until smooth. Pour the pureed pineapple through a fine, mesh strainer to remove the pulp. You will have about 12 oz of juice left.\nAdd the strained juice, cream of coconut, coconut cream, and rum to the blender and puree until smooth.\nDivide ice among 4 glasses and then pour in the pina colada. Garnish with pineapple slices, maraschino cherries, and little umbrellas if you wish.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("justalittlebitofbacon.com")
    expect(recipe.canonical_url).to eq("https://www.justalittlebitofbacon.com/my-perfect-pina-colada-recipe/")
    expect(recipe.site_name).to eq("Just a Little Bit of Bacon")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Just a Little Bit of Bacon")
    expect(recipe.description).to eq("My pina colada has plenty of pineapple flavor, lots of smooth coconut, and not too much sugar. Perfect for sipping on a warm day! Serve it over ice and think about summer.")
    expect(recipe.image).to eq("https://www.justalittlebitofbacon.com/wp-content/uploads/2016/04/pina-colada-4.jpg")
    expect(recipe.category).to eq("Drinks")
    expect(recipe.cuisine).to eq("Caribbean")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(5)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "350 kcal",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 350.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#comment-2526")
  end
end
