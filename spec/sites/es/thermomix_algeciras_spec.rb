# frozen_string_literal: true

RSpec.describe "thermomix-algeciras.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_algeciras", url: "https://thermomix-algeciras.es/jose-manuel-ulloa-lara/legumbres-y-platos-de-cuchara/guiso-de-garbanzos-con-langostinos-y-pulpo-en-conserva") }

  it "reads the title" do
    expect(recipe.title).to eq("Guiso de garbanzos con langostinos y pulpo en conserva")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "3 dientes de ajo",
      "4 ramitas de perejil fresco (hojas y parte del tallo)",
      "1 cucharada colmada de pan rallado",
      "800 g de garbanzos cocidos (en conserva), lavados y escurridos",
      "50 g de aceite de oliva",
      "150 g de cebolla en trozos",
      "1 cucharada de pimentón",
      "1 lata pulpo en aceite",
      "¼ de cucharadita de comino molido",
      "1 pimienta de Cayena seca entera (opcional)",
      "1 hoja de laurel seca",
      "1 cucharadita de sal",
      "100 g de vino blanco",
      "500 g de caldo de pescado",
      "18 langostinos crudos medianos pelados (aprox. 250 g)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 3.0, unit: "dientes", name: "ajo" },
      { amount: 4.0, unit: "ramitas", name: "perejil fresco" },
      { amount: 1.0, unit: "cucharada", name: "colmada de pan rallado" },
      { amount: 800.0, unit: "g", name: "garbanzos cocidos, lavados y escurridos" },
      { amount: 50.0, unit: "g", name: "aceite de oliva" },
      { amount: 150.0, unit: "g", name: "cebolla en trozos" },
      { amount: 1.0, unit: "cucharada", name: "pimentón" },
      { amount: 1.0, unit: "lata", name: "pulpo en aceite" },
      { amount: 0.25, unit: nil, name: "cucharadita de comino molido" },
      { amount: 1.0, unit: nil, name: "pimienta de Cayena seca entera" },
      { amount: 1.0, unit: nil, name: "hoja de laurel seca" },
      { amount: 1.0, unit: "cucharadita", name: "sal" },
      { amount: 100.0, unit: "g", name: "vino blanco" },
      { amount: 500.0, unit: "g", name: "caldo de pescado" },
      { amount: 18.0, unit: nil, name: "langostinos crudos medianos pelados" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pon en el vaso 1 diente de ajo, el perejil, el pan rallado y 50 g de garbanzos cocidos y pica 5 seg/vel 7. Retira en un bol y reserva.",
      "Pon en el vaso el aceite, la cebolla y 2 dientes de ajo. Trocea 3 seg/vel 5 y sofríe 7 min/120°C/vel 1.",
      "Añade el pimentón, la lata de pulpo escurrida, el comino, la cayena, el laurel y la sal y rehoga 5 min/120°C/inv/vel 1.",
      "Incorpora el vino blanco y el caldo y programa 5 min/100°C/inv/vel 1.",
      "Agrega la picada de garbanzos, ajos y perejil, 750 g de garbanzos cocidos y los langostinos y programa 6 min/100°C/inv/vel . Sirva inmediatamente."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pon en el vaso 1 diente de ajo, el perejil, el pan rallado y 50 g de garbanzos cocidos y pica 5 seg/vel 7. Retira en un bol y reserva.\nPon en el vaso el aceite, la cebolla y 2 dientes de ajo. Trocea 3 seg/vel 5 y sofríe 7 min/120°C/vel 1.\nAñade el pimentón, la lata de pulpo escurrida, el comino, la cayena, el laurel y la sal y rehoga 5 min/120°C/inv/vel 1.\nIncorpora el vino blanco y el caldo y programa 5 min/100°C/inv/vel 1.\nAgrega la picada de garbanzos, ajos y perejil, 750 g de garbanzos cocidos y los langostinos y programa 6 min/100°C/inv/vel . Sirva inmediatamente.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-algeciras.es")
    expect(recipe.canonical_url).to eq("https://thermomix-algeciras.es/jose-manuel-ulloa-lara/legumbres-y-platos-de-cuchara/guiso-de-garbanzos-con-langostinos-y-pulpo-en-conserva")
    expect(recipe.site_name).to eq("Thermomix Algeciras")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("JOSE MANUEL ULLOA LARA")
    expect(recipe.description).to eq("Guiso de garbanzos con langostinos y pulpo en conserva, una receta de Legumbres y platos de cuchara, elaborada por JOSE MANUEL ULLOA LARA. Descubre las mejores recetas de Blogosfera Thermomix Algeciras")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/92080286c8725482164bbd59cd817ad2_f9cbd45176/92080286c8725482164bbd59cd817ad2_f9cbd45176.jpg")
    expect(recipe.category).to eq("Legumbres y platos de cuchara")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Guiso de garbanzos con langostinos y pulpo en conserva", "Legumbres y platos de cuchara"])
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
    expect(recipe.links).to include("https://blogosferathermomix.es/delegaciones-thermomix")
  end
end
