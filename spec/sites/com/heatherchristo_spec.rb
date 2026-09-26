# frozen_string_literal: true

RSpec.describe "heatherchristo.com" do
  subject(:recipe) { scrape_cassette("com/heatherchristo", url: "https://heatherchristo.com/2020/03/12/creamy-basil-mint-pesto-pasta-vegan-gluten-free/") }

  it "reads the title" do
    expect(recipe.title).to eq("Creamy Basil Mint Pesto Pasta (Vegan and gluten-free)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 cloves garlic",
      "2 cups packed fresh basil leaves",
      "1 cup packed fresh mint leaves",
      "¼ avocado",
      "1⁄3 cup olive oil",
      "1⁄4 cup red wine vinegar",
      "Kosher salt",
      "1 pound gluten-free spaghetti",
      "2 macadamia nuts for grating for garnish (optional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "cloves", name: "garlic" },
      { amount: 2.0, unit: "cups", name: "packed fresh basil leaves" },
      { amount: 1.0, unit: "cup", name: "packed fresh mint leaves" },
      { amount: 0.25, unit: nil, name: "avocado" },
      { amount: 0.33, unit: "cup", name: "olive oil" },
      { amount: 0.25, unit: "cup", name: "red wine vinegar" },
      { amount: nil, unit: nil, name: "Kosher salt" },
      { amount: 1.0, unit: "pound", name: "gluten-free spaghetti" },
      { amount: 2.0, unit: nil, name: "macadamia nuts for grating for garnish" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Creamy Basil-Mint Pesto:",
      "In the still boiling water, add the basil and the mint leaves and boil for about 30 seconds, then immediately pull them out, drain and add to the ice water so that they completely cool down.",
      "In the jar of a blender, add the garlic cloves. the blanched herbs, avocado and the oil and vinegar. Puree on high until smooth and bright green, then season to taste with kosher salt. Set aside.",
      "In the still boiling water add the pasta and cook to al dente according to manufacturer's directions.",
      "Drain the pasta and rinse it with cold water. Add it back to the empty pot and add the pesto and toss to heat the pesto."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Creamy Basil-Mint Pesto:\nIn the still boiling water, add the basil and the mint leaves and boil for about 30 seconds, then immediately pull them out, drain and add to the ice water so that they completely cool down.\nIn the jar of a blender, add the garlic cloves. the blanched herbs, avocado and the oil and vinegar. Puree on high until smooth and bright green, then season to taste with kosher salt. Set aside.\nIn the still boiling water add the pasta and cook to al dente according to manufacturer's directions.\nDrain the pasta and rinse it with cold water. Add it back to the empty pot and add the pesto and toss to heat the pesto.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("heatherchristo.com")
    expect(recipe.canonical_url).to eq("https://heatherchristo.com/2020/03/12/creamy-basil-mint-pesto-pasta-vegan-gluten-free/")
    expect(recipe.site_name).to eq("Heather Christo")
    expect(recipe.language).to eq("en-US")
    expect(recipe.author).to eq("Heather Christo")
    expect(recipe.description).to eq("I know it has been a little bit quiet over here this week. We are still in Canada and will stay here filming as long as we can. There is confirmed corona in the area as of yesterday, so I do have to say that the difference in mood and concern in just a few …")
    expect(recipe.image).to eq("https://live.staticflickr.com/65535/49449778928_db1c8a3c47_b.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(10)
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
    expect(recipe.links).to include("https://www.informizely.com/")
  end
end
