# frozen_string_literal: true

RSpec.describe "thermomix-lanzarote.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_lanzarote", url: "https://thermomix-lanzarote.es/ana-maria-garcia-ojeda/coccion-varoma/brocoli-y-patatas-panaderas-con-salmon-al-vapor") }

  it "reads the title" do
    expect(recipe.title).to eq("Brocoli y patatas panaderas con salmón al vapor")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 brocoli en ramilletes",
      "400g de patatas peladas y cortadas en rodajas",
      "1\\2 cebolla y un pimiento",
      "1 lomo de salmón",
      "Sal y pimienta"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "brocoli en ramilletes" },
      { amount: 400.0, unit: "g", name: "patatas peladas y cortadas en rodajas" },
      { amount: 1.0, unit: nil, name: "\\2 cebolla y un pimiento" },
      { amount: 1.0, unit: nil, name: "lomo de salmón" },
      { amount: nil, unit: nil, name: "Sal y pimienta" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Echamos dentro del vaso, 1/2 litro de agua e introducimos el cestillo con el brocoli",
      "Dentro del recipiente varoma colocamos las patatas en rodajas la cebolla y los pimientos en trozos y salamos un poquito. Podemos poner un chorrito de aceite de olivA por encima",
      "En la bandeja del varoma, colocamos el lomo del salmón, salpimentado y envuelto en papel de horno humedecido, formando un papillote.",
      "Tapamos y programamos 25 minutos, Varoma, V 1.",
      "Sano, rápido y rico,rico"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Echamos dentro del vaso, 1/2 litro de agua e introducimos el cestillo con el brocoli\nDentro del recipiente varoma colocamos las patatas en rodajas la cebolla y los pimientos en trozos y salamos un poquito. Podemos poner un chorrito de aceite de olivA por encima\nEn la bandeja del varoma, colocamos el lomo del salmón, salpimentado y envuelto en papel de horno humedecido, formando un papillote.\nTapamos y programamos 25 minutos, Varoma, V 1.\nSano, rápido y rico,rico")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-lanzarote.es")
    expect(recipe.canonical_url).to eq("https://thermomix-lanzarote.es/ana-maria-garcia-ojeda/coccion-varoma/brocoli-y-patatas-panaderas-con-salmon-al-vapor")
    expect(recipe.site_name).to eq("Thermomix Lanzarote")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("ANA MARIA GARCIA OJEDA")
    expect(recipe.description).to eq("El pescado al vapor tiene un sabor muy suave y peculiar, diferente a otras cocciones., y además no desprende olores desagradables en nuestra cocina. No dejes de probarlo Te sorprenderá")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/4e6a7a0b0e6bec1fc07ea856553035d2_9402e3fedd/4e6a7a0b0e6bec1fc07ea856553035d2_9402e3fedd.jpg")
    expect(recipe.category).to eq("Cocción en varoma")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("3 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Brocoli y patatas panaderas con salmón al vapor", "Cocción en varoma"])
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
