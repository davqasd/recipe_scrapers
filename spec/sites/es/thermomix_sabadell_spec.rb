# frozen_string_literal: true

RSpec.describe "thermomix-sabadell.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_sabadell", url: "https://thermomix-sabadell.es/maribel-osete/carnes-y-aves/fricando-con-thermomix-la-cocina-de-maribel") }

  it "reads the title" do
    expect(recipe.title).to eq("Fricandó con Thermomix® La cocina de Maribel")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 ñoras",
      "50gr Avellana tostada",
      "50 gr Almendra tostada",
      "3 nueces",
      "un puñado de piñones",
      "4-5 dientes de Ajo",
      "una ramita de perejil (solo las hojas)",
      "25 g de setas deshidratadas",
      "350 g de agua caliente",
      "300 g de cebolla cortada en cuartos",
      "2-3 dientes de ajo",
      "100 g de aceite de oliva virgen extra",
      "100 g de tomate triturado natural o en conserva",
      "50 g de harina",
      "1000g/1250 g de filete de ternera( de la culata de la espaldilla o llana ) cortados en dos o tres trozos.",
      "50gr de picada",
      "100 g de brandy o Vi ranci"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: nil, name: "ñoras" },
      { amount: 50.0, unit: "gr", name: "Avellana tostada" },
      { amount: 50.0, unit: "gr", name: "Almendra tostada" },
      { amount: 3.0, unit: nil, name: "nueces" },
      { amount: nil, unit: nil, name: "un puñado de piñones" },
      { amount: 4.0, unit: "dientes", name: "Ajo" },
      { amount: nil, unit: nil, name: "una ramita de perejil" },
      { amount: 25.0, unit: "g", name: "setas deshidratadas" },
      { amount: 350.0, unit: "g", name: "agua caliente" },
      { amount: 300.0, unit: "g", name: "cebolla cortada en cuartos" },
      { amount: 2.0, unit: "dientes", name: "ajo" },
      { amount: 100.0, unit: "g", name: "aceite de oliva virgen extra" },
      { amount: 100.0, unit: "g", name: "tomate triturado natural o en conserva" },
      { amount: 50.0, unit: "g", name: "harina" },
      { amount: 1000.0, unit: "g", name: "filete de ternera cortados en dos o tres trozos." },
      { amount: 50.0, unit: "gr", name: "picada" },
      { amount: 100.0, unit: "g", name: "brandy o Vi ranci" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Poner en el vaso limpio y seco las ñoras y pulverizar 5 segundos velocidad 6",
      "Añadir 50 gr Almendra tostada50 gr , 50gr Avellana,3 nueces, un puñado de piñones,",
      "7 segundos en velocidad 6",
      "Añadir 4-5 dientes de Ajo y una ramita de perejil (solo las hojas)",
      "7 segundos vel 6 repetir la operación si fuese necesario, bajando los restos de las paredes. Con estos ingredientes obtendremos 200 g de picada. Utilizamos 50 g para preparar fricandó y guardamos el resto en bolsitas individuales de 50gr para otras veces.Poner en un bol las setas con el agua para hidratarlas durante 15 minutos.",
      "Poner en el vaso la cebolla, los ajos y el aceite, y programar 3 segundos velocidad 5",
      "sofreimos durante 10m temp 120 vel cuchara",
      "añadimos 100gr de tomate salpimentar",
      "sofreir 5 min temp 120 vel cucharamientras tanto salpimentar y enharinar la carne.",
      "añadimos la carne al vaso filete a filete y programamos 2 min 120 giro inverso, vel cuchara",
      "Añadimos la picada, las setas con el agua de remojarlas y el brandy, programamos 30 minutos modo vapor , giro a la izquierda, velocidad cuchara.",
      "volcar en cazuela de barro y servir acompañado de la guarnición,m yo he puesto arroz en vasitos. Bon profit !! Sugerencia : En el paso 6 tenemos 30 minutos temperatura Varoma, con lo cual podremos aprovechar para hacer nuestra guarnición, en el recipiente varoma, ya bien sea arroz, verduras, patatas... deja volar tu imaginación."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Poner en el vaso limpio y seco las ñoras y pulverizar 5 segundos velocidad 6\nAñadir 50 gr Almendra tostada50 gr , 50gr Avellana,3 nueces, un puñado de piñones,\n7 segundos en velocidad 6\nAñadir 4-5 dientes de Ajo y una ramita de perejil (solo las hojas)\n7 segundos vel 6 repetir la operación si fuese necesario, bajando los restos de las paredes. Con estos ingredientes obtendremos 200 g de picada. Utilizamos 50 g para preparar fricandó y guardamos el resto en bolsitas individuales de 50gr para otras veces.Poner en un bol las setas con el agua para hidratarlas durante 15 minutos.\nPoner en el vaso la cebolla, los ajos y el aceite, y programar 3 segundos velocidad 5\nsofreimos durante 10m temp 120 vel cuchara\nañadimos 100gr de tomate salpimentar\nsofreir 5 min temp 120 vel cucharamientras tanto salpimentar y enharinar la carne.\nañadimos la carne al vaso filete a filete y programamos 2 min 120 giro inverso, vel cuchara\nAñadimos la picada, las setas con el agua de remojarlas y el brandy, programamos 30 minutos modo vapor , giro a la izquierda, velocidad cuchara.\nvolcar en cazuela de barro y servir acompañado de la guarnición,m yo he puesto arroz en vasitos. Bon profit !! Sugerencia : En el paso 6 tenemos 30 minutos temperatura Varoma, con lo cual podremos aprovechar para hacer nuestra guarnición, en el recipiente varoma, ya bien sea arroz, verduras, patatas... deja volar tu imaginación.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-sabadell.es")
    expect(recipe.canonical_url).to eq("https://thermomix-sabadell.es/maribel-osete/carnes-y-aves/fricando-con-thermomix-la-cocina-de-maribel")
    expect(recipe.site_name).to eq("Thermomix Sabadell")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("MARIBEL OSETE GUERRERO")
    expect(recipe.description).to eq("Sugerencia : En el paso 11 tenemos 30 minutos temperatura Varoma, con lo cual, podremos aprovechar para hacer nuestra guarnición, en el recipiente varoma, ya bien sea arroz, verduras, patatas... deja volar tu imaginación.")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/5d17f225d64e73a532b799c66bdb4c3e_8ba3eacc79/5d17f225d64e73a532b799c66bdb4c3e_8ba3eacc79.jpg")
    expect(recipe.category).to eq("Carnes y aves")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(1)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Fricandó con Thermomix® La cocina de Maribel", "Carnes y aves"])
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
