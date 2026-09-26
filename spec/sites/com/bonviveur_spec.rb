# frozen_string_literal: true

RSpec.describe "bonviveur.com" do
  subject(:recipe) { scrape_cassette("com/bonviveur", url: "https://bonviveur.com/es/recetas/vindaloo-de-cerdo") }

  it "reads the title" do
    expect(recipe.title).to eq("Vindaloo de cerdo")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "800 g de carne de cerdo para guisar, preferiblemente aguja, cabecero o paleta",
      "1 cucharadita de sal",
      "3 cucharadas de vinagre de vino",
      "8-10 guindillas rojas secas",
      "1 cucharada de pimentón",
      "½ cucharadita de semillas de comino",
      "1 rama de canela",
      "10 clavos de olor",
      "½ cucharadita de pimienta negra en grano",
      "4 o 5 vainas de cardamomo verde",
      "10 dientes de ajo",
      "1 trozo de jengibre fresco de 3 cm",
      "1 pizca de sal",
      "½ cucharadita de cúrcuma molida",
      "2 cucharadas de vinagre de vino",
      "3 o 4 cucharadas de aceite suave",
      "6 dientes de ajo",
      "2 cebollas medianas",
      "2 tomates",
      "2 o 3 guindillas verdes frescas",
      "1 cucharadita de azúcar",
      "1 cucharada de vinagre de vino",
      "Cilantro fresco",
      "1 guindilla roja"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 800.0, unit: "g", name: "carne de cerdo para guisar, preferiblemente aguja, cabecero o paleta" },
      { amount: 1.0, unit: "cucharadita", name: "sal" },
      { amount: 3.0, unit: "cucharadas", name: "vinagre de vino" },
      { amount: 8.0, unit: nil, name: "guindillas rojas secas" },
      { amount: 1.0, unit: "cucharada", name: "pimentón" },
      { amount: 0.5, unit: "cucharadita", name: "semillas de comino" },
      { amount: 1.0, unit: "rama", name: "canela" },
      { amount: 10.0, unit: nil, name: "clavos de olor" },
      { amount: 0.5, unit: "cucharadita", name: "pimienta negra en grano" },
      { amount: 4.0, unit: nil, name: "vainas de cardamomo verde" },
      { amount: 10.0, unit: "dientes", name: "ajo" },
      { amount: 1.0, unit: "trozo", name: "jengibre fresco de 3 cm" },
      { amount: 1.0, unit: "pizca", name: "sal" },
      { amount: 0.5, unit: "cucharadita", name: "cúrcuma molida" },
      { amount: 2.0, unit: "cucharadas", name: "vinagre de vino" },
      { amount: 3.0, unit: "cucharadas", name: "aceite suave" },
      { amount: 6.0, unit: "dientes", name: "ajo" },
      { amount: 2.0, unit: nil, name: "cebollas medianas" },
      { amount: 2.0, unit: nil, name: "tomates" },
      { amount: 2.0, unit: nil, name: "guindillas verdes frescas" },
      { amount: 1.0, unit: "cucharadita", name: "azúcar" },
      { amount: 1.0, unit: "cucharada", name: "vinagre de vino" },
      { amount: nil, unit: nil, name: "Cilantro fresco" },
      { amount: 1.0, unit: nil, name: "guindilla roja" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Cortamos el cerdo en dados, lo mezclamos con sal y vinagre y lo marinamos de 2 a 3 horas",
      "Molemos las guindillas rojas con el pimentón, el comino, la canela, los clavos, la pimienta y el cardamomo",
      "Machacamos el ajo y el jengibre y hacemos una pasta con la cúrcuma, el vinagre y las especias molidas",
      "Añadimos la mitad de la pasta al cerdo, mezclamos y dejamos marinar 12 horas como mínimo",
      "En una olla, doramos los ajos machacados en el aceite, añadimos las cebollas en juliana, sofreímos hasta que queden pochadas e incorporamos la mitad de las guindillas verdes en tiras finas",
      "Echamos a la olla la pasta de especias restante, los tomates en dados, el azúcar y el vinagre y dejamos que reduzca",
      "Añadimos el cerdo con toda su marinada y cocinamos a fuego fuerte un par de minutos",
      "Cubrimos a ras con agua, tapamos y cocinamos a fuego suave durante unos 30 minutos, destapamos y continuamos 15 minutos más",
      "Añadimos la guindilla verde restante en tiras, mezclamos y servimos el vindaloo acompañado con cilantro y guindilla roja fresca picada por encima"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Cortamos el cerdo en dados, lo mezclamos con sal y vinagre y lo marinamos de 2 a 3 horas\nMolemos las guindillas rojas con el pimentón, el comino, la canela, los clavos, la pimienta y el cardamomo\nMachacamos el ajo y el jengibre y hacemos una pasta con la cúrcuma, el vinagre y las especias molidas\nAñadimos la mitad de la pasta al cerdo, mezclamos y dejamos marinar 12 horas como mínimo\nEn una olla, doramos los ajos machacados en el aceite, añadimos las cebollas en juliana, sofreímos hasta que queden pochadas e incorporamos la mitad de las guindillas verdes en tiras finas\nEchamos a la olla la pasta de especias restante, los tomates en dados, el azúcar y el vinagre y dejamos que reduzca\nAñadimos el cerdo con toda su marinada y cocinamos a fuego fuerte un par de minutos\nCubrimos a ras con agua, tapamos y cocinamos a fuego suave durante unos 30 minutos, destapamos y continuamos 15 minutos más\nAñadimos la guindilla verde restante en tiras, mezclamos y servimos el vindaloo acompañado con cilantro y guindilla roja fresca picada por encima")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("bonviveur.com")
    expect(recipe.canonical_url).to eq("https://bonviveur.com/es/recetas/vindaloo-de-cerdo")
    expect(recipe.site_name).to eq("Bon Viveur")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("Damián Serrano")
    expect(recipe.description).to eq("A continuación, vamos a explicar cómo hacer vindaloo de cerdo en casa, un curry de carne marinada en vinagre, ajo y más especias. Con consejos para que lo prepares con ingredientes de aquí y, además, puedas adaptar el nivel de picante a tu gusto.")
    expect(recipe.image).to eq("https://imag.bonviveur.com/vindaloo-de-cerdo-con-cilantro-y-guindilla.jpg")
    expect(recipe.category).to eq("Plato principal")
    expect(recipe.cuisine).to eq("India")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(105)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(75)
    expect(recipe.keywords).to eq(["Vindaloo"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to be_nil
    expect(recipe.ratings_count).to be_nil
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "calories" => "612 calories" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 612.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://bonviveur.com/es/")
  end
end
