# frozen_string_literal: true

RSpec.describe "zenbelly.com" do
  subject(:recipe) { scrape_cassette("com/zenbelly", url: "https://www.zenbelly.com/gingerbread/") }

  it "reads the title" do
    expect(recipe.title).to eq("Paleo Gingerbread")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "butter (ghee, or shortening for greasing the pan)",
      "3 cups almond flour",
      "1 1/2 cups tapioca starch (plus more for flouring pan)",
      "1/2 cup coconut flour",
      "1 1/2 teaspoons baking soda",
      "2 teaspoons ground ginger",
      "1 teaspoons ground cinnamon",
      "1/4 teaspoon ground allspice",
      "1/4 teaspoon ground cardamom",
      "1/2 teaspoon finely ground sea salt",
      "1 cup coconut sugar",
      "1 cup molasses (use true molasses if you can find it)",
      "2 teaspoons fresh ginger",
      "1 cup boiling water",
      "4 eggs"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "butter" },
      { amount: 3.0, unit: "cups", name: "almond flour" },
      { amount: 1.5, unit: "cups", name: "tapioca starch" },
      { amount: 0.5, unit: "cup", name: "coconut flour" },
      { amount: 1.5, unit: "teaspoons", name: "baking soda" },
      { amount: 2.0, unit: "teaspoons", name: "ground ginger" },
      { amount: 1.0, unit: "teaspoons", name: "ground cinnamon" },
      { amount: 0.25, unit: "teaspoon", name: "ground allspice" },
      { amount: 0.25, unit: "teaspoon", name: "ground cardamom" },
      { amount: 0.5, unit: "teaspoon", name: "finely ground sea salt" },
      { amount: 1.0, unit: "cup", name: "coconut sugar" },
      { amount: 1.0, unit: "cup", name: "molasses" },
      { amount: 2.0, unit: "teaspoons", name: "fresh ginger" },
      { amount: 1.0, unit: "cup", name: "boiling water" },
      { amount: 4.0, unit: nil, name: "eggs" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preheat the oven to 350ºF. Grease a 9×13-inch cake pan.",
      "In a large bowl, whisk together the almond flour, tapioca starch, coconut flour, baking soda, ground ginger, cinnamon, allspice, cardamom, and salt.",
      "In a medium heat proof bowl, whisk together the coconut sugar, molasses, fresh ginger, and boiling water. Once it’s lukewarm (the molasses and coconut sugar should take the temperature down enough), whisk in the eggs.",
      "Pour the wet ingredients into the dry ingredients and whisk until there are no lumps.",
      "Pour into the prepared pan and bake for 28-35 minutes*"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preheat the oven to 350ºF. Grease a 9×13-inch cake pan.\nIn a large bowl, whisk together the almond flour, tapioca starch, coconut flour, baking soda, ground ginger, cinnamon, allspice, cardamom, and salt.\nIn a medium heat proof bowl, whisk together the coconut sugar, molasses, fresh ginger, and boiling water. Once it’s lukewarm (the molasses and coconut sugar should take the temperature down enough), whisk in the eggs.\nPour the wet ingredients into the dry ingredients and whisk until there are no lumps.\nPour into the prepared pan and bake for 28-35 minutes*")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("zenbelly.com")
    expect(recipe.canonical_url).to eq("https://www.zenbelly.com/gingerbread/")
    expect(recipe.site_name).to eq("zenbelly")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Simone Miller")
    expect(recipe.description).to eq("'Tis the season for Gingerbread. To be honest, I can't remember the last time I had it before I made it for this here bloggy blog. Paleo Gingerbread When I went to start making")
    expect(recipe.image).to eq("https://www.zenbelly.com/wp-content/uploads/2019/01/gingerbread-3-225x225.jpeg")
    expect(recipe.category).to eq("Dessert")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("20 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(30)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(5)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.zenbelly.com/")
  end
end
