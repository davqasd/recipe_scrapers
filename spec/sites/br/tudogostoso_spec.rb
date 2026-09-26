# frozen_string_literal: true

RSpec.describe "tudogostoso.com.br" do
  subject(:recipe) { scrape_cassette("br/tudogostoso", url: "https://www.tudogostoso.com.br/receita/320713-churros-fit-de-pao-de-forma-na-airfryer-com-apenas-3-ingredientes.html") }

  it "reads the title" do
    expect(recipe.title).to eq("Churros fit de pão de forma na airfryer com apenas 3 ingredientes")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 fatias de pão de forma integral sem casca",
      "20 g de doce de leite zero açúcar",
      "canela em pó a gosto",
      "1 colher (chá) rasa de leite em pó desnatado (opcional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "fatias", name: "pão de forma integral sem casca" },
      { amount: 20.0, unit: "g", name: "doce de leite zero açúcar" },
      { amount: nil, unit: nil, name: "canela em pó a gosto" },
      { amount: 1.0, unit: "colher", name: "rasa de leite em pó desnatado" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Com ajuda de um rolo ou um copo, amasse e abra as fatias de pão, deixando-as mais finas.",
      "Em seguida, divida o recheio de doce de leite em cada uma das fatias.",
      "Com cuidado, enrole a fatia de pão recheado como se fosse um rocambole. Ao final, se precisar, espete um palito para mantê-lo fechado.",
      "Leve os rolinhos para assar na airfryer a 200° C por 5 minutinhos. Fique de olho para não queimar!",
      "Passado esse tempo, retire e polvilho a canela e o leite em pó desnatado por cima.",
      "Sirva quentinho!"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Com ajuda de um rolo ou um copo, amasse e abra as fatias de pão, deixando-as mais finas.\nEm seguida, divida o recheio de doce de leite em cada uma das fatias.\nCom cuidado, enrole a fatia de pão recheado como se fosse um rocambole. Ao final, se precisar, espete um palito para mantê-lo fechado.\nLeve os rolinhos para assar na airfryer a 200° C por 5 minutinhos. Fique de olho para não queimar!\nPassado esse tempo, retire e polvilho a canela e o leite em pó desnatado por cima.\nSirva quentinho!")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("tudogostoso.com.br")
    expect(recipe.canonical_url).to eq("https://www.tudogostoso.com.br/receita/320713-churros-fit-de-pao-de-forma-na-airfryer-com-apenas-3-ingredientes.html")
    expect(recipe.site_name).to eq("TudoGostoso")
    expect(recipe.language).to eq("pt-br")
    expect(recipe.author).to eq("TudoGostoso")
    expect(recipe.description).to eq("A receita de churros fit de pão de forma na airfryer é ideal para quem gosta de um docinho, mas procura por preparos leves, fáceis e que não fujam da dieta. O doce fit leva apenas 3 ingredientes e fica pronto em poucos passos, sendo uma ótima alternativa para matar a vontade de comer algo doce sem passar horas na cozinha. O preparo é simples e combina perfeitamente com a praticidade da airfryer. Para quem procura churros fit na airfryer, essa versão com pão de forma é uma escolha fácil para o café da tarde ou aquele lanchinho especial. Além disso, aprender como fazer churros fit na airfryer não tem segredo: basta seguir o passo a passo e deixar o aparelho fazer o trabalho. A receita de churros na airfryer fit com pão de forma ainda é uma ótima ideia para variar o cardápio com um quitute diferente e muito saboroso.")
    expect(recipe.image).to eq("https://static.itdg.com.br/images/1200-675/81a88576de547c678394e93f59504547/churros-fit-de-pao-de-forma-na-airfryer-com-apenas-3-ingredientes.jpg")
    expect(recipe.category).to eq("Doces e sobremesas")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 items")
    expect(recipe.total_time).to eq(8)
    expect(recipe.prep_time).to eq(8)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq([
      "Receita de Churros fit de pão de forma na airfryer com apenas 3 ingredientes",
      "Doces e sobremesas",
      "Doces e sobremesas lights",
      "Airfryer",
      "Airfryer > Sobremesas e doces"
    ])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(5.0)
    expect(recipe.ratings_count).to eq(6)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("https://www.tudogostoso.com.br/")
  end
end
