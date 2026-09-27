# frozen_string_literal: true

RSpec.describe "adrianasbestrecipes.com" do
  subject(:recipe) { scrape_cassette("com/adrianasbestrecipes", url: "https://www.adrianasbestrecipes.com/es/fajitas-de-ternera-estilo-tex-mex-receta-facil/") }

  it "reads the title" do
    expect(recipe.title).to eq("Fajitas de Ternera Estilo Tex-Mex Receta Fácil")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1/4 taza aceite de oliva",
      "1 cucharadita sal Kosher",
      "1 cucharadita pimienta negra (recién molida)",
      "1/2 cucharadita comino (en polvo)",
      "4 escalopes de ternera",
      "1 cucharada aceite de cocina (semilla de uva, vegetal o de maíz)",
      "1 pizca sal Kosher",
      "2 cebollas moradas (grandes o 3 pequeñas cortadas en julianas)",
      "3 jalapeños (grandes, sin tallo, desvenados y cortados en julianas)",
      "3 chiles morrones (rojo, amarillo y naranja cortados en julianas.)",
      "2 tazas queso chihuahua o monterrey jack (rallado)",
      "8 tortillas de harina (calientes)",
      "1 taza salsa taquera (o salsa de tu elección)",
      "4 tazas frijoles pintos (de olla calientes)",
      "4 tazas arroz a la mexicana (cocido y caliente)",
      "1 aguacate grande (cortado en rodajas)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 0.25, unit: "taza", name: "aceite de oliva" },
      { amount: 1.0, unit: "cucharadita", name: "sal Kosher" },
      { amount: 1.0, unit: "cucharadita", name: "pimienta negra" },
      { amount: 0.5, unit: "cucharadita", name: "comino" },
      { amount: 4.0, unit: nil, name: "escalopes de ternera" },
      { amount: 1.0, unit: "cucharada", name: "aceite de cocina" },
      { amount: 1.0, unit: "pizca", name: "sal Kosher" },
      { amount: 2.0, unit: nil, name: "cebollas moradas" },
      { amount: 3.0, unit: nil, name: "jalapeños" },
      { amount: 3.0, unit: nil, name: "chiles morrones" },
      { amount: 2.0, unit: "tazas", name: "queso chihuahua o monterrey jack" },
      { amount: 8.0, unit: nil, name: "tortillas de harina" },
      { amount: 1.0, unit: "taza", name: "salsa taquera" },
      { amount: 4.0, unit: "tazas", name: "frijoles pintos" },
      { amount: 4.0, unit: "tazas", name: "arroz a la mexicana" },
      { amount: 1.0, unit: nil, name: "aguacate grande" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "sazonar",
      "Sazona los escalopes de ternera con sal, pimienta, comino, aceite de oliva y frota. Refrigere hasta que esté listo para cocinar.",
      "calentar",
      "Usa una sartén para asar, agrega aceite de cocina y colócala en la estufa. Pon el fuego alto y calienta la sartén durante 2-3 minutos. Luego, reduce a medio fuego.",
      "asar",
      "Asa las cebollas durante 2-3 minutos a fuego medio hasta que estén ligeramente caramelizadas. Agrega una pizca de sal, ya que ayuda a que las cebollas se cocinen más rápido. Aparta la uso posterior.",
      "asar",
      "Asa los pimientos morrones y los jalapeños cortados en julianas durante 3-4 minutos a fuego medio. Agrega sal si es necesario. Aparta la uso posterior.",
      "asar",
      "Asa los escalopes de ternera por cada lado durante menos de un minuto a fuego medio a alto. Aparta la uso posterior.",
      "preparar",
      "Agrega los pimientos y las cebollas asados a una bandeja para hornear o a una sartén apta para horno. Agrega los escalopes de ternera cocidos y cubre con queso chihuahua rallado.",
      "hornear",
      "Configura el horno para asar a 400 grados Fahrenheit. Coloca la sartén dentro del horno y hornea durante 3-5 minutos hasta que el queso se gratine.",
      "servir",
      "Sirve las fajitas de ternera con tortillas de harina calientes, salsa picante mexicana o taquera, frijoles de olla, arroz y rodajas de aguacate."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Para condimentar la ternera", 4],
        ["Para las fajitas de ternera", 7],
        ["Para servir", 5]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("sazonar\nSazona los escalopes de ternera con sal, pimienta, comino, aceite de oliva y frota. Refrigere hasta que esté listo para cocinar.\ncalentar\nUsa una sartén para asar, agrega aceite de cocina y colócala en la estufa. Pon el fuego alto y calienta la sartén durante 2-3 minutos. Luego, reduce a medio fuego.\nasar\nAsa las cebollas durante 2-3 minutos a fuego medio hasta que estén ligeramente caramelizadas. Agrega una pizca de sal, ya que ayuda a que las cebollas se cocinen más rápido. Aparta la uso posterior.\nasar\nAsa los pimientos morrones y los jalapeños cortados en julianas durante 3-4 minutos a fuego medio. Agrega sal si es necesario. Aparta la uso posterior.\nasar\nAsa los escalopes de ternera por cada lado durante menos de un minuto a fuego medio a alto. Aparta la uso posterior.\npreparar\nAgrega los pimientos y las cebollas asados a una bandeja para hornear o a una sartén apta para horno. Agrega los escalopes de ternera cocidos y cubre con queso chihuahua rallado.\nhornear\nConfigura el horno para asar a 400 grados Fahrenheit. Coloca la sartén dentro del horno y hornea durante 3-5 minutos hasta que el queso se gratine.\nservir\nSirve las fajitas de ternera con tortillas de harina calientes, salsa picante mexicana o taquera, frijoles de olla, arroz y rodajas de aguacate.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("adrianasbestrecipes.com")
    expect(recipe.canonical_url).to eq("https://www.adrianasbestrecipes.com/es/fajitas-de-ternera-estilo-tex-mex-receta-facil/")
    expect(recipe.site_name).to eq("Adriana's Best Recipes")
    expect(recipe.language).to eq("es-ES")
    expect(recipe.author).to eq("Chef Adriana Martin")
    expect(recipe.description).to eq("Las exquisitas fajitas de ternera estilo Tex-Mex con delicioso queso gratinado son una opción tentadora para la temporada de parrilladas. ¡Sírvelas para compartir en familia o bien prepara un delicioso festín de tacos!")
    expect(recipe.image).to eq("https://www.adrianasbestrecipes.com/wp-content/uploads/2024/06/veal-scaloppini-meal-.jpeg")
    expect(recipe.category).to eq("Platillo Principal")
    expect(recipe.cuisine).to eq("Cocina Mexicana Fusion")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(15)
    expect(recipe.cook_time).to eq(20)
    expect(recipe.keywords).to eq(%w[fajitas Tacos ternera])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "1814 kcal",
      "carbohydrateContent" => "243 g",
      "proteinContent" => "87 g",
      "fatContent" => "54 g",
      "transFatContent" => "0.01 g",
      "cholesterolContent" => "183 mg",
      "saturatedFatContent" => "18 g",
      "sodiumContent" => "1927 mg",
      "fiberContent" => "28 g",
      "sugarContent" => "13 g",
      "unsaturatedFatContent" => "33 g",
      "servingSize" => "1 porción"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 1814.0 },
      { name: "carbohydrateContent", unit: "g", amount: 243.0 },
      { name: "proteinContent", unit: "g", amount: 87.0 },
      { name: "fatContent", unit: "g", amount: 54.0 },
      { name: "transFatContent", unit: "g", amount: 0.01 },
      { name: "cholesterolContent", unit: "mg", amount: 183.0 },
      { name: "saturatedFatContent", unit: "g", amount: 18.0 },
      { name: "sodiumContent", unit: "mg", amount: 1927.0 },
      { name: "fiberContent", unit: "g", amount: 28.0 },
      { name: "sugarContent", unit: "g", amount: 13.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 33.0 },
      { name: "servingSize", unit: "porción", amount: 1.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content")
  end
end
