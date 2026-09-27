# frozen_string_literal: true

RSpec.describe "thermomix-madrid-mendezalvaro.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_madrid_mendezalvaro", url: "https://thermomix-madrid-mendezalvaro.es/lucila-simon-fernandez/masas-panes-reposteria/rosquillas-de-san-isidro-1") }

  it "reads the title" do
    expect(recipe.title).to eq("ROSQUILLAS DE SAN ISIDRO")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 huevos",
      "90 g de azúcar",
      "120 g de aceite",
      "20 g de licor de anís",
      "5 g de anís en grano",
      "260 g de harina",
      "1 yema de huevo para pincelar",
      "Si queremos hacer rosquillas listas haremos una glasa con 1 clara y 150 g de azúcar"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: nil, name: "huevos" },
      { amount: 90.0, unit: "g", name: "azúcar" },
      { amount: 120.0, unit: "g", name: "aceite" },
      { amount: 20.0, unit: "g", name: "licor de anís" },
      { amount: 5.0, unit: "g", name: "anís en grano" },
      { amount: 260.0, unit: "g", name: "harina" },
      { amount: 1.0, unit: nil, name: "yema de huevo para pincelar" },
      { amount: nil, unit: nil, name: "Si queremos hacer rosquillas listas haremos una glasa con 1 clara y 150 g de azúcar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pone la mariposa en las cuchillas, añade al vaso los huevos y el azúcar y programa 5 minutos/vel 4.",
      "Incorpora el aceite, el licor de anís en grano y mezcla 5 seg/vel2.",
      "Retira la mariposa, añade la harina y mezcla 30 seg/vel 6. A continuación programa 5 min/función amasar. Deja reposar 15-20 minutos y mientras precalienta el horno a 220º",
      "Con las manos aceitadas haz bolitas del tamaño e introduce los dedos en el centro para hacer la forma de cada rosquilla. Colócalas en una bandeja de horno forrada con papel de hornear y pincela con la yema de huevo batida.",
      "Hornea unos 10 minutos a 220º y otros 10 minutos más a 180º tienen que quedar doraditas. Saca del horno y deja enfriar sobre una rejilla.",
      "1",
      "Si quieres hacer rosquillas listas prepara una glasa y barniza con ella la s rosquillas tontas. Aquí te dejo cómo hacer la glasa. https://backend.blogosferathermomix.es/admin/content-manager/collection-types/api::post.post/frnozo1mrk5t3batz58gswkr"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pone la mariposa en las cuchillas, añade al vaso los huevos y el azúcar y programa 5 minutos/vel 4.\nIncorpora el aceite, el licor de anís en grano y mezcla 5 seg/vel2.\nRetira la mariposa, añade la harina y mezcla 30 seg/vel 6. A continuación programa 5 min/función amasar. Deja reposar 15-20 minutos y mientras precalienta el horno a 220º\nCon las manos aceitadas haz bolitas del tamaño e introduce los dedos en el centro para hacer la forma de cada rosquilla. Colócalas en una bandeja de horno forrada con papel de hornear y pincela con la yema de huevo batida.\nHornea unos 10 minutos a 220º y otros 10 minutos más a 180º tienen que quedar doraditas. Saca del horno y deja enfriar sobre una rejilla.\n1\nSi quieres hacer rosquillas listas prepara una glasa y barniza con ella la s rosquillas tontas. Aquí te dejo cómo hacer la glasa. https://backend.blogosferathermomix.es/admin/content-manager/collection-types/api::post.post/frnozo1mrk5t3batz58gswkr")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-madrid-mendezalvaro.es")
    expect(recipe.canonical_url).to eq("https://thermomix-madrid-mendezalvaro.es/lucila-simon-fernandez/masas-panes-reposteria/rosquillas-de-san-isidro-1")
    expect(recipe.site_name).to eq("Thermomix Madrid Mendez Alvaro")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("*LUCILA SIMON FERNANDEZ")
    expect(recipe.description).to eq("Es una masa muy pegajosa, si no puedes hacer bolas con las manos coge porciones con la cuchara y deja sobre la bandeja, luego haces un agujero con el dedo y listo.")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/9a8ff7d4_ed3c_4d9c_9ad4_1c6f6f7cb608_fd9b067c82/9a8ff7d4_ed3c_4d9c_9ad4_1c6f6f7cb608_fd9b067c82.jpg")
    expect(recipe.category).to eq("Masas, panes y repostería")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("30 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["ROSQUILLAS DE SAN ISIDRO", "Masas", "panes y repostería"])
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
