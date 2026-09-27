# frozen_string_literal: true

RSpec.describe "thermomix-santander.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_santander", url: "https://thermomix-santander.es/maria-luisa-restegui-rebolledo/coccion-varoma/pan-de-molde-sin-corteza-1") }

  it "reads the title" do
    expect(recipe.title).to eq("Pan de molde sin corteza")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 - 2 cucharaditas de aceite de oliva, para untar el molde",
      "1150 gr de agua",
      "10 gr de levadura prensada fresca",
      "250 gr de harina de fuerza",
      "1 cucharadita de sal",
      "Utensilios útiles: molde de cake de 1 litro, papel de hornear y rejilla."
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "cucharaditas", name: "aceite de oliva, para untar el molde" },
      { amount: 1150.0, unit: "gr", name: "agua" },
      { amount: 10.0, unit: "gr", name: "levadura prensada fresca" },
      { amount: 250.0, unit: "gr", name: "harina de fuerza" },
      { amount: 1.0, unit: "cucharadita", name: "sal" },
      { amount: nil, unit: nil, name: "Utensilios útiles: molde de cake de 1 litro, papel de hornear y rejilla." }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Engrase con aceite de oliva un molde de cake de 1 litro de capacidad y reserve.",
      "Ponga en el vaso 150 gr de agua y la levadura y programe 2 min/37°C/vel 1.",
      "Añada la harina de fuerza y la sal y e inicie Amasar 2 min 30 seg/ vel. espiga. Vierta la masa sobre una superficie de trabajo espolvoreada con harina y amásela ligeramente formando un cilindro. Coloque la masa en el molde reservado y deje reposar hasta que doble su volumen (aprox. 45-60 minutos, en función de la temperatura ambiente). Mientras tanto, lave el vaso.",
      "Ponga en el vaso 1000 gr de agua, sitúe el recipiente Varoma en su posición con el molde, cubra con un trozo de papel de hornear y tape el Varoma. Programe 45 min/Varoma/vel 1. Retire el Varoma, espere unos minutos, desmolde sobre una rejilla y deje enfriar. Corte en rebanadas y sirva."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Engrase con aceite de oliva un molde de cake de 1 litro de capacidad y reserve.\nPonga en el vaso 150 gr de agua y la levadura y programe 2 min/37°C/vel 1.\nAñada la harina de fuerza y la sal y e inicie Amasar 2 min 30 seg/ vel. espiga. Vierta la masa sobre una superficie de trabajo espolvoreada con harina y amásela ligeramente formando un cilindro. Coloque la masa en el molde reservado y deje reposar hasta que doble su volumen (aprox. 45-60 minutos, en función de la temperatura ambiente). Mientras tanto, lave el vaso.\nPonga en el vaso 1000 gr de agua, sitúe el recipiente Varoma en su posición con el molde, cubra con un trozo de papel de hornear y tape el Varoma. Programe 45 min/Varoma/vel 1. Retire el Varoma, espere unos minutos, desmolde sobre una rejilla y deje enfriar. Corte en rebanadas y sirva.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-santander.es")
    expect(recipe.canonical_url).to eq("https://thermomix-santander.es/maria-luisa-restegui-rebolledo/coccion-varoma/pan-de-molde-sin-corteza-1")
    expect(recipe.site_name).to eq("Thermomix Santander")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("Mª LUISA RESTEGUI REBOLLEDO")
    expect(recipe.description).to eq("Pan de molde sin corteza, una receta de Cocción en varoma, elaborada por Mª LUISA RESTEGUI REBOLLEDO. Descubre las mejores recetas de Blogosfera Thermomix Santander")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/Pan_de_molde_sin_corteza_en_el_varoma_41a795c2a8/Pan_de_molde_sin_corteza_en_el_varoma_41a795c2a8.jpg")
    expect(recipe.category).to eq("Cocción en varoma")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(2)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Pan de molde sin corteza", "Cocción en varoma"])
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
