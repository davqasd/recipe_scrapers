# frozen_string_literal: true

RSpec.describe "hogarmania.com" do
  subject(:recipe) { scrape_cassette("com/hogarmania", url: "https://www.hogarmania.com/cocina/recetas/sopas-cremas/crema-calabaza-thermomix-receta-facil.html") }

  it "reads the title" do
    expect(recipe.title).to eq("Crema de calabaza con Thermomix (receta muy fácil)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "500 gr de calabaza (pelada y sin pepitas)",
      "2 puerros",
      "3 zanahorias",
      "1 patata",
      "1/2 litro de agua o caldo de verduras",
      "50 gr de aceite de oliva",
      "1 cucharadita de sal",
      "Pimienta molida al gusto",
      "Nata o crema",
      "Perejil picado",
      "Pipas de girasol o de calabaza"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 500.0, unit: "gr", name: "calabaza" },
      { amount: 2.0, unit: nil, name: "puerros" },
      { amount: 3.0, unit: nil, name: "zanahorias" },
      { amount: 1.0, unit: nil, name: "patata" },
      { amount: 0.5, unit: "litro", name: "agua o caldo de verduras" },
      { amount: 50.0, unit: "gr", name: "aceite de oliva" },
      { amount: 1.0, unit: "cucharadita", name: "sal" },
      { amount: nil, unit: nil, name: "Pimienta molida al gusto" },
      { amount: nil, unit: nil, name: "Nata o crema" },
      { amount: nil, unit: nil, name: "Perejil picado" },
      { amount: nil, unit: nil, name: "Pipas de girasol o de calabaza" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq(nil)
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to be_nil
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("hogarmania.com")
    expect(recipe.canonical_url).to eq("https://www.hogarmania.com/cocina/recetas/sopas-cremas/crema-calabaza-thermomix-receta-facil.html")
    expect(recipe.site_name).to eq("Hogarmania")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("Lídia Montaner")
    expect(recipe.description).to eq("Prepara crema de calabaza casera con Thermomix siguiendo esta receta paso a paso y consigue que quede perfecta con nuestros trucos. Un plato fácil, ligero y saludable.")
    expect(recipe.image).to eq("https://static.bainet.es/clip/48ed3189-5109-4cf0-888d-6e0bf3900d0e_source-aspect-ratio_1600w_0.jpg")
    expect(recipe.category).to eq("Sopas y cremas")
    expect(recipe.cuisine).to eq("Cocina española")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(70)
    expect(recipe.prep_time).to eq(35)
    expect(recipe.cook_time).to eq(35)
    expect(recipe.keywords).to eq([
      "Calabaza",
      "Verduras",
      "Sopas y cremas",
      "Recetas de primeros platos",
      "Cocina española",
      "Otoño"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.0)
    expect(recipe.ratings_count).to eq(653)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#content-body")
  end
end
