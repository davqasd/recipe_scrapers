# frozen_string_literal: true

RSpec.describe "thermomix-pamplona.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_pamplona", url: "https://thermomix-pamplona.es/claudia-torrent/verduras-hortalizas-ensaladas/acelgas-con-huevos-duros-y-salsa-de-champinones") }

  it "reads the title" do
    expect(recipe.title).to eq("Acelgas con huevos duros y salsa de champiñones")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "70 g de queso parmesano",
      "250 g de agua",
      "200 g de champiñones frescos laminados",
      "800 g de acelgas, las hojas verdes y tallos tiernos",
      "4 huevos",
      "3 dientes de ajo laminados",
      "40g de harina",
      "600 g de leche",
      "2 cucharaditas de sal",
      "1 pellizco de pimienta molida",
      "1 pellizco de nuez moscada"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 70.0, unit: "g", name: "queso parmesano" },
      { amount: 250.0, unit: "g", name: "agua" },
      { amount: 200.0, unit: "g", name: "champiñones frescos laminados" },
      { amount: 800.0, unit: "g", name: "acelgas, las hojas verdes y tallos tiernos" },
      { amount: 4.0, unit: nil, name: "huevos" },
      { amount: 3.0, unit: "dientes", name: "ajo laminados" },
      { amount: 40.0, unit: "g", name: "harina" },
      { amount: 600.0, unit: "g", name: "leche" },
      { amount: 2.0, unit: "cucharaditas", name: "sal" },
      { amount: 1.0, unit: nil, name: "pellizco de pimienta molida" },
      { amount: 1.0, unit: nil, name: "pellizco de nuez moscada" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Con el vaso limpio y seco, ralla el parmesano 10 seg/vel 10. Retira a un bol y reserva.",
      "Pon el agua en el vaso. Introduce el cestillo con los champiñones. Coloca el Recipiente Varoma en su posición con las acelgas y los huevos envueltos en film transparente (que toquen la base del recipiente). Programa 20 min/varoma/vel 1.",
      "Retira el Varoma. Con la muesca de la espátula retira el cestillo y vacía el vaso.Pon los huevos bajo el chorro de agua fría. Con el dorso de una cuchara aplasta las acelgas para que escurran bien el agua.",
      "Pon 20 g de aceite en el vaso y programa 2 min/120/vel 1.",
      "Añade los ajos y programa 3 min/120/vel 1",
      "Añade las acelgas bien escurridas, 1/2 cucharadita de sal y un pellizco de pimienta y rehoga 2 min/120/giro inverso/vel cuchara.Vierte en una fuente refractaria, por ejemplo en la rock star Anna.",
      "Salsa de champiñonesPrecalienta el horno a 200 con el grill encendido. Pon en el vaso 40 g de aceite y los champiñones reservados y sofríe 2 min/120/giro inverso/vel cuchara.",
      "Añade la harina y rehoga 4 min/120/giro inverso/vel cuchara.",
      "Incorpora la leche, 20 g del parmesano rallado, la sal, la pimienta y la nuez moscada y programa 7 min/100/ giro inverso/velocidad 2.Mientras tanto, pela los huevos, córtalos en rodajas y coloca encima de las acelgas.",
      "Vierte la salsa de champiñones por encima, espolvorea con el queso rallado y gratina unos 5 minutos o hasta que esté dorado.Deja enfriar 15 minutos y sirve."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Con el vaso limpio y seco, ralla el parmesano 10 seg/vel 10. Retira a un bol y reserva.\nPon el agua en el vaso. Introduce el cestillo con los champiñones. Coloca el Recipiente Varoma en su posición con las acelgas y los huevos envueltos en film transparente (que toquen la base del recipiente). Programa 20 min/varoma/vel 1.\nRetira el Varoma. Con la muesca de la espátula retira el cestillo y vacía el vaso.Pon los huevos bajo el chorro de agua fría. Con el dorso de una cuchara aplasta las acelgas para que escurran bien el agua.\nPon 20 g de aceite en el vaso y programa 2 min/120/vel 1.\nAñade los ajos y programa 3 min/120/vel 1\nAñade las acelgas bien escurridas, 1/2 cucharadita de sal y un pellizco de pimienta y rehoga 2 min/120/giro inverso/vel cuchara.Vierte en una fuente refractaria, por ejemplo en la rock star Anna.\nSalsa de champiñonesPrecalienta el horno a 200 con el grill encendido. Pon en el vaso 40 g de aceite y los champiñones reservados y sofríe 2 min/120/giro inverso/vel cuchara.\nAñade la harina y rehoga 4 min/120/giro inverso/vel cuchara.\nIncorpora la leche, 20 g del parmesano rallado, la sal, la pimienta y la nuez moscada y programa 7 min/100/ giro inverso/velocidad 2.Mientras tanto, pela los huevos, córtalos en rodajas y coloca encima de las acelgas.\nVierte la salsa de champiñones por encima, espolvorea con el queso rallado y gratina unos 5 minutos o hasta que esté dorado.Deja enfriar 15 minutos y sirve.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-pamplona.es")
    expect(recipe.canonical_url).to eq("https://thermomix-pamplona.es/claudia-torrent/verduras-hortalizas-ensaladas/acelgas-con-huevos-duros-y-salsa-de-champinones")
    expect(recipe.site_name).to eq("Thermomix Pamplona")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("CLAUDIA TORRENT ALAMANY")
    expect(recipe.description).to eq("Acelgas con huevos duros y salsa de champiñones, una receta de Verduras, hortalizas y ensaladas, elaborada por CLAUDIA TORRENT ALAMANY. Descubre las mejores recetas de Blogosfera Thermomix Pamplona")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/9919defd661e393b9be10fe0ab4712d4_b1d463f4a7/9919defd661e393b9be10fe0ab4712d4_b1d463f4a7.jpg")
    expect(recipe.category).to eq("Verduras, hortalizas y ensaladas")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Acelgas con huevos duros y salsa de champiñones", "Verduras", "hortalizas y ensaladas"])
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
