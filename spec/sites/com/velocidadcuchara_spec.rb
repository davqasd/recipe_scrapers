# frozen_string_literal: true

RSpec.describe "velocidadcuchara.com" do
  subject(:recipe) { scrape_cassette("com/velocidadcuchara", url: "https://www.velocidadcuchara.com/salmorejo-la-receta-de-juan-pozuelo-con-thermomix/") }

  it "reads the title" do
    expect(recipe.title).to eq("Salmorejo, la receta de Juan Pozuelo")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "750 g de tomates pera, bien maduros",
      "2 dientes de ajo",
      "200 g de miga de pan de torrija * o pan normal",
      "200 g de aceite virgen extra de la variedad arberquina",
      "50 g de vinagre de jerez",
      "sal",
      "Una bolsa de patatas fritas para hacer una base diferente ;D (opcional)*"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 750.0, unit: "g", name: "tomates pera, bien maduros" },
      { amount: 2.0, unit: "dientes", name: "ajo" },
      { amount: 200.0, unit: "g", name: "miga de pan de torrija * o pan normal" },
      { amount: 200.0, unit: "g", name: "aceite virgen extra de la variedad arberquina" },
      { amount: 50.0, unit: "g", name: "vinagre de jerez" },
      { amount: nil, unit: nil, name: "sal" },
      { amount: nil, unit: nil, name: "Una bolsa de patatas fritas para hacer una base diferente;D *" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Tritura los tomates con los ajos 1 minuto en velocidad 7 y cuela con un chino o un colador. La parte sólida que quede en el colador úsala para hacer caldos, sofriendo con vino y agua. La parte líquida será con la que continuemos preparando hoy nuestro salmorejo.",
      "Vierte en el vaso, el líquido de los tomates, el pan, aceite, y vinagre. Programa 7 minutos en velocidad 9.",
      "Mientras tienes la Thermomix ® en marcha, machaca las patatas fritas que pondremos como base en los vasitos donde vamos a servir el salmorejo -puedes hacerlo a mano machacando la bolsa, con la Thermomix ® o con una batidora-. Cuando lo tengas listo transfiere las patatillas machacadas a sus respectivos vasos.",
      "Ya solo falta que dejes enfriar bien el salmorejo y que sirvas en los vasitos. Listo"
    ])
  end

  it "splits the ingredients into the groups the page names" do
    expect(recipe.ingredient_groups.map { |group| [group.purpose, group.ingredients.size] }).
      to eq([
        [nil, 6],
        ["Para servir (opcional)", 1]
      ])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Tritura los tomates con los ajos 1 minuto en velocidad 7 y cuela con un chino o un colador. La parte sólida que quede en el colador úsala para hacer caldos, sofriendo con vino y agua. La parte líquida será con la que continuemos preparando hoy nuestro salmorejo.\nVierte en el vaso, el líquido de los tomates, el pan, aceite, y vinagre. Programa 7 minutos en velocidad 9.\nMientras tienes la Thermomix ® en marcha, machaca las patatas fritas que pondremos como base en los vasitos donde vamos a servir el salmorejo -puedes hacerlo a mano machacando la bolsa, con la Thermomix ® o con una batidora-. Cuando lo tengas listo transfiere las patatillas machacadas a sus respectivos vasos.\nYa solo falta que dejes enfriar bien el salmorejo y que sirvas en los vasitos. Listo")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("velocidadcuchara.com")
    expect(recipe.canonical_url).to eq("https://www.velocidadcuchara.com/salmorejo-la-receta-de-juan-pozuelo-con-thermomix/")
    expect(recipe.site_name).to eq("Velocidad Cuchara")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("Rosa Ardá")
    expect(recipe.description).to eq("Receta de Salmorejo de Juan Pozuelo, el mejor salmorejo que puedes hacer en Thermomix ®, compra ingredientes de calidad y disfruta. No deja indiferente.")
    expect(recipe.image).to eq("https://www.velocidadcuchara.com/wp-content/uploads/2011/05/Salmorejo-blog-Juan-Pozuelo1-140x93.png")
    expect(recipe.category).to eq("Entrantes, Primeros,")
    expect(recipe.cuisine).to eq("Española")
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to eq(2)
    expect(recipe.cook_time).to eq(8)
    expect(recipe.keywords).to be_nil
    expect(recipe.equipment).to be_nil
    expect(recipe.dietary_restrictions).to be_nil
    expect(recipe.ratings).to eq(4.4)
    expect(recipe.ratings_count).to eq(9)
  end

  it "publishes no nutrients" do
    expect(recipe.nutrients).to be_nil
    expect(recipe.parsed_nutrients).to be_nil
  end

  it "collects the links on the page" do
    expect(recipe.links).to include("#comment-235527")
  end
end
