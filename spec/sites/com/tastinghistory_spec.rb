# frozen_string_literal: true

RSpec.describe "tastinghistory.com" do
  subject(:recipe) { scrape_cassette("com/tastinghistory", url: "https://www.tastinghistory.com/recipes/electioncake") }

  it "reads the title" do
    expect(recipe.title).to eq("Election Cake")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 tablespoons (18 g) active dry yeast",
      "1/2 cup (120 ml) flat beer",
      "4 cups (500 g) flour",
      "1 1/2 cups (350 ml) milk",
      "1 heaping cup (180 g) raisins",
      "1 1/2 sticks (170 g) butter, softened",
      "1 1/8 cup (225 g) sugar",
      "2 eggs, at room temperature",
      "1/4 cup (60 ml) brandy",
      "2 tablespoons (30 ml) sweet wine",
      "1 tablespoon ground cinnamon",
      "1 tablespoon ground coriander",
      "2 teaspoons ground allspice"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "tablespoons", name: "active dry yeast" },
      { amount: 0.5, unit: "cup", name: "flat beer" },
      { amount: 4.0, unit: "cups", name: "flour" },
      { amount: 1.5, unit: "cups", name: "milk" },
      { amount: 1.0, unit: "cup", name: "raisins" },
      { amount: 1.5, unit: "sticks", name: "butter, softened" },
      { amount: 1.13, unit: "cup", name: "sugar" },
      { amount: 2.0, unit: nil, name: "eggs, at room temperature" },
      { amount: 0.25, unit: "cup", name: "brandy" },
      { amount: 2.0, unit: "tablespoons", name: "sweet wine" },
      { amount: 1.0, unit: "tablespoon", name: "ground cinnamon" },
      { amount: 1.0, unit: "tablespoon", name: "ground coriander" },
      { amount: 2.0, unit: "teaspoons", name: "ground allspice" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Stir the yeast into the beer and let it sit for about 10 minutes until it’s nice and foamy.",
      "In a large bowl, mix together the flour and milk until you get a very dry dough.",
      "Add the yeast mixture to the flour mixture and mix it until it forms a rough dough. If the dough becomes too wet, add a couple of tablespoons of flour, just enough so that it forms a dough.",
      "Cover and let it rise for 2 hours at room temperature, or overnight in the fridge.",
      "If you refrigerated your dough, take it out and let it come back to room temperature.",
      "While the dough warms back up, put the raisins in a small bowl and cover them with cool water and let them soak for 20 minutes to plump up.",
      "In a large bowl, beat the butter slightly, then add the sugar and beat until it’s nice and fluffy.",
      "Add the eggs and beat until they’re just incorporated, then mix in the brandy and wine. Add all of the spices and stir until evenly mixed.",
      "Mix the butter batter into the risen bread dough. This will take a while, but if you keep at it, they eventually will mostly come together, and that's good enough. I used my hands, but a stand mixer would probably work fine. Cover and let it rise for another 30 to 40 minutes.",
      "Preheat the oven to 375°F (190°C).",
      "While the batter rises, butter the bottom and sides of a 10 inch (25 cm) round cake pan, place some parchment on the bottom, then butter the parchment. You could also use two smaller pans or several loaf pans.",
      "Drain the raisins and toss them in a bit of flour so that they won’t sink to the bottom of the cake.",
      "Mix the raisins into the batter after it has risen until they’re evenly distributed, then pour the batter into the prepared pan(s). You want them to be about 2/3 full. Smooth out the top so that it’s level, then bake for about 45 minutes or until a toothpick or skewer inserted into the center of the cake comes out clean.",
      "Let the cake cool to room temperature, then slice and serve it forth, election not required."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Stir the yeast into the beer and let it sit for about 10 minutes until it’s nice and foamy.\nIn a large bowl, mix together the flour and milk until you get a very dry dough.\nAdd the yeast mixture to the flour mixture and mix it until it forms a rough dough. If the dough becomes too wet, add a couple of tablespoons of flour, just enough so that it forms a dough.\nCover and let it rise for 2 hours at room temperature, or overnight in the fridge.\nIf you refrigerated your dough, take it out and let it come back to room temperature.\nWhile the dough warms back up, put the raisins in a small bowl and cover them with cool water and let them soak for 20 minutes to plump up.\nIn a large bowl, beat the butter slightly, then add the sugar and beat until it’s nice and fluffy.\nAdd the eggs and beat until they’re just incorporated, then mix in the brandy and wine. Add all of the spices and stir until evenly mixed.\nMix the butter batter into the risen bread dough. This will take a while, but if you keep at it, they eventually will mostly come together, and that's good enough. I used my hands, but a stand mixer would probably work fine. Cover and let it rise for another 30 to 40 minutes.\nPreheat the oven to 375°F (190°C).\nWhile the batter rises, butter the bottom and sides of a 10 inch (25 cm) round cake pan, place some parchment on the bottom, then butter the parchment. You could also use two smaller pans or several loaf pans.\nDrain the raisins and toss them in a bit of flour so that they won’t sink to the bottom of the cake.\nMix the raisins into the batter after it has risen until they’re evenly distributed, then pour the batter into the prepared pan(s). You want them to be about 2/3 full. Smooth out the top so that it’s level, then bake for about 45 minutes or until a toothpick or skewer inserted into the center of the cake comes out clean.\nLet the cake cool to room temperature, then slice and serve it forth, election not required.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("tastinghistory.com")
    expect(recipe.canonical_url).to eq("https://www.tastinghistory.com/recipes/electioncake")
    expect(recipe.site_name).to eq("Tasting History")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Surprisingly delicious yeasted cake with spices and raisins")
    expect(recipe.image).to eq("http://static1.squarespace.com/static/63cdc8f90de33a009e0349bf/63cde38cbd14d66a8de2e196/6716e3dcca46d107683444a6/1730679922663/Election+Cake.JPG?format=1500w")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
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
    expect(recipe.links).to include("#page")
  end
end
