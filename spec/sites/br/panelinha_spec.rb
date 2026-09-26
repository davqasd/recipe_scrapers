# frozen_string_literal: true

RSpec.describe "panelinha.com.br" do
  subject(:recipe) { scrape_cassette("br/panelinha", url: "https://panelinha.com.br/receita/rosbife") }

  it "reads the title" do
    expect(recipe.title).to eq("Rosbife")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "750 g de filé mignon em peça para rosbife",
      "1 colher (chá) de mostarda amarela em pó",
      "1 colher (chá) de páprica defumada",
      "azeite a gosto",
      "sal e pimenta-do-reino moída na hora a gosto"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 750.0, unit: "g", name: "filé mignon em peça para rosbife" },
      { amount: 1.0, unit: "colher", name: "mostarda amarela em pó" },
      { amount: 1.0, unit: "colher", name: "páprica defumada" },
      { amount: nil, unit: nil, name: "azeite a gosto" },
      { amount: nil, unit: nil, name: "sal e pimenta-do-reino moída na hora a gosto" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Preaqueça o forno a 220 ºC (temperatura alta). Retire a peça de filé mignon da geladeira e deixe em temperatura ambiente por 15 minutos, enquanto o forno aquece.",
      "Numa tigela pequena, misture a páprica com a mostarda em pó. Disponha a peça de filé mignon na tábua e tempere com sal, pimenta e a mistura de mostarda com páprica. Regue com ½ colher (sopa) de azeite e espalhe bem com as mãos por toda a superfície da carne.",
      "Transfira o filé mignon para uma assadeira grande e leve ao forno para assar por 15 minutos. Após esse tempo, diminua a temperatura para 180 ºC (temperatura média) e deixe o rosbife no forno por mais 10 minutos para assar a carne com o interior bem vermelhinho (mal passada). Se quiser ao ponto, deixe assar por mais 5 minutos.",
      "Retire a assadeira do forno e deixe o rosbife descansar por 10 minutos antes de cortar e servir – nesse período os sucos se redistribuem, deixando a carne mais suculenta."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Preaqueça o forno a 220 ºC (temperatura alta). Retire a peça de filé mignon da geladeira e deixe em temperatura ambiente por 15 minutos, enquanto o forno aquece.\nNuma tigela pequena, misture a páprica com a mostarda em pó. Disponha a peça de filé mignon na tábua e tempere com sal, pimenta e a mistura de mostarda com páprica. Regue com ½ colher (sopa) de azeite e espalhe bem com as mãos por toda a superfície da carne.\nTransfira o filé mignon para uma assadeira grande e leve ao forno para assar por 15 minutos. Após esse tempo, diminua a temperatura para 180 ºC (temperatura média) e deixe o rosbife no forno por mais 10 minutos para assar a carne com o interior bem vermelhinho (mal passada). Se quiser ao ponto, deixe assar por mais 5 minutos.\nRetire a assadeira do forno e deixe o rosbife descansar por 10 minutos antes de cortar e servir – nesse período os sucos se redistribuem, deixando a carne mais suculenta.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("panelinha.com.br")
    expect(recipe.canonical_url).to eq("https://panelinha.com.br/receita/rosbife")
    expect(recipe.site_name).to eq("Panelinha - Receitas que funcionam")
    expect(recipe.language).to eq("pt-br")
    expect(recipe.author).to eq("Panelinha")
    expect(recipe.description).to eq("Clássico é clássico! Com a técnica certa, o rosbife fica perfeito. Atente para os tempos e as temperaturas. Ele não pode estar gelado e precisa mesmo do descanso depois de assado.")
    expect(recipe.image).to eq("https://i.panelinha.com.br/i1/bk-9959-rosbife.webp")
    expect(recipe.category).to eq("Carnes")
    expect(recipe.cuisine).to eq("Inglesa")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
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
