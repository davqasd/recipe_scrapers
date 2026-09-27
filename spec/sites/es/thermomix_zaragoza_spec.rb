# frozen_string_literal: true

RSpec.describe "thermomix-zaragoza.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_zaragoza", url: "https://thermomix-zaragoza.es/catalina-arilla/trucos-thermomix/receta-de-cuchara-con-thermomix-lentejas-en-puchero-a-la-antigua") }

  it "reads the title" do
    expect(recipe.title).to eq("Receta de cuchara con Thermomix. Lentejas en puchero a la antigua.")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "350 g de lentejas",
      "100 g de pimiento rojo en trozos",
      "60 g de pimiento verde en trozos",
      "50 g de zanahoria en trozos",
      "60 g de cebolla en trozos",
      "25 g de aceite de oliva virgen extra",
      "15 g de pimentón dulce ahumado",
      "2 cucharaditas rasas de canela molida",
      "1 cucharadita de caldo concentrado de verduras",
      "1 cucharadita de sal",
      "950 g de agua",
      "1 hoja de laurel",
      "240-250 g de patatas en dados de 1.5 cm"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 350.0, unit: "g", name: "lentejas" },
      { amount: 100.0, unit: "g", name: "pimiento rojo en trozos" },
      { amount: 60.0, unit: "g", name: "pimiento verde en trozos" },
      { amount: 50.0, unit: "g", name: "zanahoria en trozos" },
      { amount: 60.0, unit: "g", name: "cebolla en trozos" },
      { amount: 25.0, unit: "g", name: "aceite de oliva virgen extra" },
      { amount: 15.0, unit: "g", name: "pimentón dulce ahumado" },
      { amount: 2.0, unit: "cucharaditas", name: "rasas de canela molida" },
      { amount: 1.0, unit: "cucharadita", name: "caldo concentrado de verduras" },
      { amount: 1.0, unit: "cucharadita", name: "sal" },
      { amount: 950.0, unit: "g", name: "agua" },
      { amount: 1.0, unit: nil, name: "hoja de laurel" },
      { amount: 240.0, unit: "g", name: "patatas en dados de 1.5 cm" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Poner las lentejas a remojo media hora en agua caliente.",
      "Poner en el vaso el pimiento rojo, el pimiento verde, la zanahoria, la cebolla, el aceite, el pimentón, la canela, el concentrado de caldo y la sal y picar 4 seg / vel 5.",
      "Añadir las lentejas escurridas y bien aclaradas.",
      "Verter el agua y echar la hoja de laurel. Programar 15 min / 100 ºC / Giro inverso / vel Cuchara.",
      "Echar las patatas y programar 25 min / 98 ºC / Giro inverso / Vel Cuchara.",
      "Probar el punto de cocción de las lentejas y, si es necesario, programar 5 minutos más.",
      "Verter en una sopera y servir caliente tras un reposo de unos 5 minutos."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Poner las lentejas a remojo media hora en agua caliente.\nPoner en el vaso el pimiento rojo, el pimiento verde, la zanahoria, la cebolla, el aceite, el pimentón, la canela, el concentrado de caldo y la sal y picar 4 seg / vel 5.\nAñadir las lentejas escurridas y bien aclaradas.\nVerter el agua y echar la hoja de laurel. Programar 15 min / 100 ºC / Giro inverso / vel Cuchara.\nEchar las patatas y programar 25 min / 98 ºC / Giro inverso / Vel Cuchara.\nProbar el punto de cocción de las lentejas y, si es necesario, programar 5 minutos más.\nVerter en una sopera y servir caliente tras un reposo de unos 5 minutos.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-zaragoza.es")
    expect(recipe.canonical_url).to eq("https://thermomix-zaragoza.es/catalina-arilla/trucos-thermomix/receta-de-cuchara-con-thermomix-lentejas-en-puchero-a-la-antigua")
    expect(recipe.site_name).to eq("Thermomix Zaragoza")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("CATALINA ARILLA SUAREZ")
    expect(recipe.description).to eq("Receta de cuchara con Thermomix. Lentejas en puchero a la antigua., una receta de Trucos, elaborada por CATALINA ARILLA SUAREZ. Descubre las mejores recetas de Blogosfera Thermomix Zaragoza")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/e57418eba077142fdcdf6a7e43af4df0_925e8cb371/e57418eba077142fdcdf6a7e43af4df0_925e8cb371.jpg")
    expect(recipe.category).to eq("Trucos")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(1)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Receta de cuchara con Thermomix. Lentejas en puchero a la antigua.", "Trucos"])
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
