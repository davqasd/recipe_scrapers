# frozen_string_literal: true

RSpec.describe "thermomix-laspalmas.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_laspalmas", url: "https://thermomix-laspalmas.es/isabel-romero-mayo/pastas-y-arroces/cocina-en-niveles") }

  it "reads the title" do
    expect(recipe.title).to eq("Cocina en niveles")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "50 g de aceite de oliva",
      "400 g de agua",
      "1 diente de ajo",
      "140 g de atún en lata",
      "300 g de calabacín en brunoise",
      "200 g de cebolla",
      "2 huevos forrados en film transparente",
      "800 g de lomo de cerdo en trozos de 3 cm",
      "60 g de mantequilla",
      "150 g de patatas en brunoise",
      "250 g de pasta farfalle",
      "90 g de pimiento rojo",
      "200 g de tomate triturado",
      "10 unidades de tomates cherry",
      "2 yemas de huevo",
      "175 g de zanahorias en brunoise",
      "25 g de zumo de naranja"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 50.0, unit: "g", name: "aceite de oliva" },
      { amount: 400.0, unit: "g", name: "agua" },
      { amount: 1.0, unit: "diente", name: "ajo" },
      { amount: 140.0, unit: "g", name: "atún en lata" },
      { amount: 300.0, unit: "g", name: "calabacín en brunoise" },
      { amount: 200.0, unit: "g", name: "cebolla" },
      { amount: 2.0, unit: nil, name: "huevos forrados en film transparente" },
      { amount: 800.0, unit: "g", name: "lomo de cerdo en trozos de 3 cm" },
      { amount: 60.0, unit: "g", name: "mantequilla" },
      { amount: 150.0, unit: "g", name: "patatas en brunoise" },
      { amount: 250.0, unit: "g", name: "pasta farfalle" },
      { amount: 90.0, unit: "g", name: "pimiento rojo" },
      { amount: 200.0, unit: "g", name: "tomate triturado" },
      { amount: 10.0, unit: nil, name: "unidades de tomates cherry" },
      { amount: 2.0, unit: nil, name: "yemas de huevo" },
      { amount: 175.0, unit: "g", name: "zanahorias en brunoise" },
      { amount: 25.0, unit: "g", name: "zumo de naranja" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Introduzca en el Varoma el lomo de cerdo y aderécelo con sal y pimienta . En la bandeja del Varoma coloque los huevos, las patatas, el calabacín y 150 g de la zanahoria; aderece al gusto (por ejemplo: con sal, aceite aromatizado, hierbas provenzales, etc.). Tape el Varoma y reserve.",
      "Introduzca en el vaso el aceite, el ajo, la cebolla, el pimiento rojo y los 25 g restantes de la zanahoria. Programe 10 segundos, velocidad 4.5. Concluido el tiempo, sofría 5 minutos, temperatura 100ºC, velocidad 1,5. Acto seguido, incorpore el tomate triturado y el agua. Coloque el Varoma en su posición y seleccione el modo “al vapor”, 15 minutos, velocidad 1.",
      "Concluido este tiempo, introduzca en el vaso del Thermomix el cestillo con la pasta. Vuelva a colocar el Varoma en su posición y programe el modo “al vapor”, 15 minutos, velocidad 4.",
      "Retire el Varoma y el cestillo. Coloque la carne en un recipiente, la pasta junto con algunas de las verduras y los huevos en otro, y las verduras restantes en un tercer recipiente. Reserve.",
      "Introduzca en el vaso del Thermomix las yemas de huevo, la mantequilla, la sal, la pimienta y el zumo de naranja. Programe 1 minuto, velocidad 6. A continuación, seleccione el modo “espesar” a 80ºC. Finalizado el tiempo, vierta esa salsa sobre la carne. En el recipiente de la pasta, vierta la lata de atún y trocee unos tomates cherry."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Introduzca en el Varoma el lomo de cerdo y aderécelo con sal y pimienta . En la bandeja del Varoma coloque los huevos, las patatas, el calabacín y 150 g de la zanahoria; aderece al gusto (por ejemplo: con sal, aceite aromatizado, hierbas provenzales, etc.). Tape el Varoma y reserve.\nIntroduzca en el vaso el aceite, el ajo, la cebolla, el pimiento rojo y los 25 g restantes de la zanahoria. Programe 10 segundos, velocidad 4.5. Concluido el tiempo, sofría 5 minutos, temperatura 100ºC, velocidad 1,5. Acto seguido, incorpore el tomate triturado y el agua. Coloque el Varoma en su posición y seleccione el modo “al vapor”, 15 minutos, velocidad 1.\nConcluido este tiempo, introduzca en el vaso del Thermomix el cestillo con la pasta. Vuelva a colocar el Varoma en su posición y programe el modo “al vapor”, 15 minutos, velocidad 4.\nRetire el Varoma y el cestillo. Coloque la carne en un recipiente, la pasta junto con algunas de las verduras y los huevos en otro, y las verduras restantes en un tercer recipiente. Reserve.\nIntroduzca en el vaso del Thermomix las yemas de huevo, la mantequilla, la sal, la pimienta y el zumo de naranja. Programe 1 minuto, velocidad 6. A continuación, seleccione el modo “espesar” a 80ºC. Finalizado el tiempo, vierta esa salsa sobre la carne. En el recipiente de la pasta, vierta la lata de atún y trocee unos tomates cherry.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-laspalmas.es")
    expect(recipe.canonical_url).to eq("https://thermomix-laspalmas.es/isabel-romero-mayo/pastas-y-arroces/cocina-en-niveles")
    expect(recipe.site_name).to eq("Thermomix Las Palmas")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("ISABEL ROMERO MAYO")
    expect(recipe.description).to eq("Menú completo para quienes no tienen tiempo")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/51ae77bc7c5ff9ad8dea14b9565dfc0c_f699462ca2/51ae77bc7c5ff9ad8dea14b9565dfc0c_f699462ca2.jpg")
    expect(recipe.category).to eq("Pastas y arroces")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Cocina en niveles", "Pastas y arroces"])
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
