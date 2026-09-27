# frozen_string_literal: true

RSpec.describe "hellofresh.es" do
  subject(:recipe) { scrape_cassette("es/hellofresh", url: "https://www.hellofresh.es/recipes/todo-al-horno-extra-de-alitas-con-miel-y-salsa-de-soja-69411a22351bdfaa40d7f4d5") }

  it "reads the title" do
    expect(recipe.title).to eq("¡Todo al horno! Alitas con miel y salsa de soja con ensalada de pepino y arroz al coco")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 paquete Miel",
      "1 sobre(s) Salsa de soja",
      "1 paquete Alitas de pollo",
      "180 mililitro(s) Leche de coco",
      "150 gramo(s) Arroz basmati",
      "1 unidad(es) Pepino",
      "5 gramo(s) Semillas de sésamo negras",
      "1 pizca(s) Sal y pimienta",
      "2 cucharada(s) Aceite de oliva",
      "120 mililitro(s) Agua",
      "2 cucharadita(s) Vinagre"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "paquete", name: "Miel" },
      { amount: 1.0, unit: nil, name: "sobre Salsa de soja" },
      { amount: 1.0, unit: "paquete", name: "Alitas de pollo" },
      { amount: 180.0, unit: nil, name: "mililitro Leche de coco" },
      { amount: 150.0, unit: nil, name: "gramo Arroz basmati" },
      { amount: 1.0, unit: nil, name: "unidad Pepino" },
      { amount: 5.0, unit: nil, name: "gramo Semillas de sésamo negras" },
      { amount: 1.0, unit: "pizca", name: "Sal y pimienta" },
      { amount: 2.0, unit: "cucharada", name: "Aceite de oliva" },
      { amount: 120.0, unit: nil, name: "mililitro Agua" },
      { amount: 2.0, unit: "cucharadita", name: "Vinagre" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "¡Asegúrate de utilizar las cantidades indicadas a la izquierda para preparar tu receta! Precalienta el horno a 220ºC. En un bol, agrega la miel, la salsa de soja, las alitas de pollo, un chorrito de aceite, sal y pimienta. Remueve. Coloca las alitas de pollo en un lado de una bandeja de horno con papel de horno. RECUERDA: Lávate las manos y los utensilios de cocina después de manipular carne cruda.",
      "En una fuente para horno, agrega la leche de coco, el arroz y el agua. Mezcla bien y coloca la fuente en el otro lado de la bandeja de horno, junto a las alitas. Hornea todo a media altura 25-30 min o hasta que el arroz esté tierno y las alitas queden doradas y bien cocinadas. Gira las alitas a mitad de cocción.",
      "Retira los extremos del pepino y córtalo por la mitad a lo largo. Corta en medias lunas finas. En un bol, mezcla el vinagre, chorrito de aceite, sal y pimienta. Agrega el pepino y la mitad de las semillas de sésamo y mezcla bien. Una vez el arroz esté listo, remueve para separar.",
      "Sirve el arroz, las alitas de pollo y la ensalada de pepino en platos, por separado. Agrega las semillas de sésamo negro restantes sobre el plato."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("¡Asegúrate de utilizar las cantidades indicadas a la izquierda para preparar tu receta! Precalienta el horno a 220ºC. En un bol, agrega la miel, la salsa de soja, las alitas de pollo, un chorrito de aceite, sal y pimienta. Remueve. Coloca las alitas de pollo en un lado de una bandeja de horno con papel de horno. RECUERDA: Lávate las manos y los utensilios de cocina después de manipular carne cruda.\nEn una fuente para horno, agrega la leche de coco, el arroz y el agua. Mezcla bien y coloca la fuente en el otro lado de la bandeja de horno, junto a las alitas. Hornea todo a media altura 25-30 min o hasta que el arroz esté tierno y las alitas queden doradas y bien cocinadas. Gira las alitas a mitad de cocción.\nRetira los extremos del pepino y córtalo por la mitad a lo largo. Corta en medias lunas finas. En un bol, mezcla el vinagre, chorrito de aceite, sal y pimienta. Agrega el pepino y la mitad de las semillas de sésamo y mezcla bien. Una vez el arroz esté listo, remueve para separar.\nSirve el arroz, las alitas de pollo y la ensalada de pepino en platos, por separado. Agrega las semillas de sésamo negro restantes sobre el plato.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hellofresh.es")
    expect(recipe.canonical_url).to eq("https://www.hellofresh.es/recipes/alitas-de-pollo-marinadas-con-miel-y-soja-6841465d5a41964b9c0385bd")
    expect(recipe.site_name).to eq("HelloFresh")
    expect(recipe.language).to eq("es-ES")
    expect(recipe.author).to eq("HelloFresh")
    expect(recipe.description).to be_nil
    expect(recipe.image).to eq("https://img.hellofresh.com/f_auto,fl_lossy,h_640,q_auto,w_1200/")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to eq("Asiática")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(35)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.150390557944775)
    expect(recipe.ratings_count).to eq(64)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "877 kcal",
      "fatContent" => "41.2 g",
      "saturatedFatContent" => "19.1 g",
      "carbohydrateContent" => "82.3 g",
      "sugarContent" => "16.4 g",
      "proteinContent" => "61.3 g",
      "fiberContent" => "2.2 g",
      "sodiumContent" => "2.3 mg",
      "servingSize" => "577"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 877.0 },
      { name: "fatContent", unit: "g", amount: 41.2 },
      { name: "saturatedFatContent", unit: "g", amount: 19.1 },
      { name: "carbohydrateContent", unit: "g", amount: 82.3 },
      { name: "sugarContent", unit: "g", amount: 16.4 },
      { name: "proteinContent", unit: "g", amount: 61.3 },
      { name: "fiberContent", unit: "g", amount: 2.2 },
      { name: "sodiumContent", unit: "mg", amount: 2.3 },
      { name: "servingSize", unit: nil, amount: 577.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#page")
  end
end
