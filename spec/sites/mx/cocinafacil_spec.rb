# frozen_string_literal: true

RSpec.describe "cocinafacil.com.mx" do
  subject(:recipe) { scrape_cassette("mx/cocinafacil", url: "https://www.cocinafacil.com.mx/recetas/molletes-receta-con-pimientos") }

  it "reads the title" do
    expect(recipe.title).to eq("Molletes: receta con pimientos")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 taza de queso mascarpone",
      "null ½ taza de crema para batir",
      "4 panes integrales",
      "2 pimientos en tiras",
      "1 taza de ejotes cocidos",
      "null ½ taza de espinaca",
      "4 cdas. de aceite de oliva"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "taza", name: "queso mascarpone" },
      { amount: 0.5, unit: "taza", name: "crema para batir" },
      { amount: 4.0, unit: nil, name: "panes integrales" },
      { amount: 2.0, unit: nil, name: "pimientos en tiras" },
      { amount: 1.0, unit: "taza", name: "ejotes cocidos" },
      { amount: 0.5, unit: "taza", name: "espinaca" },
      { amount: 4.0, unit: "cdas", name: "aceite de oliva" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Mezcla el queso mascarpone con la crema, tuesta los panes y saltea los ejotes y pimientos con el aceite de oliva.",
      "Cubre los panes con el queso y la verdura.",
      "Termina con la espinaca y pimienta."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Mezcla el queso mascarpone con la crema, tuesta los panes y saltea los ejotes y pimientos con el aceite de oliva.\nCubre los panes con el queso y la verdura.\nTermina con la espinaca y pimienta.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("cocinafacil.com.mx")
    expect(recipe.canonical_url).to eq("https://www.cocinafacil.com.mx/recetas/molletes-receta-con-pimientos")
    expect(recipe.site_name).to eq("Cocina Fácil")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("Josselin Melara")
    expect(recipe.description).to eq("Estos molletes son ligeros y serán ideales para desayunar o cenar, pruébalos.")
    expect(recipe.image).to eq("https://editorialtelevisa.brightspotcdn.com/wp-content/uploads/2019/12/molletes-receta-pimientos.jpg")
    expect(recipe.category).to eq("Desayuno")
    expect(recipe.cuisine).to eq("Desayuno")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 items")
    expect(recipe.total_time).to eq(25)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["desayunos", "cenas ligeras", "molletes", "recetas de molletes"])
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
    expect(recipe.links).to include("/")
  end
end
