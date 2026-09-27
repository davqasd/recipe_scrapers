# frozen_string_literal: true

RSpec.describe "thermomix-esplugues.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_esplugues", url: "https://thermomix-esplugues.es/eugenia-arenas-ylla/masas-panes-reposteria/mi-receta-de-10-en-cookidoo") }

  it "reads the title" do
    expect(recipe.title).to eq("\"Mi receta de 10 en Cookidoo\"")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "120 gr de leche (y algo más para pincelar)",
      "15 gr de levadura prensada fresca",
      "15 gr de mantequilla en trozos",
      "1 huevo",
      "25 gr de azúcar",
      "250 gr de harina de fuerza ( y algo más para espolvorear)",
      "1 pellizco de sal",
      "100 gr de sobrasada"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 120.0, unit: "gr", name: "leche" },
      { amount: 15.0, unit: "gr", name: "levadura prensada fresca" },
      { amount: 15.0, unit: "gr", name: "mantequilla en trozos" },
      { amount: 1.0, unit: nil, name: "huevo" },
      { amount: 25.0, unit: "gr", name: "azúcar" },
      { amount: 250.0, unit: "gr", name: "harina de fuerza" },
      { amount: 1.0, unit: nil, name: "pellizco de sal" },
      { amount: 100.0, unit: "gr", name: "sobrasada" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pon en el vaso la leche, la levadura, la mantequilla, el huevo y el azúcar e inicia Calentar /37°C/vel 2.",
      "Añade la harina y la sal e inicia Amasar /30 seg. Mientras tanto, forra una bandeja de horno con papel de hornear y reserva.",
      "Agrega la sobrasada en trozos e inicia Amasar /1'. La sobrasada ha de quedar bien integrada en la masa. Si fuera necesario amasas 30 segundos más.",
      "Vierte la masa en la superficie de trabajo espolvoreada con harina y forma un cilindro de aprox. 22 cm de largo. Colócalo en la bandeja de horno y pincélalo con leche.",
      "Sin precalentar el horno, hornea durante 30-35 minutos (180°C).Si dispones del Thermomix sensor, sigue las instrucciones del Cooking Center.",
      "Retira del horno y deja enfriar sobre una rejilla antes de servir ( la bandeja del varoma te sirve de rejilla ).",
      "Puedes cortarlo en rebanadas y congelarlo."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pon en el vaso la leche, la levadura, la mantequilla, el huevo y el azúcar e inicia Calentar /37°C/vel 2.\nAñade la harina y la sal e inicia Amasar /30 seg. Mientras tanto, forra una bandeja de horno con papel de hornear y reserva.\nAgrega la sobrasada en trozos e inicia Amasar /1'. La sobrasada ha de quedar bien integrada en la masa. Si fuera necesario amasas 30 segundos más.\nVierte la masa en la superficie de trabajo espolvoreada con harina y forma un cilindro de aprox. 22 cm de largo. Colócalo en la bandeja de horno y pincélalo con leche.\nSin precalentar el horno, hornea durante 30-35 minutos (180°C).Si dispones del Thermomix sensor, sigue las instrucciones del Cooking Center.\nRetira del horno y deja enfriar sobre una rejilla antes de servir ( la bandeja del varoma te sirve de rejilla ).\nPuedes cortarlo en rebanadas y congelarlo.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-esplugues.es")
    expect(recipe.canonical_url).to eq("https://thermomix-esplugues.es/eugenia-arenas-ylla/masas-panes-reposteria/mi-receta-de-10-en-cookidoo")
    expect(recipe.site_name).to eq("Thermomix Barcelona Esplugues")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("EUGENIA ARENAS YLLA")
    expect(recipe.description).to eq("Es un pan espectacular. Lo puedes poner como acompañamiento de muchos platos y con queso para un bocadillo.")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/c2241a7215b4a91c0d52f3dc302f8c56_4962a376c1/c2241a7215b4a91c0d52f3dc302f8c56_4962a376c1.jpg")
    expect(recipe.category).to eq("Masas, panes y repostería")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["\"Mi receta de 10 en Cookidoo\"", "Masas", "panes y repostería"])
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
