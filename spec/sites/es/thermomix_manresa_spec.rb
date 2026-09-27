# frozen_string_literal: true

RSpec.describe "thermomix-manresa.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_manresa", url: "https://thermomix-manresa.es/carrioprat/masas-panes-reposteria/bunyols-de-l-emporda") }

  it "reads the title" do
    expect(recipe.title).to eq("Bunyols de l´Empordà")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "La pell d'una llimona (només la part groga)",
      "25 gr. de matafaluga en pols",
      "3 ous",
      "100 gr. de sucre",
      "50 gr. de greix de porc",
      "100 gr. de llet",
      "70 g. d'anís líquid",
      "1 pessic de sal",
      "500 g. de farina de força",
      "40 g.de llevat fresc",
      "Oli per fregir"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: nil, unit: nil, name: "La pell d'una llimona" },
      { amount: 25.0, unit: "gr", name: "matafaluga en pols" },
      { amount: 3.0, unit: nil, name: "ous" },
      { amount: 100.0, unit: "gr", name: "sucre" },
      { amount: 50.0, unit: "gr", name: "greix de porc" },
      { amount: 100.0, unit: "gr", name: "llet" },
      { amount: 70.0, unit: "g", name: "d'anís líquid" },
      { amount: 1.0, unit: nil, name: "pessic de sal" },
      { amount: 500.0, unit: "g", name: "farina de força" },
      { amount: 40.0, unit: "g", name: "de llevat fresc" },
      { amount: nil, unit: nil, name: "Oli per fregir" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Posar en el vas La pell d'una llimona (només la part groga) i ratllar 10 seg/velocidad 5, ha de quedar ben fina.",
      "Afegir-hi 3 ous, 25 gr. de matafaluga en pols, 100 gr. de sucre, 50 gr. de greix de porc, 100 gr. de llet, 70 gr. d'anís líquid, 1 pessic de sal, programar 1 min/37°C/velocidad 4",
      "Afegir-hi 500 gr. de farina de força, i 40 gr. de llevat fresc. Programar 8 seg/velocidad 6",
      "Un cop barrejat programar Amasar /3 min",
      "Buidar la massa en un vol untat previament amb oli. Deixar reposar la massa 1 hora o fins que dobli el seu tamany",
      "Amb les mans untades amb una mica d'oli, agafar porcions petites, fer boletes i deixar-les reposar una hora.",
      "Posar oli a escalfar en una paella i anar posant les boletes fen un forat amb els dits .",
      "Un cop cuits es treuen i es posen damunt d'un paper de cuina , un cop escorreguts els passarem per el sucre"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Posar en el vas La pell d'una llimona (només la part groga) i ratllar 10 seg/velocidad 5, ha de quedar ben fina.\nAfegir-hi 3 ous, 25 gr. de matafaluga en pols, 100 gr. de sucre, 50 gr. de greix de porc, 100 gr. de llet, 70 gr. d'anís líquid, 1 pessic de sal, programar 1 min/37°C/velocidad 4\nAfegir-hi 500 gr. de farina de força, i 40 gr. de llevat fresc. Programar 8 seg/velocidad 6\nUn cop barrejat programar Amasar /3 min\nBuidar la massa en un vol untat previament amb oli. Deixar reposar la massa 1 hora o fins que dobli el seu tamany\nAmb les mans untades amb una mica d'oli, agafar porcions petites, fer boletes i deixar-les reposar una hora.\nPosar oli a escalfar en una paella i anar posant les boletes fen un forat amb els dits .\nUn cop cuits es treuen i es posen damunt d'un paper de cuina , un cop escorreguts els passarem per el sucre")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-manresa.es")
    expect(recipe.canonical_url).to eq("https://thermomix-manresa.es/carrioprat/masas-panes-reposteria/bunyols-de-l-emporda")
    expect(recipe.site_name).to eq("Thermomix Barcelona Manresa")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("M TERESA CARRIO PRAT")
    expect(recipe.description).to eq("Bunyols de l´Empordà, una receta de Masas, panes y repostería, elaborada por M TERESA CARRIO PRAT. Descubre las mejores recetas de Blogosfera Thermomix Barcelona Manresa")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/bunyols_2520a25169/bunyols_2520a25169.jfif")
    expect(recipe.category).to eq("Masas, panes y repostería")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(2)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Bunyols de l´Empordà", "Masas", "panes y repostería"])
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
