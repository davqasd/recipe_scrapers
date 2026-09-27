# frozen_string_literal: true

RSpec.describe "thermomix-orense.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_orense", url: "https://thermomix-orense.es/maria-ribao-novoa/postres-y-dulces/tarta-de-manzana-cremosa") }

  it "reads the title" do
    expect(recipe.title).to eq("Tarta de manzana cremosa")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "800gr de manzana",
      "250 ml de leche",
      "2 huevos",
      "250gr de azúcar",
      "20gr de harina",
      "1 cda.. Agua",
      "50 gr de mermelada",
      "1 plancha de masa quebrada"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 800.0, unit: "gr", name: "manzana" },
      { amount: 250.0, unit: "ml", name: "leche" },
      { amount: 2.0, unit: nil, name: "huevos" },
      { amount: 250.0, unit: "gr", name: "azúcar" },
      { amount: 20.0, unit: "gr", name: "harina" },
      { amount: 1.0, unit: "cda", name: "Agua" },
      { amount: 50.0, unit: "gr", name: "mermelada" },
      { amount: 1.0, unit: nil, name: "plancha de masa quebrada" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pelamos y cortamos las manzanas añadimos al vaso 650gr.Troceamos 2 min / vel.5Los 150gr restantes son para decorar",
      "Añadimos la leche, el azúcar y huevos. Mezclamos 1 min/vel 1.5 .Agregamos la harina, Mezclamos 2min/vel 3En este punto precalentamos el horno a 180º",
      "Mientras tanto en aceitamos un molde de 26ø.Colocamos la masa quebrada en el molde y asentamos la masa en la base y paredes.",
      "Vertemos la mezcla y colocamos con gajos muy finitos en forma de espiral por toda la superficie.En es punto agréganos en un bol la mermelada con un par de cucharadas de agua.Pincelamos la superficie con la mezcla.",
      "Horneamos a 180º durante 70 min."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pelamos y cortamos las manzanas añadimos al vaso 650gr.Troceamos 2 min / vel.5Los 150gr restantes son para decorar\nAñadimos la leche, el azúcar y huevos. Mezclamos 1 min/vel 1.5 .Agregamos la harina, Mezclamos 2min/vel 3En este punto precalentamos el horno a 180º\nMientras tanto en aceitamos un molde de 26ø.Colocamos la masa quebrada en el molde y asentamos la masa en la base y paredes.\nVertemos la mezcla y colocamos con gajos muy finitos en forma de espiral por toda la superficie.En es punto agréganos en un bol la mermelada con un par de cucharadas de agua.Pincelamos la superficie con la mezcla.\nHorneamos a 180º durante 70 min.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-orense.es")
    expect(recipe.canonical_url).to eq("https://thermomix-orense.es/maria-ribao-novoa/postres-y-dulces/tarta-de-manzana-cremosa")
    expect(recipe.site_name).to eq("Thermomix Orense")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("MARIA RIBAO NOVOA")
    expect(recipe.description).to eq("En lugar del glaseado de mermelada se puede sustituir por una mezcla de agua y canela y barnizar de la misma forma.")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/f79443ad3b3e29beb9fbc44600bf3975_c2a1b17418/f79443ad3b3e29beb9fbc44600bf3975_c2a1b17418.jpg")
    expect(recipe.category).to eq("Postres y dulces")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(2)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Tarta de manzana cremosa", "Postres y dulces"])
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
