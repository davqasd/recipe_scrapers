# frozen_string_literal: true

RSpec.describe "thermomix-cadiz.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_cadiz", url: "https://thermomix-cadiz.es/gloria-rodriguez/pescados-y-mariscos/ensaladilla-de-langostinos-al-ajillo-y-pulpo-a-la-gallega") }

  it "reads the title" do
    expect(recipe.title).to eq("Ensaladilla de langostinos al ajillo y pulpo a la gallega")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "800gramos de patatas para cocer",
      "3 pata de pulpo ya cocido",
      "4 huevos",
      "15 a 20 langostinos",
      "8 dientes de ajo",
      "150 gramos de aove y 200 de girasol .",
      "pimenton dulce o picante (al gusto)",
      "sal"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 800.0, unit: "gramos", name: "patatas para cocer" },
      { amount: 3.0, unit: nil, name: "pata de pulpo ya cocido" },
      { amount: 4.0, unit: nil, name: "huevos" },
      { amount: 15.0, unit: nil, name: "langostinos" },
      { amount: 8.0, unit: "dientes", name: "ajo" },
      { amount: 150.0, unit: "gramos", name: "aove y 200 de girasol." },
      { amount: nil, unit: nil, name: "pimenton dulce o picante" },
      { amount: nil, unit: nil, name: "sal" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pelar las patatas ,trocear como para guisar y poner en el varoma e incorporamos los huevos cubierto con fil cada uno.Ponemos 1 litro de agua en el vaso 45 min/varoma/vel1.Unas vez terminado el tiempo comprobamos q las patatas estan tiernas ,si es asi ponemos en un bol y le añadimos 2 o 3 pellizco de sal y picamos o aplastamos con un tenedor .Los huevos los pelamos y los picamos.Vaciar el vaso y enjuagar.",
      "Ponga en el vaso el aove y los dientes de ajo y trocee 3seg/vel5.Con la espatula,baje el ajo hacia el fondo del vaso.Sin poner el cubilete,sofria 5min/120º/vel cuchara.Incorpore los langostinos y pellizco de sal,sin poner cubiete,rehogue 3 min/120º/vel cuchara.Cuando se hagan,retire y reservalas.En el mismo aove incorporamos las cascaras/cabezas de los langostinos extrayendo todos los jugos,cuela y deja enfriar.",
      "Una vez frio el aceite preparamos la mayonesa con el aove aromatizado de los langostinos .Ponga en el vaso los huevos,2 o 3 pellizco de sal.Mezcle 1min 40 seg/vel 4 y ,con la maquina en marcha ,vierta el aceite lentamente sobre la tapa,dejando que caiga en un hilo muy fino alrededor del cibulete para lograruna emulsion.Primero incorporamos el aove aromatido ,luego el resto del aceite.Vierta la mayonesa en un bol y reserve.",
      "En un bowl mezclamos las patatas ,los huevos,los langostinos ya picados y pulpo troceado(tienes que dejar unos cuantos troceados a laminas para el emplatado),un poquito de sal y añadimos la mayonesa casera.Para el emplatado poner la ensaladilla en un aro de emplatar (el que tengas),cubre con rodajas de pulpo ,el pimeton,sal y chorrito de aove."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pelar las patatas ,trocear como para guisar y poner en el varoma e incorporamos los huevos cubierto con fil cada uno.Ponemos 1 litro de agua en el vaso 45 min/varoma/vel1.Unas vez terminado el tiempo comprobamos q las patatas estan tiernas ,si es asi ponemos en un bol y le añadimos 2 o 3 pellizco de sal y picamos o aplastamos con un tenedor .Los huevos los pelamos y los picamos.Vaciar el vaso y enjuagar.\nPonga en el vaso el aove y los dientes de ajo y trocee 3seg/vel5.Con la espatula,baje el ajo hacia el fondo del vaso.Sin poner el cubilete,sofria 5min/120º/vel cuchara.Incorpore los langostinos y pellizco de sal,sin poner cubiete,rehogue 3 min/120º/vel cuchara.Cuando se hagan,retire y reservalas.En el mismo aove incorporamos las cascaras/cabezas de los langostinos extrayendo todos los jugos,cuela y deja enfriar.\nUna vez frio el aceite preparamos la mayonesa con el aove aromatizado de los langostinos .Ponga en el vaso los huevos,2 o 3 pellizco de sal.Mezcle 1min 40 seg/vel 4 y ,con la maquina en marcha ,vierta el aceite lentamente sobre la tapa,dejando que caiga en un hilo muy fino alrededor del cibulete para lograruna emulsion.Primero incorporamos el aove aromatido ,luego el resto del aceite.Vierta la mayonesa en un bol y reserve.\nEn un bowl mezclamos las patatas ,los huevos,los langostinos ya picados y pulpo troceado(tienes que dejar unos cuantos troceados a laminas para el emplatado),un poquito de sal y añadimos la mayonesa casera.Para el emplatado poner la ensaladilla en un aro de emplatar (el que tengas),cubre con rodajas de pulpo ,el pimeton,sal y chorrito de aove.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-cadiz.es")
    expect(recipe.canonical_url).to eq("https://thermomix-cadiz.es/gloria-rodriguez/pescados-y-mariscos/ensaladilla-de-langostinos-al-ajillo-y-pulpo-a-la-gallega")
    expect(recipe.site_name).to eq("Thermomix Cádiz")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("GLORIA M. RODRIGUEZ CAMACHO")
    expect(recipe.description).to eq("Ensaladilla de langostinos al ajillo y pulpo a la gallega, una receta de Pescados y mariscos, elaborada por GLORIA M. RODRIGUEZ CAMACHO. Descubre las mejores recetas de Blogosfera Thermomix Cádiz")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/691c290e70f22e61849b3a07c77983c2_644f3a207a/691c290e70f22e61849b3a07c77983c2_644f3a207a.jpg")
    expect(recipe.category).to eq("Pescados y mariscos")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(1)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Ensaladilla de langostinos al ajillo y pulpo a la gallega", "Pescados y mariscos"])
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
