# frozen_string_literal: true

RSpec.describe "biggerbolderbaking.com" do
  subject(:recipe) { scrape_cassette("com/biggerbolderbaking", url: "https://www.biggerbolderbaking.com/make-pie-crust/") }

  it "reads the title" do
    expect(recipe.title).to eq("Best Pie Crust Recipe")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1⅓ cups (6 ½ oz/185 g) all-purpose flour",
      "1 tablespoon powdered sugar",
      "⅛ teaspoon salt",
      "7 tablespoons (3 ½ oz/100 g) butter (, cold and cubed)",
      "1 large egg yolk",
      "2 - 3 tablespoons water (, cold)",
      "2 ⅔ cups (13 oz/370 g) all-purpose flour",
      "2 tablespoons powdered sugar",
      "¼ teaspoon salt",
      "14 tablespoons (7 oz/200 g) butter, cold and cubed",
      "2 large egg yolks",
      "4-6 tablespoons water, cold"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.33, unit: "cups", name: "all-purpose flour" },
      { amount: 1.0, unit: "tablespoon", name: "powdered sugar" },
      { amount: 0.13, unit: "teaspoon", name: "salt" },
      { amount: 7.0, unit: "tablespoons", name: "butter" },
      { amount: 1.0, unit: nil, name: "large egg yolk" },
      { amount: 2.0, unit: "tablespoons", name: "water" },
      { amount: 2.67, unit: "cups", name: "all-purpose flour" },
      { amount: 2.0, unit: "tablespoons", name: "powdered sugar" },
      { amount: 0.25, unit: "teaspoon", name: "salt" },
      { amount: 14.0, unit: "tablespoons", name: "butter, cold and cubed" },
      { amount: 2.0, unit: nil, name: "large egg yolks" },
      { amount: 4.0, unit: "tablespoons", name: "water, cold" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a large bowl add the flour, powdered sugar and salt and mix together.",
      "Add the butter and rub in with your fingers or a pastry blender until it resembles coarse breadcrumbs. (You can also do this in the food processor).",
      "In a small bowl, mix together the egg yolk and the smaller tablespoon amount of water and add to the dry ingredients.",
      "Mix gently until your dough comes together. Then, using your hands, pull the dough together to incorporate any dry pieces. If your dough seems too dry, you can add some of your remaining water. (Be careful not to hastily add more liquid as this will not yield the best results).",
      "Wrap the pastry in cling wrap and refrigerate for a minimum of 30 minutes to allow the gluten to relax before rolling. (The dough will get a little wetter once it relaxes).",
      "Bake according to your recipe directions. Or store for up to 2 days in the fridge. You can also freeze the dough for up to 8 weeks and defrost overnight in the fridge before using."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Single Pie Crust Recipe", 6],
        ["Double Pie Crust Recipe", 6]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a large bowl add the flour, powdered sugar and salt and mix together.\nAdd the butter and rub in with your fingers or a pastry blender until it resembles coarse breadcrumbs. (You can also do this in the food processor).\nIn a small bowl, mix together the egg yolk and the smaller tablespoon amount of water and add to the dry ingredients.\nMix gently until your dough comes together. Then, using your hands, pull the dough together to incorporate any dry pieces. If your dough seems too dry, you can add some of your remaining water. (Be careful not to hastily add more liquid as this will not yield the best results).\nWrap the pastry in cling wrap and refrigerate for a minimum of 30 minutes to allow the gluten to relax before rolling. (The dough will get a little wetter once it relaxes).\nBake according to your recipe directions. Or store for up to 2 days in the fridge. You can also freeze the dough for up to 8 weeks and defrost overnight in the fridge before using.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("biggerbolderbaking.com")
    expect(recipe.canonical_url).to eq("https://www.biggerbolderbaking.com/make-pie-crust/")
    expect(recipe.site_name).to eq("Gemma’s Bigger Bolder Baking")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Gemma Stafford")
    expect(recipe.description).to eq("My Best Homemade Pie Crust is a foolproof, bakery-quality crust for sweet or savory fillings, and it’s perfect to make ahead.")
    expect(recipe.image).to eq("https://www.biggerbolderbaking.com/wp-content/uploads/2020/08/2-Homemade-Pie-Crust-Thumbnail-scaled.jpg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to eq("American")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("1 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to eq(["how to make pie crust"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.58)
    expect(recipe.ratings_count).to eq(316)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.biggerbolderbaking.com/")
  end
end
