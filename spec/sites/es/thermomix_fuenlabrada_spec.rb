# frozen_string_literal: true

RSpec.describe "thermomix-fuenlabrada.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_fuenlabrada", url: "https://thermomix-fuenlabrada.es/susana-vela-inchauste/postres-y-dulces/crema-de-galleta-lotus-para-postres-thermomix-susana-vela") }

  it "reads the title" do
    expect(recipe.title).to eq("Crema de galleta lotus para postres Thermomix® Susana Vela")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "250 g de galletas lotus",
      "50 g de mantequilla en trozos",
      "150 g de leche condensada",
      "100 g de leche"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 250.0, unit: "g", name: "galletas lotus" },
      { amount: 50.0, unit: "g", name: "mantequilla en trozos" },
      { amount: 150.0, unit: "g", name: "leche condensada" },
      { amount: 100.0, unit: "g", name: "leche" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Añade al vaso 250 g de galletas",
      "seleccione el modo triturar 40 seg. O seleccione 40 segundos velocidad 10",
      "Baje los ingredientes de las paredes al fondo",
      "Añade al vaso la mantequilla en trozos a temperatura ambiente",
      "Incorpora 100 g de leche y 150 g de leche condensada",
      "Mezcla con el modo triturar 30 seg. O seleccione 30 seg/vel 8.",
      "Para una mejor textura puedes añadir 20-30g de leche (5 cucharadas)",
      "Guarda en un recipiente hermético hasta su utilización."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Añade al vaso 250 g de galletas\nseleccione el modo triturar 40 seg. O seleccione 40 segundos velocidad 10\nBaje los ingredientes de las paredes al fondo\nAñade al vaso la mantequilla en trozos a temperatura ambiente\nIncorpora 100 g de leche y 150 g de leche condensada\nMezcla con el modo triturar 30 seg. O seleccione 30 seg/vel 8.\nPara una mejor textura puedes añadir 20-30g de leche (5 cucharadas)\nGuarda en un recipiente hermético hasta su utilización.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-fuenlabrada.es")
    expect(recipe.canonical_url).to eq("https://thermomix-fuenlabrada.es/susana-vela-inchauste/postres-y-dulces/crema-de-galleta-lotus-para-postres-thermomix-susana-vela")
    expect(recipe.site_name).to eq("Thermomix Fuenlabrada")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("SUSANA VELA INCHAUSTI")
    expect(recipe.description).to eq("Es ideal para tartas, incorporar al helado de lotus o cualquier elaboración dulce. Puedes consultar la receta original en https://cookidoo.es/recipes/recipe/es-ES/r805686")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/Receta_crema_lotus_thermomix_facil_y_rapido_susana_vela_thermomix_TM_7_b02234bdb8/Receta_crema_lotus_thermomix_facil_y_rapido_susana_vela_thermomix_TM_7_b02234bdb8.png")
    expect(recipe.category).to eq("Postres y dulces")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Crema de galleta lotus para postres Thermomix® Susana Vela", "Postres y dulces"])
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
