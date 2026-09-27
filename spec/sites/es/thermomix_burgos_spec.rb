# frozen_string_literal: true

RSpec.describe "thermomix-burgos.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_burgos", url: "https://thermomix-burgos.es/maria-yolanda-garay-barajas/verduras-hortalizas-ensaladas/la-mejor-receta-de-la-historia-de-thermomix-merluza-rellena-con-ajada-de-gambas-y-salsa-de-piquillos") }

  it "reads the title" do
    expect(recipe.title).to eq("LA MEJOR RECETA DE LA HISTORIA DE THERMOMIX: MERLUZA RELLENA CON AJADA DE GAMBAS Y SALSA DE PIQUILLOS")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "250 gr de gambas frescas enteras sin pelar",
      "3 dientes de ajo",
      "70 gr de aceite de oliva virgen extra (y un poco más para regar al emplazar)",
      "200 gr de agua",
      "2 filetes de merluza fresca (la parte de la cola) 600 gr aproximadamente, salpimentados",
      "4 patatas pequeñas",
      "8 espárragos verdes (sin la parte leñosa)",
      "30 gr de cebolla",
      "150 gr de calabacín pelado y cortado en trozos",
      "1 cucharadita de sal",
      "1 pellizco de pimienta",
      "100 gr de pimientos de piquillo",
      "30 gr de leche"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 250.0, unit: "gr", name: "gambas frescas enteras sin pelar" },
      { amount: 3.0, unit: "dientes", name: "ajo" },
      { amount: 70.0, unit: "gr", name: "aceite de oliva virgen extra" },
      { amount: 200.0, unit: "gr", name: "agua" },
      { amount: 2.0, unit: nil, name: "filetes de merluza fresca 600 gr aproximadamente, salpimentados" },
      { amount: 4.0, unit: nil, name: "patatas pequeñas" },
      { amount: 8.0, unit: nil, name: "espárragos verdes" },
      { amount: 30.0, unit: "gr", name: "cebolla" },
      { amount: 150.0, unit: "gr", name: "calabacín pelado y cortado en trozos" },
      { amount: 1.0, unit: "cucharadita", name: "sal" },
      { amount: 1.0, unit: nil, name: "pellizco de pimienta" },
      { amount: 100.0, unit: "gr", name: "pimientos de piquillo" },
      { amount: 30.0, unit: "gr", name: "leche" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pelamos las gambas y reservamos también las cáscaras y las cabezas.",
      "Ponemos en el vaso 30 gr de aceite y calentamos, 5 min/120º/vel 1. Añadimos los ajos y los picamos, 5 seg/vel 5. Sofreímos 3 min/120º/vel 1.",
      "Añadimos los cuerpos de las gambas y los rehogamos 2 min/120º/giro inverso/vel 1. Retiramos del vaso y reservamos.",
      "Ponemos en el vaso las cáscaras y las cabezas de las gambas, y añadimos el agua. Troceamos 2 seg/vel 5. Programamos 5 min/100º/vel 4.Colamos el fumet a través de un colador de malla fina y lo reservaremos.Lavamos y secamos el vaso y la tapa.",
      "Sobre un film transparente colocamos unos de los filetes de merluza, y vertemos por encima la ajada de gambas. Colocamos el otro filete encima y lo envolvemos con el film. Lo hacemos rodar sobre la superficie de trabajo para que quede bien cerrado.Ponemos en recipiente varoma la mariposa para que quede hueco y suba el vapor, y sobre ella colocamos el pescado, las patatas y los espárragos. Tapamos y reservamos.",
      "Ponemos en el vaso la cebolla, el calabacín y 40 gr de aceite. Troceamos 3 seg/vel 4. Sofreímos 3 min/120º/vel 1.Añadimos el fumet, la sala y la pimienta. Colocamos el Varoma en su posición y programamos 25 min/varoma/ vel 2.",
      "Retiramos el Varoma, y añadimos en el vaso los pimientos de piquillo. Trituramos 10 seg/vel 8. Añadimos la leche y programamos 2 min/100º/vel 1.",
      "Mientras tanto, quitamos el film transparente al pescado, y lo colocamos en la fuente. Ponemos la patatas y los espárragos, y regamos con la salsa."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pelamos las gambas y reservamos también las cáscaras y las cabezas.\nPonemos en el vaso 30 gr de aceite y calentamos, 5 min/120º/vel 1. Añadimos los ajos y los picamos, 5 seg/vel 5. Sofreímos 3 min/120º/vel 1.\nAñadimos los cuerpos de las gambas y los rehogamos 2 min/120º/giro inverso/vel 1. Retiramos del vaso y reservamos.\nPonemos en el vaso las cáscaras y las cabezas de las gambas, y añadimos el agua. Troceamos 2 seg/vel 5. Programamos 5 min/100º/vel 4.Colamos el fumet a través de un colador de malla fina y lo reservaremos.Lavamos y secamos el vaso y la tapa.\nSobre un film transparente colocamos unos de los filetes de merluza, y vertemos por encima la ajada de gambas. Colocamos el otro filete encima y lo envolvemos con el film. Lo hacemos rodar sobre la superficie de trabajo para que quede bien cerrado.Ponemos en recipiente varoma la mariposa para que quede hueco y suba el vapor, y sobre ella colocamos el pescado, las patatas y los espárragos. Tapamos y reservamos.\nPonemos en el vaso la cebolla, el calabacín y 40 gr de aceite. Troceamos 3 seg/vel 4. Sofreímos 3 min/120º/vel 1.Añadimos el fumet, la sala y la pimienta. Colocamos el Varoma en su posición y programamos 25 min/varoma/ vel 2.\nRetiramos el Varoma, y añadimos en el vaso los pimientos de piquillo. Trituramos 10 seg/vel 8. Añadimos la leche y programamos 2 min/100º/vel 1.\nMientras tanto, quitamos el film transparente al pescado, y lo colocamos en la fuente. Ponemos la patatas y los espárragos, y regamos con la salsa.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-burgos.es")
    expect(recipe.canonical_url).to eq("https://thermomix-burgos.es/maria-yolanda-garay-barajas/verduras-hortalizas-ensaladas/la-mejor-receta-de-la-historia-de-thermomix-merluza-rellena-con-ajada-de-gambas-y-salsa-de-piquillos")
    expect(recipe.site_name).to eq("Thermomix Burgos")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("YOLANDA GARAY BARAJAS")
    expect(recipe.description).to eq("Una receta que forma parte de la historia de Thermomix")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/aa534daeedfbe62fd292aee09b3d8e4e_e278722e75/aa534daeedfbe62fd292aee09b3d8e4e_e278722e75.jpg")
    expect(recipe.category).to eq("Verduras, hortalizas y ensaladas")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["LA MEJOR RECETA DE LA HISTORIA DE THERMOMIX: MERLUZA RELLENA CON AJADA DE GAMBAS Y SALSA DE PIQUILLOS", "Verduras", "hortalizas y ensaladas"])
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
