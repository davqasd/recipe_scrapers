# frozen_string_literal: true

RSpec.describe "thermomix-granada.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_granada", url: "https://thermomix-granada.es/angeles-rodriguez-canadas/dietas-especiales/batido-proteico-aprobado-por-un-entrenador-personal-receta-facil-con-thermomix") }

  it "reads the title" do
    expect(recipe.title).to eq("Batido Proteico Aprobado por un Entrenador Personal – Receta Fácil con Thermomix")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 yemas de huevo",
      "2 yogures desnatados",
      "1 plátano cortado en rodajas",
      "250 ml de leche desnatada"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: nil, name: "yemas de huevo" },
      { amount: 2.0, unit: nil, name: "yogures desnatados" },
      { amount: 1.0, unit: nil, name: "plátano cortado en rodajas" },
      { amount: 250.0, unit: "ml", name: "leche desnatada" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Coloca todos los ingredientes en la jarra de tu Thermomix.",
      "Programa 1 mt / velocidad 10",
      "Sirve inmediatamente en un vaso alt",
      "Disfruta de su textura cremosa y sabor natural.",
      "Consejo: si te gusta más frío, añade unos cubitos de hielo junto con los ingredientes",
      "Idea extraPuedes personalizarlo con canela, cacao puro en polvo o una cucharada de avena para aumentar la fibra."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Coloca todos los ingredientes en la jarra de tu Thermomix.\nPrograma 1 mt / velocidad 10\nSirve inmediatamente en un vaso alt\nDisfruta de su textura cremosa y sabor natural.\nConsejo: si te gusta más frío, añade unos cubitos de hielo junto con los ingredientes\nIdea extraPuedes personalizarlo con canela, cacao puro en polvo o una cucharada de avena para aumentar la fibra.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-granada.es")
    expect(recipe.canonical_url).to eq("https://thermomix-granada.es/angeles-rodriguez-canadas/dietas-especiales/batido-proteico-aprobado-por-un-entrenador-personal-receta-facil-con-thermomix")
    expect(recipe.site_name).to eq("Thermomix Granada")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("ANGELES RODRIGUEZ CAÑADAS")
    expect(recipe.description).to eq("Si quieres más recetas proteicas rápidas con Thermomix aprobadas por un entrenador personal, déjame un comentario con la palabra “PROTEÁNA” en mis redes sociales y te enviaré mis recetas favoritas. Encuéntrame en Instagram, Facebook, TikTok")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/ee53b5993c9c590791fd52afdc85a9b0_3b652bf00b/ee53b5993c9c590791fd52afdc85a9b0_3b652bf00b.jpg")
    expect(recipe.category).to eq("Dietas especiales")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Batido Proteico Aprobado por un Entrenador Personal – Receta Fácil con Thermomix", "Dietas especiales"])
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
