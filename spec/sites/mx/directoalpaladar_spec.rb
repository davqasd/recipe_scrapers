# frozen_string_literal: true

RSpec.describe "directoalpaladar.com.mx" do
  subject(:recipe) { scrape_cassette("mx/directoalpaladar", url: "https://www.directoalpaladar.com.mx/comida-mexicana/como-hacer-chiles-rellenos-fideo-seco-receta-facil-deliciosa-acompanada-salsa-frijol") }

  it "reads the title" do
    expect(recipe.title).to eq("Cómo hacer chiles rellenos de fideo seco: una receta fácil y deliciosa acompañada con salsa de frijol")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "Chiles poblanos",
      "2 tazas de frijoles negros",
      "2ml Caldo de pollo",
      "1 Sal y pimienta al gusto",
      "1ml Crema ácida",
      "1g Queso fresco",
      "3 jitomates",
      "1 1/2 cebolla",
      "3 3 dientes de ajo",
      "2 chiles guajillo sin semillas ni venas",
      "2 chiles pasilla",
      "2 chiles ancho",
      "1g Pasta de tomate",
      "2 tazas de caldo de pollo",
      "3 Cucharadas de aceite de oliva",
      "1 1 paquete de sopa de fideo",
      "1 Sal y pimienta al gusto"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "Chiles poblanos" },
      { amount: 2.0, unit: "tazas", name: "frijoles negros" },
      { amount: 2.0, unit: "ml", name: "Caldo de pollo" },
      { amount: 1.0, unit: nil, name: "Sal y pimienta al gusto" },
      { amount: 1.0, unit: "ml", name: "Crema ácida" },
      { amount: 1.0, unit: "g", name: "Queso fresco" },
      { amount: 3.0, unit: nil, name: "jitomates" },
      { amount: 1.5, unit: nil, name: "cebolla" },
      { amount: 3.0, unit: nil, name: "3 dientes de ajo" },
      { amount: 2.0, unit: nil, name: "chiles guajillo sin semillas ni venas" },
      { amount: 2.0, unit: nil, name: "chiles pasilla" },
      { amount: 2.0, unit: nil, name: "chiles ancho" },
      { amount: 1.0, unit: "g", name: "Pasta de tomate" },
      { amount: 2.0, unit: "tazas", name: "caldo de pollo" },
      { amount: 3.0, unit: "Cucharadas", name: "aceite de oliva" },
      { amount: 1.0, unit: nil, name: "1 paquete de sopa de fideo" },
      { amount: 1.0, unit: nil, name: "Sal y pimienta al gusto" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "1. Tatemar y limpiar los chiles Tatemar los chiles poblanos directamente sobre el fuego hasta que la piel quede completamente quemada y cubierta de ampollas. Colócalos en una bolsa o recipiente tapado para que suden durante unos minutos. Después, retira cuidadosamente la piel sin enjuagarlos bajo el chorro de agua. Haz un corte a lo largo de cada chile y retira las semillas y las venas con cuidado para no romperlos. Reserva. 2. Prepara la salsa de frijol Coloca en la licuadora los frijoles negros cocidos junto con el caldo de pollo. Sazona con sal y pimienta al gusto y licua hasta obtener una salsa homogénea. Reserva. 3. Asa los ingredientes para el fideo Parte los tomates por la mitad y colócalos en un sartén junto con la cebolla. Añade los chiles guajillos, pasilla y anchos y deja que se doren durante unos minutos. Retira los chiles y colócalos en un recipiente. Cúbrelos con agua caliente y déjalos reposar hasta que se suavicen. Mientras tanto, incorpora los dientes de ajo al sartén y continúa asando los ingredientes hasta que estén ligeramente dorados. 4. Licua la salsa de tres chiles Cuando los tomates, la cebolla y el ajo estén listos, colócalos en la licuadora junto con el caldo de pollo, la pasta de tomate, los chiles previamente suavizados, sal y pimienta al gusto. Licua durante unos minutos hasta obtener una salsa uniforme y después cuélala para retirar cualquier resto de semillas o piel. 5. Prepara el fideo seco Calienta un sartén a fuego medio y agrega el aceite de oliva. Incorpora el fideo y dóralo, moviendo constantemente, hasta que cambie ligeramente de color. Vierte la salsa de los tres chiles y mezcla para que el fideo quede completamente cubierto. Cuando la preparación comience a hervir, baja el fuego, tapa el sartén y deja cocinar durante 8 a 10 minutos, o hasta que el fideo esté suave y haya absorbido prácticamente todo el líquido. 6. Rellena los chiles Una vez que el fideo esté listo, rellena cuidadosamente los chiles poblanos. Procura no poner demasiada cantidad para evitar que se rompan. Para servir, coloca una porción de la salsa de frijol en el plato y encima acomoda el chile relleno. Termina con un poco de crema y queso fresco. El resultado es un platillo sencillo pero muy lucidor: chile poblano tatemado, fideo seco con el sabor de tres chiles y una cremosa salsa de frijol. Una opción diferente para aprovechar ingredientes que quizá ya tienes en casa y preparar algo rico sin pasar todo el día en la cocina."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("1. Tatemar y limpiar los chiles Tatemar los chiles poblanos directamente sobre el fuego hasta que la piel quede completamente quemada y cubierta de ampollas. Colócalos en una bolsa o recipiente tapado para que suden durante unos minutos. Después, retira cuidadosamente la piel sin enjuagarlos bajo el chorro de agua. Haz un corte a lo largo de cada chile y retira las semillas y las venas con cuidado para no romperlos. Reserva. 2. Prepara la salsa de frijol Coloca en la licuadora los frijoles negros cocidos junto con el caldo de pollo. Sazona con sal y pimienta al gusto y licua hasta obtener una salsa homogénea. Reserva. 3. Asa los ingredientes para el fideo Parte los tomates por la mitad y colócalos en un sartén junto con la cebolla. Añade los chiles guajillos, pasilla y anchos y deja que se doren durante unos minutos. Retira los chiles y colócalos en un recipiente. Cúbrelos con agua caliente y déjalos reposar hasta que se suavicen. Mientras tanto, incorpora los dientes de ajo al sartén y continúa asando los ingredientes hasta que estén ligeramente dorados. 4. Licua la salsa de tres chiles Cuando los tomates, la cebolla y el ajo estén listos, colócalos en la licuadora junto con el caldo de pollo, la pasta de tomate, los chiles previamente suavizados, sal y pimienta al gusto. Licua durante unos minutos hasta obtener una salsa uniforme y después cuélala para retirar cualquier resto de semillas o piel. 5. Prepara el fideo seco Calienta un sartén a fuego medio y agrega el aceite de oliva. Incorpora el fideo y dóralo, moviendo constantemente, hasta que cambie ligeramente de color. Vierte la salsa de los tres chiles y mezcla para que el fideo quede completamente cubierto. Cuando la preparación comience a hervir, baja el fuego, tapa el sartén y deja cocinar durante 8 a 10 minutos, o hasta que el fideo esté suave y haya absorbido prácticamente todo el líquido. 6. Rellena los chiles Una vez que el fideo esté listo, rellena cuidadosamente los chiles poblanos. Procura no poner demasiada cantidad para evitar que se rompan. Para servir, coloca una porción de la salsa de frijol en el plato y encima acomoda el chile relleno. Termina con un poco de crema y queso fresco. El resultado es un platillo sencillo pero muy lucidor: chile poblano tatemado, fideo seco con el sabor de tres chiles y una cremosa salsa de frijol. Una opción diferente para aprovechar ingredientes que quizá ya tienes en casa y preparar algo rico sin pasar todo el día en la cocina.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("directoalpaladar.com.mx")
    expect(recipe.canonical_url).to eq("https://www.directoalpaladar.com.mx/comida-mexicana/como-hacer-chiles-rellenos-fideo-seco-receta-facil-deliciosa-acompanada-salsa-frijol")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("Cristina Díaz")
    expect(recipe.description).to eq("Después de unos días de fiesta, puentes y mucha comida, se antoja preparar un platillo delicioso, fácil de hacer y que no requiera pasar...")
    expect(recipe.image).to eq("https://i.blogs.es/22a22d/chile-relleno/650_1200.jpeg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(60)
    expect(recipe.prep_time).to eq(60)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
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
    expect(recipe.links).to include("https://www.webedia.es/")
  end
end
