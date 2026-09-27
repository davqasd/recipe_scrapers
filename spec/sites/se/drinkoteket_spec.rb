# frozen_string_literal: true

RSpec.describe "drinkoteket.se" do
  subject(:recipe) { scrape_cassette("se/drinkoteket", url: "https://drinkoteket.se/recept/amarula-spice/") }

  it "reads the title" do
    expect(recipe.title).to eq("Amarula Spice")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq(%w[
      Amarula
      Mangojuice
      Chili
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "Amarula" },
      { amount: nil, unit: nil, name: "Mangojuice" },
      { amount: nil, unit: nil, name: "Chili" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Finhacka den färska chilifrukten. Ta bort kärnorna.",
      "Häll Amarula, mangojuice och chili i en shaker.",
      "Fyll upp shakern med is och skaka ordentligt.",
      "Sila upp i ett glas och garnera med chilifrukt."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Finhacka den färska chilifrukten. Ta bort kärnorna.\nHäll Amarula, mangojuice och chili i en shaker.\nFyll upp shakern med is och skaka ordentligt.\nSila upp i ett glas och garnera med chilifrukt.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("drinkoteket.se")
    expect(recipe.canonical_url).to eq("https://drinkoteket.se/recept/amarula-spice/")
    expect(recipe.site_name).to eq("Drinkoteket")
    expect(recipe.language).to eq("sv-SE")
    expect(recipe.author).to eq("Drinkoteket")
    expect(recipe.description).to eq("Amarula Spice är en god, gräddig, fruktig och lite kryddig drink.")
    expect(recipe.image).to eq("https://drinkoteket.se/wp-content/uploads/amarula-spice-860x860.jpg")
    expect(recipe.category).to eq("Drink")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(4)
    expect(recipe.cook_time).to eq(2)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#reviews")
  end
end
