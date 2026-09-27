# frozen_string_literal: true

RSpec.describe "thermomix-albacete.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_albacete", url: "https://thermomix-albacete.es/lorenza-martinez-garcia/masas-panes-reposteria/pan-rustico-de-espelta-y-harina-de-fuerza-con-suero-de-leche-en-thermomix") }

  it "reads the title" do
    expect(recipe.title).to eq("PAN RUSTICO DE ESPELTA Y HARINA DE FUERZA CON SUERO DE LECHE EN THERMOMIX.")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "400 GRAMOS DE SUERO DE LECHE.",
      "400 GRAMOS DE HARINA DE FUERZA.",
      "7 GRAMOS DE LEVADURA SECA DE PANADERIA.",
      "200 GRAMOS DE HARINA DE ESPELTA.",
      "30 GRAMOS DE ACEITE DE OLIVA.",
      "10 GRAMOS DE SAL."
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 400.0, unit: "GRAMOS", name: "SUERO DE LECHE." },
      { amount: 400.0, unit: "GRAMOS", name: "HARINA DE FUERZA." },
      { amount: 7.0, unit: "GRAMOS", name: "LEVADURA SECA DE PANADERIA." },
      { amount: 200.0, unit: "GRAMOS", name: "HARINA DE ESPELTA." },
      { amount: 30.0, unit: "GRAMOS", name: "ACEITE DE OLIVA." },
      { amount: 10.0, unit: "GRAMOS", name: "SAL." }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "PONER EL SUERO DE LECHE EN EL VASO Y ATEMPERAR 3 MINUTOS 37º VELOCIDAD 1, ESTO AYUDARA A ACTIVAR LA LEVADURA SECA.",
      "AÑADIR LA LEVADURA SECA Y MEZCLAR 15 SEGUNDOS VELOCIDAD 3.",
      "AÑADIR LAS HARINAS, EL ACEITE Y LA SAL Y MEZCLAR 15 SEGUNDOS VELOCIDAD 6.",
      "SEGUIDAMENTE QUITAR EL CUBILETE PARA AIREAR LA MASA Y AMASAR PROGRAMANDO 5 MINUTOS.",
      "DEJAR LA MASA DENTRO DEL VASO CON EL CUBILETE PUESTO Y UN PAÑO LIMPIO Y SECO ENCIMA PARA FERMENTAR Y QUE DOBLE SU VOLUMEN ESTO SERA SOBRE UNA HORA Y MEDIA MAS O MENOS.",
      "SEGUIDAMENTE ECHAR LA MASA SOBRE LA ENCIMERA ENHARINADA, Y ENVOLVER UN POCO LA MASA, YO E SACADO DOS PANES SE PUEDE HACER BARRAS LO QUE MAS OS GUSTE, PONER UN PAPEL DE HORNO SOBRE LA BANDEJA Y DEJAR REPOSAR LOS PANES TAPADOS DE NUEVO ASTA QUE DOBLEN SU VOLUMEN SOBRE MEDIA HORA, SE LE HACEN UNOS CORTES CON UN CUCHILLO AFILADO Y UN POQUITO DE HARINA PARA QUE AL HORNEAR SE TUESTE UN POCO LA CORTEZA.",
      "PRECALENTAR EL HORNO A 220º CON VENTILACION.METER LA BANDEJA CON LOS PANES Y AL SER POSIBLE PODEIS PONER UN RECIPIENTE CON AGUA PARA CREAR HUMEDAD DENTRO, HORNEAR DURANTE 15 MINUTOS A ESTA TEMPERATURA, DESPUES BAJAR LA TEMPERATURA A 190º Y TERMINAR DE HORNEAR OTROS 20 O 25 MINUTOS ASTA QUE AL TOCARLO LA CORTEZA SUENE A HUECO.",
      "SACAR Y DEJAR ENFRIAR SOBRE UNA REJILLA."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("PONER EL SUERO DE LECHE EN EL VASO Y ATEMPERAR 3 MINUTOS 37º VELOCIDAD 1, ESTO AYUDARA A ACTIVAR LA LEVADURA SECA.\nAÑADIR LA LEVADURA SECA Y MEZCLAR 15 SEGUNDOS VELOCIDAD 3.\nAÑADIR LAS HARINAS, EL ACEITE Y LA SAL Y MEZCLAR 15 SEGUNDOS VELOCIDAD 6.\nSEGUIDAMENTE QUITAR EL CUBILETE PARA AIREAR LA MASA Y AMASAR PROGRAMANDO 5 MINUTOS.\nDEJAR LA MASA DENTRO DEL VASO CON EL CUBILETE PUESTO Y UN PAÑO LIMPIO Y SECO ENCIMA PARA FERMENTAR Y QUE DOBLE SU VOLUMEN ESTO SERA SOBRE UNA HORA Y MEDIA MAS O MENOS.\nSEGUIDAMENTE ECHAR LA MASA SOBRE LA ENCIMERA ENHARINADA, Y ENVOLVER UN POCO LA MASA, YO E SACADO DOS PANES SE PUEDE HACER BARRAS LO QUE MAS OS GUSTE, PONER UN PAPEL DE HORNO SOBRE LA BANDEJA Y DEJAR REPOSAR LOS PANES TAPADOS DE NUEVO ASTA QUE DOBLEN SU VOLUMEN SOBRE MEDIA HORA, SE LE HACEN UNOS CORTES CON UN CUCHILLO AFILADO Y UN POQUITO DE HARINA PARA QUE AL HORNEAR SE TUESTE UN POCO LA CORTEZA.\nPRECALENTAR EL HORNO A 220º CON VENTILACION.METER LA BANDEJA CON LOS PANES Y AL SER POSIBLE PODEIS PONER UN RECIPIENTE CON AGUA PARA CREAR HUMEDAD DENTRO, HORNEAR DURANTE 15 MINUTOS A ESTA TEMPERATURA, DESPUES BAJAR LA TEMPERATURA A 190º Y TERMINAR DE HORNEAR OTROS 20 O 25 MINUTOS ASTA QUE AL TOCARLO LA CORTEZA SUENE A HUECO.\nSACAR Y DEJAR ENFRIAR SOBRE UNA REJILLA.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-albacete.es")
    expect(recipe.canonical_url).to eq("https://thermomix-albacete.es/lorenza-martinez-garcia/masas-panes-reposteria/pan-rustico-de-espelta-y-harina-de-fuerza-con-suero-de-leche-en-thermomix")
    expect(recipe.site_name).to eq("Thermomix Albacete")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("LOREN MARTINEZ GARCIA")
    expect(recipe.description).to eq("PAN RUSTICO DE ESPELTA Y HARINA DE FUERZA CON SUERO DE LECHE EN THERMOMIX., una receta de Masas, panes y repostería, elaborada por LOREN MARTINEZ GARCIA. Descubre las mejores recetas de Blogosfera Thermomix Albacete")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/acf67b0f03bf1a5801878e88e5aa65e9_31ada32568/acf67b0f03bf1a5801878e88e5aa65e9_31ada32568.jpg")
    expect(recipe.category).to eq("Masas, panes y repostería")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("15 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["PAN RUSTICO DE ESPELTA Y HARINA DE FUERZA CON SUERO DE LECHE EN THERMOMIX.", "Masas", "panes y repostería"])
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
