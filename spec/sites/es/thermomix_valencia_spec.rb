# frozen_string_literal: true

RSpec.describe "thermomix-valencia.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_valencia", url: "https://thermomix-valencia.es/amparo-beneyto/masas-panes-reposteria/pan-de-platano-con-thermomix-receta-facil-rapida-y-jugosa") }

  it "reads the title" do
    expect(recipe.title).to eq("Pan de Plátano con Thermomix: Receta fácil, rápida y jugosa")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "75g mantequilla en trozos",
      "350g de plátano (maduro en trozos)",
      "160g azúcar",
      "1 huevo",
      "1 cucharadita de vainilla líquida",
      "175g harina de repostería",
      "20g de cacao puro en polvo",
      "1/2 cucharadita de bicarbonato",
      "1 pellizco de sal",
      "100g de pepitas de chocolate negro"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 75.0, unit: "g", name: "mantequilla en trozos" },
      { amount: 350.0, unit: "g", name: "plátano" },
      { amount: 160.0, unit: "g", name: "azúcar" },
      { amount: 1.0, unit: nil, name: "huevo" },
      { amount: 1.0, unit: "cucharadita", name: "vainilla líquida" },
      { amount: 175.0, unit: "g", name: "harina de repostería" },
      { amount: 20.0, unit: "g", name: "cacao puro en polvo" },
      { amount: 0.5, unit: "cucharadita", name: "bicarbonato" },
      { amount: 1.0, unit: nil, name: "pellizco de sal" },
      { amount: 100.0, unit: "g", name: "pepitas de chocolate negro" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Precaliente el horno 180ºC. Engrase y enharine un molde de cake de 1,5 litros de capacidad y reserve.",
      "Ponga en el vaso la mantequilla y programe 4 minutos temperatura 60ºC velocidad 1.",
      "Añada el plátano, el azúcar, el huevo y la vainilla y mezcle 15 segundos velocidad 5. Con la espátula baje los ingredientes hacia el fondo del vaso.",
      "Agregue la harina, el cacao puro en polvo, el bicarbonato, la sal y las pepitas de chocolate, mezcle 15 segundos velocidad 5. Vierta la masa en el molde preparado y extiéndela con la espátula para nivelarla.",
      "Hornee durante 50 minutos temperatura 180ªC o hasta que al pinchar con una brocheta, salga limpia.",
      "Retire del horno y mantenga en el molde 15 minutos. Después, desmolde sobre una rejilla y deje enfriar antes de servir."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Precaliente el horno 180ºC. Engrase y enharine un molde de cake de 1,5 litros de capacidad y reserve.\nPonga en el vaso la mantequilla y programe 4 minutos temperatura 60ºC velocidad 1.\nAñada el plátano, el azúcar, el huevo y la vainilla y mezcle 15 segundos velocidad 5. Con la espátula baje los ingredientes hacia el fondo del vaso.\nAgregue la harina, el cacao puro en polvo, el bicarbonato, la sal y las pepitas de chocolate, mezcle 15 segundos velocidad 5. Vierta la masa en el molde preparado y extiéndela con la espátula para nivelarla.\nHornee durante 50 minutos temperatura 180ªC o hasta que al pinchar con una brocheta, salga limpia.\nRetire del horno y mantenga en el molde 15 minutos. Después, desmolde sobre una rejilla y deje enfriar antes de servir.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-valencia.es")
    expect(recipe.canonical_url).to eq("https://thermomix-valencia.es/amparo-beneyto/masas-panes-reposteria/pan-de-platano-con-thermomix-receta-facil-rapida-y-jugosa")
    expect(recipe.site_name).to eq("Thermomix Valencia")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("AMPARO BENEYTO BELDA")
    expect(recipe.description).to eq("Puedes añadir nueces, pasas para darle un toque extra. Guárdalo en un recipiente hermético, se mantiene húmedo por varios días. También lo puedes congelar por porciones.")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/0f03325dc791b282c1125232db82229a_69b248858d/0f03325dc791b282c1125232db82229a_69b248858d.jpg")
    expect(recipe.category).to eq("Masas, panes y repostería")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Pan de Plátano con Thermomix: Receta fácil", "rápida y jugosa", "Masas", "panes y repostería"])
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
