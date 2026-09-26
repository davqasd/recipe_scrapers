# frozen_string_literal: true

RSpec.describe "pingodoce.pt" do
  subject(:recipe) { scrape_cassette("pt/pingodoce", url: "https://www.pingodoce.pt/receitas/secretos-grelhados-com-abacaxi-e-alecrim/") }

  it "reads the title" do
    expect(recipe.title).to eq("Secretos grelhados com abacaxi e alecrim")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "4 unid. secretos de porco preto Pingo Doce",
      "1 c. de café sal",
      "½ unid. limão (sumo)",
      "¼ cháv. vinho branco",
      "4 rodela abacaxi",
      "1 c. de sopa mel",
      "q.b. alecrim"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 4.0, unit: "unid", name: "secretos de porco preto Pingo Doce" },
      { amount: 1.0, unit: "c. de café", name: "sal" },
      { amount: 0.5, unit: "unid", name: "limão" },
      { amount: 0.25, unit: "cháv", name: "vinho branco" },
      { amount: 4.0, unit: "rodela", name: "abacaxi" },
      { amount: 1.0, unit: "c. de sopa", name: "mel" },
      { amount: nil, unit: nil, name: "q.b. alecrim" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Passo 1",
      "Tempere os secretos com sal a gosto, o sumo de limão e o vinho branco. Deixe repousar cerca de 20 minutos.",
      "Passo 2",
      "Corte as rodelas de abacaxi em quartos e grelhe até estarem bem marcadas. A seguir, grelhe a carne até estar bem cozinhada por dentro e bem suculenta.",
      "Passo 3",
      "Verta a marinada dos secretos numa panela pequena e junte o mel e o alecrim. Deixe ferver, misture bem e regue o ananás e a carne antes de servir."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Passo 1\nTempere os secretos com sal a gosto, o sumo de limão e o vinho branco. Deixe repousar cerca de 20 minutos.\nPasso 2\nCorte as rodelas de abacaxi em quartos e grelhe até estarem bem marcadas. A seguir, grelhe a carne até estar bem cozinhada por dentro e bem suculenta.\nPasso 3\nVerta a marinada dos secretos numa panela pequena e junte o mel e o alecrim. Deixe ferver, misture bem e regue o ananás e a carne antes de servir.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("pingodoce.pt")
    expect(recipe.canonical_url).to eq("https://www.pingodoce.pt/receitas/secretos-grelhados-com-abacaxi-e-alecrim/")
    expect(recipe.site_name).to eq("Pingo Doce")
    expect(recipe.language).to eq("pt")
    expect(recipe.author).to be_nil
    expect(recipe.description).to eq("Experimente fazer secretos de porco preto grelhados e junte-lhes abacaxi e um delicioso molho de mel e alecrim. O resultado? Um prato com muito sabor, que vai querer repetir vezes sem conta!")
    expect(recipe.image).to eq("https://www.pingodoce.pt/wp-content/uploads/2022/07/secretos-grelhados-com-abacaxi-e-alecrim.jpg")
    expect(recipe.category).to eq("Carne")
    expect(recipe.cuisine).to eq("Sem tipo de cozinha")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("2 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to eq(25)
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["abacaxi e ananás", "porco"])
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.7)
    expect(recipe.ratings_count).to eq(42)
  end

  it "reads the nutrients" do
    expect(recipe.nutrients).to eq({ "calories" => "916 calories" })
  end

  it "parses every nutrient into a name, a unit and an amount" do
    expect(recipe.parsed_nutrients.map(&:to_h)).to eq([
      { name: "calories", unit: "kcal", amount: 916.0 }
    ])
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#maincontent")
  end
end
