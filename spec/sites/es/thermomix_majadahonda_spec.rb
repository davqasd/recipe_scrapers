# frozen_string_literal: true

RSpec.describe "thermomix-majadahonda.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_majadahonda", url: "https://thermomix-majadahonda.es/eva-maria-clemente-exposito/sopas-y-cremas/receta-riquisima-y-saludable-sopa-de-pescado-y-arroz-con-thermomix") }

  it "reads the title" do
    expect(recipe.title).to eq("Receta riquísima y saludable: Sopa de pescado y arroz con Thermomix")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "250 g de chirlas frescas o bien 200 g de mejillones frescos limpios",
      "1 cucharada de sal",
      "150 - 200 g de gambas frescas enteras sin pelar",
      "500 g de agua",
      "100 g de pimiento rojo en trozos",
      "100 g de pimiento verde en trozos",
      "150 g de cebolla en cuartos",
      "2 dientes de ajo",
      "200 g de tomate entero en conserva (escurrido)",
      "70 g de aceite de oliva virgen extra",
      "150 g de calamares en trozos",
      "500 g de caldo de pescado o bien 500 g de agua con 1 cucharadita de sal",
      "20 g de brandy",
      "1 hoja de laurel seca",
      "1 pimienta de Cayena seca entera (opcional)",
      "1 pellizco de pimienta negra molida",
      "50 g de arroz",
      "300 g de filetes de merluza fresca (pueden ser congelados)",
      "1 cucharada de perejil fresco picado para espolvorear"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 250.0, unit: "g", name: "chirlas frescas o bien 200 g de mejillones frescos limpios" },
      { amount: 1.0, unit: "cucharada", name: "sal" },
      { amount: 150.0, unit: "g", name: "gambas frescas enteras sin pelar" },
      { amount: 500.0, unit: "g", name: "agua" },
      { amount: 100.0, unit: "g", name: "pimiento rojo en trozos" },
      { amount: 100.0, unit: "g", name: "pimiento verde en trozos" },
      { amount: 150.0, unit: "g", name: "cebolla en cuartos" },
      { amount: 2.0, unit: "dientes", name: "ajo" },
      { amount: 200.0, unit: "g", name: "tomate entero en conserva" },
      { amount: 70.0, unit: "g", name: "aceite de oliva virgen extra" },
      { amount: 150.0, unit: "g", name: "calamares en trozos" },
      { amount: 500.0, unit: "g", name: "caldo de pescado o bien 500 g de agua con 1 cucharadita de sal" },
      { amount: 20.0, unit: "g", name: "brandy" },
      { amount: 1.0, unit: nil, name: "hoja de laurel seca" },
      { amount: 1.0, unit: nil, name: "pimienta de Cayena seca entera" },
      { amount: 1.0, unit: nil, name: "pellizco de pimienta negra molida" },
      { amount: 50.0, unit: "g", name: "arroz" },
      { amount: 300.0, unit: "g", name: "filetes de merluza fresca" },
      { amount: 1.0, unit: "cucharada", name: "perejil fresco picado para espolvorear" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "PREPARACIÓNPonga las chirlas en un recipiente con agua y sal para que suelten la arena.",
      "FUMETPele las gambas y ponga en el vaso las cabezas y las cáscaras, reserve los cuerpos. Añada el agua y programe 5 min/100°C/vel 4. Cuele el fumet a través de un colador de malla fina y reserve. Lave el vaso y la tapa.",
      "SOPAPonga en el vaso los pimientos, la cebolla, el ajo y el tomate y el aceite. Triture 30 seg/vel 5-10 progresivamente y sofría 7 min/120°C/vel 1.",
      "Agregue el calamar, el fumet reservado, el caldo, el brandy, el laurel, la cayena y la pimienta. Programe 10 min/100°C/giro inverso/vel cuchara.",
      "Añada el arroz. Sitúe el recipiente Varoma en su posición con las chirlas aclaradas y los filetes de merluza. Tape el Varoma y programe 15 min/Varoma/giro inverso/vel cuchara.",
      "Retire el Varoma y añada al vaso los cuerpos de las gambas. Ponga en una sopera las chirlas y la merluza en trozos. Vierta la sopa, espolvoree con el perejil picado y sirva."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("PREPARACIÓNPonga las chirlas en un recipiente con agua y sal para que suelten la arena.\nFUMETPele las gambas y ponga en el vaso las cabezas y las cáscaras, reserve los cuerpos. Añada el agua y programe 5 min/100°C/vel 4. Cuele el fumet a través de un colador de malla fina y reserve. Lave el vaso y la tapa.\nSOPAPonga en el vaso los pimientos, la cebolla, el ajo y el tomate y el aceite. Triture 30 seg/vel 5-10 progresivamente y sofría 7 min/120°C/vel 1.\nAgregue el calamar, el fumet reservado, el caldo, el brandy, el laurel, la cayena y la pimienta. Programe 10 min/100°C/giro inverso/vel cuchara.\nAñada el arroz. Sitúe el recipiente Varoma en su posición con las chirlas aclaradas y los filetes de merluza. Tape el Varoma y programe 15 min/Varoma/giro inverso/vel cuchara.\nRetire el Varoma y añada al vaso los cuerpos de las gambas. Ponga en una sopera las chirlas y la merluza en trozos. Vierta la sopa, espolvoree con el perejil picado y sirva.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-majadahonda.es")
    expect(recipe.canonical_url).to eq("https://thermomix-majadahonda.es/eva-maria-clemente-exposito/sopas-y-cremas/receta-riquisima-y-saludable-sopa-de-pescado-y-arroz-con-thermomix")
    expect(recipe.site_name).to eq("Thermomix Majadahonda")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("EVA MARIA CLEMENTE EXPOSITO")
    expect(recipe.description).to eq("Comentario nutricional: La sopa de pescado es una rica receta que aporta proteínas de alto valor biológico, un tipo de grasa muy saludable (a través del pescado y aceite de oliva) y también nos aporta una carga ligera de hidratos de carbono a través del a")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/b2639d0203fd0721cbfe78dd184900aa_fc683dafa0/b2639d0203fd0721cbfe78dd184900aa_fc683dafa0.jpg")
    expect(recipe.category).to eq("Sopas y cremas")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Receta riquísima y saludable: Sopa de pescado y arroz con Thermomix", "Sopas y cremas"])
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
