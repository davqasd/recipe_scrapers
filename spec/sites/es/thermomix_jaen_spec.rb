# frozen_string_literal: true

RSpec.describe "thermomix-jaen.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_jaen", url: "https://thermomix-jaen.es/francisca-ruiz-vico/legumbres-y-platos-de-cuchara/potaje-de-garbanzos-con-pulpo-y-langostinos") }

  it "reads the title" do
    expect(recipe.title).to eq("POTAJE DE GARBANZOS CON PULPO Y LANGOSTINOS")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "800 g de langostinos crudos los pelamos y reservamos los cuerpos.",
      "Un puerro, cortado a trozos",
      "25 g de aceite de oliva",
      "1 l de agua",
      "1 cucharadita de sal",
      "3 Ajos pelados",
      "35 g de aceite de oliva",
      "200 g de cebolla en cuartos Y 70 g de zanahoria",
      "50 g de pimiento verde y 50g. De pimiento rojo troceados",
      "100 g de tomate natural triturado",
      "Una Pizca de comino molido. Media cucharadita de pimentón dulce, Una pizca de pimentón picante, Dos. Hojas de laurel.",
      "200 g de pulpo cocido, cortado en rodajas",
      "Una cucharadita de concentrado casero o en su lugar, sal al gusto",
      "100 g de vino blanco Y una cucharadita de concentrado de ñoras",
      "800 g de garbanzos cocidos",
      "500 g de langostinos pelados reservados",
      "400 g de fumet de langostinos"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 800.0, unit: "g", name: "langostinos crudos los pelamos y reservamos los cuerpos." },
      { amount: nil, unit: nil, name: "Un puerro, cortado a trozos" },
      { amount: 25.0, unit: "g", name: "aceite de oliva" },
      { amount: 1.0, unit: "l", name: "agua" },
      { amount: 1.0, unit: "cucharadita", name: "sal" },
      { amount: 3.0, unit: nil, name: "Ajos pelados" },
      { amount: 35.0, unit: "g", name: "aceite de oliva" },
      { amount: 200.0, unit: "g", name: "cebolla en cuartos Y 70 g de zanahoria" },
      { amount: 50.0, unit: "g", name: "pimiento verde y 50g. De pimiento rojo troceados" },
      { amount: 100.0, unit: "g", name: "tomate natural triturado" },
      { amount: nil, unit: nil, name: "Una Pizca de comino molido. Media cucharadita de pimentón dulce, Una pizca de pimentón picante, Dos. Hojas de laurel." },
      { amount: 200.0, unit: "g", name: "pulpo cocido, cortado en rodajas" },
      { amount: nil, unit: nil, name: "Una cucharadita de concentrado casero o en su lugar, sal al gusto" },
      { amount: 100.0, unit: "g", name: "vino blanco Y una cucharadita de concentrado de ñoras" },
      { amount: 800.0, unit: "g", name: "garbanzos cocidos" },
      { amount: 500.0, unit: "g", name: "langostinos pelados reservados" },
      { amount: 400.0, unit: "g", name: "fumet de langostinos" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Para hacer el fumet lo primero que hacemos es poner en el vaso las cáscaras de los langostinos 1 puerro cortado en trozos ,25 g de aceite de oliva y rehogamos 3minutos 120° velocidad uno",
      "Incorporamos 1 l de agua y programamos 8 minutos, 100° velocidad 1.Una vez pasado el tiempo colamos el fumét y reservamos.",
      "Ponemos en el vaso tres ajos y 35 g de aceite de oliva, picamos los ajos durante 15 segundos velocidad 5 y posteriormente sofreímos 8 minutos 100° velocidad cuchara",
      "Añadimos junto con el sofrito 200 g de cebolla en cuartos, los 70 g de zanahoria y los 50 g de pimiento verde y 50 g.pimiento rojo troceados,100 g de tomate natural triturado, una pizca de comino molido y una cucharada de concentrado casero o en su lugar, sal al gusto, media cucharadita de pimentón dulce y una pizca de pimentón picante todo lo trituramos durante 15 segundos a velocidad 5 sofreímos 10 minutos 100°, giro a la izquierda velocidad cuchara.",
      "Junto con el sofrito, añadimos los 200 g de pulpo cocido, cortado en rodajas, las dos hojas de laurel, 100 g de vino blanco y 1 cucharadita de concentrado de ñoras,800 g de garbanzos cocidos y 400 g de fumet reservado y programamos 15 minutos 100° giro a la izquierda velocidad cuchara.",
      "Por último, añadimos al vaso los 500 g de langostinos pelados y programamos 5 minutos 100° ,giro a la izquierda yvelocidad cuchara"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Para hacer el fumet lo primero que hacemos es poner en el vaso las cáscaras de los langostinos 1 puerro cortado en trozos ,25 g de aceite de oliva y rehogamos 3minutos 120° velocidad uno\nIncorporamos 1 l de agua y programamos 8 minutos, 100° velocidad 1.Una vez pasado el tiempo colamos el fumét y reservamos.\nPonemos en el vaso tres ajos y 35 g de aceite de oliva, picamos los ajos durante 15 segundos velocidad 5 y posteriormente sofreímos 8 minutos 100° velocidad cuchara\nAñadimos junto con el sofrito 200 g de cebolla en cuartos, los 70 g de zanahoria y los 50 g de pimiento verde y 50 g.pimiento rojo troceados,100 g de tomate natural triturado, una pizca de comino molido y una cucharada de concentrado casero o en su lugar, sal al gusto, media cucharadita de pimentón dulce y una pizca de pimentón picante todo lo trituramos durante 15 segundos a velocidad 5 sofreímos 10 minutos 100°, giro a la izquierda velocidad cuchara.\nJunto con el sofrito, añadimos los 200 g de pulpo cocido, cortado en rodajas, las dos hojas de laurel, 100 g de vino blanco y 1 cucharadita de concentrado de ñoras,800 g de garbanzos cocidos y 400 g de fumet reservado y programamos 15 minutos 100° giro a la izquierda velocidad cuchara.\nPor último, añadimos al vaso los 500 g de langostinos pelados y programamos 5 minutos 100° ,giro a la izquierda yvelocidad cuchara")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-jaen.es")
    expect(recipe.canonical_url).to eq("https://thermomix-jaen.es/francisca-ruiz-vico/legumbres-y-platos-de-cuchara/potaje-de-garbanzos-con-pulpo-y-langostinos")
    expect(recipe.site_name).to eq("Thermomix Jaén")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("FRANCISCA RUIZ VICO")
    expect(recipe.description).to eq("POTAJE DE GARBANZOS CON PULPO Y LANGOSTINOS, una receta de Legumbres y platos de cuchara, elaborada por FRANCISCA RUIZ VICO. Descubre las mejores recetas de Blogosfera Thermomix Jaén")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/016a57ec3189fd09ef5ed499ad253616_8d4b9cd73d/016a57ec3189fd09ef5ed499ad253616_8d4b9cd73d.jpg")
    expect(recipe.category).to eq("Legumbres y platos de cuchara")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["POTAJE DE GARBANZOS CON PULPO Y LANGOSTINOS", "Legumbres y platos de cuchara"])
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
