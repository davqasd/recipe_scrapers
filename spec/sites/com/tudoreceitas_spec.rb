# frozen_string_literal: true

RSpec.describe "tudoreceitas.com" do
  subject(:recipe) { scrape_cassette("com/tudoreceitas", url: "https://www.tudoreceitas.com/receita-de-omelete-de-carne-moida-3457.html") }

  it "reads the title" do
    expect(recipe.title).to eq("Receita de Omelete de carne moída")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "5 unidades de ovo",
      "½ xícara de leite",
      "¼ xícara de água",
      "2 ramos de cebolinha",
      "pimenta do reino",
      "sal",
      "500 gramas de carne moída",
      "1 unidade de cebola pequena",
      "1 unidade de pimentão vermelho pequeno",
      "1 unidade de pimentão verde pequeno",
      "2 dentes de alho",
      "1 colher de chá de tempero para carne",
      "1 colher de sopa de óleo",
      "pimenta do reino",
      "sal"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 5.0, unit: nil, name: "unidades de ovo" },
      { amount: 0.5, unit: "xícara", name: "leite" },
      { amount: 0.25, unit: "xícara", name: "água" },
      { amount: 2.0, unit: nil, name: "ramos de cebolinha" },
      { amount: nil, unit: nil, name: "pimenta do reino" },
      { amount: nil, unit: nil, name: "sal" },
      { amount: 500.0, unit: "gramas", name: "carne moída" },
      { amount: 1.0, unit: nil, name: "unidade de cebola pequena" },
      { amount: 1.0, unit: nil, name: "unidade de pimentão vermelho pequeno" },
      { amount: 1.0, unit: nil, name: "unidade de pimentão verde pequeno" },
      { amount: 2.0, unit: "dentes", name: "alho" },
      { amount: 1.0, unit: "colher de chá", name: "tempero para carne" },
      { amount: 1.0, unit: "colher de sopa", name: "óleo" },
      { amount: nil, unit: nil, name: "pimenta do reino" },
      { amount: nil, unit: nil, name: "sal" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Para fazer estes burritos de omelete, comece por preparar os legumes: retire as sementes dos pimentões e pique junto com a cebola e os dentes de alho. Leve a refogar numa panela com o óleo, em fogo médio, mexendo de vez em quando. Este passo é crucial para garantir que os sabores se fundam adequadamente, criando uma base aromática deliciosa.",
      "Enquanto isso, tempere a carne moída com o tempero para carne, sal e pimenta a gosto, e misture com as mãos. Adicione à panela quando os ingredientes estiverem douradinhos, e fique mexendo até a carne estar soltinha e cozinhada. Para um toque adicional de sabor, você pode incorporar uma pitada de cominho ou páprica, que darão um aroma especial ao prato.",
      "Quando a carne estiver pronta, desligue e prepare a omelete: bata os ovos com o leite, a água, a cebolinha picada, sal e pimenta a gosto. Se desejar, acrescente uma pequena quantidade de queijo ralado para uma textura mais cremosa e saborosa.",
      "Leve ao fogo uma frigideira levemente untada, coloque um pouco da mistura, e cozinhe de um lado e do outro, até obter uma omelete firme e dourada. Retire e repita novamente, até completar 4 omeletes. Certifique-se de que o fogo não esteja muito alto para evitar que a omelete queime antes de cozinhar por completo.",
      "Para montar a omelete de carne moída, simplesmente coloque as omeletes em um prato, adicione uma porção da carne, feche e prenda com um palito de dente. Sirva como refeição principal, acompanhando com nachos caseiros, e bom apetite! Para uma apresentação ainda mais atraente, você pode adicionar um pouco de salsa fresca picada ou fatias de abacate ao prato."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Para fazer estes burritos de omelete, comece por preparar os legumes: retire as sementes dos pimentões e pique junto com a cebola e os dentes de alho. Leve a refogar numa panela com o óleo, em fogo médio, mexendo de vez em quando. Este passo é crucial para garantir que os sabores se fundam adequadamente, criando uma base aromática deliciosa.\nEnquanto isso, tempere a carne moída com o tempero para carne, sal e pimenta a gosto, e misture com as mãos. Adicione à panela quando os ingredientes estiverem douradinhos, e fique mexendo até a carne estar soltinha e cozinhada. Para um toque adicional de sabor, você pode incorporar uma pitada de cominho ou páprica, que darão um aroma especial ao prato.\nQuando a carne estiver pronta, desligue e prepare a omelete: bata os ovos com o leite, a água, a cebolinha picada, sal e pimenta a gosto. Se desejar, acrescente uma pequena quantidade de queijo ralado para uma textura mais cremosa e saborosa.\nLeve ao fogo uma frigideira levemente untada, coloque um pouco da mistura, e cozinhe de um lado e do outro, até obter uma omelete firme e dourada. Retire e repita novamente, até completar 4 omeletes. Certifique-se de que o fogo não esteja muito alto para evitar que a omelete queime antes de cozinhar por completo.\nPara montar a omelete de carne moída, simplesmente coloque as omeletes em um prato, adicione uma porção da carne, feche e prenda com um palito de dente. Sirva como refeição principal, acompanhando com nachos caseiros, e bom apetite! Para uma apresentação ainda mais atraente, você pode adicionar um pouco de salsa fresca picada ou fatias de abacate ao prato.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("tudoreceitas.com")
    expect(recipe.canonical_url).to eq("https://www.tudoreceitas.com/receita-de-omelete-de-carne-moida-3457.html")
    expect(recipe.site_name).to eq("tudoreceitas.com")
    expect(recipe.language).to eq("pt")
    expect(recipe.author).to eq("Nelson Ferreira")
    expect(recipe.description).to eq("Uma omelete pode ser muito mais que simplesmente ovos batidos e fritos, pode render uma refeição completa! Como prova disso, no TudoReceitas.com ensinamos você a preparar esta receita de omelete de carne moída, uma proposta semelhante à panqueca de carne moída, porém mais proteica e sem glúten. Confira abaixo os ingredientes e passo a passo!")
    expect(recipe.image).to eq("https://cdn0.tudoreceitas.com/pt/posts/7/5/4/omelete_de_carne_moida_3457_orig.jpg")
    expect(recipe.category).to eq("Prato principal")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to eq(45)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.0)
    expect(recipe.ratings_count).to eq(1)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "79 kcal",
      "fatContent" => "54 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 79.0 },
      { name: "fatContent", unit: "g", amount: 54.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#comentarios")
  end
end
