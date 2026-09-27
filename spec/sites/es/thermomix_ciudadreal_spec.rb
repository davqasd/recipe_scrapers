# frozen_string_literal: true

RSpec.describe "thermomix-ciudadreal.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_ciudadreal", url: "https://thermomix-ciudadreal.es/rosa-maria-fernandez-garcia/carnes-y-aves/comparte-tus-mejores-momentos-con-cookidoo-rollo-de-pechuga-de-pollo") }

  it "reads the title" do
    expect(recipe.title).to eq("\"COMPARTE TUS MEJORES MOMENTOS CON COOKIDOO\" ROLLO DE PECHUGA DE POLLO")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "40g Aceite",
      "1 cucharada de pisto",
      "30g de Cebolla",
      "3 zanahorias en rodaja",
      "100 g Vino Blanco",
      "500g Agua",
      "1/ 2 cucharadita sal",
      "ROLLO ingredientes",
      "5 Filetes finos de pechuga de pollo",
      "4 huevos ( se le hace tortilla francesa)",
      "5 tiras de Bacón",
      "4 Filete de Jamón Serrano"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 40.0, unit: "g", name: "Aceite" },
      { amount: 1.0, unit: "cucharada", name: "pisto" },
      { amount: 30.0, unit: "g", name: "Cebolla" },
      { amount: 3.0, unit: nil, name: "zanahorias en rodaja" },
      { amount: 100.0, unit: "g", name: "Vino Blanco" },
      { amount: 500.0, unit: "g", name: "Agua" },
      { amount: 0.5, unit: "cucharadita", name: "sal" },
      { amount: nil, unit: nil, name: "ROLLO ingredientes" },
      { amount: 5.0, unit: nil, name: "Filetes finos de pechuga de pollo" },
      { amount: 4.0, unit: nil, name: "huevos" },
      { amount: 5.0, unit: nil, name: "tiras de Bacón" },
      { amount: 4.0, unit: nil, name: "Filete de Jamón Serrano" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Ponga en el vaso la cebolla, y sofría 3 minutos/120ºC/ vel 1",
      "Coloque sobre la encimera 2 rectángulos de film transparente ( aprox 30 x 50 cm) superpuestos entre si.Coloque encima las filetes de pechuga de pollo, las lonchas de jamón serrano, lonchas de beicon, y tortilla francesa, formando un rectángulo y forme un rollo bien apretado, ayudándose con el film transparente. Haga rodar el rollo sobre la superficie de trabajo para que quede bien sellado. Colóquelo en el recipiente Varoma y con una brocheta o tenedor, pinche el rollo en varias partes, tape y reserve.",
      "Incorpore 1 cucharada pisto y sofría 2 minutos/120ºC/vel 1 , añada 3 zanahorias en rodajas y sofría 2 minutos /120ºC / vel 1",
      "Incorpore el vino y programe 3 minutos/ varoma/ vel 1 y añada el agua y sal y sitúe el recipiente Varoma en su posición y programe 20 minutos/varoma/ vel 2.",
      "Una vez templado el rollo de pechuga, retire el film transparente, corte en rodajas",
      "Batimos la salsa 15seg / vel 5 al 9 progresivamente",
      "Ponga una sarten con la salsa y las rodajas para incorporar la salsa a la pechuga y estén mas sabrosas"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Ponga en el vaso la cebolla, y sofría 3 minutos/120ºC/ vel 1\nColoque sobre la encimera 2 rectángulos de film transparente ( aprox 30 x 50 cm) superpuestos entre si.Coloque encima las filetes de pechuga de pollo, las lonchas de jamón serrano, lonchas de beicon, y tortilla francesa, formando un rectángulo y forme un rollo bien apretado, ayudándose con el film transparente. Haga rodar el rollo sobre la superficie de trabajo para que quede bien sellado. Colóquelo en el recipiente Varoma y con una brocheta o tenedor, pinche el rollo en varias partes, tape y reserve.\nIncorpore 1 cucharada pisto y sofría 2 minutos/120ºC/vel 1 , añada 3 zanahorias en rodajas y sofría 2 minutos /120ºC / vel 1\nIncorpore el vino y programe 3 minutos/ varoma/ vel 1 y añada el agua y sal y sitúe el recipiente Varoma en su posición y programe 20 minutos/varoma/ vel 2.\nUna vez templado el rollo de pechuga, retire el film transparente, corte en rodajas\nBatimos la salsa 15seg / vel 5 al 9 progresivamente\nPonga una sarten con la salsa y las rodajas para incorporar la salsa a la pechuga y estén mas sabrosas")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-ciudadreal.es")
    expect(recipe.canonical_url).to eq("https://thermomix-ciudadreal.es/rosa-maria-fernandez-garcia/carnes-y-aves/comparte-tus-mejores-momentos-con-cookidoo-rollo-de-pechuga-de-pollo")
    expect(recipe.site_name).to eq("Thermomix Ciudad Real")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("ROSA MARIA FERNANDEZ GARCIA")
    expect(recipe.description).to eq("\"COMPARTE TUS MEJORES MOMENTOS CON COOKIDOO\" ROLLO DE PECHUGA DE POLLO, una receta de Carnes y aves, elaborada por ROSA MARIA FERNANDEZ GARCIA. Descubre las mejores recetas de Blogosfera Thermomix Ciudad Real")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/c8cadbf93830e8d74e6e817d6b81d32a_bd739f8ae3/c8cadbf93830e8d74e6e817d6b81d32a_bd739f8ae3.jpg")
    expect(recipe.category).to eq("Carnes y aves")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["\"COMPARTE TUS MEJORES MOMENTOS CON COOKIDOO\" ROLLO DE PECHUGA DE POLLO", "Carnes y aves"])
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
