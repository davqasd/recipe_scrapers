# frozen_string_literal: true

RSpec.describe "thermomix-marbella.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_marbella", url: "https://thermomix-marbella.es/teresa-ortiz-de-villate/postres-y-dulces/tarta-de-torrija-y-arroz-con-leche") }

  it "reads the title" do
    expect(recipe.title).to eq("TARTA DE TORRIJA Y ARROZ CON LECHE")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "120g pan de torrijas",
      "3 huevos",
      "100 g de miel",
      "150 g de pedro jimenex",
      "50 g de aceite de oliva suave",
      "Para el arroz con leche",
      "750 g de leche entera",
      "100 g de arroz redondo",
      "1 piel de limón",
      "1 piel de naranja",
      "1 rama de canela",
      "1 pizca de sal",
      "1 sobre de cuajada",
      "100 g de azúcar"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 120.0, unit: "g", name: "pan de torrijas" },
      { amount: 3.0, unit: nil, name: "huevos" },
      { amount: 100.0, unit: "g", name: "miel" },
      { amount: 150.0, unit: "g", name: "pedro jimenex" },
      { amount: 50.0, unit: "g", name: "aceite de oliva suave" },
      { amount: nil, unit: nil, name: "Para el arroz con leche" },
      { amount: 750.0, unit: "g", name: "leche entera" },
      { amount: 100.0, unit: "g", name: "arroz redondo" },
      { amount: 1.0, unit: nil, name: "piel de limón" },
      { amount: 1.0, unit: nil, name: "piel de naranja" },
      { amount: 1.0, unit: "rama", name: "canela" },
      { amount: 1.0, unit: "pizca", name: "sal" },
      { amount: 1.0, unit: nil, name: "sobre de cuajada" },
      { amount: 100.0, unit: "g", name: "azúcar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Caramelizamos el molde con miel",
      "Añadimos todos los ingredientes en el vaso y batimos 20 segundos a velocidad 6",
      "Añadimos al molde caramelizado",
      "Y en el vaso limpio ponemos 500 g de agua y calentamos en modo hervidor",
      "Tapamos bien el molde con tapa o Albal y encima papel absorbente y programamos 39 minutos temperatura varoma velocidad 2",
      "Dejamos enfriar y pasamos hacer mientras el arroz con leche",
      "Añadimos en el vaso todos los ingredientes del arroz con leche y programamos 40 minutos temperatura 90 grados velocidad 1",
      "Luego añadimos el azúcar y programamos 5 minutos 90 grados vel 1",
      "Quitamos la piel de limón y naranja y la canela y añadimos encima de la torrija que tenemos en el molde y dejamos cuajar 2 horas pero a mí me gusta de 1 día para otro"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Caramelizamos el molde con miel\nAñadimos todos los ingredientes en el vaso y batimos 20 segundos a velocidad 6\nAñadimos al molde caramelizado\nY en el vaso limpio ponemos 500 g de agua y calentamos en modo hervidor\nTapamos bien el molde con tapa o Albal y encima papel absorbente y programamos 39 minutos temperatura varoma velocidad 2\nDejamos enfriar y pasamos hacer mientras el arroz con leche\nAñadimos en el vaso todos los ingredientes del arroz con leche y programamos 40 minutos temperatura 90 grados velocidad 1\nLuego añadimos el azúcar y programamos 5 minutos 90 grados vel 1\nQuitamos la piel de limón y naranja y la canela y añadimos encima de la torrija que tenemos en el molde y dejamos cuajar 2 horas pero a mí me gusta de 1 día para otro")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-marbella.es")
    expect(recipe.canonical_url).to eq("https://thermomix-marbella.es/teresa-ortiz-de-villate/postres-y-dulces/tarta-de-torrija-y-arroz-con-leche")
    expect(recipe.site_name).to eq("Thermomix Marbella")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("TERE ORTIZ DE VILLATE PINEDA")
    expect(recipe.description).to eq("Típico dulce especial de semana santa adaptado a la Thermomix en el cual se juntan dos postres especial de semana santa en uno solo , donde por un lado tenemos la torrija y por otro tenemos el arroz con leche uno en dos os lo recomiendo que lo probéis")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/ac9b6151a1f1d87f9466efa27d51fafe_f6fd05f169/ac9b6151a1f1d87f9466efa27d51fafe_f6fd05f169.jpg")
    expect(recipe.category).to eq("Postres y dulces")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["TARTA DE TORRIJA Y ARROZ CON LECHE", "Postres y dulces"])
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
