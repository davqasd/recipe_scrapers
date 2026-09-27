# frozen_string_literal: true

RSpec.describe "thermomix-salamanca.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_salamanca", url: "https://thermomix-salamanca.es/rocio-pilo-alvarez/aperitivos-entrantes-tapas/receta-turron-de-brie") }

  it "reads the title" do
    expect(recipe.title).to eq("RECETA TURRÓN DE BRIE")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "50gr de nata 35% de grasa",
      "250 gr de queso brie con la corteza ligeramente raspada y cortado en trozos",
      "4 quesitos en porciones",
      "40 gr de nueces peladas",
      "40gr de pistachos pelados",
      "30 gr de arándanos deshidratados"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 50.0, unit: "gr", name: "nata 35% de grasa" },
      { amount: 250.0, unit: "gr", name: "queso brie con la corteza ligeramente raspada y cortado en trozos" },
      { amount: 4.0, unit: nil, name: "quesitos en porciones" },
      { amount: 40.0, unit: "gr", name: "nueces peladas" },
      { amount: 40.0, unit: "gr", name: "pistachos pelados" },
      { amount: 30.0, unit: "gr", name: "arándanos deshidratados" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Forraremos con film transparende un molde tipo cake de aproximadamente 32x12x10 cm. (Puedes usar un brick de leche vacío cortado por la mitad)",
      "Ponemos en el vaso la nata, los quesitos y el queso brie, programamos 7 minutos,90 grados, velocidad 2.",
      "Incorporamos las nueces, los pistachos y los arándanos. Programamos 20 segundos, giro a la izquierda, velocidad 3. Acabado el tiempo vertemos la mezcla en nuestro molde y lo reservamos en el frigorífico un mínimo de 2horas.",
      "Desmoldamos sobre una tabla o plato y dejamos atemperar unos 15 minutos antes de servir.",
      "A Disfrutar! Truquito: tibio está muy muy rico por lo que puedes ponerlo sobre el pan tipo tosta y darle un leve golpecito de calor."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Forraremos con film transparende un molde tipo cake de aproximadamente 32x12x10 cm. (Puedes usar un brick de leche vacío cortado por la mitad)\nPonemos en el vaso la nata, los quesitos y el queso brie, programamos 7 minutos,90 grados, velocidad 2.\nIncorporamos las nueces, los pistachos y los arándanos. Programamos 20 segundos, giro a la izquierda, velocidad 3. Acabado el tiempo vertemos la mezcla en nuestro molde y lo reservamos en el frigorífico un mínimo de 2horas.\nDesmoldamos sobre una tabla o plato y dejamos atemperar unos 15 minutos antes de servir.\nA Disfrutar! Truquito: tibio está muy muy rico por lo que puedes ponerlo sobre el pan tipo tosta y darle un leve golpecito de calor.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-salamanca.es")
    expect(recipe.canonical_url).to eq("https://thermomix-salamanca.es/rocio-pilo-alvarez/aperitivos-entrantes-tapas/receta-turron-de-brie")
    expect(recipe.site_name).to eq("Thermomix Salamanca")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("ROCIO P.")
    expect(recipe.description).to eq("RECETA TURRÓN DE BRIE, una receta de Aperitivos, entrantes y tapas, elaborada por ROCIO P.. Descubre las mejores recetas de Blogosfera Thermomix Salamanca")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/4dd8f50fff6dec3a9904c23a36d0a1cb_7a540ad480/4dd8f50fff6dec3a9904c23a36d0a1cb_7a540ad480.jpg")
    expect(recipe.category).to eq("Aperitivos, entrantes y tapas")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["RECETA TURRÓN DE BRIE", "Aperitivos", "entrantes y tapas"])
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
