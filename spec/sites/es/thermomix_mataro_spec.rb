# frozen_string_literal: true

RSpec.describe "thermomix-mataro.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_mataro", url: "https://thermomix-mataro.es/ma-jose-navarro-munoz/postres-y-dulces/cuajada-con-miel-y-nueces-sin-lactosa") }

  it "reads the title" do
    expect(recipe.title).to eq("Cuajada con miel y nueces sin lactosa")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "500 leche semi sin lactosa",
      "1 sobre de cuajada",
      "Miel al gusto",
      "Mermelada al gusto",
      "Nueces o frutos variados"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 500.0, unit: nil, name: "leche semi sin lactosa" },
      { amount: 1.0, unit: nil, name: "sobre de cuajada" },
      { amount: nil, unit: nil, name: "Miel al gusto" },
      { amount: nil, unit: nil, name: "Mermelada al gusto" },
      { amount: nil, unit: nil, name: "Nueces o frutos variados" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Poner la leche junto la cuajada programar 4min/90º/vel 5",
      "Reparte en los vasitos preparados , dejar templar y al frigorífico"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Poner la leche junto la cuajada programar 4min/90º/vel 5\nReparte en los vasitos preparados , dejar templar y al frigorífico")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-mataro.es")
    expect(recipe.canonical_url).to eq("https://thermomix-mataro.es/ma-jose-navarro-munoz/postres-y-dulces/cuajada-con-miel-y-nueces-sin-lactosa")
    expect(recipe.site_name).to eq("Thermomix Mataró (Barcelona)")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("Mª JOSE NAVARRO MUÑOZ")
    expect(recipe.description).to eq("Puedes poner la miel, en el fondo de vaso o bien a la hora de comer")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/3b115e8561553d147b234a98c38d96c1_7834910d63/3b115e8561553d147b234a98c38d96c1_7834910d63.jpg")
    expect(recipe.category).to eq("Postres y dulces")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("5 servings")
    expect(recipe.total_time).to eq(5)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Cuajada con miel y nueces sin lactosa", "Postres y dulces"])
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
