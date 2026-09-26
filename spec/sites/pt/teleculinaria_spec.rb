# frozen_string_literal: true

RSpec.describe "teleculinaria.pt" do
  subject(:recipe) { scrape_cassette("pt/teleculinaria", url: "https://teleculinaria.pt/receitas/pastel-de-nata/") }

  it "reads the title" do
    expect(recipe.title).to eq("Pastel de Nata")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 rolos massa folhada estendida",
      "150 g açúcar",
      "30 g farinha",
      "5 gemas M",
      "250 ml leite",
      "1 limão",
      "Manteiga para untar"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "rolos", name: "massa folhada estendida" },
      { amount: 150.0, unit: "g", name: "açúcar" },
      { amount: 30.0, unit: "g", name: "farinha" },
      { amount: 5.0, unit: nil, name: "gemas M" },
      { amount: 250.0, unit: "ml", name: "leite" },
      { amount: 1.0, unit: nil, name: "limão" },
      { amount: nil, unit: nil, name: "Manteiga para untar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Aqueça o forno a 240ºC. Leve ao lume o leite com o açúcar e a casca do limão e deixe ferver.",
      "Numa tigela, misture a farinha com as gemas. Rejeite a casca de limão do leite e deite-o em fio sobre a mistura das gemas, mexendo sempre até ficar bem homogéneo. Retire e reserve.",
      "Rejeite o papel vegetal da massa folhada, enrole-a bem e corte cada rolo em 4 ou 5 rodelas.",
      "Unte com manteiga pequenas formas metálicas e coloque uma rodela de massa dentro de cada uma. Com a ajuda dos polegares, estenda a massa pelo interior das formas, de modo a ficar todo coberto.",
      "Encha as formas com o creme até 2/3 da sua capacidade. Leve ao forno durante cerca de 15 minutos. Retire, deixe arrefecer e desenforme. Sirva de seguida."
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        ["Ingredientes", 7]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Aqueça o forno a 240ºC. Leve ao lume o leite com o açúcar e a casca do limão e deixe ferver.\nNuma tigela, misture a farinha com as gemas. Rejeite a casca de limão do leite e deite-o em fio sobre a mistura das gemas, mexendo sempre até ficar bem homogéneo. Retire e reserve.\nRejeite o papel vegetal da massa folhada, enrole-a bem e corte cada rolo em 4 ou 5 rodelas.\nUnte com manteiga pequenas formas metálicas e coloque uma rodela de massa dentro de cada uma. Com a ajuda dos polegares, estenda a massa pelo interior das formas, de modo a ficar todo coberto.\nEncha as formas com o creme até 2/3 da sua capacidade. Leve ao forno durante cerca de 15 minutos. Retire, deixe arrefecer e desenforme. Sirva de seguida.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("teleculinaria.pt")
    expect(recipe.canonical_url).to eq("https://teleculinaria.pt/receitas/pastel-de-nata/")
    expect(recipe.site_name).to eq("Teleculinária")
    expect(recipe.language).to eq("pt-pt")
    expect(recipe.author).to eq("master")
    expect(recipe.description).to eq("Os pastéis de nata são perfeitos para acompanhar um café ou chá, mas também podem ser desfrutados a qualquer hora do dia. Uma iguaria que combina a tradição e o prazer gastronómico em cada mordida!Hora de provar um pastel de nata.")
    expect(recipe.image).to eq("https://teleculinaria.pt/wp-content/uploads/2025/10/iqxudeu0stwe.jpg")
    expect(recipe.category).to be_nil
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to be_nil
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq([
      "como fazer pastéis de nata",
      "doces",
      "Doces Tradicionais",
      "doces tradicionais portugueses",
      "pastéis de nata originais",
      "receita de pasteis de nata",
      "receitas de doces",
      "receitas de sobremesas",
      "receitas económicas",
      "sobremesas"
    ])
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
    expect(recipe.links).to include("https://teleculinaria.pt/")
  end
end
