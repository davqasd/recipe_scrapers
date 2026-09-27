# frozen_string_literal: true

RSpec.describe "thermomix-almeria.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_almeria", url: "https://thermomix-almeria.es/marina-martinez-lopez/tecnicas-basicas/fideos-con-costilla-y-verduras-al-estilo-casero") }

  it "reads the title" do
    expect(recipe.title).to eq("Fideos con costilla y verduras al estilo casero")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "50 g de pimiento rojo",
      "50 g de pimiento verde",
      "150 g de cebolla",
      "2 dientes de ajo",
      "50 g de aceite de oliva suave",
      "500 g de costilla troceada",
      "100 g de tomate frito",
      "100 g de champiñón fresco laminado",
      "200 g de fideos nº 4",
      "1 pizca de pimentón dulce",
      "700 g de agua",
      "Sal al gusto"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 50.0, unit: "g", name: "pimiento rojo" },
      { amount: 50.0, unit: "g", name: "pimiento verde" },
      { amount: 150.0, unit: "g", name: "cebolla" },
      { amount: 2.0, unit: "dientes", name: "ajo" },
      { amount: 50.0, unit: "g", name: "aceite de oliva suave" },
      { amount: 500.0, unit: "g", name: "costilla troceada" },
      { amount: 100.0, unit: "g", name: "tomate frito" },
      { amount: 100.0, unit: "g", name: "champiñón fresco laminado" },
      { amount: 200.0, unit: "g", name: "fideos nº 4" },
      { amount: 1.0, unit: "pizca", name: "pimentón dulce" },
      { amount: 700.0, unit: "g", name: "agua" },
      { amount: nil, unit: nil, name: "Sal al gusto" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pon en el vaso 150 g de cebolla en trozos de 2-3cm, 2 dientes de ajo, 50 g de pimiento rojo, 50 g de pimiento verde y 50 g de aceite de oliva suave. Tritura 5 seg/velocidad 5.",
      "Baja los restos hacia las cuchillas.",
      "Programa 8 min/Varoma/velocidad cuchara.",
      "Coloca la mariposa en las cuchillas, añade 500 g de costilla troceada u otra carne/pescado (puede ser pollo, rape...) y cocina 8 min/Varoma/giro inverso/velocidad cuchara.",
      "Incorpora100 g de champiñón fresco laminado, 100 g de tomate frito, y cocina 4 min/100°C/giro inverso/velocidad cuchara.",
      "Quita la mariposa, añade 700 g de agua, el colorante (si deseas), Sal al gusto y 1 pizca de pimentón dulce y cocina 25 min/100°C/giro inverso/velocidad cuchara.",
      "¡Listo para servir bien caliente!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pon en el vaso 150 g de cebolla en trozos de 2-3cm, 2 dientes de ajo, 50 g de pimiento rojo, 50 g de pimiento verde y 50 g de aceite de oliva suave. Tritura 5 seg/velocidad 5.\nBaja los restos hacia las cuchillas.\nPrograma 8 min/Varoma/velocidad cuchara.\nColoca la mariposa en las cuchillas, añade 500 g de costilla troceada u otra carne/pescado (puede ser pollo, rape...) y cocina 8 min/Varoma/giro inverso/velocidad cuchara.\nIncorpora100 g de champiñón fresco laminado, 100 g de tomate frito, y cocina 4 min/100°C/giro inverso/velocidad cuchara.\nQuita la mariposa, añade 700 g de agua, el colorante (si deseas), Sal al gusto y 1 pizca de pimentón dulce y cocina 25 min/100°C/giro inverso/velocidad cuchara.\n¡Listo para servir bien caliente!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-almeria.es")
    expect(recipe.canonical_url).to eq("https://thermomix-almeria.es/marina-martinez-lopez/tecnicas-basicas/fideos-con-costilla-y-verduras-al-estilo-casero")
    expect(recipe.site_name).to eq("Thermomix Almería")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("MARINA MARTINEZ LOPEZ")
    expect(recipe.description).to eq("Este plato es perfecto para los días de frío y puede prepararse con antelación, conservando todo su sabor y textura.")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/1f39e2823b869d9ccd30dad2ca2893ed_b751301848/1f39e2823b869d9ccd30dad2ca2893ed_b751301848.jpg")
    expect(recipe.category).to eq("Técnicas básicas")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Fideos con costilla y verduras al estilo casero", "Técnicas básicas"])
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
