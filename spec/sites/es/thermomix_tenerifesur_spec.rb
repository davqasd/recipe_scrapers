# frozen_string_literal: true

RSpec.describe "thermomix-tenerifesur.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_tenerifesur", url: "https://thermomix-tenerifesur.es/frank-dorta/postres-y-dulces/recetas-contra-el-calor-lemon-meringue-pie") }

  it "reads the title" do
    expect(recipe.title).to eq("Recetas contra el calor: Lemon Meringue Pie")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "100g azucar",
      "200g mantequilla fria en trozos",
      "370g de harina común",
      "1 huevo",
      "1 pellizco de sal",
      "1 cucharadita de vainilla liquida",
      "165g de agua",
      "165g de zumo de limón recién exprimido",
      "6 yemas de huevo ( reservar las claras)",
      "430g de azucar",
      "80g de mantequilla",
      "100g de maicena",
      "Mitad o toda la cantidad de las claras reservadas",
      "el doble de cantidad de azucar que las claras"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 100.0, unit: "g", name: "azucar" },
      { amount: 200.0, unit: "g", name: "mantequilla fria en trozos" },
      { amount: 370.0, unit: "g", name: "harina común" },
      { amount: 1.0, unit: nil, name: "huevo" },
      { amount: 1.0, unit: nil, name: "pellizco de sal" },
      { amount: 1.0, unit: "cucharadita", name: "vainilla liquida" },
      { amount: 165.0, unit: "g", name: "agua" },
      { amount: 165.0, unit: "g", name: "zumo de limón recién exprimido" },
      { amount: 6.0, unit: nil, name: "yemas de huevo" },
      { amount: 430.0, unit: "g", name: "azucar" },
      { amount: 80.0, unit: "g", name: "mantequilla" },
      { amount: 100.0, unit: "g", name: "maicena" },
      { amount: nil, unit: nil, name: "Mitad o toda la cantidad de las claras reservadas" },
      { amount: nil, unit: nil, name: "el doble de cantidad de azucar que las claras" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Masa SabléPonemos en el vaso el azucar y programamos 15 segundos / velocidad 10.Añadimos la mantequilla, la harina, el huevo, la sal y la vainilla y mezclamos 20 segundos / velocidad 5. Retiramos la masa del vaso envolvemos en film transparente y reservamos en la nevera mientras realizamos el curd de limón.",
      "Curd de limónAñadimos al vaso el agua, el zumo de limón, las yemas de huevo, el azucar, la mantequilla y la maicena. Programamos el Modo ESPESAR seleccionando 100ºC. Mientras precalentamos el horno a 180ºC.",
      "Preparación del PieEstiramos la masa reservada entre dos papeles de horno y rellenamos un molde para pie que previamente tendremos engrasado con mantequilla o spray antihaderente. Pinchamos toda la masa con un tenedor para evitar que en el horneado se infle.Horneamos durante 25 minutos.Lavamos bien nuestro vaso y lo dejamos totalmente seco para comenzar con el merengue.",
      "MerengueAñadimos la mitad o la totalidad de las claras reservadas utilizando la pesa para luego añadir el doble de la cantidad en azucar.Ponemos la Mariposa y programamos 2 minutos/ temperatura 55ºC / velocidad 1/ SIN cubilete.Una vez finalice programamos 6 Minutos / sin temperatura / velocidad 2.Tendremos listo nuestro Merengue para colocarlo encima de nuestro Pie y tostarlo levemente con un soplete de cocina.Enjoy!!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Masa SabléPonemos en el vaso el azucar y programamos 15 segundos / velocidad 10.Añadimos la mantequilla, la harina, el huevo, la sal y la vainilla y mezclamos 20 segundos / velocidad 5. Retiramos la masa del vaso envolvemos en film transparente y reservamos en la nevera mientras realizamos el curd de limón.\nCurd de limónAñadimos al vaso el agua, el zumo de limón, las yemas de huevo, el azucar, la mantequilla y la maicena. Programamos el Modo ESPESAR seleccionando 100ºC. Mientras precalentamos el horno a 180ºC.\nPreparación del PieEstiramos la masa reservada entre dos papeles de horno y rellenamos un molde para pie que previamente tendremos engrasado con mantequilla o spray antihaderente. Pinchamos toda la masa con un tenedor para evitar que en el horneado se infle.Horneamos durante 25 minutos.Lavamos bien nuestro vaso y lo dejamos totalmente seco para comenzar con el merengue.\nMerengueAñadimos la mitad o la totalidad de las claras reservadas utilizando la pesa para luego añadir el doble de la cantidad en azucar.Ponemos la Mariposa y programamos 2 minutos/ temperatura 55ºC / velocidad 1/ SIN cubilete.Una vez finalice programamos 6 Minutos / sin temperatura / velocidad 2.Tendremos listo nuestro Merengue para colocarlo encima de nuestro Pie y tostarlo levemente con un soplete de cocina.Enjoy!!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-tenerifesur.es")
    expect(recipe.canonical_url).to eq("https://thermomix-tenerifesur.es/frank-dorta/postres-y-dulces/recetas-contra-el-calor-lemon-meringue-pie")
    expect(recipe.site_name).to eq("Thermomix Tenerife Sur")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("FRANCISCO MARRERO DORTA")
    expect(recipe.description).to eq("Recetas contra el calor: Lemon Meringue Pie, una receta de Postres y dulces, elaborada por FRANCISCO MARRERO DORTA. Descubre las mejores recetas de Blogosfera Thermomix Tenerife Sur")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/e677446e9c03b5bf606784ab2c83edd0_76297c8e4d/e677446e9c03b5bf606784ab2c83edd0_76297c8e4d.jpg")
    expect(recipe.category).to eq("Postres y dulces")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(3)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Recetas contra el calor: Lemon Meringue Pie", "Postres y dulces"])
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
