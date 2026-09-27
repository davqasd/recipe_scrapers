# frozen_string_literal: true

RSpec.describe "thermomix-jerez.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_jerez", url: "https://thermomix-jerez.es/carmen-bejarano-busto/aperitivos-entrantes-tapas/ajo-campero") }

  it "reads the title" do
    expect(recipe.title).to eq("AJO CAMPERO CON THERMOMIX 3.0")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "* 700g de tomates medianos y rojos",
      "* 200g de pimientos verdes",
      "* 120g de aceite de oliva",
      "* 1200g de agua",
      "* 6 u 8 dientes de ajos ( 30g )",
      "* 500g de pan de campo (de un día para otro, solo la miga)",
      "* sal al gusto"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 700.0, unit: "g", name: "tomates medianos y rojos" },
      { amount: 200.0, unit: "g", name: "pimientos verdes" },
      { amount: 120.0, unit: "g", name: "aceite de oliva" },
      { amount: 1200.0, unit: "g", name: "agua" },
      { amount: 6.0, unit: nil, name: "u 8 dientes de ajos" },
      { amount: 500.0, unit: "g", name: "pan de campo" },
      { amount: nil, unit: nil, name: "sal al gusto" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "*Cueza los tomates en el cestillo para escaldarlos con el agua durante 20 minutos/temp. varoma/vel 1",
      "* Reservar el agua y pelar los tomates",
      "* Troceamos los ajos y los pimientos 5 seg/vel 5",
      "* Seguidamente eche los tomates sin la piel y vuelva a trocear 4 seg/vel 5",
      "*Añada el pan troceado y encima de este medio litro del agua de haber cocido los tomates y la sal.",
      "*Programe 7 mtos/temp 60º/giro a la izquierda/ vel 3 e ir agregando por el vocal el aceite poco a poco, ayudandose de la espatula si fuese necesario, en tm7 tendrá que quitar la tapa y envolver con la espatulade adentro hacia fuera hasta que quede bien integrado al menos 2 veces durante los 7 mtos."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("*Cueza los tomates en el cestillo para escaldarlos con el agua durante 20 minutos/temp. varoma/vel 1\n* Reservar el agua y pelar los tomates\n* Troceamos los ajos y los pimientos 5 seg/vel 5\n* Seguidamente eche los tomates sin la piel y vuelva a trocear 4 seg/vel 5\n*Añada el pan troceado y encima de este medio litro del agua de haber cocido los tomates y la sal.\n*Programe 7 mtos/temp 60º/giro a la izquierda/ vel 3 e ir agregando por el vocal el aceite poco a poco, ayudandose de la espatula si fuese necesario, en tm7 tendrá que quitar la tapa y envolver con la espatulade adentro hacia fuera hasta que quede bien integrado al menos 2 veces durante los 7 mtos.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-jerez.es")
    expect(recipe.canonical_url).to eq("https://thermomix-jerez.es/carmen-bejarano-busto/aperitivos-entrantes-tapas/ajo-campero")
    expect(recipe.site_name).to eq("Thermomix Jerez")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("CARMEN BEJARANO BUSTO")
    expect(recipe.description).to eq("NOTA: Servir caliente y acompañado de huevos duros, pimientos asados, rabanos.....")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/Screenshot_20260228_101846_Samsung_Internet_add97226d1/Screenshot_20260228_101846_Samsung_Internet_add97226d1.jpg")
    expect(recipe.category).to eq("Aperitivos, entrantes y tapas")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to eq(1)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["AJO CAMPERO CON THERMOMIX 3.0", "Aperitivos", "entrantes y tapas"])
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
