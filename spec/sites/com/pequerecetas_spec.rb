# frozen_string_literal: true

RSpec.describe "pequerecetas.com" do
  subject(:recipe) { scrape_cassette("com/pequerecetas", url: "https://www.pequerecetas.com/receta/tarta-de-queso-la-vina-en-freidora-de-aire/") }

  it "reads the title" do
    expect(recipe.title).to eq("Tarta de Queso La Viña en freidora de aire")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "570 g de queso crema",
      "280 g de nata líquida para montar",
      "4 huevos medianos",
      "150 g de azúcar",
      "6 g de maicena"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 570.0, unit: "g", name: "queso crema" },
      { amount: 280.0, unit: "g", name: "nata líquida para montar" },
      { amount: 4.0, unit: nil, name: "huevos medianos" },
      { amount: 150.0, unit: "g", name: "azúcar" },
      { amount: 6.0, unit: "g", name: "maicena" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preparamos los ingredientes",
      "Ponemos todos los ingredientes en un bol amplio. Batimos con una batidora de varillas hasta que todo se encuentre integrado.",
      "Forramos el molde",
      "Preparamos el molde forrándolo con papel de horno que previamente habremos humedecido con agua y arrugado para que se adapte bien sin necesidad de recortarlo. Mientras precalentamos la freidora de aire a 160ºC durante 5 minutos.",
      "Vertemos en el molde",
      "Ponemos la masa de la tarta de queso en el molde. Si sobra mucho papel de horno recórtalo ligeramente para evitar que toque la resistencia de la freidora de aire.",
      "Horneamos en la freidora de aire",
      "Horneamos en nuestra airfryer a 160ºC durante 40 minutos. Una vez finalice verás que la superficie está dorada, y que la tarta todavía se bambolea, pero no te preocupes, es normal en este tipo de tarta de queso. Deja que repose durante media hora dentro de la freidora de aire.",
      "Refrigeramos durante al menos dos horas en el frigorífico, y si puedes durante más tiempo o incluso de un día para otro, manteniéndola en el mismo molde.",
      "Servimos",
      "Ahora ya solo nos queda sacar con cuidado la tarta del molde, despegar el papel de horno ¡y comernos esta deliciosa tarta de queso La Viña!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preparamos los ingredientes\nPonemos todos los ingredientes en un bol amplio. Batimos con una batidora de varillas hasta que todo se encuentre integrado.\nForramos el molde\nPreparamos el molde forrándolo con papel de horno que previamente habremos humedecido con agua y arrugado para que se adapte bien sin necesidad de recortarlo. Mientras precalentamos la freidora de aire a 160ºC durante 5 minutos.\nVertemos en el molde\nPonemos la masa de la tarta de queso en el molde. Si sobra mucho papel de horno recórtalo ligeramente para evitar que toque la resistencia de la freidora de aire.\nHorneamos en la freidora de aire\nHorneamos en nuestra airfryer a 160ºC durante 40 minutos. Una vez finalice verás que la superficie está dorada, y que la tarta todavía se bambolea, pero no te preocupes, es normal en este tipo de tarta de queso. Deja que repose durante media hora dentro de la freidora de aire.\nRefrigeramos durante al menos dos horas en el frigorífico, y si puedes durante más tiempo o incluso de un día para otro, manteniéndola en el mismo molde.\nServimos\nAhora ya solo nos queda sacar con cuidado la tarta del molde, despegar el papel de horno ¡y comernos esta deliciosa tarta de queso La Viña!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("pequerecetas.com")
    expect(recipe.canonical_url).to eq("https://www.pequerecetas.com/receta/tarta-de-queso-la-vina-en-freidora-de-aire/")
    expect(recipe.site_name).to eq("Recetas de cocina fácil para toda la familia - Pequerecetas")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("Elena Sepúlveda")
    expect(recipe.description).to eq("Receta de tarta de queso La Viña en freidora de aire, la mejor tarta de queso por sus ingredientes, sencillez y sabor ¡queda perfecta en la airfryer!")
    expect(recipe.image).to eq("https://www.pequerecetas.com/wp-content/uploads/2024/02/tarta-de-queso-en-freidora-de-aire.jpg")
    expect(recipe.category).to eq("Recetas de Meriendas Fáciles, Recetas de Postres Caseros")
    expect(recipe.cuisine).to eq("Recetas Españolas, Recetas Vascas")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to eq(5)
    expect(recipe.cook_time).to eq(40)
    expect(recipe.keywords).to eq(["fácil", "rápida", "airfryer", "tarta de queso", "tarta de queso la viña"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.19)
    expect(recipe.ratings_count).to eq(105)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "calories" => "375kcal por 100g" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 375.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#brx-content")
  end
end
