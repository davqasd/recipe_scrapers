# frozen_string_literal: true

RSpec.describe "thermomix-barcelona.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_barcelona", url: "https://thermomix-barcelona.es/sonia-ripoll/dietas-especiales/crema-de-avellanas-leche-cacao-sin-azucar-sin-gluten-y-sin-lactosa-con-thermomix") }

  it "reads the title" do
    expect(recipe.title).to eq("CREMA DE AVELLANAS, LECHE, CACAO SIN AZUCAR SIN GLUTEN Y SIN LACTOSA con Thermomix")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "40g eritritol",
      "200g de avellanas tostadas y peladas",
      "15g aceite de oliva suave",
      "10g de vainilla en pasta",
      "25g de cacao puro en polvo",
      "200g de leche semidesnatada sin lactosa"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 40.0, unit: "g", name: "eritritol" },
      { amount: 200.0, unit: "g", name: "avellanas tostadas y peladas" },
      { amount: 15.0, unit: "g", name: "aceite de oliva suave" },
      { amount: 10.0, unit: "g", name: "vainilla en pasta" },
      { amount: 25.0, unit: "g", name: "cacao puro en polvo" },
      { amount: 200.0, unit: "g", name: "leche semidesnatada sin lactosa" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pesa el eritritol y pulveriza 30 segundos / velocidad 10. Reserva en un bol.",
      "Pesa las avellanas y tritura 30 segundos /velocidad 10. Baja las avellanas al fondo del vaso con la espátula y repite este paso hasta obtener una crema fina de avellanas.",
      "Añade el eritritol reservado, el aceite, el cacao, la vainilla y la leche y tritura 1 minuto / velocidad 10. Baja los ingredientes al fondo del vaso y mezcla 30 segundos / velocidad 8. Reserva en la nevera o utiliza a tu conveniencia."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pesa el eritritol y pulveriza 30 segundos / velocidad 10. Reserva en un bol.\nPesa las avellanas y tritura 30 segundos /velocidad 10. Baja las avellanas al fondo del vaso con la espátula y repite este paso hasta obtener una crema fina de avellanas.\nAñade el eritritol reservado, el aceite, el cacao, la vainilla y la leche y tritura 1 minuto / velocidad 10. Baja los ingredientes al fondo del vaso y mezcla 30 segundos / velocidad 8. Reserva en la nevera o utiliza a tu conveniencia.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-barcelona.es")
    expect(recipe.canonical_url).to eq("https://thermomix-barcelona.es/sonia-ripoll/dietas-especiales/crema-de-avellanas-leche-cacao-sin-azucar-sin-gluten-y-sin-lactosa-con-thermomix")
    expect(recipe.site_name).to eq("Thermomix Barcelona")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("SONIA RIPOLL MASSANES")
    expect(recipe.description).to eq("CREMA DE AVELLANAS, LECHE, CACAO SIN AZUCAR SIN GLUTEN Y SIN LACTOSA con Thermomix, una receta de Dietas especiales, elaborada por SONIA RIPOLL MASSANES. Descubre las mejores recetas de Blogosfera Thermomix Barcelona")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/d0810d0cda466de2507348f91e43700f_a29bbba2a6/d0810d0cda466de2507348f91e43700f_a29bbba2a6.jpg")
    expect(recipe.category).to eq("Dietas especiales")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("1 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["CREMA DE AVELLANAS", "LECHE", "CACAO SIN AZUCAR SIN GLUTEN Y SIN LACTOSA con Thermomix", "Dietas especiales"])
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
