# frozen_string_literal: true

RSpec.describe "comidinhasdochef.com" do
  subject(:recipe) { scrape_cassette("com/comidinhasdochef", url: "https://comidinhasdochef.com/receita-de-torta-na-marmita/") }

  it "reads the title" do
    expect(recipe.title).to eq("Receita de Torta na Marmita")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "500 g de farinha de trigo",
      "200 g de margarina ou manteiga",
      "1 caixa de creme de leite",
      "1 colher (sopa) de fermento químico em pó",
      "sal a gosto",
      "1 unidade de gema"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 500.0, unit: "g", name: "farinha de trigo" },
      { amount: 200.0, unit: "g", name: "margarina ou manteiga" },
      { amount: 1.0, unit: nil, name: "caixa de creme de leite" },
      { amount: 1.0, unit: "colher", name: "fermento químico em pó" },
      { amount: nil, unit: nil, name: "sal a gosto" },
      { amount: 1.0, unit: nil, name: "unidade de gema" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Como preparar Receita de Torta na Marmita",
      "Misture todos os ingredientes em uma tigela, até a massa soltar das mãos;",
      "Abra a massa aos poucos com um rolo de macarrão;",
      "Em seguida, forre as marmitinhas com a massa já abertas;",
      "Acrescente o recheio (frango, carne, atum, e etc...);",
      "Cubra com mais um pedaço da massa aberta;",
      "Obs: Certifique-se que a torta esteja bem fechada.",
      "Pincele a gema em cima da massa e asse em forno preaquecido (180ºC) por cerca de 35 minutos ou até dourar."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Como preparar Receita de Torta na Marmita\nMisture todos os ingredientes em uma tigela, até a massa soltar das mãos;\nAbra a massa aos poucos com um rolo de macarrão;\nEm seguida, forre as marmitinhas com a massa já abertas;\nAcrescente o recheio (frango, carne, atum, e etc...);\nCubra com mais um pedaço da massa aberta;\nObs: Certifique-se que a torta esteja bem fechada.\nPincele a gema em cima da massa e asse em forno preaquecido (180ºC) por cerca de 35 minutos ou até dourar.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("comidinhasdochef.com")
    expect(recipe.canonical_url).to eq("https://comidinhasdochef.com/receita-de-torta-na-marmita/")
    expect(recipe.site_name).to eq("Comidinhas do Chef")
    expect(recipe.language).to eq("pt-BR")
    expect(recipe.author).to eq("Pedro Cavalcanti")
    expect(recipe.description).to eq("Aposte na torta na marmita. Essa deliciosa vem ganhando espaço cada dia mais. Você pode vender cada uma a R$4,50. Receita de Torta na Marmita.")
    expect(recipe.image).to eq("https://i0.wp.com/comidinhasdochef.com/wp-content/uploads/2016/04/Receita-de-Torta-na-Marmita.jpg?fit=600%2C295&ssl=1")
    expect(recipe.category).to eq("Bolos")
    expect(recipe.cuisine).to eq("Brasileira")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(55)
    expect(recipe.prep_time).to eq(20)
    expect(recipe.cook_time).to eq(35)
    expect(recipe.keywords).to eq(["Receita de Torta na Marmita"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.7)
    expect(recipe.ratings_count).to eq(9)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "360 kcal",
      "carbohydrateContent" => "36 g",
      "fiberContent" => "1 g",
      "proteinContent" => "10 g",
      "servingSize" => "4",
      "sodiumContent" => "521 mg",
      "saturatedFatContent" => "5 g",
      "unsaturatedFatContent" => "8 g",
      "transFatContent" => "0 g",
      "fatContent" => "24 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 360.0 },
      { name: "carbohydrateContent", unit: "g", amount: 36.0 },
      { name: "fiberContent", unit: "g", amount: 1.0 },
      { name: "proteinContent", unit: "g", amount: 10.0 },
      { name: "servingSize", unit: nil, amount: 4.0 },
      { name: "sodiumContent", unit: "mg", amount: 521.0 },
      { name: "saturatedFatContent", unit: "g", amount: 5.0 },
      { name: "unsaturatedFatContent", unit: "g", amount: 8.0 },
      { name: "transFatContent", unit: "g", amount: 0.0 },
      { name: "fatContent", unit: "g", amount: 24.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#primary")
  end
end
