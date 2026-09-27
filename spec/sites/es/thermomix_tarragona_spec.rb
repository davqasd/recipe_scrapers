# frozen_string_literal: true

RSpec.describe "thermomix-tarragona.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_tarragona", url: "https://thermomix-tarragona.es/raquel-elez-toledano-1/carnes-y-aves/mi-receta-de-10-en-cookidoo") }

  it "reads the title" do
    expect(recipe.title).to eq("Mi receta de 10 en Cookidoo")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 kg de carne de ternera cortada finita",
      "30 g de setas deshidratas puestas en remojo",
      "100 g de cebolla",
      "50 g de aceite",
      "50 g de brandy o coñac",
      "400 g de agua",
      "1 cucharadita de bovril ( concentrado de carne )",
      "sal y pimienta al gusto",
      "50 g de aceite de oliva",
      "2 dientes de ajo",
      "2 rebanadas de pan seco (o biscotes)",
      "25 g de avellanas o almendras crudas",
      "1 cucharada de pimiento choricero o ñora triturado"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "kg", name: "carne de ternera cortada finita" },
      { amount: 30.0, unit: "g", name: "setas deshidratas puestas en remojo" },
      { amount: 100.0, unit: "g", name: "cebolla" },
      { amount: 50.0, unit: "g", name: "aceite" },
      { amount: 50.0, unit: "g", name: "brandy o coñac" },
      { amount: 400.0, unit: "g", name: "agua" },
      { amount: 1.0, unit: "cucharadita", name: "bovril" },
      { amount: nil, unit: nil, name: "sal y pimienta al gusto" },
      { amount: 50.0, unit: "g", name: "aceite de oliva" },
      { amount: 2.0, unit: "dientes", name: "ajo" },
      { amount: 2.0, unit: nil, name: "rebanadas de pan seco" },
      { amount: 25.0, unit: "g", name: "avellanas o almendras crudas" },
      { amount: 1.0, unit: "cucharada", name: "pimiento choricero o ñora triturado" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preparación : Picada : ponemos el aceite a calentar 5 min /temp 120º /vel 1 A continuación agregamos 1 ajo cortado a cuartos , el pan cortado a daditos y las avellanas o almendras y programamos 7 min / temp 120º/ vel cuchara Agregamos el pimiento o ñora y programamos 3 min / temp 120o / vel cuchara. Incorporar 1 ajo crudo y triturar la picada unos 1 min / vel progresiva de 5-10 y reservar a un bol.",
      "Sofrito : Sin lavar el vaso ponemos la cebolla y troceamos 5 seg / vel 4 Bajamos con la espátula e incorporamos el aceite y sofreir 7 min / temp 120 º / vel cuchara Agregamos el brandy y rehogamos 2 min / temp 120 o / vel cuchara destapado para que evapore el alcohol Incorporamos la picada , el agua , el bovril y trituramos 5 seg de 5 -10 progresivo Ponemos la mariposa en las cuchillas Añadimos al vaso los filetes de ternera ya salpimentados y programamos 30 min/ temp varoma / vel cuchara /giro inverso Añadimos las setas y programamos 15 min / temp varoma/ vel cuchara / giro inverso",
      "NOTA : Cuando agregamos la carne podemos poner el recipiente varoma y poner verduritas de guarnición"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preparación : Picada : ponemos el aceite a calentar 5 min /temp 120º /vel 1 A continuación agregamos 1 ajo cortado a cuartos , el pan cortado a daditos y las avellanas o almendras y programamos 7 min / temp 120º/ vel cuchara Agregamos el pimiento o ñora y programamos 3 min / temp 120o / vel cuchara. Incorporar 1 ajo crudo y triturar la picada unos 1 min / vel progresiva de 5-10 y reservar a un bol.\nSofrito : Sin lavar el vaso ponemos la cebolla y troceamos 5 seg / vel 4 Bajamos con la espátula e incorporamos el aceite y sofreir 7 min / temp 120 º / vel cuchara Agregamos el brandy y rehogamos 2 min / temp 120 o / vel cuchara destapado para que evapore el alcohol Incorporamos la picada , el agua , el bovril y trituramos 5 seg de 5 -10 progresivo Ponemos la mariposa en las cuchillas Añadimos al vaso los filetes de ternera ya salpimentados y programamos 30 min/ temp varoma / vel cuchara /giro inverso Añadimos las setas y programamos 15 min / temp varoma/ vel cuchara / giro inverso\nNOTA : Cuando agregamos la carne podemos poner el recipiente varoma y poner verduritas de guarnición")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-tarragona.es")
    expect(recipe.canonical_url).to eq("https://thermomix-tarragona.es/raquel-elez-toledano-1/carnes-y-aves/mi-receta-de-10-en-cookidoo")
    expect(recipe.site_name).to eq("Thermomix Tarragona")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("RAQUEL ELEZ TOLEDANO")
    expect(recipe.description).to eq("Mi receta de 10 en Cookidoo")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/be4333e4323ac6afab6a3ab1c9b0420e_119abd491b/be4333e4323ac6afab6a3ab1c9b0420e_119abd491b.jpg")
    expect(recipe.category).to eq("Carnes y aves")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("0 servings")
    expect(recipe.total_time).to eq(1)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Mi receta de 10 en Cookidoo", "Carnes y aves"])
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
