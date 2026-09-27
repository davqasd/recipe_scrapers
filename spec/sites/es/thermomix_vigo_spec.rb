# frozen_string_literal: true

RSpec.describe "thermomix-vigo.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_vigo", url: "https://thermomix-vigo.es/juan-jose-pazos-castano/postres-y-dulces/yogur-griego-rapido-y-versatil") }

  it "reads the title" do
    expect(recipe.title).to eq("Yogur griego rápido y versátil")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "Leche entera 2 litros",
      "Leche entera en polvo 250gr",
      "Nata para montar 200gr",
      "Yogur griego 180gr"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: "litros", name: "Leche entera" },
      { amount: 250.0, unit: "gr", name: "Leche entera en polvo" },
      { amount: 200.0, unit: "gr", name: "Nata para montar" },
      { amount: 180.0, unit: "gr", name: "Yogur griego" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Añadimos al vaso 2 litros de leche fresca entera y los 250gr de leche en polvo entera, programamos 40 seg/velocidad 4",
      "a continuación programamos función calentar /50ºC",
      "añadimos 200gr de nata para montar y programamos 30seg/velocidad 3.5",
      "Añadimos 180gr de yogur griego y programamos 30seg/velocidad 3.5",
      "nos aseguramos de que no haya grumos y programamos modo fermentar 45ºC durante 8 horas. Pasado ese tiempo removemos bien con la espátula, lo pasamos a un recipiente y lo conservaremos en nevera"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Añadimos al vaso 2 litros de leche fresca entera y los 250gr de leche en polvo entera, programamos 40 seg/velocidad 4\na continuación programamos función calentar /50ºC\nañadimos 200gr de nata para montar y programamos 30seg/velocidad 3.5\nAñadimos 180gr de yogur griego y programamos 30seg/velocidad 3.5\nnos aseguramos de que no haya grumos y programamos modo fermentar 45ºC durante 8 horas. Pasado ese tiempo removemos bien con la espátula, lo pasamos a un recipiente y lo conservaremos en nevera")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-vigo.es")
    expect(recipe.canonical_url).to eq("https://thermomix-vigo.es/juan-jose-pazos-castano/postres-y-dulces/yogur-griego-rapido-y-versatil")
    expect(recipe.site_name).to eq("Thermomix Vigo")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("JUAN JOSE PAZOS CASTAÑO")
    expect(recipe.description).to eq("Este yogur nos durará en nevera sobre 8 días.")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/griego_75906cd728/griego_75906cd728.webp")
    expect(recipe.category).to eq("Postres y dulces")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Yogur griego rápido y versátil", "Postres y dulces"])
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
