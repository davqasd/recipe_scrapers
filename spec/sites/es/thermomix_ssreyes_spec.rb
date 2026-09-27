# frozen_string_literal: true

RSpec.describe "thermomix-ssreyes.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_ssreyes", url: "https://thermomix-ssreyes.es/leticia-modrego-pechero/aperitivos-entrantes-tapas/tapa-saludable") }

  it "reads the title" do
    expect(recipe.title).to eq("TAPA SALUDABLE")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "100 gramos leche de coco",
      "10 gramos levadura fresca",
      "130 gramos de harina de espelta",
      "1 cucharadita de carbón activado",
      "1/2 cucharadita sal",
      "25 gramos de aceite de oliva",
      "100 gramos calabacín en dados",
      "1 diente de ajo",
      "50 gramos cebolla en trozos",
      "200 gramos de pechuga de pollo en trozos (semicongelado)",
      "50 gramos queso rallado",
      "25 gramos de aceite de oliva",
      "1 diente de ajo",
      "50 gramos de cebolla en trozos",
      "50 gramos de zanahoria en trozos",
      "500 gramos de tomate triturado",
      "10 gramos de azúcar",
      "1 cucharadita de sal",
      "1 pellizco de pimienta",
      "1 cucharadita de orégano",
      "150 gramos del queso que más te guste"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 100.0, unit: "gramos", name: "leche de coco" },
      { amount: 10.0, unit: "gramos", name: "levadura fresca" },
      { amount: 130.0, unit: "gramos", name: "harina de espelta" },
      { amount: 1.0, unit: "cucharadita", name: "carbón activado" },
      { amount: 0.5, unit: "cucharadita", name: "sal" },
      { amount: 25.0, unit: "gramos", name: "aceite de oliva" },
      { amount: 100.0, unit: "gramos", name: "calabacín en dados" },
      { amount: 1.0, unit: "diente", name: "ajo" },
      { amount: 50.0, unit: "gramos", name: "cebolla en trozos" },
      { amount: 200.0, unit: "gramos", name: "pechuga de pollo en trozos" },
      { amount: 50.0, unit: "gramos", name: "queso rallado" },
      { amount: 25.0, unit: "gramos", name: "aceite de oliva" },
      { amount: 1.0, unit: "diente", name: "ajo" },
      { amount: 50.0, unit: "gramos", name: "cebolla en trozos" },
      { amount: 50.0, unit: "gramos", name: "zanahoria en trozos" },
      { amount: 500.0, unit: "gramos", name: "tomate triturado" },
      { amount: 10.0, unit: "gramos", name: "azúcar" },
      { amount: 1.0, unit: "cucharadita", name: "sal" },
      { amount: 1.0, unit: nil, name: "pellizco de pimienta" },
      { amount: 1.0, unit: "cucharadita", name: "orégano" },
      { amount: 150.0, unit: "gramos", name: "del queso que más te guste" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pon en el vaso la leche y la levadura y mezcla 2 min⁠/⁠37°C⁠/⁠vel 2.",
      "Añade la harina, el carbón activado y 1/2 cucharadita de sal. Mezcla 10 seg⁠/⁠vel 4 e inicia Amasar ⁠/⁠2 min. Retira del vaso y divide la masa en 12 piezas. Forma bolitas y colócalas en la bandeja del varoma (haz un huequito en el centro). Reserva",
      "Añade el aceite, el calabacín, el ajo y la cebolla en el vaso y programa Alta temperatura/Dorar 6 minutos",
      "Añade el pollo, el queso, la sal y la pimienta y tritura 10 segundos velocidad 10",
      "Forma albóndigas y colócalas en el recipiente varoma. Reserva",
      "Pon el aceite en el vaso y calienta 3 min⁠/⁠120°C⁠/⁠vel 1.",
      "Añade los dientes de ajo, la cebolla y la zanahoria. Trocea 10 seg⁠/⁠vel 5 y sofríe 7 min⁠/⁠120°C⁠/⁠vel 3.",
      "Incorpora el tomate, el azúcar, la sal, la pimienta y el orégano. Coloca el cestillo e introduce un bol con el queso dentro. Programa 30 min/varoma⁠/⁠vel 1."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pon en el vaso la leche y la levadura y mezcla 2 min⁠/⁠37°C⁠/⁠vel 2.\nAñade la harina, el carbón activado y 1/2 cucharadita de sal. Mezcla 10 seg⁠/⁠vel 4 e inicia Amasar ⁠/⁠2 min. Retira del vaso y divide la masa en 12 piezas. Forma bolitas y colócalas en la bandeja del varoma (haz un huequito en el centro). Reserva\nAñade el aceite, el calabacín, el ajo y la cebolla en el vaso y programa Alta temperatura/Dorar 6 minutos\nAñade el pollo, el queso, la sal y la pimienta y tritura 10 segundos velocidad 10\nForma albóndigas y colócalas en el recipiente varoma. Reserva\nPon el aceite en el vaso y calienta 3 min⁠/⁠120°C⁠/⁠vel 1.\nAñade los dientes de ajo, la cebolla y la zanahoria. Trocea 10 seg⁠/⁠vel 5 y sofríe 7 min⁠/⁠120°C⁠/⁠vel 3.\nIncorpora el tomate, el azúcar, la sal, la pimienta y el orégano. Coloca el cestillo e introduce un bol con el queso dentro. Programa 30 min/varoma⁠/⁠vel 1.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-ssreyes.es")
    expect(recipe.canonical_url).to eq("https://thermomix-ssreyes.es/leticia-modrego-pechero/aperitivos-entrantes-tapas/tapa-saludable")
    expect(recipe.site_name).to eq("Thermomix San Sebastián de los Reyes")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("LETICIA MODREGO PECHERO")
    expect(recipe.description).to eq("Espolvorear con especias")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/20260712_134335_af4184ac34/20260712_134335_af4184ac34.jpg")
    expect(recipe.category).to eq("Aperitivos, entrantes y tapas")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(40)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["TAPA SALUDABLE", "Aperitivos", "entrantes y tapas"])
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
