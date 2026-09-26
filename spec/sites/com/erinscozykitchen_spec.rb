# frozen_string_literal: true

RSpec.describe "erinscozykitchen.com" do
  subject(:recipe) { scrape_cassette("com/erinscozykitchen", url: "https://erinscozykitchen.com/recipe/strawberry-sago/") }

  it "reads the title" do
    expect(recipe.title).to eq("Strawberry Sago")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cups strawberries (chopped)",
      "1/2 cup lychee jelly (or whatever flavor and quantity you prefer)",
      "1/2 cup strawbeery jelly (or whatever flavor and quantity you prefer)",
      "1/2 cup strawberry bursting boba (or whatever flavor and quantity you prefer)",
      "1/2 cup small tapioca pearls (sago)",
      "1 1/2 cup milk",
      "1/3 cup sugar",
      "ice",
      "sweetened condensed milk"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cups", name: "strawberries" },
      { amount: 0.5, unit: "cup", name: "lychee jelly" },
      { amount: 0.5, unit: "cup", name: "strawbeery jelly" },
      { amount: 0.5, unit: "cup", name: "strawberry bursting boba" },
      { amount: 0.5, unit: "cup", name: "small tapioca pearls" },
      { amount: 1.5, unit: "cup", name: "milk" },
      { amount: 0.33, unit: "cup", name: "sugar" },
      { amount: nil, unit: nil, name: "ice" },
      { amount: nil, unit: nil, name: "sweetened condensed milk" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Cook the Sago",
      "Bring a pot of water to a boil. Add the tapioca pearls and reduce heat to medium-low.",
      "Cook for about 15 minutes, stirring occasionally to prevent sticking.",
      "Remove from heat, cover with a lid, and let sit for 10-15 minutes until the sago becomes fully translucent.",
      "Strain the cooked pearls using a fine mesh strainer and rinse with cold water until the water runs clear and the pearls no longer stick together.",
      "Make Strawberry Puree",
      "In a blender, dump 1 cup of your chopped strawberries and 1/3 cup of sguar and blend until smooth.",
      "Assemble the Strawberry Sago",
      "In a large bowl, add the chopped strawberries, lychee jelly, strawberry jelly, strawberry bursting boba, and cooked sago pearls.",
      "Pour in the strawberry puree and milk.",
      "Sweeten with condensed milk according to your preference.",
      "Add ice if desired for a refreshing touch.",
      "Stir everything together until well mixed.",
      "Serve and Enjoy!",
      "Pour the mixture into serving glasses or bowls and enjoy your strawberry sago!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Cook the Sago\nBring a pot of water to a boil. Add the tapioca pearls and reduce heat to medium-low.\nCook for about 15 minutes, stirring occasionally to prevent sticking.\nRemove from heat, cover with a lid, and let sit for 10-15 minutes until the sago becomes fully translucent.\nStrain the cooked pearls using a fine mesh strainer and rinse with cold water until the water runs clear and the pearls no longer stick together.\nMake Strawberry Puree\nIn a blender, dump 1 cup of your chopped strawberries and 1/3 cup of sguar and blend until smooth.\nAssemble the Strawberry Sago\nIn a large bowl, add the chopped strawberries, lychee jelly, strawberry jelly, strawberry bursting boba, and cooked sago pearls.\nPour in the strawberry puree and milk.\nSweeten with condensed milk according to your preference.\nAdd ice if desired for a refreshing touch.\nStir everything together until well mixed.\nServe and Enjoy!\nPour the mixture into serving glasses or bowls and enjoy your strawberry sago!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("erinscozykitchen.com")
    expect(recipe.canonical_url).to eq("https://erinscozykitchen.com/recipe/strawberry-sago/")
    expect(recipe.site_name).to eq("Erin's Cozy Kitchen")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("erin")
    expect(recipe.description).to eq("This strawberry sago is a refreshing dessert drink packed with layers of flavor and texture. The creamy milk pairs perfectly with fresh strawberries, jellies, and chewy tapioca pearls (sago) which add fun, fruity bursts in every bite. Sweetened with condensed milk and customizable with your favorite jellies or milk options, this recipe is the perfect indulgence for hot days or an afternoon treat. Make it your own with plant-based milks or flavored syrups for a delicious twist!")
    expect(recipe.image).to eq("https://erinscozykitchen.com/wp-content/uploads/2025/03/IMG_8714-1.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq([
      "Asian sago dessert",
      "chilled strawberry sago",
      "creamy strawberry sago",
      "easy strawberry dessert",
      "homemade sago pudding",
      "no-bake strawberry dessert",
      "refreshing strawberry dessert",
      "sago pearls with strawberry",
      "strawberry and sago",
      "strawberry boba dessert",
      "strawberry dessert idea",
      "strawberry dessert with sago",
      "strawberry milk sago",
      "strawberry sago",
      "strawberry sago dessert",
      "strawberry sago recipe",
      "strawberry tapioca pudding",
      "summer sago recipe",
      "sweet strawberry sago",
      "tapioca pearl dessert"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main")
  end
end
