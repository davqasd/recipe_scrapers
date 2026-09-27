# frozen_string_literal: true

RSpec.describe "thermomix-tenerife.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_tenerife", url: "https://thermomix-tenerife.es/miriam-r-cahua-asmat/aperitivos-entrantes-tapas/pollo-desmenuzado-o-deshilachado") }

  it "reads the title" do
    expect(recipe.title).to eq("Pollo desmenuzado o deshilachado")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "500 g de pechuga de pollo",
      "600 g de agua",
      "1 o 2 ramitas de apio (opcional)",
      "Sal y especias al gusto",
      "1 zanahoria"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 500.0, unit: "g", name: "pechuga de pollo" },
      { amount: 600.0, unit: "g", name: "agua" },
      { amount: 1.0, unit: "ramitas", name: "apio" },
      { amount: nil, unit: nil, name: "Sal y especias al gusto" },
      { amount: 1.0, unit: nil, name: "zanahoria" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Agregar los 600 g de agua al vaso del Thermomix.",
      "Incorporar al vaso del Thermomix, la sal, especies y las ramitas de apio y zanahoria.",
      "Coloque el pollo en el vaso de nuestro Thermomix.",
      "Cocción: 20 min / temperatura 120º / velocidad 1 (giro inverso). Con esto, lo que hacemos es cocer el pollo; además, de tener un caldo de pollo que podríamos reservar para otras comidas sin necesidad de usar los cubitos de concentrados. O una sopa a la que le podríamos agregar verduras, fideos y algo del pollo que desmenuzaremos.",
      "Retirar y colar el pollo y el caldo del vaso del Thermomix y reservar.",
      "El pollo guisado, agregarlo al vaso de nuestro Thermomix.",
      "Una vez puesto, los trozos de pollo guisado. Desmenuzamos y deshilachamos nuestro pollo. ¿Cómo? Pues ponemos de tiempo 4 segundos / velocidad 4 y, a utilizar nuestro pollo como mejor queramos."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Agregar los 600 g de agua al vaso del Thermomix.\nIncorporar al vaso del Thermomix, la sal, especies y las ramitas de apio y zanahoria.\nColoque el pollo en el vaso de nuestro Thermomix.\nCocción: 20 min / temperatura 120º / velocidad 1 (giro inverso). Con esto, lo que hacemos es cocer el pollo; además, de tener un caldo de pollo que podríamos reservar para otras comidas sin necesidad de usar los cubitos de concentrados. O una sopa a la que le podríamos agregar verduras, fideos y algo del pollo que desmenuzaremos.\nRetirar y colar el pollo y el caldo del vaso del Thermomix y reservar.\nEl pollo guisado, agregarlo al vaso de nuestro Thermomix.\nUna vez puesto, los trozos de pollo guisado. Desmenuzamos y deshilachamos nuestro pollo. ¿Cómo? Pues ponemos de tiempo 4 segundos / velocidad 4 y, a utilizar nuestro pollo como mejor queramos.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-tenerife.es")
    expect(recipe.canonical_url).to eq("https://thermomix-tenerife.es/miriam-r-cahua-asmat/aperitivos-entrantes-tapas/pollo-desmenuzado-o-deshilachado")
    expect(recipe.site_name).to eq("Thermomix Tenerife")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("Miriam Rocío")
    expect(recipe.description).to eq("*UN TIP* En mi caso, suelo preparar pan con pollo: Trituro apio lo más fino posible. En un bol mezclo apio, pollo desmenuzado, mayonesa y una cdta. de mostaza. Esta mezcla, la uso todas las mañanas para los desayunos o meriendas de mi hijo.")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/c987a4ade90376f0c4dbdf7e41065516_8ac8b2b6e6/c987a4ade90376f0c4dbdf7e41065516_8ac8b2b6e6.jpg")
    expect(recipe.category).to eq("Aperitivos, entrantes y tapas")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Pollo desmenuzado o deshilachado", "Aperitivos", "entrantes y tapas"])
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
