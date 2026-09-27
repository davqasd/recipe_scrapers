# frozen_string_literal: true

RSpec.describe "thermomix-elche.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_elche", url: "https://thermomix-elche.es/magui-peral-molla/postres-y-dulces/polos-tipo-magnum-receta-versatil") }

  it "reads the title" do
    expect(recipe.title).to eq("Polos tipo Magnum (receta versátil)")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "120 G FRUTOS SECOS. P ejem avellanas, cacahuetes, almendras, pistachos...O bien 120 g de la crema de pistachos de cookidoo (con avellanas)",
      "ENDULZANTE AL GUSTO puede ser 10 g de eritritol con sucralosa O bien 60/70 g de dátiles deshuesados...",
      "Chorrito de vainilla",
      "50 g de leche en polvo",
      "250 g LÁCTEO ANIMAL O VEGETAL puede ser leche de coco, 2 yogures griegos o mascarpone",
      "400 g de chocolate de postres",
      "40 g de aceite de coco o de girasol",
      "Granillo de almendra"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 120.0, unit: "G", name: "FRUTOS SECOS. P ejem avellanas, cacahuetes, almendras, pistachos...O bien 120 g de la crema de pistachos de cookidoo" },
      { amount: nil, unit: nil, name: "ENDULZANTE AL GUSTO puede ser 10 g de eritritol con sucralosa O bien 60/70 g de dátiles deshuesados..." },
      { amount: nil, unit: nil, name: "Chorrito de vainilla" },
      { amount: 50.0, unit: "g", name: "leche en polvo" },
      { amount: 250.0, unit: "g", name: "LÁCTEO ANIMAL O VEGETAL puede ser leche de coco, 2 yogures griegos o mascarpone" },
      { amount: 400.0, unit: "g", name: "chocolate de postres" },
      { amount: 40.0, unit: "g", name: "aceite de coco o de girasol" },
      { amount: nil, unit: nil, name: "Granillo de almendra" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Si usamos frutos secos triturar 20 seg/velocidad 8 Bajar los restos de las paredes del vaso y volver a triturar 30 seg/velocidad 6 Si es necesario repetir la operación, hasta que suelte el aceite y esté la pasta brillante",
      "Añadir el endulzante elegido, la vainilla, el lácteo elegido (el que más cremoso queda es el mascarpone) y la leche en polvo. (Si estás usando lácteo vegetal por intolerancia no le pongas leche en polvo) triturar en velocidad progresiva 5/7/10 30 seg/velocidad 10 bajar los restos y repetir la operación si fuera necesario (Eso en el caso de usar dátiles como endulzante) Si sólo vas a mezclar ingredientes que no hay que triturar puedes hacerlo 20 segundos en velocidad 5",
      "Verter en los moldes 5/6 dependiendo del tamaño y congelar al menos 5 o 6 horas, o mejor de un día para otro",
      "Para bañar los polos Triturar el chocolate 10 seg/velocidad 8 y fundirlo con el el aceite 6 min/50°C/velocidad 2.5",
      "Verter el chocolate fundido en un vaso estrecho y alto donde quepan los polos y bañarlos brevemente. Añadir granillo de almendra al gusto. Colocarlos sobre papel de hornear y volver a congelar unos 5 minutos"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Si usamos frutos secos triturar 20 seg/velocidad 8 Bajar los restos de las paredes del vaso y volver a triturar 30 seg/velocidad 6 Si es necesario repetir la operación, hasta que suelte el aceite y esté la pasta brillante\nAñadir el endulzante elegido, la vainilla, el lácteo elegido (el que más cremoso queda es el mascarpone) y la leche en polvo. (Si estás usando lácteo vegetal por intolerancia no le pongas leche en polvo) triturar en velocidad progresiva 5/7/10 30 seg/velocidad 10 bajar los restos y repetir la operación si fuera necesario (Eso en el caso de usar dátiles como endulzante) Si sólo vas a mezclar ingredientes que no hay que triturar puedes hacerlo 20 segundos en velocidad 5\nVerter en los moldes 5/6 dependiendo del tamaño y congelar al menos 5 o 6 horas, o mejor de un día para otro\nPara bañar los polos Triturar el chocolate 10 seg/velocidad 8 y fundirlo con el el aceite 6 min/50°C/velocidad 2.5\nVerter el chocolate fundido en un vaso estrecho y alto donde quepan los polos y bañarlos brevemente. Añadir granillo de almendra al gusto. Colocarlos sobre papel de hornear y volver a congelar unos 5 minutos")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-elche.es")
    expect(recipe.canonical_url).to eq("https://thermomix-elche.es/magui-peral-molla/postres-y-dulces/polos-tipo-magnum-receta-versatil")
    expect(recipe.site_name).to eq("Thermomix Elche")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("MARGARITA PERAL MOLLA")
    expect(recipe.description).to eq("Las raciones dependen del tamaño de los moldes. Si son más grandes salen 5 o 6 si son algo menores")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/e857152d7e2f8f2854f2433266a078dc_58a9dd6692/e857152d7e2f8f2854f2433266a078dc_58a9dd6692.jpg")
    expect(recipe.category).to eq("Postres y dulces")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Polos tipo Magnum (receta versátil)", "Postres y dulces"])
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
