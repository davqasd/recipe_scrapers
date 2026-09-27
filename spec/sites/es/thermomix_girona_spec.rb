# frozen_string_literal: true

RSpec.describe "thermomix-girona.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_girona", url: "https://thermomix-girona.es/mariona-camos-piera/salsas-y-guarniciones/beixamel-amb-thermomix") }

  it "reads the title" do
    expect(recipe.title).to eq("Beixamel amb Thermomix")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "200 gr de ceba de Figueres a octaus",
      "40gr farina",
      "20gr oli oliva",
      "500gr llet",
      "1/2 cp de sal",
      "pebre molt i nou moscada"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 200.0, unit: "gr", name: "ceba de Figueres a octaus" },
      { amount: 40.0, unit: "gr", name: "farina" },
      { amount: 20.0, unit: "gr", name: "oli oliva" },
      { amount: 500.0, unit: "gr", name: "llet" },
      { amount: 0.5, unit: nil, name: "cp de sal" },
      { amount: nil, unit: nil, name: "pebre molt i nou moscada" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Posa en el vas els 20gr d'oli d'oliva i els 200gr de ceba tallada a octaus. Programa 15min|120ºC|vel1.",
      "Després barreja bé amb l'espàtula i troceja 2seg|vel4. Si veus que no ha quedat prou petita, repeteix el pas.",
      "Afegeix 40gr de farina i afoga durant 3min|100ºC|vel1.",
      "Afegeix les 500gr de llet, la sal, pebre, i la nou moscada i programa 6min|90ºC|vel4."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Posa en el vas els 20gr d'oli d'oliva i els 200gr de ceba tallada a octaus. Programa 15min|120ºC|vel1.\nDesprés barreja bé amb l'espàtula i troceja 2seg|vel4. Si veus que no ha quedat prou petita, repeteix el pas.\nAfegeix 40gr de farina i afoga durant 3min|100ºC|vel1.\nAfegeix les 500gr de llet, la sal, pebre, i la nou moscada i programa 6min|90ºC|vel4.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-girona.es")
    expect(recipe.canonical_url).to eq("https://thermomix-girona.es/mariona-camos-piera/salsas-y-guarniciones/beixamel-amb-thermomix")
    expect(recipe.site_name).to eq("Thermomix Girona")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("MARIONA CAMOS PIERA")
    expect(recipe.description).to eq("Surt 580gr de beixamel.")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/4fd620efda0350ea18a382112fae8a28_9e5da39dfe/4fd620efda0350ea18a382112fae8a28_9e5da39dfe.jpg")
    expect(recipe.category).to eq("Salsas y guarniciones")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("580 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Beixamel amb Thermomix", "Salsas y guarniciones"])
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
