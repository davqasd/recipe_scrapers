# frozen_string_literal: true

RSpec.describe "thermomix-caceres.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_caceres", url: "https://thermomix-caceres.es/ma-gracia-portillo-coronado/aperitivos-entrantes-tapas/bombon-de-pisto-y-parmesano-con-un-toque-de-escamas-de-pimenton-ahumadas") }

  it "reads the title" do
    expect(recipe.title).to eq("Bombon de pisto y parmesano con un toque de escamas de pimentón ahumadas")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "100 g. de cebolla en trozos de aprox. 3 cm.",
      "150g de calabacin en trozoz de 3 cm.",
      "100g pimiento rojo cortado en trozos de 3 cm",
      "50g. de aceite",
      "100g de pimiento verde en trozos de 3 cm.",
      "300g de tomate bien picadito",
      "1 cucharadita de sal",
      "Nuez moscada",
      "pimienta negra molida",
      "50g mantequilla",
      "100g harina",
      "500g de leche entera",
      "Cucharadita de sal",
      "Pimienta negra molida",
      "Nuez moscada"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 100.0, unit: "g", name: "cebolla en trozos de aprox. 3 cm." },
      { amount: 150.0, unit: "g", name: "calabacin en trozoz de 3 cm." },
      { amount: 100.0, unit: "g", name: "pimiento rojo cortado en trozos de 3 cm" },
      { amount: 50.0, unit: "g", name: "aceite" },
      { amount: 100.0, unit: "g", name: "pimiento verde en trozos de 3 cm." },
      { amount: 300.0, unit: "g", name: "tomate bien picadito" },
      { amount: 1.0, unit: "cucharadita", name: "sal" },
      { amount: nil, unit: nil, name: "Nuez moscada" },
      { amount: nil, unit: nil, name: "pimienta negra molida" },
      { amount: 50.0, unit: "g", name: "mantequilla" },
      { amount: 100.0, unit: "g", name: "harina" },
      { amount: 500.0, unit: "g", name: "leche entera" },
      { amount: nil, unit: nil, name: "Cucharadita de sal" },
      { amount: nil, unit: nil, name: "Pimienta negra molida" },
      { amount: nil, unit: nil, name: "Nuez moscada" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Ponga en el vaso la cebolla, el pimiento rojo, el pimiento verde y el calabacín. Trocee 5 seg/vel 4.",
      "Añada el aceite y programe 20 min/120°C//vel .",
      "Incorpore el tomate triturado, la sal y la pimienta. Programe 20 min/120°C/ giro inverso/vel cuchara Reservamos en un bol",
      "50g de mantequilla 100g de harina 5 mitos 120º velocidad 1echamos 500g de leche 10 minutos 100º velocidad 4",
      "Echamos el pisto 10 minutos velocidad 4 25 g de queso parmesano en polvo 3 minutos velocidad 4 ponemos la masa en una fuente o manga pastelera y reservamos en el frigorífico hasta el día siguiente"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Ponga en el vaso la cebolla, el pimiento rojo, el pimiento verde y el calabacín. Trocee 5 seg/vel 4.\nAñada el aceite y programe 20 min/120°C//vel .\nIncorpore el tomate triturado, la sal y la pimienta. Programe 20 min/120°C/ giro inverso/vel cuchara Reservamos en un bol\n50g de mantequilla 100g de harina 5 mitos 120º velocidad 1echamos 500g de leche 10 minutos 100º velocidad 4\nEchamos el pisto 10 minutos velocidad 4 25 g de queso parmesano en polvo 3 minutos velocidad 4 ponemos la masa en una fuente o manga pastelera y reservamos en el frigorífico hasta el día siguiente")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-caceres.es")
    expect(recipe.canonical_url).to eq("https://thermomix-caceres.es/ma-gracia-portillo-coronado/aperitivos-entrantes-tapas/bombon-de-pisto-y-parmesano-con-un-toque-de-escamas-de-pimenton-ahumadas")
    expect(recipe.site_name).to eq("Thermomix Cáceres")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("Mª GRACIA PORTILLO CORONADO")
    expect(recipe.description).to eq("Eso si, con thermomix quedan fenomenal nada que ver con hacerlas en la sartén. Si necesitas información pincha en el botón verde y por WhatsApp te atiendo enseguida. Gracias por leerme")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/96286ec8d7a2b68cccc3c0d578fb510c_1e422de238/96286ec8d7a2b68cccc3c0d578fb510c_1e422de238.jpg")
    expect(recipe.category).to eq("Aperitivos, entrantes y tapas")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(1)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Bombon de pisto y parmesano con un toque de escamas de pimentón ahumadas", "Aperitivos", "entrantes y tapas"])
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
