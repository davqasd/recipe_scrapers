# frozen_string_literal: true

RSpec.describe "thermomix-badajoz.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_badajoz", url: "https://thermomix-badajoz.es/rocio-gallego-fernandez/masas-panes-reposteria/galletitas-chips-ahoy") }

  it "reads the title" do
    expect(recipe.title).to eq("Galletitas chips Ahoy")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "110 grs de mantequilla",
      "1 huevo",
      "20grs azucar blanca",
      "50grs azucar moreno",
      "150 grs harina trigo",
      "3grs sal",
      "3grs bicarbonato sodio",
      "50grs chips de chocolate"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 110.0, unit: "grs", name: "mantequilla" },
      { amount: 1.0, unit: nil, name: "huevo" },
      { amount: 20.0, unit: "grs", name: "azucar blanca" },
      { amount: 50.0, unit: "grs", name: "azucar moreno" },
      { amount: 150.0, unit: "grs", name: "harina trigo" },
      { amount: 3.0, unit: "grs", name: "sal" },
      { amount: 3.0, unit: "grs", name: "bicarbonato sodio" },
      { amount: 50.0, unit: "grs", name: "chips de chocolate" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Ponemos la mantequilla y programamos 40° en modo calentar.( 10min/40°/vel 2)",
      "Añadimos el huevo,azúcar blanco, azúcar Moreno, mezclamos 10seg/vel3.",
      "Añadimos la harina, sal, bicarbonato y mezclamos 10seg/vel3.",
      "Añadimos las chips chocolate y mezclamos 3seg/vel2.",
      "Pasamos a una manga pastelera y formamos pequeñas porciones tipo una moneda en el papel de horno. Ponemos en el horno a 190° y horneamos durante 8 ó 9 minutos, observamos que estén los bordes dorados y las galletas dora ditas, retiramos del horno y dejamos enfriar antes conservarlas en una cajita o un bote de cristal."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Ponemos la mantequilla y programamos 40° en modo calentar.( 10min/40°/vel 2)\nAñadimos el huevo,azúcar blanco, azúcar Moreno, mezclamos 10seg/vel3.\nAñadimos la harina, sal, bicarbonato y mezclamos 10seg/vel3.\nAñadimos las chips chocolate y mezclamos 3seg/vel2.\nPasamos a una manga pastelera y formamos pequeñas porciones tipo una moneda en el papel de horno. Ponemos en el horno a 190° y horneamos durante 8 ó 9 minutos, observamos que estén los bordes dorados y las galletas dora ditas, retiramos del horno y dejamos enfriar antes conservarlas en una cajita o un bote de cristal.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-badajoz.es")
    expect(recipe.canonical_url).to eq("https://thermomix-badajoz.es/rocio-gallego-fernandez/masas-panes-reposteria/galletitas-chips-ahoy")
    expect(recipe.site_name).to eq("Thermomix Badajoz")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("ROCIO GALLEGO FERNANDEZ")
    expect(recipe.description).to eq("Espero que os gusten estas pequeñas galletas deliciosas.")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/IMG_0448_4865ac88ac/IMG_0448_4865ac88ac.jpeg")
    expect(recipe.category).to eq("Masas, panes y repostería")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(15)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Galletitas chips Ahoy", "Masas", "panes y repostería"])
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
