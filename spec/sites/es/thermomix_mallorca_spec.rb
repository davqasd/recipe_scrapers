# frozen_string_literal: true

RSpec.describe "thermomix-mallorca.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_mallorca", url: "https://thermomix-mallorca.es/marga-miralles-cantarellas/verduras-hortalizas-ensaladas/tumbet-healthy") }

  it "reads the title" do
    expect(recipe.title).to eq("Tumbet healthy")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "70 g de aceite",
      "100 g de agua",
      "500 g de patatas cortadas en rodajas",
      "500 g de pimientos rojos",
      "50o g de berenjenas, y/o calabacines cortados en rodajas",
      "120g de cebolla",
      "750 g de tomate triturado",
      "5 ajos cascados con piel",
      "3 hojas de laurel",
      "Sal",
      "Pimienta"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 70.0, unit: "g", name: "aceite" },
      { amount: 100.0, unit: "g", name: "agua" },
      { amount: 500.0, unit: "g", name: "patatas cortadas en rodajas" },
      { amount: 500.0, unit: "g", name: "pimientos rojos" },
      { amount: 50.0, unit: nil, name: "o g de berenjenas, y/o calabacines cortados en rodajas" },
      { amount: 120.0, unit: "g", name: "cebolla" },
      { amount: 750.0, unit: "g", name: "tomate triturado" },
      { amount: 5.0, unit: nil, name: "ajos cascados con piel" },
      { amount: 3.0, unit: nil, name: "hojas de laurel" },
      { amount: nil, unit: nil, name: "Sal" },
      { amount: nil, unit: nil, name: "Pimienta" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Calienta el aceite y el agua durante 3 min/120º/ vel cuchara.",
      "Coloca la mariposa en el vaso, añade las patatas y programa 20 min/120º/giro a la inversa/vel cuchara.",
      "Cuela con el cestillo, y pon el aceite que has recogido otra vez en el vaso.",
      "Añade 2 ajos aplastados, la cebolla y los pimientos troceados, programa 15 min/120º/giro a la inversa/vel cuchara.",
      "Coloca las berenjenas y/o calabacín en el recipiente Varoma de tal forma que no se impida la salida del vapor. Reserva.",
      "Agrega al vaso el tomate y el resto de los ingredientes (sal, pimienta y laurel). Coloca el Varoma en su posición , programa 20 min/Varoma/giro a la inversa/vel cuchara.",
      "Coloca en una fuente una primera capa de patatas, una segunda capa de berenjenas/calabacín y finalmente cubrelo todo con la salsa de pimientos y tomate."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Calienta el aceite y el agua durante 3 min/120º/ vel cuchara.\nColoca la mariposa en el vaso, añade las patatas y programa 20 min/120º/giro a la inversa/vel cuchara.\nCuela con el cestillo, y pon el aceite que has recogido otra vez en el vaso.\nAñade 2 ajos aplastados, la cebolla y los pimientos troceados, programa 15 min/120º/giro a la inversa/vel cuchara.\nColoca las berenjenas y/o calabacín en el recipiente Varoma de tal forma que no se impida la salida del vapor. Reserva.\nAgrega al vaso el tomate y el resto de los ingredientes (sal, pimienta y laurel). Coloca el Varoma en su posición , programa 20 min/Varoma/giro a la inversa/vel cuchara.\nColoca en una fuente una primera capa de patatas, una segunda capa de berenjenas/calabacín y finalmente cubrelo todo con la salsa de pimientos y tomate.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-mallorca.es")
    expect(recipe.canonical_url).to eq("https://thermomix-mallorca.es/marga-miralles-cantarellas/verduras-hortalizas-ensaladas/tumbet-healthy")
    expect(recipe.site_name).to eq("Thermomix Mallorca")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("MARGA MIRALLES CANTARELLAS")
    expect(recipe.description).to eq("Tumbet healthy, una receta de Verduras, hortalizas y ensaladas, elaborada por MARGA MIRALLES CANTARELLAS. Descubre las mejores recetas de Blogosfera Thermomix Mallorca")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/Tumbet_5af389b5c8/Tumbet_5af389b5c8.jpg")
    expect(recipe.category).to eq("Verduras, hortalizas y ensaladas")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("9 servings")
    expect(recipe.total_time).to eq(1)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Tumbet healthy", "Verduras", "hortalizas y ensaladas"])
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
