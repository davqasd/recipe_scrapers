# frozen_string_literal: true

RSpec.describe "thermomix-castellon.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_castellon", url: "https://thermomix-castellon.es/alexandra-dippl/pescados-y-mariscos/bacalao-a-tres-bandas-con-thermomix-1") }

  it "reads the title" do
    expect(recipe.title).to eq("BACALAO A TRES BANDAS CON THERMOMIX")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "50 gr de cebolla",
      "1 diente de ajo",
      "500 gr de tomate triturado",
      "30 gr de aceite",
      "1 cucharadita de azucar",
      "1 cucharadita de sal",
      "1 pellizco de pimienta negra",
      "4 trozos de bacalao",
      "800 gr de patatas cortadas en rodajas",
      "100 gr de pimiento verde",
      "Lactonesa o alioli"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 50.0, unit: "gr", name: "cebolla" },
      { amount: 1.0, unit: "diente", name: "ajo" },
      { amount: 500.0, unit: "gr", name: "tomate triturado" },
      { amount: 30.0, unit: "gr", name: "aceite" },
      { amount: 1.0, unit: "cucharadita", name: "azucar" },
      { amount: 1.0, unit: "cucharadita", name: "sal" },
      { amount: 1.0, unit: nil, name: "pellizco de pimienta negra" },
      { amount: 4.0, unit: "trozos", name: "bacalao" },
      { amount: 800.0, unit: "gr", name: "patatas cortadas en rodajas" },
      { amount: 100.0, unit: "gr", name: "pimiento verde" },
      { amount: nil, unit: nil, name: "Lactonesa o alioli" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preparamos en la base del varoma las patatas cortadas en rodajas finas y el pimiento a tiras. Poner un hilo de aceite y sal y en la bandeja del varoma preparamos el bacalao con la piel hacia arriba",
      "Introducimos la cebolla y el ajo en el vaso y troceamos 2 seg vel 5",
      "Añadimos el aceite y sofreimos 5 min/Varoma/vel.1",
      "Añadimos el tomate, azucar, sal y pimienta, colocamos el varoma sin la bandeja y programamos 20min/varoma/vel.1",
      "Colocamos a bandeja del varoma y programamos 6 min/Varoma/vel.1",
      "Si queremos servir gratinado colocamos en una bandeja alternando capas de patata, pimiento y tomate, colocando por ultimo el bacalao. Ponemos una cucharada de lactonesa o alioli y gratinamos 5 minutos a 250º"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preparamos en la base del varoma las patatas cortadas en rodajas finas y el pimiento a tiras. Poner un hilo de aceite y sal y en la bandeja del varoma preparamos el bacalao con la piel hacia arriba\nIntroducimos la cebolla y el ajo en el vaso y troceamos 2 seg vel 5\nAñadimos el aceite y sofreimos 5 min/Varoma/vel.1\nAñadimos el tomate, azucar, sal y pimienta, colocamos el varoma sin la bandeja y programamos 20min/varoma/vel.1\nColocamos a bandeja del varoma y programamos 6 min/Varoma/vel.1\nSi queremos servir gratinado colocamos en una bandeja alternando capas de patata, pimiento y tomate, colocando por ultimo el bacalao. Ponemos una cucharada de lactonesa o alioli y gratinamos 5 minutos a 250º")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-castellon.es")
    expect(recipe.canonical_url).to eq("https://thermomix-castellon.es/alexandra-dippl/pescados-y-mariscos/bacalao-a-tres-bandas-con-thermomix-1")
    expect(recipe.site_name).to eq("Thermomix Castellón")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("ALEXANDRA DIPPL")
    expect(recipe.description).to eq("BACALAO A TRES BANDAS CON THERMOMIX, una receta de Pescados y mariscos, elaborada por ALEXANDRA DIPPL. Descubre las mejores recetas de Blogosfera Thermomix Castellón")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/0ee4d0780655e70ffca3b581cb4e22d2_c33858b844/0ee4d0780655e70ffca3b581cb4e22d2_c33858b844.jpg")
    expect(recipe.category).to eq("Pescados y mariscos")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["BACALAO A TRES BANDAS CON THERMOMIX", "Pescados y mariscos"])
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
