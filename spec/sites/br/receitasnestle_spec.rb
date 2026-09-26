# frozen_string_literal: true

RSpec.describe "receitasnestle.com.br" do
  subject(:recipe) { scrape_cassette("br/receitasnestle", url: "https://www.receitasnestle.com.br/receitas/pudim-de-leite-moca") }

  it "reads the title" do
    expect(recipe.title).to eq("Pudim de Leite Condensado Moça: receita simples e rápida!")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 xícara (chá) de açúcar",
      "meia xícara (chá) de água quente",
      "1 Leite MOÇA® (lata ou caixinha) 395 g",
      "2 medidas (da lata) de Leite Líquido NINHO® Forti+ Integral",
      "3 ovos"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: "xícara", name: "açúcar" },
      { amount: 0.5, unit: "xícara", name: "água quente" },
      { amount: 1.0, unit: nil, name: "Leite MOÇA® 395 g" },
      { amount: 2.0, unit: "medidas", name: "Leite Líquido NINHO® Forti+ Integral" },
      { amount: 3.0, unit: nil, name: "ovos" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Calda",
      "Em uma panela de fundo largo, derreta o açúcar até ficar dourado.",
      "Modo de Preparo",
      "Junte a água quente e mexa com uma colher. Deixe ferver até dissolver os torrões de açúcar e a calda engrossar.",
      "Modo de Preparo",
      "Forre com a calda uma forma com furo central (19 cm de diâmetro) e reserve.",
      "Pudim",
      "Em um liquidificador, acrescente o Leite Condensado Integral MOÇA, o leite NINHO Forti+ Integral e os ovos. Bata até obter uma consistência homogênea e despeje na forma reservada.",
      "Modo de Preparo",
      "Cubra com papel-alumínio e leve ao forno médio (180°C), em banho-maria, por cerca de 1 hora e 30 minutos.",
      "Modo de Preparo",
      "Depois de frio, leve o pudim de leite condensado MOÇA para gelar por cerca de 6 horas. Desenforme e sirva a seguir."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Calda\nEm uma panela de fundo largo, derreta o açúcar até ficar dourado.\nModo de Preparo\nJunte a água quente e mexa com uma colher. Deixe ferver até dissolver os torrões de açúcar e a calda engrossar.\nModo de Preparo\nForre com a calda uma forma com furo central (19 cm de diâmetro) e reserve.\nPudim\nEm um liquidificador, acrescente o Leite Condensado Integral MOÇA, o leite NINHO Forti+ Integral e os ovos. Bata até obter uma consistência homogênea e despeje na forma reservada.\nModo de Preparo\nCubra com papel-alumínio e leve ao forno médio (180°C), em banho-maria, por cerca de 1 hora e 30 minutos.\nModo de Preparo\nDepois de frio, leve o pudim de leite condensado MOÇA para gelar por cerca de 6 horas. Desenforme e sirva a seguir.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("receitasnestle.com.br")
    expect(recipe.canonical_url).to eq("https://www.receitasnestle.com.br/receitas/pudim-de-leite-moca")
    expect(recipe.site_name).to eq("Receitas Nestlé")
    expect(recipe.language).to eq("pt-br")
    expect(recipe.author).to eq("Receitas Nestlé")
    expect(recipe.description).to eq("A receita de Pudim de Leite Moça é uma sobremesa clássica e irresistível que encanta a todos. Com sua textura cremosa e sabor doce, essa receita é perfeita para finalizar um almoço ou jantar. O Pudim é fácil de preparar e pode ser feito com ingredientes simples, como Leite Condensado MOÇA, ovos e açúcar para a calda de caramelo brilhante que o decora. Este é um doce que carrega história e significado para diversas famílias ao longo de anos desde sua criação, por isso se tornou tão importante para a Confeitaria brasileira. Surpreenda seus convidados com essa delícia que é um verdadeiro ícone da culinária brasileira e que sempre faz sucesso nas mesas!")
    expect(recipe.image).to eq("https://www.receitasnestle.com.br/sites/default/files/srh_recipes/77309619092d18ac08b115a4a13badf6.jpg")
    expect(recipe.category).to eq("Meal set")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("16 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to eq(10)
    expect(recipe.cook_time).to eq(10)
    expect(recipe.keywords).to eq([
      "Classico Moca",
      "sem farinha",
      "baixo desembolso",
      "receitas sem crustaceos",
      "receita sem carne de porco",
      "receita sem peixe",
      "receita sem crustaceos",
      "receita típica",
      "pudim leite moça",
      "Café da Tarde",
      "Meal set",
      "Sobremesa",
      "Dias da semana",
      "Finais de semana",
      "Dia das Mães",
      "Treenut-Free",
      "Sem Amendoim",
      "Sem peixe",
      "Sem crustáceos",
      "Pouco sal",
      "Sem carne de porco",
      "Pescador",
      "Under 300 kcal",
      "Source of protein",
      "Tortas / tortas doces",
      "Pudim",
      "Flan / Mousse",
      "Do forno",
      "Melhor sobremesa",
      "Prato principal"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.4)
    expect(recipe.ratings_count).to eq(368)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({
      "calories" => "219",
      "carbohydrateContent" => "30",
      "proteinContent" => "8",
      "sodiumContent" => "108",
      "sugarContent" => "19",
      "fatContent" => "7"
    })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: nil, amount: 219.0 },
      { name: "carbohydrateContent", unit: nil, amount: 30.0 },
      { name: "proteinContent", unit: nil, amount: 8.0 },
      { name: "sodiumContent", unit: nil, amount: 108.0 },
      { name: "sugarContent", unit: nil, amount: 19.0 },
      { name: "fatContent", unit: nil, amount: 7.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#main-content")
  end
end
