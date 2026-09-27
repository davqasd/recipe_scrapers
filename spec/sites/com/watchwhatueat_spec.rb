# frozen_string_literal: true

RSpec.describe "watchwhatueat.com" do
  subject(:recipe) { scrape_cassette("com/watchwhatueat", url: "https://www.watchwhatueat.com/perfect-lemonade-recipe/") }

  it "reads the title" do
    expect(recipe.title).to eq("Peach Flavored Perfect Lemonade Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 fresh peaches seeded",
      "3/4 cup lemon juice",
      "1/2 cup agave (or more according to your taste)",
      "5 cup drinking water",
      "2 tbsp loosely packed mint leaves (optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: nil, name: "fresh peaches seeded" },
      { amount: 0.75, unit: "cup", name: "lemon juice" },
      { amount: 0.5, unit: "cup", name: "agave" },
      { amount: 5.0, unit: "cup", name: "drinking water" },
      { amount: 2.0, unit: "tbsp", name: "loosely packed mint leaves" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a blender make a puree of two peaches with 1 cup of water. Using a strainer, strain the peach juice to remove coarse particles.",
      "In a pitcher, add strained peach juice, lemon juice and agave. Mix it well to combine all ingredients. Adjust sweetener according to your taste.",
      "Add water, few slices of peach and mint leaves. Chill the lemonade in the refrigerator before serving",
      "Serve over ice to enjoy this perfect peach lemonade"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a blender make a puree of two peaches with 1 cup of water. Using a strainer, strain the peach juice to remove coarse particles.\nIn a pitcher, add strained peach juice, lemon juice and agave. Mix it well to combine all ingredients. Adjust sweetener according to your taste.\nAdd water, few slices of peach and mint leaves. Chill the lemonade in the refrigerator before serving\nServe over ice to enjoy this perfect peach lemonade")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("watchwhatueat.com")
    expect(recipe.canonical_url).to eq("https://www.watchwhatueat.com/perfect-lemonade-recipe/")
    expect(recipe.site_name).to eq("Watch What U Eat")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Watch What U Eat")
    expect(recipe.description).to eq("Try this peach flavored perfect lemonade recipe to enjoy fresh peaches. Healthy & naturally sweetened refreshing summer drink.")
    expect(recipe.image).to eq("https://www.watchwhatueat.com/wp-content/uploads/2016/03/Peach-lemonade-featured-1.jpg")
    expect(recipe.category).to eq("Drinks")
    expect(recipe.cuisine).to eq("American Inspired")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["peach lemonade", "perfect lemonade"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.86)
    expect(recipe.ratings_count).to eq(7)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "79 kcal",
      "servingSize" => "1 serving"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 79.0 },
      { name: "servingSize", unit: "serving", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#genesis-content")
  end
end
