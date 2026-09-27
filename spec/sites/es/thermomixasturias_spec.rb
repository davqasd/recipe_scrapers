# frozen_string_literal: true

RSpec.describe "thermomixasturias.es" do
  subject(:recipe) { scrape_cassette("es/thermomixasturias", url: "https://thermomixasturias.es/lorena-estrada/verduras-hortalizas-ensaladas/recetas-de-verano-con-thermomix-salmorejo-sin-gluten-2") }

  it "reads the title" do
    expect(recipe.title).to eq("RECETAS DE VERANO CON THERMOMIX \"SALMOREJO SIN GLUTEN\"")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "80 gr de aceite de oliva virgen extra",
      "4 huevos duros",
      "100 gr de jamon serrano en trozos",
      "1 diente de ajo",
      "1 kilo de tomates maduros en cuartos",
      "1 aguacate",
      "1 cucharadita de sal",
      "10 gr de vinagre de manzana"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 80.0, unit: "gr", name: "aceite de oliva virgen extra" },
      { amount: 4.0, unit: nil, name: "huevos duros" },
      { amount: 100.0, unit: "gr", name: "jamon serrano en trozos" },
      { amount: 1.0, unit: "diente", name: "ajo" },
      { amount: 1.0, unit: "kilo", name: "tomates maduros en cuartos" },
      { amount: 1.0, unit: nil, name: "aguacate" },
      { amount: 1.0, unit: "cucharadita", name: "sal" },
      { amount: 10.0, unit: "gr", name: "vinagre de manzana" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Colocamos una jarra sobre la tapa del vaso y pesamos el aceite. Retiramos y reservamos.",
      "Ponemos en el vaso los huevos y troceamos 2 seg/vel 4. Retiramos del vaso a un bol y reservamos.",
      "Picamos el jamon programando Turbo 1 seg/2-3 veces. Retiramos a otro bol y reservamos.",
      "Ponemos en el vaso el ajo, el tomate, el aguacate, la sal y el vinagre y trituramos 3 min / vel 10. Con la espatula bajamos los ingredientes hacia el fondo del vaso.",
      "Colocamos el cubilete en la tapa, programamos 1 min / vel 5 y, mientras tanto, vertemos el aceite poco a poco sobre la tapa. Ponemos el salmorejo en un recipiente y reservamos en el firgorifico. Servimos muy frio, acompañado del jamon y los huevos picados."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Colocamos una jarra sobre la tapa del vaso y pesamos el aceite. Retiramos y reservamos.\nPonemos en el vaso los huevos y troceamos 2 seg/vel 4. Retiramos del vaso a un bol y reservamos.\nPicamos el jamon programando Turbo 1 seg/2-3 veces. Retiramos a otro bol y reservamos.\nPonemos en el vaso el ajo, el tomate, el aguacate, la sal y el vinagre y trituramos 3 min / vel 10. Con la espatula bajamos los ingredientes hacia el fondo del vaso.\nColocamos el cubilete en la tapa, programamos 1 min / vel 5 y, mientras tanto, vertemos el aceite poco a poco sobre la tapa. Ponemos el salmorejo en un recipiente y reservamos en el firgorifico. Servimos muy frio, acompañado del jamon y los huevos picados.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomixasturias.es")
    expect(recipe.canonical_url).to eq("https://thermomixasturias.es/lorena-estrada/verduras-hortalizas-ensaladas/recetas-de-verano-con-thermomix-salmorejo-sin-gluten-2")
    expect(recipe.site_name).to eq("Thermomix Asturias")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("LORENA ESTRADA MARTINEZ")
    expect(recipe.description).to eq("Puedes sustituir el aguacate por manzana, zanahoria...")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/9f0524e2d3e82eaf602fe5968c0a6cc5_65dd58c5a0/9f0524e2d3e82eaf602fe5968c0a6cc5_65dd58c5a0.jpg")
    expect(recipe.category).to eq("Verduras, hortalizas y ensaladas")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["RECETAS DE VERANO CON THERMOMIX \"SALMOREJO SIN GLUTEN\"", "Verduras", "hortalizas y ensaladas"])
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
