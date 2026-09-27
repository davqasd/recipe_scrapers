# frozen_string_literal: true

RSpec.describe "thermomix-coruna.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_coruna", url: "https://thermomix-coruna.es/diana-m-pineiro-dieste/postres-y-dulces/tarta-de-queso-estilo-la-vina") }

  it "reads the title" do
    expect(recipe.title).to eq("Tarta de queso \"estilo la viña”")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1.1000 gr de queso crema (tipo Philadelphia)",
      "2. 500 gr de nata para montar",
      "3. 5 huevos",
      "4. 350 gr de azúcar",
      "5. 1 pizca de sal"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.1, unit: "gr", name: "queso crema" },
      { amount: 2.0, unit: nil, name: "500 gr de nata para montar" },
      { amount: 3.0, unit: nil, name: "5 huevos" },
      { amount: 4.0, unit: nil, name: "350 gr de azúcar" },
      { amount: 5.0, unit: nil, name: "1 pizca de sal" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Precalienta el horno a 200 °C (calor arriba y abajo). Forra un molde desmontable (Ø 24 cm) con papel de horno húmedo, dejando que sobresalga por los bordes.",
      "Mezcla todos los ingredientes:Introduce en el vaso: queso, nata, huevos, azúcar, maicena y sal.Programa 30 s a velocidad 6 hasta obtener una mezcla muy homogénea.",
      "Vierte la preparación en el molde y nivélala con movimientos suaves.",
      "Hornea aprox. 50 min a 180–200 °C (según tipología de horno), hasta que la superficie esté bien dorada, pero el centro siga ligeramente tembloroso. Al pinchar con palillo, éste debe salir limpio, aunque el centro se mueva.",
      "Templado dentro del horno: apaga el horno, deja la puerta entreabierta y deja reposar dentro unos 10 min.",
      "Deja enfriar a temperatura ambiente. Luego refrigera mínimo 4 h, idealmente toda la noche para asentar textura.",
      "Desmolda, retira el papel y, si lo deseas, cubre con miel o mermelada antes de servir."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Precalienta el horno a 200 °C (calor arriba y abajo). Forra un molde desmontable (Ø 24 cm) con papel de horno húmedo, dejando que sobresalga por los bordes.\nMezcla todos los ingredientes:Introduce en el vaso: queso, nata, huevos, azúcar, maicena y sal.Programa 30 s a velocidad 6 hasta obtener una mezcla muy homogénea.\nVierte la preparación en el molde y nivélala con movimientos suaves.\nHornea aprox. 50 min a 180–200 °C (según tipología de horno), hasta que la superficie esté bien dorada, pero el centro siga ligeramente tembloroso. Al pinchar con palillo, éste debe salir limpio, aunque el centro se mueva.\nTemplado dentro del horno: apaga el horno, deja la puerta entreabierta y deja reposar dentro unos 10 min.\nDeja enfriar a temperatura ambiente. Luego refrigera mínimo 4 h, idealmente toda la noche para asentar textura.\nDesmolda, retira el papel y, si lo deseas, cubre con miel o mermelada antes de servir.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-coruna.es")
    expect(recipe.canonical_url).to eq("https://thermomix-coruna.es/diana-m-pineiro-dieste/postres-y-dulces/tarta-de-queso-estilo-la-vina")
    expect(recipe.site_name).to eq("Thermomix Coruña")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("DIANA M PIÑEIRO DIESTE")
    expect(recipe.description).to eq("? Consejo: Sírvela con miel o mermelada… o sola, ¡porque ya lo dice todo! ?Ideal para: postres, celebraciones o solamente para darte un capricho.")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/d45f82265bd9df47960e508371241789_c7cc411b30/d45f82265bd9df47960e508371241789_c7cc411b30.jpg")
    expect(recipe.category).to eq("Postres y dulces")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to eq(2)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Tarta de queso \"estilo la viña”", "Postres y dulces"])
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
