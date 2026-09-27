# frozen_string_literal: true

RSpec.describe "thermomix-plasencia.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_plasencia", url: "https://thermomix-plasencia.es/guadalupe-cordobes-sanchez/postres-y-dulces/natillas-de-zanahoria-en-thermomix-desde-villanueva-de-la-vera-plasencia") }

  it "reads the title" do
    expect(recipe.title).to eq("NATILLAS DE ZANAHORIA EN THERMOMIX DESDE VILLANUEVA DE LA VERA- PLASENCIA.")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "300 gr. de zanahoria",
      "500 grs agua",
      "3 Huevos tamaño M a temperatura ambiente",
      "90 gr. azúcar",
      "600 gr. leche",
      "Esencia o aroma de vainilla",
      "Galleta molida, trozos de chocolate, coco rallado, o incluso canela para decorar"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 300.0, unit: "gr", name: "zanahoria" },
      { amount: 500.0, unit: "grs", name: "agua" },
      { amount: 3.0, unit: nil, name: "Huevos tamaño M a temperatura ambiente" },
      { amount: 90.0, unit: "gr", name: "azúcar" },
      { amount: 600.0, unit: "gr", name: "leche" },
      { amount: nil, unit: nil, name: "Esencia o aroma de vainilla" },
      { amount: nil, unit: nil, name: "Galleta molida, trozos de chocolate, coco rallado, o incluso canela para decorar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Poner en el vaso 300 gr. de zanahoria y trocear 4 seg/velocidad 4. Vierta a continuación en el cestillo.",
      "Coloque en el vaso el agua e introduzca el cestillo dentro del vaso con la zanahoria troceada. Cocer al vapor 30 min/Varoma/velocidad 1. Retire el cestillo con la muesca de la espátula. Vierta las zanahorias sobre papel secante de cocina y empape bien el exceso de agua.",
      "Ponga en el vaso la zanahoria y añada 50 gr de leche. Programe 10 seg/velocidad 10 para conseguir una consistencia de crema fina de zanahoria. Bajamos los ingredientes al fondo del vaso con la ayuda de la espátula.3.Ponga en el vaso la zanahoria y añada 50 gr de leche. Programe 10 seg/velocidad 10 para conseguir una consistencia de crema fina de zanahoria. Bajamos los ingredientes al fondo del vaso con la ayuda de la espátula.",
      "Añadimos al vaso 90 gr. azúcar, 3 Huevos M a temperatura ambiente, 600 gr. leche (el resto tras el paso anterior ), un chorrito de Esencia o aroma de vainilla y programamos 8 min/85°C/velocidad 3.5.",
      "A continuación al abrir el vaso observamos si no tiene espuma lo volvemos a programar 2 min/velocidad 3.5 y en el caso de que tenga espuma sería 2 min/85°C/velocidad 3.5 de nuevo.",
      "6.Verter inmediatamente en unos vasitos y dejar enfriar. Servir espolvoreados con galleta molida, o trozos de chocolate, o coco rallado."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Poner en el vaso 300 gr. de zanahoria y trocear 4 seg/velocidad 4. Vierta a continuación en el cestillo.\nColoque en el vaso el agua e introduzca el cestillo dentro del vaso con la zanahoria troceada. Cocer al vapor 30 min/Varoma/velocidad 1. Retire el cestillo con la muesca de la espátula. Vierta las zanahorias sobre papel secante de cocina y empape bien el exceso de agua.\nPonga en el vaso la zanahoria y añada 50 gr de leche. Programe 10 seg/velocidad 10 para conseguir una consistencia de crema fina de zanahoria. Bajamos los ingredientes al fondo del vaso con la ayuda de la espátula.3.Ponga en el vaso la zanahoria y añada 50 gr de leche. Programe 10 seg/velocidad 10 para conseguir una consistencia de crema fina de zanahoria. Bajamos los ingredientes al fondo del vaso con la ayuda de la espátula.\nAñadimos al vaso 90 gr. azúcar, 3 Huevos M a temperatura ambiente, 600 gr. leche (el resto tras el paso anterior ), un chorrito de Esencia o aroma de vainilla y programamos 8 min/85°C/velocidad 3.5.\nA continuación al abrir el vaso observamos si no tiene espuma lo volvemos a programar 2 min/velocidad 3.5 y en el caso de que tenga espuma sería 2 min/85°C/velocidad 3.5 de nuevo.\n6.Verter inmediatamente en unos vasitos y dejar enfriar. Servir espolvoreados con galleta molida, o trozos de chocolate, o coco rallado.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-plasencia.es")
    expect(recipe.canonical_url).to eq("https://thermomix-plasencia.es/guadalupe-cordobes-sanchez/postres-y-dulces/natillas-de-zanahoria-en-thermomix-desde-villanueva-de-la-vera-plasencia")
    expect(recipe.site_name).to eq("Thermomix Plasencia")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("GUADALUPE CORDOBES SANCHEZ")
    expect(recipe.description).to eq("Sugerencias y/o trucos: - Si al cambio de temperatura se disocian las volvemos a poner durante 10 seg. a velocidad 8 para dejarlas finas de nuevo. - La leche puede ser al gusto, es decir desde desnatada, semi, entera, de almendra, de soja.... - Esta")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/b1246d9b8e2051200b1f412091f25b17_b179590326/b1246d9b8e2051200b1f412091f25b17_b179590326.jpg")
    expect(recipe.category).to eq("Postres y dulces")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["NATILLAS DE ZANAHORIA EN THERMOMIX DESDE VILLANUEVA DE LA VERA- PLASENCIA.", "Postres y dulces"])
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
