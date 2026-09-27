# frozen_string_literal: true

RSpec.describe "thermomix-sevilla.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_sevilla", url: "https://thermomix-sevilla.es/inmaculada-franco-martin/dietas-especiales/pastas-de-almendra-turquia-sin-gluten") }

  it "reads the title" do
    expect(recipe.title).to eq("Pastas de almendra - Turquía sin gluten")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "50 g de azúcar glass",
      "100 g de azúcar",
      "8 tiras de piel de naranja (sin nada de parte blanca)",
      "250 g de almendra molida certificada sin gluten",
      "1 cucharadita de polvo de hornear o levadura química sin gluten",
      "1 huevo",
      "25 g de agua de azahar sin gluten",
      "150 g de granillo de almendra cruda sin gluten",
      "8 ciruelas pasas sin hueso y sin gluten (cortadas por la mitad)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 50.0, unit: "g", name: "azúcar glass" },
      { amount: 100.0, unit: "g", name: "azúcar" },
      { amount: 8.0, unit: nil, name: "tiras de piel de naranja" },
      { amount: 250.0, unit: "g", name: "almendra molida certificada sin gluten" },
      { amount: 1.0, unit: "cucharadita", name: "polvo de hornear o levadura química sin gluten" },
      { amount: 1.0, unit: nil, name: "huevo" },
      { amount: 25.0, unit: "g", name: "agua de azahar sin gluten" },
      { amount: 150.0, unit: "g", name: "granillo de almendra cruda sin gluten" },
      { amount: 8.0, unit: nil, name: "ciruelas pasas sin hueso y sin gluten" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Azúcar glas: Ponga en el vaso el azúcar y pulverice 10 seg/vel 10. Retire del vaso y reserve.",
      "Precaliente el horno a 200°C. Forre una bandeja de horno con papel de hornear.",
      "Ponga en el vaso el azúcar y la piel de naranja y pulverice 10 seg/vel 10. Con la espátula, baje los ingredientes hacia el fondo del vaso.",
      "Añada la almendra molida, la levadura, el huevo y el agua de azahar. Mezcle 12 seg/vel 4. Forme 16 bolas del tamaño de una nuez, aplástelas y reboce con el granillo de almendra. Colóquelas en la bandeja preparada y ponga ½ ciruela pasa en el centro.",
      "Hornee durante 12 minutos (200°C). Retire del horno, espolvoree con el azúcar glas reservado y sirva o conserve en un recipiente hermético."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Azúcar glas: Ponga en el vaso el azúcar y pulverice 10 seg/vel 10. Retire del vaso y reserve.\nPrecaliente el horno a 200°C. Forre una bandeja de horno con papel de hornear.\nPonga en el vaso el azúcar y la piel de naranja y pulverice 10 seg/vel 10. Con la espátula, baje los ingredientes hacia el fondo del vaso.\nAñada la almendra molida, la levadura, el huevo y el agua de azahar. Mezcle 12 seg/vel 4. Forme 16 bolas del tamaño de una nuez, aplástelas y reboce con el granillo de almendra. Colóquelas en la bandeja preparada y ponga ½ ciruela pasa en el centro.\nHornee durante 12 minutos (200°C). Retire del horno, espolvoree con el azúcar glas reservado y sirva o conserve en un recipiente hermético.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-sevilla.es")
    expect(recipe.canonical_url).to eq("https://thermomix-sevilla.es/inmaculada-franco-martin/dietas-especiales/pastas-de-almendra-turquia-sin-gluten")
    expect(recipe.site_name).to eq("Thermomix Sevilla Florida")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("INMACULADA FRANCO MARTIN")
    expect(recipe.description).to eq("⭐ MI CONSEJO El secreto de estas pastas está en no escatimar en la almendra y en utilizar una buena naranja y agua de azahar. El resultado es una pasta con un exterior crujiente y un interior muy aromático y delicioso. Si las preparáis, contadme qué os han parecido. ¡Estoy segura de que os van a sorprender! ❤️ 💡 Idea: Son perfectas para preparar con antelación y conservar en un recipiente hermético. Así tendrás siempre a mano un pequeño capricho dulce para acompañar una infusión o para ofrecer a tus invitados.")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/GALLETAS_ALMENDRA_TURQUIA_38655c59d4/GALLETAS_ALMENDRA_TURQUIA_38655c59d4.png")
    expect(recipe.category).to eq("Dietas especiales")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("16 servings")
    expect(recipe.total_time).to eq(30)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Pastas de almendra - Turquía sin gluten", "Dietas especiales"])
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
