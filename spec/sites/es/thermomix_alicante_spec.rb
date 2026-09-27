# frozen_string_literal: true

RSpec.describe "thermomix-alicante.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_alicante", url: "https://thermomix-alicante.es/virtudes-amoros-milan/carnes-y-aves/otono-en-tu-plato-solomillo-al-horno-con-batata-y-tomates-cherrys-confitados-una-combinacion-perfecta-para-fortalecer-tus-defensas") }

  it "reads the title" do
    expect(recipe.title).to eq("OTOÑO EN TU PLATO, SOLOMILLO AL HORNO CON BATATA Y TOMATES CHERRYS CONFITADOS, UNA COMBINACIÓN PERFECTA PARA FORTALECER TUS DEFENSAS.")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "Para los cherrys confitados: 500 g de cherrys de diferentes tipos y colores 200 ml de aceite de oliva virgen extra",
      "2 ramitas de albahaca 2 ramitas de tomillo",
      "1 cabeza de ajos cortada por la mitad Una pizca de sal",
      "Para la batata asada: 1 kilo de batata -carne interior amarilla- o 3 unidades Aceite de oliva virgen extra Sal",
      "Para la carne: 1 solomillo de cerdo por cada 2 persona",
      "Un chorro de aceite Sal y pimienta al gusto",
      "La vinagreta: 50-60 g de aceite de albahaca de los tomates confitados o aceite de oliva virgen extra",
      "Perejil picadito u hojas de albahaca picaditas 2 ajos picaditos o prensados -con el prensa ajos- 10-15 g de vinagre al gusto o zumo de limón"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "Para los cherrys confitados: 500 g de cherrys de diferentes tipos y colores 200 ml de aceite de oliva virgen extra" },
      { amount: 2.0, unit: "ramitas", name: "albahaca 2 ramitas de tomillo" },
      { amount: 1.0, unit: nil, name: "cabeza de ajos cortada por la mitad Una pizca de sal" },
      { amount: nil, unit: nil, name: "Para la batata asada: 1 kilo de batata -carne interior amarilla- o 3 unidades Aceite de oliva virgen extra Sal" },
      { amount: nil, unit: nil, name: "Para la carne: 1 solomillo de cerdo por cada 2 persona" },
      { amount: nil, unit: nil, name: "Un chorro de aceite Sal y pimienta al gusto" },
      { amount: 50.0, unit: "g", name: "La vinagreta, de aceite de albahaca de los tomates confitados o aceite de oliva virgen extra" },
      { amount: nil, unit: nil, name: "Perejil picadito u hojas de albahaca picaditas 2 ajos picaditos o prensados -con el prensa ajos- 10-15 g de vinagre al gusto o zumo de limón" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Empezaremos preparando los Cherrys que es lo que más tarda. Pon en una tarterita los tomates cherry lavaditos y secos, las ramitas de tomillo, albahaca, la cabeza de ajos por la mitad y cubre con aceite hasta la mitad de los tomates. No es necesario que esté sumergidos en aceite, luego verás que merman. Calienta el aceite y cuando esté caliente baja la temperatura a 1,5-2 en tu placa de inducción para que se vayan cocinando a unos 70-80ºC durante 1 hora y tapados. Acabado el tiempo, apaga el fuego y deja que enfríen. Listo. En Thermomix® coloca en cubrecuchillas y coloca lo tomates y 600 g de aceite y cocina 1 hora a 70-80ºC, giro a la izquierda y velocidad cuchara.",
      "Para la batata asada: Lava y seca las batatas y corta por la mitad. Precalienta el horno a 200ºC con ventilador, pon las batatas sobre la bandeja con la piel hacía arriba, riega con un chorro de aceite y sal y hornea 35 minutos. Pasado el tiempo, retira la bandeja y en cuanto puedas pela las batatas. Pasa a un cuenco la carne anaranjada de las batatas y con un tenedor aplasta para obtener un puré, añade un chorro de aceite, sal y pimienta, mezcla y reserva. En el momento de servir con 2 cucharas harás la forma de \"quenelle\" -tipo croqueta francesa de 3 caras- para servir y que quede bonita -o al gusto",
      "La carne: Únta la carne con aceite, sal y pimienta y sella en una sartén durante unos 10 minutos. Luego hornea 18 minutos a 140ºC con calor arriba. Retira y deja reposar cubierta de papel albal durante 5-10 minutos y corta al gusto.",
      "La vinagreta de albahaca: Pon en un vaso todos los ingrediente y remueve. Reserva",
      "Montaje del plato: Coloca la carne partida en un plato con las quenelle de puré de batata, los cherrys confitados y riega con la vinagreta. Listo"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Empezaremos preparando los Cherrys que es lo que más tarda. Pon en una tarterita los tomates cherry lavaditos y secos, las ramitas de tomillo, albahaca, la cabeza de ajos por la mitad y cubre con aceite hasta la mitad de los tomates. No es necesario que esté sumergidos en aceite, luego verás que merman. Calienta el aceite y cuando esté caliente baja la temperatura a 1,5-2 en tu placa de inducción para que se vayan cocinando a unos 70-80ºC durante 1 hora y tapados. Acabado el tiempo, apaga el fuego y deja que enfríen. Listo. En Thermomix® coloca en cubrecuchillas y coloca lo tomates y 600 g de aceite y cocina 1 hora a 70-80ºC, giro a la izquierda y velocidad cuchara.\nPara la batata asada: Lava y seca las batatas y corta por la mitad. Precalienta el horno a 200ºC con ventilador, pon las batatas sobre la bandeja con la piel hacía arriba, riega con un chorro de aceite y sal y hornea 35 minutos. Pasado el tiempo, retira la bandeja y en cuanto puedas pela las batatas. Pasa a un cuenco la carne anaranjada de las batatas y con un tenedor aplasta para obtener un puré, añade un chorro de aceite, sal y pimienta, mezcla y reserva. En el momento de servir con 2 cucharas harás la forma de \"quenelle\" -tipo croqueta francesa de 3 caras- para servir y que quede bonita -o al gusto\nLa carne: Únta la carne con aceite, sal y pimienta y sella en una sartén durante unos 10 minutos. Luego hornea 18 minutos a 140ºC con calor arriba. Retira y deja reposar cubierta de papel albal durante 5-10 minutos y corta al gusto.\nLa vinagreta de albahaca: Pon en un vaso todos los ingrediente y remueve. Reserva\nMontaje del plato: Coloca la carne partida en un plato con las quenelle de puré de batata, los cherrys confitados y riega con la vinagreta. Listo")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-alicante.es")
    expect(recipe.canonical_url).to eq("https://thermomix-alicante.es/virtudes-amoros-milan/carnes-y-aves/otono-en-tu-plato-solomillo-al-horno-con-batata-y-tomates-cherrys-confitados-una-combinacion-perfecta-para-fortalecer-tus-defensas")
    expect(recipe.site_name).to eq("Thermomix Alicante")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("VIRTUDES AMOROS MILAN")
    expect(recipe.description).to eq("OTOÑO EN TU PLATO, SOLOMILLO AL HORNO CON BATATA Y TOMATES CHERRYS CONFITADOS, UNA COMBINACIÓN PERFECTA PARA FORTALECER TUS DEFENSAS., una receta de Carnes y aves, elaborada por VIRTUDES AMOROS MILAN. Descubre las mejores recetas de Blogosfera Thermomix Alicante")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/64716ac62e20799a326a532d22779c64_b0ebf2bb99/64716ac62e20799a326a532d22779c64_b0ebf2bb99.jpg")
    expect(recipe.category).to eq("Carnes y aves")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(1)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["OTOÑO EN TU PLATO", "SOLOMILLO AL HORNO CON BATATA Y TOMATES CHERRYS CONFITADOS", "UNA COMBINACIÓN PERFECTA PARA FORTALECER TUS DEFENSAS.", "Carnes y aves"])
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
