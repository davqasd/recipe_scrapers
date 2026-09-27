# frozen_string_literal: true

RSpec.describe "mundodereceitasbimby.com.pt" do
  subject(:recipe) { scrape_cassette("pt/mundodereceitasbimby", url: "https://www.mundodereceitasbimby.com.pt/Sobremesas-receitas/Tiramisu/ubmdwr8t-6f492-702841-cfcd2-ren6jxzs") }

  it "reads the title" do
    expect(recipe.title).to eq("Tiramisú")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 gelatina neutra",
      "água, q.b. p/ demolhar",
      "6 gemas de ovo",
      "200 g natas",
      "150 açúcar",
      "500 g queijo mascarpone",
      "200 g café, pronto",
      "50 g licor",
      "50 g rum",
      "24 palitos de la reine",
      "cacau em pó, p/ decorar"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: nil, name: "gelatina neutra" },
      { amount: nil, unit: nil, name: "água, q.b. p/ demolhar" },
      { amount: 6.0, unit: nil, name: "gemas de ovo" },
      { amount: 200.0, unit: "g", name: "natas" },
      { amount: 150.0, unit: nil, name: "açúcar" },
      { amount: 500.0, unit: "g", name: "queijo mascarpone" },
      { amount: 200.0, unit: "g", name: "café, pronto" },
      { amount: 50.0, unit: "g", name: "licor" },
      { amount: 50.0, unit: "g", name: "rum" },
      { amount: 24.0, unit: nil, name: "palitos de la reine" },
      { amount: nil, unit: nil, name: "cacau em pó, p/ decorar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Inserir título",
      "Coloque as folhas de gelatina em água fria. Reserve.",
      "Insira a borboleta. Coloque no copo as gemas, as natas e o açúcar e programe 5 min/90°C/vel 1,5.",
      "De seguida programe mais 2 min/vel 1,5.",
      "Adicione as folhas de gelatina bem escorridas e misture 30 seg/vel 1,5. Retire o copo da base para que arrefeça.",
      "Uma vez frio, misture 10 seg/vel 1,5.",
      "Adicione o queijo e programe 20 seg/vel 2,5.",
      "Prepare uma forma forrada com película aderente e deite metade da mistura. Coloque no frigorífico.",
      "Entretanto coloque num recipiente o café e o licor e embeba os palitos, tendo o cuidado para que não fiquem demasiado ensopados.",
      "Coloque sobre a mistura reservada no frigorífico uma camada de palitos, por cima destes a restante mistura do copo e cubra novamente com palitos. Tape com película aderente e coloque de novo no frigorífico pelo menos 2 horas.",
      "Desenforme, retire a película aderente e polvilhe com cacau. Se desejar mais decorado, cubra com aparas de chocolate branco. Mantenha-o no frigorífico até ao momento de servir."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Inserir título\nColoque as folhas de gelatina em água fria. Reserve.\nInsira a borboleta. Coloque no copo as gemas, as natas e o açúcar e programe 5 min/90°C/vel 1,5.\nDe seguida programe mais 2 min/vel 1,5.\nAdicione as folhas de gelatina bem escorridas e misture 30 seg/vel 1,5. Retire o copo da base para que arrefeça.\nUma vez frio, misture 10 seg/vel 1,5.\nAdicione o queijo e programe 20 seg/vel 2,5.\nPrepare uma forma forrada com película aderente e deite metade da mistura. Coloque no frigorífico.\nEntretanto coloque num recipiente o café e o licor e embeba os palitos, tendo o cuidado para que não fiquem demasiado ensopados.\nColoque sobre a mistura reservada no frigorífico uma camada de palitos, por cima destes a restante mistura do copo e cubra novamente com palitos. Tape com película aderente e coloque de novo no frigorífico pelo menos 2 horas.\nDesenforme, retire a película aderente e polvilhe com cacau. Se desejar mais decorado, cubra com aparas de chocolate branco. Mantenha-o no frigorífico até ao momento de servir.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("mundodereceitasbimby.com.pt")
    expect(recipe.canonical_url).to eq("https://www.mundodereceitasbimby.com.pt/Sobremesas-receitas/Tiramisu/ubmdwr8t-6f492-702841-cfcd2-ren6jxzs")
    expect(recipe.site_name).to be_nil
    expect(recipe.language).to be_nil
    expect(recipe.author).to eq("Equipa Bimby")
    expect(recipe.description).to eq("Tiramisú de Equipa Bimby. Receita Bimby® na categoria Sobremesas do %site-name%, A Comunidade de Receitas Bimby®.")
    expect(recipe.image).to eq("https://d1swnf22g3u0in.cloudfront.net/recipeimage/ubmdwr8t-6f492-702841-cfcd2-ren6jxzs/ff642584-cbed-4b96-afe4-dda9278616cd/original/tiramisu.jpg")
    expect(recipe.category).to eq("Sobremesas")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(38)
    expect(recipe.prep_time).to eq(38)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.9)
    expect(recipe.ratings_count).to eq(10)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#socialShares")
  end
end
