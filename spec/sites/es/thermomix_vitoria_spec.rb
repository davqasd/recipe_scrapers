# frozen_string_literal: true

RSpec.describe "thermomix-vitoria.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_vitoria", url: "https://thermomix-vitoria.es/beatriz-lopez-zurimendi/te-cuida/desayuno-probiotico-en-tarro-1") }

  it "reads the title" do
    expect(recipe.title).to eq("Desayuno probiótico en tarro")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 plátano en trozos",
      "20 g de miel",
      "500g de yogur griego",
      "80 g de granos de granada",
      "20 g de semillas de chía",
      "10 g de zumo de limón",
      "1 manzana pelada en láminas",
      "1-2 kiwis pelados en láminas",
      "10 g de semillas de lino"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "plátano en trozos" },
      { amount: 20.0, unit: "g", name: "miel" },
      { amount: 500.0, unit: "g", name: "yogur griego" },
      { amount: 80.0, unit: "g", name: "granos de granada" },
      { amount: 20.0, unit: "g", name: "semillas de chía" },
      { amount: 10.0, unit: "g", name: "zumo de limón" },
      { amount: 1.0, unit: nil, name: "manzana pelada en láminas" },
      { amount: 1.0, unit: nil, name: "kiwis pelados en láminas" },
      { amount: 10.0, unit: "g", name: "semillas de lino" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Ponga en el vaso el Platano, la miel, el yogur griego, 30 g de granada, las semillas de chía y el zumo de limón y mezcle 30 segundos en velocidad 4.",
      "Reparta la mezcla en 4 tarros de cristal.",
      "Añada al tarro una capa de láminas de manzana, otra de kiwi y espolvoree los granos de granada restantes, las semillas de lino y sirva."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Ponga en el vaso el Platano, la miel, el yogur griego, 30 g de granada, las semillas de chía y el zumo de limón y mezcle 30 segundos en velocidad 4.\nReparta la mezcla en 4 tarros de cristal.\nAñada al tarro una capa de láminas de manzana, otra de kiwi y espolvoree los granos de granada restantes, las semillas de lino y sirva.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-vitoria.es")
    expect(recipe.canonical_url).to eq("https://thermomix-vitoria.es/beatriz-lopez-zurimendi/te-cuida/desayuno-probiotico-en-tarro-1")
    expect(recipe.site_name).to eq("Thermomix Vitoria")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("BEATRIZ LOPEZ ZURIMENDI")
    expect(recipe.description).to eq("Desayuno probiótico en tarro, una receta de Te cuida, elaborada por BEATRIZ LOPEZ ZURIMENDI. Descubre las mejores recetas de Blogosfera Thermomix Vitoria")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/IMG_7347_a0b3525957/IMG_7347_a0b3525957.jpeg")
    expect(recipe.category).to eq("Te cuida")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Desayuno probiótico en tarro", "Te cuida"])
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
