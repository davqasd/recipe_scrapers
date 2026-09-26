# frozen_string_literal: true

RSpec.describe "recetasnestle.com.mx" do
  subject(:recipe) { scrape_cassette("mx/recetasnestle", url: "https://www.recetasnestle.com.mx/recetas/waffles-zanahoria-yoghurt") }

  it "reads the title" do
    expect(recipe.title).to eq("Waffles de Zanahoria con Yoghurt")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 Taza de Yoghurt Danone® Natural sin Azúcar",
      "2 Huevos",
      "1 Cucharadita de esencia de vainilla",
      "1 Cucharada de mantequilla",
      "1 Taza de zanahoria",
      "3 Tazas de Cereal NESTLÉ® FITNESS® Miel y Almendras",
      "1 Taza de frutos rojos",
      "2 Ramitas de menta"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "Taza", name: "Yoghurt Danone® Natural sin Azúcar" },
      { amount: 2.0, unit: nil, name: "Huevos" },
      { amount: 1.0, unit: "Cucharadita", name: "esencia de vainilla" },
      { amount: 1.0, unit: "Cucharada", name: "mantequilla" },
      { amount: 1.0, unit: "Taza", name: "zanahoria" },
      { amount: 3.0, unit: "Tazas", name: "Cereal NESTLÉ® FITNESS® Miel y Almendras" },
      { amount: 1.0, unit: "Taza", name: "frutos rojos" },
      { amount: 2.0, unit: "Ramitas", name: "menta" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Integra los ingredientes",
      "Licúa el Yoghurt Danone® natural sin azúcar, los huevos, la esencia de vainilla, la mantequilla, la zanahoria y el Cereal NESTLÉ® FITNESS® Miel y Almendras.",
      "Cocina",
      "Vierte la mezcla en la waflera previamente rociada con un poco de aceite en aerosol. Cocina hasta que estén ligeramente dorados.",
      "Disfruta",
      "Sirve los waffles, decora con los frutos rojos y las hojas de menta."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Integra los ingredientes\nLicúa el Yoghurt Danone® natural sin azúcar, los huevos, la esencia de vainilla, la mantequilla, la zanahoria y el Cereal NESTLÉ® FITNESS® Miel y Almendras.\nCocina\nVierte la mezcla en la waflera previamente rociada con un poco de aceite en aerosol. Cocina hasta que estén ligeramente dorados.\nDisfruta\nSirve los waffles, decora con los frutos rojos y las hojas de menta.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("recetasnestle.com.mx")
    expect(recipe.canonical_url).to eq("https://www.recetasnestle.com.mx/recetas/waffles-zanahoria-yoghurt")
    expect(recipe.site_name).to eq("Recetas Nestlé")
    expect(recipe.language).to eq("es-mx")
    expect(recipe.author).to eq("Abraham Gómez")
    expect(recipe.description).to eq("Aprende a preparar unos WAFFLES con ZANAHORIA hechos con YOGHURT NATURAL y CEREAL FITNESS®. Acompaña con frutos rojos y menta para decorar.")
    expect(recipe.image).to eq("https://www.recetasnestle.com.mx/sites/default/files/srh_recipes/2517941898194cacdfdf469a1d880098.jpg")
    expect(recipe.category).to eq("Otro")
    expect(recipe.cuisine).to eq("Global")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(21)
    expect(recipe.prep_time).to eq(4)
    expect(recipe.cook_time).to eq(15)
    expect(recipe.keywords).to eq([
      "Desayuno",
      "Otro",
      "Global",
      "Fines de semana",
      "Sin pescado",
      "Sin crustáceos",
      "Libre de carne de puerco",
      "Fuente de fibra",
      "cereal fitness",
      "desayunos",
      "waffles",
      "Otro",
      "Verduras",
      "Ninguna"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "967",
      "carbohydrateContent" => "158",
      "fiberContent" => "20",
      "proteinContent" => "24",
      "sodiumContent" => "580",
      "sugarContent" => "53",
      "fatContent" => "25",
      "saturatedFatContent" => "9"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: nil, amount: 967.0 },
      { name: "carbohydrateContent", unit: nil, amount: 158.0 },
      { name: "fiberContent", unit: nil, amount: 20.0 },
      { name: "proteinContent", unit: nil, amount: 24.0 },
      { name: "sodiumContent", unit: nil, amount: 580.0 },
      { name: "sugarContent", unit: nil, amount: 53.0 },
      { name: "fatContent", unit: nil, amount: 25.0 },
      { name: "saturatedFatContent", unit: nil, amount: 9.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
