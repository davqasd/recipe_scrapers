# frozen_string_literal: true

RSpec.describe "thermomix-alzira.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_alzira", url: "https://thermomix-alzira.es/alicia-rodriguez-morant/carnes-y-aves/rollo-de-pollo-con-salsa-de-champinones-y-flan-de-chocolate") }

  it "reads the title" do
    expect(recipe.title).to eq("Rollo de pollo con salsa de champiñones y flan de chocolate")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "caramelo liquido",
      "130g leche entera o evaporada",
      "130g leche codensada",
      "1 huevo y una cucharada de cacao puro en polvo",
      "4 - 5 filetes de pechuga finos, Queso enmetal cortado a tiras gordas",
      "250g de espinacas congeladas (descongelar)",
      "12-14 lochas de panceta, 6 lonchas de lacon",
      "Sal, y pimienta",
      "100g de puerro y 1 diente de ajo",
      "80gr de champiñones",
      "40g de aceite de oliva",
      "100g de vino blanco",
      "500g de agua y una pastilla de caldo de verduras",
      "80g de nata o queso de untar",
      "Verduras variadas por ejemplo para ensaladilla"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "caramelo liquido" },
      { amount: 130.0, unit: "g", name: "leche entera o evaporada" },
      { amount: 130.0, unit: "g", name: "leche codensada" },
      { amount: 1.0, unit: nil, name: "huevo y una cucharada de cacao puro en polvo" },
      { amount: 4.0, unit: nil, name: "filetes de pechuga finos, Queso enmetal cortado a tiras gordas" },
      { amount: 250.0, unit: "g", name: "espinacas congeladas" },
      { amount: 12.0, unit: nil, name: "lochas de panceta, 6 lonchas de lacon" },
      { amount: nil, unit: nil, name: "Sal, y pimienta" },
      { amount: 100.0, unit: "g", name: "puerro y 1 diente de ajo" },
      { amount: 80.0, unit: "gr", name: "champiñones" },
      { amount: 40.0, unit: "g", name: "aceite de oliva" },
      { amount: 100.0, unit: "g", name: "vino blanco" },
      { amount: 500.0, unit: "g", name: "agua y una pastilla de caldo de verduras" },
      { amount: 80.0, unit: "g", name: "nata o queso de untar" },
      { amount: nil, unit: nil, name: "Verduras variadas por ejemplo para ensaladilla" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pon los ingredientes del flan en el vaso 10seg/vel4",
      "Pon el caramelo en las flaneras y reparte la mezcla del vaso. cubre cada flanera con papel de aluminio y reserva en la bandeja del varoma"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pon los ingredientes del flan en el vaso 10seg/vel4\nPon el caramelo en las flaneras y reparte la mezcla del vaso. cubre cada flanera con papel de aluminio y reserva en la bandeja del varoma")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-alzira.es")
    expect(recipe.canonical_url).to eq("https://thermomix-alzira.es/alicia-rodriguez-morant/carnes-y-aves/rollo-de-pollo-con-salsa-de-champinones-y-flan-de-chocolate")
    expect(recipe.site_name).to eq("Thermomix Valencia Sur")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("ALICIA RODRIGUEZ MORANT")
    expect(recipe.description).to eq("Rollo de pollo con salsa de champiñones y flan de chocolate, una receta de Carnes y aves, elaborada por ALICIA RODRIGUEZ MORANT. Descubre las mejores recetas de Blogosfera Thermomix Valencia Sur")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/e0581ca0b737f64362a3a0cbd78ce799_95f9773de2/e0581ca0b737f64362a3a0cbd78ce799_95f9773de2.jpg")
    expect(recipe.category).to eq("Carnes y aves")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(1)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Rollo de pollo con salsa de champiñones y flan de chocolate", "Carnes y aves"])
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
