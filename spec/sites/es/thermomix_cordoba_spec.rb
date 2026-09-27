# frozen_string_literal: true

RSpec.describe "thermomix-cordoba.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_cordoba", url: "https://thermomix-cordoba.es/virginia-camacho-aliaga/pescados-y-mariscos/receta-de-cuchara-con-thermomix-matamaridos") }

  it "reads the title" do
    expect(recipe.title).to eq("RECETA DE CUCHARA CON THERMOMIX: \"MATAMARIDOS\"")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "60 gramos aceite, de oliva",
      "100 g de cebolla en trozos",
      "80 g de pimiento verde en trozos",
      "2 dientes ajo",
      "2 zanahorias a ruedas de 1cm.",
      "120 g de tomate maduro pelado y en trozos",
      "500 g de pescado blanco limpio sin piel en trozos",
      "600 g de patatas chascadas en trozos",
      "1000 g de agua",
      "1 pellizco sal",
      "3 ramitas de perejil fresco picado",
      "Una cucharada de concentrado de pescado casero"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 60.0, unit: "gramos", name: "aceite, de oliva" },
      { amount: 100.0, unit: "g", name: "cebolla en trozos" },
      { amount: 80.0, unit: "g", name: "pimiento verde en trozos" },
      { amount: 2.0, unit: "dientes", name: "ajo" },
      { amount: 2.0, unit: nil, name: "zanahorias a ruedas de 1cm." },
      { amount: 120.0, unit: "g", name: "tomate maduro pelado y en trozos" },
      { amount: 500.0, unit: "g", name: "pescado blanco limpio sin piel en trozos" },
      { amount: 600.0, unit: "g", name: "patatas chascadas en trozos" },
      { amount: 1000.0, unit: "g", name: "agua" },
      { amount: 1.0, unit: nil, name: "pellizco sal" },
      { amount: 3.0, unit: "ramitas", name: "perejil fresco picado" },
      { amount: nil, unit: nil, name: "Una cucharada de concentrado de pescado casero" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pon en el vaso el tomate, los ajos, la cebolla y el pimiento. Trocea 3 seg/vel 4. Con la espátula, baja los ingredientes hacia el fondo del vaso.",
      "Añade el aceite, la sal y el agua. Concentrado de pescado . Introduce el cestillo con las patatas y las zanahorias y programa 25 min/100°C/vel 1.",
      "Sitúa el recipiente Varoma en su posición y pon el pescado. Programa 10 min/Varoma/vel 1. Retira el Varoma, con la muesca de la espátula, extrae el cestillo. Pon las patatas , zanahorias y el pescado en una sopera .",
      "Coloca el cubilete en la tapa y tritura 30 seg/vel 10. Vierte el caldo sobre el pescado, zanahorias y patatas y sirve inmediatamente espolvoreado con el perejil picado."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pon en el vaso el tomate, los ajos, la cebolla y el pimiento. Trocea 3 seg/vel 4. Con la espátula, baja los ingredientes hacia el fondo del vaso.\nAñade el aceite, la sal y el agua. Concentrado de pescado . Introduce el cestillo con las patatas y las zanahorias y programa 25 min/100°C/vel 1.\nSitúa el recipiente Varoma en su posición y pon el pescado. Programa 10 min/Varoma/vel 1. Retira el Varoma, con la muesca de la espátula, extrae el cestillo. Pon las patatas , zanahorias y el pescado en una sopera .\nColoca el cubilete en la tapa y tritura 30 seg/vel 10. Vierte el caldo sobre el pescado, zanahorias y patatas y sirve inmediatamente espolvoreado con el perejil picado.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-cordoba.es")
    expect(recipe.canonical_url).to eq("https://thermomix-cordoba.es/virginia-camacho-aliaga/pescados-y-mariscos/receta-de-cuchara-con-thermomix-matamaridos")
    expect(recipe.site_name).to eq("Thermomix Córdoba")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("VIRGINIA CAMACHO ALIAGA")
    expect(recipe.description).to eq("RECETA DE CUCHARA CON THERMOMIX: \"MATAMARIDOS\", una receta de Pescados y mariscos, elaborada por VIRGINIA CAMACHO ALIAGA. Descubre las mejores recetas de Blogosfera Thermomix Córdoba")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/b97c416aa68b849ceb53f2fe6233a0f7_7ce534009e/b97c416aa68b849ceb53f2fe6233a0f7_7ce534009e.jpg")
    expect(recipe.category).to eq("Pescados y mariscos")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["RECETA DE CUCHARA CON THERMOMIX: \"MATAMARIDOS\"", "Pescados y mariscos"])
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
