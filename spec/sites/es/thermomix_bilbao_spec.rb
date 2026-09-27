# frozen_string_literal: true

RSpec.describe "thermomix-bilbao.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_bilbao", url: "https://thermomix-bilbao.es/majesus-moreno-esnarrizaga/carnes-y-aves/codillo-express-y-mas-receta-facilitada-por-susi-cosme") }

  it "reads the title" do
    expect(recipe.title).to eq("CODILLO EXPRESS Y MAS - receta facilitada por SUSI COSME")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "50 gr. de azúcar",
      "3 huevos talla M",
      "300 gr. de leche",
      "caramelo líquido para cubrir los moldes",
      "1 codillo asado",
      "200 gr. de cebolla",
      "2 ajos",
      "1 zanahoria grande",
      "50 gr. de aceite",
      "1/2 cucharadita de pimentón",
      "2 hojas de laurel",
      "170 gr. de cerveza negra",
      "330 gr. de agua",
      "300-400 gr. de patata cortada en rodajas de 0,5 mm. aprox.",
      "sal",
      "2 huevos envueltos en film transparente"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 50.0, unit: "gr", name: "azúcar" },
      { amount: 3.0, unit: nil, name: "huevos talla M" },
      { amount: 300.0, unit: "gr", name: "leche" },
      { amount: nil, unit: nil, name: "caramelo líquido para cubrir los moldes" },
      { amount: 1.0, unit: nil, name: "codillo asado" },
      { amount: 200.0, unit: "gr", name: "cebolla" },
      { amount: 2.0, unit: nil, name: "ajos" },
      { amount: 1.0, unit: nil, name: "zanahoria grande" },
      { amount: 50.0, unit: "gr", name: "aceite" },
      { amount: 0.5, unit: "cucharadita", name: "pimentón" },
      { amount: 2.0, unit: nil, name: "hojas de laurel" },
      { amount: 170.0, unit: "gr", name: "cerveza negra" },
      { amount: 330.0, unit: "gr", name: "agua" },
      { amount: 300.0, unit: "gr", name: "patata cortada en rodajas de 0,5 mm. aprox." },
      { amount: nil, unit: nil, name: "sal" },
      { amount: 2.0, unit: nil, name: "huevos envueltos en film transparente" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Ponga en el vaso el azúcar50 gr. de azúcar",
      "la leche300 gr. de leche",
      "los 3 huevos",
      "Mezcle 30 seg/velocidad 3.5. Mientras tanto, vierta caramelo liquido en las 6 flanera. Al finalizar el tiempo, reparta el contenido del Vaso sobre las flaneras caramelizadas, cubra con papel de aluminio y reserve en el Varoma. Aclare el vaso.",
      "Ponga en el vaso la cebolla en cuartos200 gr. cebolla",
      "añada los ajos, la zanahoria en trozos y el aceite 50 gr. de aceite trocee 5 seg/velocidad 4 y sofría 7 min/120°C/velocidad 2",
      "añada el pimentón1/2 cucharadita de pimentón y las 2 hojas de laurel. Sofría 1 min/120°C/velocidad 2",
      "añada 170 gr. de cerveza negra",
      "y 330 gr. de agua y un pellizco de sal",
      "Ponga el Varoma en su posición. Coloque el codillo y vierta sobre todo el jugo que tenga en el envase. Cierre el Varoma y programe 15 min/Varoma/velocidad 2.",
      "Finalizado el tiempo de Varoma, coloque el cestillo dentro del vaso y meta las patatas300 gr. de patatas cortadas en rodajas de 0,5 mm. aproximadamente. y los huevos. Vuelva a poner el Varoma en su posición con la bandeja con las flaneras y programe 25 min/Varoma/velocidad 2",
      "Vierta las patatas del castillo en una fuente, ponga también el codillo y retire el laurel del vaso antes de triturar la salsa y triture: 30 seg/velocidad 8 y corregir de sal. Vierta sobre el codillo. Pele los huevos y coloque en cuartos al rededor del codillo y sirva el codillo acompañado de una ensalada.",
      "Enfríe los flanes en la nevera antes de servir"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Ponga en el vaso el azúcar50 gr. de azúcar\nla leche300 gr. de leche\nlos 3 huevos\nMezcle 30 seg/velocidad 3.5. Mientras tanto, vierta caramelo liquido en las 6 flanera. Al finalizar el tiempo, reparta el contenido del Vaso sobre las flaneras caramelizadas, cubra con papel de aluminio y reserve en el Varoma. Aclare el vaso.\nPonga en el vaso la cebolla en cuartos200 gr. cebolla\nañada los ajos, la zanahoria en trozos y el aceite 50 gr. de aceite trocee 5 seg/velocidad 4 y sofría 7 min/120°C/velocidad 2\nañada el pimentón1/2 cucharadita de pimentón y las 2 hojas de laurel. Sofría 1 min/120°C/velocidad 2\nañada 170 gr. de cerveza negra\ny 330 gr. de agua y un pellizco de sal\nPonga el Varoma en su posición. Coloque el codillo y vierta sobre todo el jugo que tenga en el envase. Cierre el Varoma y programe 15 min/Varoma/velocidad 2.\nFinalizado el tiempo de Varoma, coloque el cestillo dentro del vaso y meta las patatas300 gr. de patatas cortadas en rodajas de 0,5 mm. aproximadamente. y los huevos. Vuelva a poner el Varoma en su posición con la bandeja con las flaneras y programe 25 min/Varoma/velocidad 2\nVierta las patatas del castillo en una fuente, ponga también el codillo y retire el laurel del vaso antes de triturar la salsa y triture: 30 seg/velocidad 8 y corregir de sal. Vierta sobre el codillo. Pele los huevos y coloque en cuartos al rededor del codillo y sirva el codillo acompañado de una ensalada.\nEnfríe los flanes en la nevera antes de servir")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-bilbao.es")
    expect(recipe.canonical_url).to eq("https://thermomix-bilbao.es/majesus-moreno-esnarrizaga/carnes-y-aves/codillo-express-y-mas-receta-facilitada-por-susi-cosme")
    expect(recipe.site_name).to eq("Thermomix Bilbao")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("MAJES MORENO ESNARRIZAGA")
    expect(recipe.description).to eq("CODILLO EXPRESS Y MAS - receta facilitada por SUSI COSME, una receta de Carnes y aves, elaborada por MAJES MORENO ESNARRIZAGA. Descubre las mejores recetas de Blogosfera Thermomix Bilbao")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/f703dd259d1b1a7f922c5c03ed4801c7_74d636c776/f703dd259d1b1a7f922c5c03ed4801c7_74d636c776.jpg")
    expect(recipe.category).to eq("Carnes y aves")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["CODILLO EXPRESS Y MAS - receta facilitada por SUSI COSME", "Carnes y aves"])
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
