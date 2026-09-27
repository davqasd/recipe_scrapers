# frozen_string_literal: true

RSpec.describe "thermomix-cartagena.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_cartagena", url: "https://thermomix-cartagena.es/ana-belen-velasco-martinez/postres-y-dulces/rollos-de-pascua-1") }

  it "reads the title" do
    expect(recipe.title).to eq("Rollos de pascua")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "800g de harina",
      "120g de anis dulce",
      "250g de aceite de girasol",
      "250g de azucar",
      "1 corteza de limon",
      "1 sobre de levadura quimica",
      "Canela al gusto",
      "100g de zumo de naranja",
      "2 huevos para pintar",
      "Almendras crudas para decorar",
      "Mezcla de azucar y canela para decorar"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 800.0, unit: "g", name: "harina" },
      { amount: 120.0, unit: "g", name: "anis dulce" },
      { amount: 250.0, unit: "g", name: "aceite de girasol" },
      { amount: 250.0, unit: "g", name: "azucar" },
      { amount: 1.0, unit: nil, name: "corteza de limon" },
      { amount: 1.0, unit: nil, name: "sobre de levadura quimica" },
      { amount: nil, unit: nil, name: "Canela al gusto" },
      { amount: 100.0, unit: "g", name: "zumo de naranja" },
      { amount: 2.0, unit: nil, name: "huevos para pintar" },
      { amount: nil, unit: nil, name: "Almendras crudas para decorar" },
      { amount: nil, unit: nil, name: "Mezcla de azucar y canela para decorar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Precalentar el horno a 180°C.",
      "Poner el anis, el aceite, el azucar y la corteza de limon y la canela al gusto y programar 2min. Vel.6.",
      "Poner en el vaso zumo de naranja, la harina y la levadura quimica, mezclar unos segundos a vel.6. A continuacion, amasar 3min en el modo amasar.",
      "Montamos los rollos haciendo bolitas de aproximadamente 65g, despues le damos forma de cilindro y le damos unos cortecitos en diagonal, sin llegar a cortar del todo y unimos los dos extremos.",
      "Colocar dos almendras en cada rollo, pincelar con el huevo y espolvorear con la mezcla de azucar y canela.",
      "Hornear hasta que esten cocidos los rollos aproximadamente 20min."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Precalentar el horno a 180°C.\nPoner el anis, el aceite, el azucar y la corteza de limon y la canela al gusto y programar 2min. Vel.6.\nPoner en el vaso zumo de naranja, la harina y la levadura quimica, mezclar unos segundos a vel.6. A continuacion, amasar 3min en el modo amasar.\nMontamos los rollos haciendo bolitas de aproximadamente 65g, despues le damos forma de cilindro y le damos unos cortecitos en diagonal, sin llegar a cortar del todo y unimos los dos extremos.\nColocar dos almendras en cada rollo, pincelar con el huevo y espolvorear con la mezcla de azucar y canela.\nHornear hasta que esten cocidos los rollos aproximadamente 20min.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-cartagena.es")
    expect(recipe.canonical_url).to eq("https://thermomix-cartagena.es/ana-belen-velasco-martinez/postres-y-dulces/rollos-de-pascua-1")
    expect(recipe.site_name).to eq("Thermomix Cartagena")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("ANA BELEN VELASCO MARTINEZ")
    expect(recipe.description).to eq("Rollos de pascua, una receta de Postres y dulces, elaborada por ANA BELEN VELASCO MARTINEZ. Descubre las mejores recetas de Blogosfera Thermomix Cartagena")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/cbd64590fa2d3da53ef329627d0b275f_50ba6f2b71/cbd64590fa2d3da53ef329627d0b275f_50ba6f2b71.jpg")
    expect(recipe.category).to eq("Postres y dulces")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("24 servings")
    expect(recipe.total_time).to eq(1)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Rollos de pascua", "Postres y dulces"])
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
