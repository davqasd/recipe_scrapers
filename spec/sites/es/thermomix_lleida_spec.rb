# frozen_string_literal: true

RSpec.describe "thermomix-lleida.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_lleida", url: "https://thermomix-lleida.es/clara-gili-valles/postres-y-dulces/recepta-per-fer-amb-nens-pastis-de-formatge") }

  it "reads the title" do
    expect(recipe.title).to eq("RECEPTA PER FER AMB NENS: PASTÁS DE FORMATGE")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1000 G DE FORMATGE CREMÓS",
      "500 G DE NATA 35%",
      "6 OUS",
      "350 G DE SUCRE",
      "30 G DE FARINA O MAICENA"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1000.0, unit: "G", name: "FORMATGE CREMÓS" },
      { amount: 500.0, unit: "G", name: "NATA 35%" },
      { amount: 6.0, unit: nil, name: "OUS" },
      { amount: 350.0, unit: "G", name: "SUCRE" },
      { amount: 30.0, unit: "G", name: "FARINA O MAICENA" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "PREESCALFEU EL FORN A 200º AMB FOC A DALT I A BAIX",
      "MULLET UN PAPER DE FORN, ESCORREU-LO I FOLREU UN MOTLLE DESMONTABLE DE 24 CM DE DIÀMETRE.",
      "POSEU AL VAS TOTS ELS INGREDIENTS I PROGRAMEU 30 SEGONS/VELOCITAT 5",
      "ENFORNEU DURANT 50 MINUTS A 200º. PER SABER SI ÉS CUIT, PUNXEU-LO AMB UNA BROQUETA DE FUSTA FINS QUE AQUESTA SURTI NETA.",
      "DEIXEU REFREDAR I SERVIU SI VOLEU AMB MELMELADA O MEL PER SOBRE."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("PREESCALFEU EL FORN A 200º AMB FOC A DALT I A BAIX\nMULLET UN PAPER DE FORN, ESCORREU-LO I FOLREU UN MOTLLE DESMONTABLE DE 24 CM DE DIÀMETRE.\nPOSEU AL VAS TOTS ELS INGREDIENTS I PROGRAMEU 30 SEGONS/VELOCITAT 5\nENFORNEU DURANT 50 MINUTS A 200º. PER SABER SI ÉS CUIT, PUNXEU-LO AMB UNA BROQUETA DE FUSTA FINS QUE AQUESTA SURTI NETA.\nDEIXEU REFREDAR I SERVIU SI VOLEU AMB MELMELADA O MEL PER SOBRE.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-lleida.es")
    expect(recipe.canonical_url).to eq("https://thermomix-lleida.es/clara-gili-valles/postres-y-dulces/recepta-per-fer-amb-nens-pastis-de-formatge")
    expect(recipe.site_name).to eq("Thermomix Lleida")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("Clara Gili Valles")
    expect(recipe.description).to eq("RECEPTA PER FER AMB NENS: PASTÁS DE FORMATGE, una receta de Postres y dulces, elaborada por Clara Gili Valles. Descubre las mejores recetas de Blogosfera Thermomix Lleida")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/3a852b77a23284ea5cea58b3822ecc40_d0df740ab9/3a852b77a23284ea5cea58b3822ecc40_d0df740ab9.jpg")
    expect(recipe.category).to eq("Postres y dulces")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["RECEPTA PER FER AMB NENS: PASTÁS DE FORMATGE", "Postres y dulces"])
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
