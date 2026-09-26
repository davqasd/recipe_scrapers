# frozen_string_literal: true

RSpec.describe "receitas.globo.com" do
  subject(:recipe) { scrape_cassette("com/receitas", url: "https://receitas.globo.com/tipos-de-prato/aves/strogonoff-de-frango-simples-4fbe8cc656ec5b3c9801b7e5.ghtml") }

  it "reads the title" do
    expect(recipe.title).to eq("Strogonoff de frango")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 colheres de sopa de óleo",
      "1 tablete de caldo de galinha",
      "1 quilo de peito de frango em cubos",
      "2 colheres de sopa de molho de tomate",
      "2 colheres de sopa de mostarda",
      "2 colheres de sopa de ketchup",
      "Champignon a gosto",
      "1 lata de creme de leite sem soro"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "colheres de sopa", name: "óleo" },
      { amount: 1.0, unit: "tablete", name: "caldo de galinha" },
      { amount: 1.0, unit: "quilo", name: "peito de frango em cubos" },
      { amount: 2.0, unit: "colheres de sopa", name: "molho de tomate" },
      { amount: 2.0, unit: "colheres de sopa", name: "mostarda" },
      { amount: 2.0, unit: "colheres de sopa", name: "ketchup" },
      { amount: nil, unit: nil, name: "Champignon a gosto" },
      { amount: 1.0, unit: "lata", name: "creme de leite sem soro" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "1 Em uma panela, coloque 3 colheres de sopa de óleo e 1 tablete de caldo de galinha. Espere aquecer para dissolver o tablete.",
      "2 Em seguida, adicione 1 quilo de peito de frango em cubos e deixe dourar.",
      "3 Depois, acrescente 2 colheres de sopa de molho de tomate, 2 colheres de sopa de mostarda, 2 colheres de sopa de ketchup e champignon a gosto. Misture.",
      "4 Desligue o fogo e acrescente 1 lata de creme de leite. Misture novamente.",
      "5 Sirva em seguida."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("1 Em uma panela, coloque 3 colheres de sopa de óleo e 1 tablete de caldo de galinha. Espere aquecer para dissolver o tablete.\n2 Em seguida, adicione 1 quilo de peito de frango em cubos e deixe dourar.\n3 Depois, acrescente 2 colheres de sopa de molho de tomate, 2 colheres de sopa de mostarda, 2 colheres de sopa de ketchup e champignon a gosto. Misture.\n4 Desligue o fogo e acrescente 1 lata de creme de leite. Misture novamente.\n5 Sirva em seguida.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("receitas.globo.com")
    expect(recipe.canonical_url).to eq("https://receitas.globo.com/tipos-de-prato/aves/strogonoff-de-frango-simples-4fbe8cc656ec5b3c9801b7e5.ghtml")
    expect(recipe.site_name).to eq("Receitas")
    expect(recipe.language).to eq("pt-BR")
    expect(recipe.author).to eq("Alm3")
    expect(recipe.description).to eq("Como fazer strogonoff de frango simples e fácil: receita tradicional leva poucos ingredientes, fica pronta rápido e rende bastante; confira")
    expect(recipe.image).to eq("https://s2-receitas.glbimg.com/-qVJeTnDOmUlgDsTGE2eGcyOQ7M=/1280x0/filters:format(jpeg)/https://i.s3.glbimg.com/v1/AUTH_1f540e0b94d8437dbbc39d567a1dee68/internal_photos/bs/2022/8/O/xH9h1GSnW1LhMobyL7hQ/strogonoff-de-frango-receita.jpg")
    expect(recipe.category).to eq("Aves")
    expect(recipe.cuisine).to eq("Brasileira")
    expect(recipe.cooking_method).to eq("Cozido")
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq([
      "receitas de strogonoff",
      "receitas com frango",
      "almoço",
      "jantar",
      "natal",
      "réveillon",
      "ano-novo",
      "páscoa",
      "reunião em família",
      "reunião com amigos",
      "receitas de strogonoff",
      "receitas com frango",
      "almoço",
      "jantar",
      "natal",
      "réveillon",
      "ano-novo",
      "páscoa",
      "reunião em família",
      "reunião com amigos"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.9)
    expect(recipe.ratings_count).to eq(12)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#")
  end
end
