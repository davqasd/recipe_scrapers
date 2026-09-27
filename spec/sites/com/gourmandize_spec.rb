# frozen_string_literal: true

RSpec.describe "gourmandize.com" do
  subject(:recipe) { scrape_cassette("com/gourmandize", url: "https://www.gourmandize.com/recipe-57163-cherry-cheese-cake.html") }

  it "reads the title" do
    expect(recipe.title).to eq("Cherry Cheese Cake Recipe - (4.1/5)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 ¼ cup crushed graham crumbs",
      "¼ cup butter",
      "¼ cup brown sugar",
      "4 oz. Pkg. Philadelphia Cream Cheese",
      "2/3 cup icing sugar",
      "1 pkg. Dream Whip",
      "1 can cherry fruit filling",
      "Fresh cherries"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.25, unit: "cup", name: "crushed graham crumbs" },
      { amount: 0.25, unit: "cup", name: "butter" },
      { amount: 0.25, unit: "cup", name: "brown sugar" },
      { amount: 4.0, unit: "oz", name: "Pkg. Philadelphia Cream Cheese" },
      { amount: 0.67, unit: "cup", name: "icing sugar" },
      { amount: 1.0, unit: "pkg", name: "Dream Whip" },
      { amount: 1.0, unit: "can", name: "cherry fruit filling" },
      { amount: nil, unit: nil, name: "Fresh cherries" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Prepare graham wafer crust made with crushed graham wafers, butter & brown sugar.",
      "Mix together and bake about 20 minutes @ 250 deg. Let cool.",
      "Prepare Dream Whip as per package directions. Set in fridge.",
      "Cream cheese, add icing sugar gradually.",
      "Once mixed thoroughly, add Dream Whip, and mix well.",
      "Once crust is cooled, add canned cherries on top of it.",
      "Put cream cheese mixture on top of fruit filling. Top with fresh cherries."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Prepare graham wafer crust made with crushed graham wafers, butter & brown sugar.\nMix together and bake about 20 minutes @ 250 deg. Let cool.\nPrepare Dream Whip as per package directions. Set in fridge.\nCream cheese, add icing sugar gradually.\nOnce mixed thoroughly, add Dream Whip, and mix well.\nOnce crust is cooled, add canned cherries on top of it.\nPut cream cheese mixture on top of fruit filling. Top with fresh cherries.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("gourmandize.com")
    expect(recipe.canonical_url).to eq("https://www.gourmandize.com/recipe-57163-cherry-cheese-cake.html")
    expect(recipe.site_name).to eq("Gourmandize")
    expect(recipe.language).to be_nil
    expect(recipe.author).to eq("BrendaFlood")
    expect(recipe.description).to eq("Cherry Cheese Cake. Discover our recipe rated 4.1/5 by 17 members.")
    expect(recipe.image).to eq("https://www.gourmandize.com/uploads/media/my-cheesecake-2.jpg?1394648283")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["cherry cheesecake", "cherry cake", "cherry", "dessert", "ice cream desserts with fruit", "baking", "cheese cake", "cheesecake", "brown sugar cake", "condensed milk cake"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.1)
    expect(recipe.ratings_count).to eq(17)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#comments")
  end
end
