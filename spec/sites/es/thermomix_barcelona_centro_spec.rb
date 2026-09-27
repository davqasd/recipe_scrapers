# frozen_string_literal: true

RSpec.describe "thermomix-barcelona-centro.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_barcelona_centro", url: "https://thermomix-barcelona-centro.es/ventura/carnes-y-aves/pollo-a-la-catalana") }

  it "reads the title" do
    expect(recipe.title).to eq("POLLO A LA CATALANA")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "contramuslos de pollo sin piel",
      "brandy",
      "tomate triturado en conserva",
      "cebolla"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "contramuslos de pollo sin piel" },
      { amount: nil, unit: nil, name: "brandy" },
      { amount: nil, unit: nil, name: "tomate triturado en conserva" },
      { amount: nil, unit: nil, name: "cebolla" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Ponga en el vaso el aceite y la manteca y caliente 4min/120ºC/vel 1",
      "Añada los contramuslos de pollo, el tomate, la cebolla, los ajos y rehogue 8min/120ºC/giro inverso/vel cuchara",
      "Incorpore el brandy, el laurel, la sal y la pimienta y programe 40 min/120ºC/giro inverso/vel cuchara. Vierta en una fuente y sirva inmediatamente"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Ponga en el vaso el aceite y la manteca y caliente 4min/120ºC/vel 1\nAñada los contramuslos de pollo, el tomate, la cebolla, los ajos y rehogue 8min/120ºC/giro inverso/vel cuchara\nIncorpore el brandy, el laurel, la sal y la pimienta y programe 40 min/120ºC/giro inverso/vel cuchara. Vierta en una fuente y sirva inmediatamente")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-barcelona-centro.es")
    expect(recipe.canonical_url).to eq("https://thermomix-barcelona-centro.es/ventura/carnes-y-aves/pollo-a-la-catalana")
    expect(recipe.site_name).to eq("Thermomix Barcelona Centro")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("ROSER VENTURA SAMBLAS")
    expect(recipe.description).to eq("Receta facilitada por Carmen Palomo")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/8a0c054033956fa2a32683ee4c2b98d7_7f12df2601/8a0c054033956fa2a32683ee4c2b98d7_7f12df2601.jpg")
    expect(recipe.category).to eq("Carnes y aves")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["POLLO A LA CATALANA", "Carnes y aves"])
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
    expect(recipe.links).to include("https://blogosferathermomix.es/delegaciones-thermomix")
  end
end
