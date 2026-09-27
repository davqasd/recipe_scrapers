# frozen_string_literal: true

RSpec.describe "thermomix-madrid-centro.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_madrid_centro", url: "https://thermomix-madrid-centro.es/agurtzane-samaniego/verduras-hortalizas-ensaladas/los-mas-deseados-para-el-verano-carpaccio-de-calabacin-con-queso-de-cabra-y-tapenade") }

  it "reads the title" do
    expect(recipe.title).to eq("Los más deseados para el verano: Carpaccio de calabacín con queso de cabra y Tapenade")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "300 g de calabacín",
      "1 lata de anchoas",
      "100 g de aceitunas negras deshuesadas del bajo aragon",
      "30 g de aceite de oliva",
      "1/2 diente de ajo",
      "30 g de alcaparras",
      "10 g de zumo de limón",
      "1 pellizco del pimienta negra molida",
      "1/2 cucharadita de tomillo",
      "Aceite de oliva virgen al gusto",
      "Piñones"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 300.0, unit: "g", name: "calabacín" },
      { amount: 1.0, unit: "lata", name: "anchoas" },
      { amount: 100.0, unit: "g", name: "aceitunas negras deshuesadas del bajo aragon" },
      { amount: 30.0, unit: "g", name: "aceite de oliva" },
      { amount: 0.5, unit: "diente", name: "ajo" },
      { amount: 30.0, unit: "g", name: "alcaparras" },
      { amount: 10.0, unit: "g", name: "zumo de limón" },
      { amount: 1.0, unit: nil, name: "pellizco del pimienta negra molida" },
      { amount: 0.5, unit: "cucharadita", name: "tomillo" },
      { amount: nil, unit: nil, name: "Aceite de oliva virgen al gusto" },
      { amount: nil, unit: nil, name: "Piñones" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Coloca el adaptador y el recipiente cortador en el vaso. Inserta el disco con la cara 1 (Laminar) hacia arriba. Coloca la tapa del cortador, introduce el calabacín por la abertura e inicie Laminar / Fino mientras presiona con el prensador. Retira el accesorio y el adaptador, y reparte las láminas de calabacín en un plato, distribuye el queso de cabra desmenuzado y distribuido, o en una bola.",
      "Para preparar el Tapenade. Incorpora las aceitunas negras, el ajo, las anchoas, las alcaparras, el zumo de limón, el tomillo y la pimienta negra molida, y programa 5 seg / vel 5. Bajamos los ingredientes hacia el fondo del vaso. A continuación programa 1 min / vel 4. Mientras tanto vierte el aceite sobre la tapa. Finalizado el tiempo baje la Tapenade hacia el fondo con la ayuda de la espatula, y mezcla 10 seg / vel 4. Vierta en un bol.",
      "Montaje del carpaccio. Reparta el Tapenade sobre el carpaccio, y riega con aceite de oliva. Sirve en la mesa inmediatamente."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Coloca el adaptador y el recipiente cortador en el vaso. Inserta el disco con la cara 1 (Laminar) hacia arriba. Coloca la tapa del cortador, introduce el calabacín por la abertura e inicie Laminar / Fino mientras presiona con el prensador. Retira el accesorio y el adaptador, y reparte las láminas de calabacín en un plato, distribuye el queso de cabra desmenuzado y distribuido, o en una bola.\nPara preparar el Tapenade. Incorpora las aceitunas negras, el ajo, las anchoas, las alcaparras, el zumo de limón, el tomillo y la pimienta negra molida, y programa 5 seg / vel 5. Bajamos los ingredientes hacia el fondo del vaso. A continuación programa 1 min / vel 4. Mientras tanto vierte el aceite sobre la tapa. Finalizado el tiempo baje la Tapenade hacia el fondo con la ayuda de la espatula, y mezcla 10 seg / vel 4. Vierta en un bol.\nMontaje del carpaccio. Reparta el Tapenade sobre el carpaccio, y riega con aceite de oliva. Sirve en la mesa inmediatamente.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-madrid-centro.es")
    expect(recipe.canonical_url).to eq("https://thermomix-madrid-centro.es/agurtzane-samaniego/verduras-hortalizas-ensaladas/los-mas-deseados-para-el-verano-carpaccio-de-calabacin-con-queso-de-cabra-y-tapenade")
    expect(recipe.site_name).to eq("Thermomix Madrid Centro")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("Agurtzane Samaniego")
    expect(recipe.description).to eq("Pon a jugar tu creatividad y tu gusto en este carpaccio")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/408931a07b0dd77eb3436c536a090fdc_d49859473a/408931a07b0dd77eb3436c536a090fdc_d49859473a.jpg")
    expect(recipe.category).to eq("Verduras, hortalizas y ensaladas")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Los más deseados para el verano: Carpaccio de calabacín con queso de cabra y Tapenade", "Verduras", "hortalizas y ensaladas"])
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
