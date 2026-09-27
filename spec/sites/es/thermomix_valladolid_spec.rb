# frozen_string_literal: true

RSpec.describe "thermomix-valladolid.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_valladolid", url: "https://thermomix-valladolid.es/laura-castell-gonzalez/masas-panes-reposteria/receta-contra-el-calor-bizcocho-de-chocolate-al-vapor") }

  it "reads the title" do
    expect(recipe.title).to eq("Receta contra el calor: Bizcocho de chocolate al vapor")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "370 g de leche condensada",
      "4 huevos",
      "100g de harina",
      "60g cacao en polvo",
      "1 sobre de levadura quimica",
      "40 gracias de mantequilla y un poco más para engrasar el molde",
      "1l de agua para el vapor"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 370.0, unit: "g", name: "leche condensada" },
      { amount: 4.0, unit: nil, name: "huevos" },
      { amount: 100.0, unit: "g", name: "harina" },
      { amount: 60.0, unit: "g", name: "cacao en polvo" },
      { amount: 1.0, unit: nil, name: "sobre de levadura quimica" },
      { amount: 40.0, unit: nil, name: "gracias de mantequilla y un poco más para engrasar el molde" },
      { amount: 1.0, unit: "l", name: "agua para el vapor" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Unte con mantequilla un molde de corona de diámetro 23 cm, y cubra las paredes y el fondo.",
      "Ponga en el vaso la leche condensada,los huevos,la harina, el cacao, la levadura y la mantequilla y programe 30seg/ vel 6.",
      "Vierta la mezcla en el molde y dele unos golpes sobre la encimera para distribuir la masa.Cubra con film transparente y reserve. Aclare el vaso.",
      "Ponga el litro de agua en el vaso para el vapor. Sitúe el recipiente varoma en su posición con el molde, coloque encima del molde 2-3 hojas de papel de cocina ( para que absorban el agua de la condensacion), tape el varoma y programe 60 min/ Varoma/ velocidad 1.",
      "Retire el molde del varoma, el papel de cocina y el film, inmediatamente al finalizar el tiempo. Dejarlo enfriar 20 min sobre una rejilla y desmoldar templado."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Unte con mantequilla un molde de corona de diámetro 23 cm, y cubra las paredes y el fondo.\nPonga en el vaso la leche condensada,los huevos,la harina, el cacao, la levadura y la mantequilla y programe 30seg/ vel 6.\nVierta la mezcla en el molde y dele unos golpes sobre la encimera para distribuir la masa.Cubra con film transparente y reserve. Aclare el vaso.\nPonga el litro de agua en el vaso para el vapor. Sitúe el recipiente varoma en su posición con el molde, coloque encima del molde 2-3 hojas de papel de cocina ( para que absorban el agua de la condensacion), tape el varoma y programe 60 min/ Varoma/ velocidad 1.\nRetire el molde del varoma, el papel de cocina y el film, inmediatamente al finalizar el tiempo. Dejarlo enfriar 20 min sobre una rejilla y desmoldar templado.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-valladolid.es")
    expect(recipe.canonical_url).to eq("https://thermomix-valladolid.es/laura-castell-gonzalez/masas-panes-reposteria/receta-contra-el-calor-bizcocho-de-chocolate-al-vapor")
    expect(recipe.site_name).to eq("Thermomix Valladolid")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("LAURA CASTELL GONZALEZ")
    expect(recipe.description).to eq("En esta receta podemos utilizar la receta de la leche condensada casera que os he pasado")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/871fe0389ef07a60cfd7dfe0eddccc47_096e49f72c/871fe0389ef07a60cfd7dfe0eddccc47_096e49f72c.jpg")
    expect(recipe.category).to eq("Masas, panes y repostería")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(1)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Receta contra el calor: Bizcocho de chocolate al vapor", "Masas", "panes y repostería"])
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
