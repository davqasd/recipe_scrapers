# frozen_string_literal: true

RSpec.describe "receiteria.com.br" do
  subject(:recipe) { scrape_cassette("br/receiteria", url: "https://www.receiteria.com.br/receita/pudim-de-leite-condensado/") }

  it "reads the title" do
    expect(recipe.title).to eq("Pudim de leite condensado")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 xícara de chá de açúcar (200 gramas)",
      "1/2 xícara de chá de água quente (120 ml)",
      "3 ovos médios",
      "320 ml de leite integral",
      "1 lata de leite condensado (395 gramas)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "xícara de chá", name: "açúcar" },
      { amount: 0.5, unit: "xícara de chá", name: "água quente" },
      { amount: 3.0, unit: nil, name: "ovos médios" },
      { amount: 320.0, unit: "ml", name: "leite integral" },
      { amount: 1.0, unit: "lata", name: "leite condensado" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Veja se tem todos os ingredientes e se prepare para fazer o melhor pudim de leite condensado, que fica lisinho e sem furinhos;",
      "Para fazer a calda, escolha uma panela de fundo grosso e coloque o açúcar. Ligue o fogo baixo e derreta até não restar quase nenhum cristal;",
      "Cuidadosamente, coloque a água quente na panela e misture vigorosamente para derreter os cristais de açúcar novamente ou até os torrões de açúcar se desmancharem e formar a calda em ponto de xarope;",
      "Despeje a calda em uma forma de pudim com 19 cm de diâmetro e espalhe para cobrir o fundo e as laterais. Reserve enquanto prepara o pudim;",
      "Quebre um ovo de cada vez em um pote separado e, se ele estiver bom, adicione no liquidificador. Junte o leite, o leite condensado e bata por aproximadamente 1 minuto até a mistura ficar completamente homogênea;",
      "Coloque uma peneira em cima da forma com a calda e despeje a mistura de pudim. Isso ajudará na remoção das bolhas e qualquer outro pedacinho de ingredientes que não foram batidos no liquidificador, deixando ele ainda mais lisinho;",
      "Cubra com papel-alumínio e leve ao forno preaquecido a 180ºC por aproximadamente 45 minutos em banho-maria. Basta colocar a forma de pudim em uma assadeira retangular com bordas altas com água;",
      "Depois, retire do forno, aguarde o pudim amornar e leve para a geladeira por pelo menos 2 horas, ou até ficar firme;",
      "Passe a faca no meio e nas laterais da forma para desgrudar o pudim. Se necessário, leve a forma na boca do fogão para derreter rapidamente o caramelo e o pudim desenformar facilmente. Desforme em um prato grande ou boleira. Sirva e bom apetite!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Veja se tem todos os ingredientes e se prepare para fazer o melhor pudim de leite condensado, que fica lisinho e sem furinhos;\nPara fazer a calda, escolha uma panela de fundo grosso e coloque o açúcar. Ligue o fogo baixo e derreta até não restar quase nenhum cristal;\nCuidadosamente, coloque a água quente na panela e misture vigorosamente para derreter os cristais de açúcar novamente ou até os torrões de açúcar se desmancharem e formar a calda em ponto de xarope;\nDespeje a calda em uma forma de pudim com 19 cm de diâmetro e espalhe para cobrir o fundo e as laterais. Reserve enquanto prepara o pudim;\nQuebre um ovo de cada vez em um pote separado e, se ele estiver bom, adicione no liquidificador. Junte o leite, o leite condensado e bata por aproximadamente 1 minuto até a mistura ficar completamente homogênea;\nColoque uma peneira em cima da forma com a calda e despeje a mistura de pudim. Isso ajudará na remoção das bolhas e qualquer outro pedacinho de ingredientes que não foram batidos no liquidificador, deixando ele ainda mais lisinho;\nCubra com papel-alumínio e leve ao forno preaquecido a 180ºC por aproximadamente 45 minutos em banho-maria. Basta colocar a forma de pudim em uma assadeira retangular com bordas altas com água;\nDepois, retire do forno, aguarde o pudim amornar e leve para a geladeira por pelo menos 2 horas, ou até ficar firme;\nPasse a faca no meio e nas laterais da forma para desgrudar o pudim. Se necessário, leve a forma na boca do fogão para derreter rapidamente o caramelo e o pudim desenformar facilmente. Desforme em um prato grande ou boleira. Sirva e bom apetite!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("receiteria.com.br")
    expect(recipe.canonical_url).to eq("https://www.receiteria.com.br/receita/pudim-de-leite-condensado/")
    expect(recipe.site_name).to eq("Receiteria")
    expect(recipe.language).to eq("pt-br")
    expect(recipe.author).to eq("Tatiana Tambellini")
    expect(recipe.description).to eq("Com 3 ingredientes, e no liquidificador, você faz um delicioso pudim de leite condensado. Receita fácil que não fica com gosto de ovo.")
    expect(recipe.image).to eq("https://www.receiteria.com.br/wp-content/uploads/pudim-de-leite-condensado-capa.jpeg")
    expect(recipe.category).to eq("Doces")
    expect(recipe.cuisine).to eq("Brasileira")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 items")
    expect(recipe.total_time).to eq(75)
    expect(recipe.prep_time).to eq(30)
    expect(recipe.cook_time).to eq(45)
    expect(recipe.keywords).to eq(["Pudim de leite condensado"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.7)
    expect(recipe.ratings_count).to eq(602)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "265 calorias",
      "proteinContent" => "7.1 g",
      "fatContent" => "5.3 g",
      "cholesterolContent" => "0 g",
      "fiberContent" => "0 g",
      "saturatedFatContent" => "1.6 g",
      "sodiumContent" => "102.6 mg",
      "sugarContent" => "9.5 g",
      "carbohydrateContent" => "47.7 g"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 265.0 },
      { name: "proteinContent", unit: "g", amount: 7.1 },
      { name: "fatContent", unit: "g", amount: 5.3 },
      { name: "cholesterolContent", unit: "g", amount: 0.0 },
      { name: "fiberContent", unit: "g", amount: 0.0 },
      { name: "saturatedFatContent", unit: "g", amount: 1.6 },
      { name: "sodiumContent", unit: "mg", amount: 102.6 },
      { name: "sugarContent", unit: "g", amount: 9.5 },
      { name: "carbohydrateContent", unit: "g", amount: 47.7 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
