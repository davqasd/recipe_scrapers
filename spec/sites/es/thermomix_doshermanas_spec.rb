# frozen_string_literal: true

RSpec.describe "thermomix-doshermanas.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_doshermanas", url: "https://thermomix-doshermanas.es/trinidad-rayas-rivas/navidad/turron-de-kinder-bueno") }

  it "reads the title" do
    expect(recipe.title).to eq("Turrón de Kinder Bueno")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "20 gr aceite de coco",
      "100 gr chocolate con leche postres",
      "300 gr chocolate blanco postres",
      "8 barritas de Kinder bueno",
      "80 gr leche evaporada"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 20.0, unit: "gr", name: "aceite de coco" },
      { amount: 100.0, unit: "gr", name: "chocolate con leche postres" },
      { amount: 300.0, unit: "gr", name: "chocolate blanco postres" },
      { amount: 8.0, unit: nil, name: "barritas de Kinder bueno" },
      { amount: 80.0, unit: "gr", name: "leche evaporada" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Lo primero que vamos a hacer es rallar 100 gr de chocolate con leche postres a 30 seg a velocidad 10.",
      "Añadimos 20 gr de aceite de coco y calentamos 5 min a 50 C y a velocidad 1.Echamos en un molde y lo reservamos en el frigorífico mientras continuamos la receta",
      "Sin lavar el vaso, añadimos 300 gr chocolate blanco postres y trituramos 30 seg a velocidad 10.",
      "Bajamos los ingredientes hacia el fondo del vaso y programamos 5 min a 50 C y a velocidad 2.",
      "Añadimos 80 gr de leche evaporada y 4 barritas de Kinder bueno troceadas.",
      "Mezclamos 30 seg a velocidad 3. La mezcla es densa.",
      "Sacar el molde del frigorífico y volcamos la mezcla. Repartiremos las otras 4 barritas Kinder troceadas.",
      "Envolver en papel film y llevar al frigorífico al menos dos horas antes de servir"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Lo primero que vamos a hacer es rallar 100 gr de chocolate con leche postres a 30 seg a velocidad 10.\nAñadimos 20 gr de aceite de coco y calentamos 5 min a 50 C y a velocidad 1.Echamos en un molde y lo reservamos en el frigorífico mientras continuamos la receta\nSin lavar el vaso, añadimos 300 gr chocolate blanco postres y trituramos 30 seg a velocidad 10.\nBajamos los ingredientes hacia el fondo del vaso y programamos 5 min a 50 C y a velocidad 2.\nAñadimos 80 gr de leche evaporada y 4 barritas de Kinder bueno troceadas.\nMezclamos 30 seg a velocidad 3. La mezcla es densa.\nSacar el molde del frigorífico y volcamos la mezcla. Repartiremos las otras 4 barritas Kinder troceadas.\nEnvolver en papel film y llevar al frigorífico al menos dos horas antes de servir")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-doshermanas.es")
    expect(recipe.canonical_url).to eq("https://thermomix-doshermanas.es/trinidad-rayas-rivas/navidad/turron-de-kinder-bueno")
    expect(recipe.site_name).to eq("Thermomix Sevilla Dos Hermanas")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("TRINIDAD RAYA")
    expect(recipe.description).to eq("Turrón de Kinder Bueno, una receta de Navidad, elaborada por TRINIDAD RAYA . Descubre las mejores recetas de Blogosfera Thermomix Sevilla Dos Hermanas")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/01a3d69015fd62f67563d6ffa7133025_6ca7f5ff7c/01a3d69015fd62f67563d6ffa7133025_6ca7f5ff7c.jpg")
    expect(recipe.category).to eq("Navidad")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Turrón de Kinder Bueno", "Navidad"])
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
