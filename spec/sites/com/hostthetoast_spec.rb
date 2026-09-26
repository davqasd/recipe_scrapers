# frozen_string_literal: true

RSpec.describe "hostthetoast.com" do
  subject(:recipe) { scrape_cassette("com/hostthetoast", url: "https://hostthetoast.com/homemade-garlic-naan/") }

  it "reads the title" do
    expect(recipe.title).to eq("Homemade Garlic Naan")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1/4 cup warm water",
      "1 tablespoon sugar",
      "1 package (2 1/4 teaspoons) active dry yeast",
      "3/4 cup warm milk",
      "3/4 cup plain yogurt",
      "4 cups all-purpose flour",
      "1 teaspoon Kosher salt",
      "1 stick melted butter, for brushing",
      "4 cloves minced garlic",
      "Fresh cilantro, to top"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.25, unit: "cup", name: "warm water" },
      { amount: 1.0, unit: "tablespoon", name: "sugar" },
      { amount: 1.0, unit: "package", name: "active dry yeast" },
      { amount: 0.75, unit: "cup", name: "warm milk" },
      { amount: 0.75, unit: "cup", name: "plain yogurt" },
      { amount: 4.0, unit: "cups", name: "all-purpose flour" },
      { amount: 1.0, unit: "teaspoon", name: "Kosher salt" },
      { amount: 1.0, unit: "stick", name: "melted butter, for brushing" },
      { amount: 4.0, unit: "cloves", name: "minced garlic" },
      { amount: nil, unit: nil, name: "Fresh cilantro, to top" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "In a glass measuring cup, combine the yeast, sugar, and water and let sit until very foamy, about 10 minutes. Meanwhile, whisk the flour and salt together in a large bowl and create a well in the center.",
      "Whisk in the warm milk and plain yogurt into the yeast mixture until well-combined. Pour into the well in the dry ingredients. Stir until a dough is formed, then turn out onto a lightly-floured surface and knead until smooth, about 3-4 minutes. Transfer the dough to a large, lightly oiled bowl and cover loosely with a damp kitchen towel. Let rise at room temperature until doubled in size, about 1 hour.",
      "Turn the dough out onto a floured surface. Knead briefly into a disc and cut the dough into 12 equal-sized pieces. Roll each piece into a ball.",
      "Heat a large, heavy bottomed skillet over medium heat. Roll each dough ball out until it is about 1/4 inch thick and approximately 6 inches wide. Brush the dough lightly with butter and place one at a time onto the hot skillet. Cook until large bubbles form on the surface, about 2 minutes. Flip the dough and cook the other side until golden, about 1-2 more minutes. Stack the cooked flat bread on a plate and cover with a towel to keep warm as you cook the remaining pieces.",
      "Add the minced garlic to the remaining melted butter. Loosely cover and microwave for 15 seconds. Brush the warm naan with the garlic butter (scooping out some of the garlic to sit on top) and sprinkle generously with cilantro. Serve warm."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("In a glass measuring cup, combine the yeast, sugar, and water and let sit until very foamy, about 10 minutes. Meanwhile, whisk the flour and salt together in a large bowl and create a well in the center.\nWhisk in the warm milk and plain yogurt into the yeast mixture until well-combined. Pour into the well in the dry ingredients. Stir until a dough is formed, then turn out onto a lightly-floured surface and knead until smooth, about 3-4 minutes. Transfer the dough to a large, lightly oiled bowl and cover loosely with a damp kitchen towel. Let rise at room temperature until doubled in size, about 1 hour.\nTurn the dough out onto a floured surface. Knead briefly into a disc and cut the dough into 12 equal-sized pieces. Roll each piece into a ball.\nHeat a large, heavy bottomed skillet over medium heat. Roll each dough ball out until it is about 1/4 inch thick and approximately 6 inches wide. Brush the dough lightly with butter and place one at a time onto the hot skillet. Cook until large bubbles form on the surface, about 2 minutes. Flip the dough and cook the other side until golden, about 1-2 more minutes. Stack the cooked flat bread on a plate and cover with a towel to keep warm as you cook the remaining pieces.\nAdd the minced garlic to the remaining melted butter. Loosely cover and microwave for 15 seconds. Brush the warm naan with the garlic butter (scooping out some of the garlic to sit on top) and sprinkle generously with cilantro. Serve warm.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hostthetoast.com")
    expect(recipe.canonical_url).to eq("https://hostthetoast.com/homemade-garlic-naan/")
    expect(recipe.site_name).to eq("Host The Toast")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Morgan")
    expect(recipe.description).to eq("Homemade Garlic Naan. Even if you've never made bread at home before, this soft, chewy, garlicky Indian flatbread is easy to make and well worth the effort.")
    expect(recipe.image).to eq("https://hostthetoast.com/wp-content/uploads/2018/08/naan-202-320x320-1-225x225.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(135)
    expect(recipe.prep_time).to eq(90)
    expect(recipe.cook_time).to eq(45)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.8)
    expect(recipe.ratings_count).to eq(62)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://hostthetoast.com/")
  end
end
