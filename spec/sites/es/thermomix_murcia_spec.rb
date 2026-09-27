# frozen_string_literal: true

RSpec.describe "thermomix-murcia.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_murcia", url: "https://thermomix-murcia.es/caridad-sanmartin-allegue/aperitivos-entrantes-tapas/magra-con-tomate-receta-de-esta-tipica-tapa-murciana-en-thermomix") }

  it "reads the title" do
    expect(recipe.title).to eq("MAGRA CON TOMATE, receta de esta típica TAPA MURCIANA en THERMOMIX")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "200 g pimiento verde en tiras de unos 3 cm por 2 cm",
      "90 g de aceite de oliva virgen extra",
      "600 g magra de cerdo en dados",
      "800 g de tomate natural triturado",
      "1-2 cucharaditas de sal",
      "1 cucharadita de azúcar",
      "pimienta molida al gusto"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 200.0, unit: "g", name: "pimiento verde en tiras de unos 3 cm por 2 cm" },
      { amount: 90.0, unit: "g", name: "aceite de oliva virgen extra" },
      { amount: 600.0, unit: "g", name: "magra de cerdo en dados" },
      { amount: 800.0, unit: "g", name: "tomate natural triturado" },
      { amount: 1.0, unit: "cucharaditas", name: "sal" },
      { amount: 1.0, unit: "cucharadita", name: "azúcar" },
      { amount: nil, unit: nil, name: "pimienta molida al gusto" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pon en el vaso los trozos de pimiento y el aceite e inicia Alta temperatura (12 min/160° Intenso) *Para TM6: hacer este paso con la receta \"pimientos dorados\" de la colección \"Básicos para dorar I\" de Cookidoo*Para TM5: programar 12 min/120º/giro inverso/vel cuchara (el sofrito va a quedar bien aunque la TM5 no tiene Alta Temperatura por lo que los pimientos no se van a dorar)Saca los pimientos separándolos del aceite y reserva.",
      "Activa la Balanza y pesa el aceite de los pimientos, completa con aceite de oliva nuevo hasta alcanzar 20 g. Calienta el aceite programando 2 min y 30 seg/120°/vel 1",
      "Añade 300 g de magra de cerdo en dados, reparte bien la carne alrededor de las cuchillas para que no quede amontonada y activa Alta temperatura (7 min y 30 seg/ 160°/ intenso). *Para TM6: hacer este paso con la receta \"Dados de solomillo de cerdo dorados\" de la colección \"Básicos para dorar I\" de Cookidoo*Para TM5: programar 7 min y 30 seg/120º/giro inverso/vel cuchara (la carne quedará rehogada, la TM5 no tiene Alta Temperatura por lo que no se van a dorar).Retira la carne del vaso colando el aceite. Con la espátula despega todo lo posible del fondo del vaso.",
      "Activa la Balanza y pesa el aceite de la carne, completa con aceite de oliva nuevo hasta alcanzar 20 g. Calienta el aceite programando 2 min y 30 seg/120°/vel 1",
      "Añade el resto de la carne (los otros 300 g de magra), reparte bien la carne alrededor de las cuchillas para que no quede amontonada y activa Alta temperatura (7 min y 30 seg/ 160°/ intenso).*Para TM6: hacer este paso con la misma receta del paso 3 \"Dados de solomillo de cerdo dorados\" de la colección \"Básicos para dorar I\" de Cookidoo*Para TM5: programar 7 min y 30 seg/120º/giro inverso/vel cuchara (la carne quedará rehogada, la TM5 no tiene Alta Temperatura por lo que no se van a dorar).Retira la carne del vaso colando el aceite. Con la espátula despega todo lo posible del fondo del vaso. NOTA: Sí queda algún resto agarrado en la base del vaso desglasa con un chorrito de vino blanco (50-100 g) activando \"Hervidor\". Con la espátula extrae la pomada resultante y échala sobre la carne.",
      "Pon el aceite de la carne en el vaso y completa hasta alcanzar 50 g, añade el tomate, 1-2 cucharaditas de sal y otra de azúcar y pimienta molida al gusto. Programa 10 min/Varoma/vel 1.Incorpora la carne reservada y cocina 15 min/Varoma/giro inverso/ vel cuchara.Añade los pimientos reservados al vaso y programa 1 min/Varoma/giro inverso/ vel cuchara.Vierte la magra con tomate en una fuente de servir."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pon en el vaso los trozos de pimiento y el aceite e inicia Alta temperatura (12 min/160° Intenso) *Para TM6: hacer este paso con la receta \"pimientos dorados\" de la colección \"Básicos para dorar I\" de Cookidoo*Para TM5: programar 12 min/120º/giro inverso/vel cuchara (el sofrito va a quedar bien aunque la TM5 no tiene Alta Temperatura por lo que los pimientos no se van a dorar)Saca los pimientos separándolos del aceite y reserva.\nActiva la Balanza y pesa el aceite de los pimientos, completa con aceite de oliva nuevo hasta alcanzar 20 g. Calienta el aceite programando 2 min y 30 seg/120°/vel 1\nAñade 300 g de magra de cerdo en dados, reparte bien la carne alrededor de las cuchillas para que no quede amontonada y activa Alta temperatura (7 min y 30 seg/ 160°/ intenso). *Para TM6: hacer este paso con la receta \"Dados de solomillo de cerdo dorados\" de la colección \"Básicos para dorar I\" de Cookidoo*Para TM5: programar 7 min y 30 seg/120º/giro inverso/vel cuchara (la carne quedará rehogada, la TM5 no tiene Alta Temperatura por lo que no se van a dorar).Retira la carne del vaso colando el aceite. Con la espátula despega todo lo posible del fondo del vaso.\nActiva la Balanza y pesa el aceite de la carne, completa con aceite de oliva nuevo hasta alcanzar 20 g. Calienta el aceite programando 2 min y 30 seg/120°/vel 1\nAñade el resto de la carne (los otros 300 g de magra), reparte bien la carne alrededor de las cuchillas para que no quede amontonada y activa Alta temperatura (7 min y 30 seg/ 160°/ intenso).*Para TM6: hacer este paso con la misma receta del paso 3 \"Dados de solomillo de cerdo dorados\" de la colección \"Básicos para dorar I\" de Cookidoo*Para TM5: programar 7 min y 30 seg/120º/giro inverso/vel cuchara (la carne quedará rehogada, la TM5 no tiene Alta Temperatura por lo que no se van a dorar).Retira la carne del vaso colando el aceite. Con la espátula despega todo lo posible del fondo del vaso. NOTA: Sí queda algún resto agarrado en la base del vaso desglasa con un chorrito de vino blanco (50-100 g) activando \"Hervidor\". Con la espátula extrae la pomada resultante y échala sobre la carne.\nPon el aceite de la carne en el vaso y completa hasta alcanzar 50 g, añade el tomate, 1-2 cucharaditas de sal y otra de azúcar y pimienta molida al gusto. Programa 10 min/Varoma/vel 1.Incorpora la carne reservada y cocina 15 min/Varoma/giro inverso/ vel cuchara.Añade los pimientos reservados al vaso y programa 1 min/Varoma/giro inverso/ vel cuchara.Vierte la magra con tomate en una fuente de servir.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-murcia.es")
    expect(recipe.canonical_url).to eq("https://thermomix-murcia.es/caridad-sanmartin-allegue/aperitivos-entrantes-tapas/magra-con-tomate-receta-de-esta-tipica-tapa-murciana-en-thermomix")
    expect(recipe.site_name).to eq("Thermomix Murcia")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("CARIDAD SANMARTIN ALLEGUE")
    expect(recipe.description).to eq("Es importante sellar bien la carne para que no pierda sus jugos, la función Alta Temperatura (TM7 y TM6) es perfecta para ello. La Función Vapor reduce el tomate mientras se fríe y consigue un tomate frito espeso con una carne tierna gracias a Thermomix")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/cfa10f2a3c90349d0234653c6e036236_86efda7b5b/cfa10f2a3c90349d0234653c6e036236_86efda7b5b.jpg")
    expect(recipe.category).to eq("Aperitivos, entrantes y tapas")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["MAGRA CON TOMATE", "receta de esta típica TAPA MURCIANA en THERMOMIX", "Aperitivos", "entrantes y tapas"])
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
