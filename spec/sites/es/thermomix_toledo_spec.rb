# frozen_string_literal: true

RSpec.describe "thermomix-toledo.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_toledo", url: "https://thermomix-toledo.es/raquel-puerto-prado/masas-panes-reposteria/pan-de-centeno-y-espelta-con-thermomix") }

  it "reads the title" do
    expect(recipe.title).to eq("Pan de Centeno y Espelta con Thermomix")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "200 g de harina de centeno",
      "300 g de agua",
      "1 g de levadura de panadería seca",
      "500 g de harina de espelta",
      "200 g de agua",
      "15 g de aceite de oliva",
      "1 cucharaditas de sal",
      "1 cucharadita de azucar"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 200.0, unit: "g", name: "harina de centeno" },
      { amount: 300.0, unit: "g", name: "agua" },
      { amount: 1.0, unit: "g", name: "levadura de panadería seca" },
      { amount: 500.0, unit: "g", name: "harina de espelta" },
      { amount: 200.0, unit: "g", name: "agua" },
      { amount: 15.0, unit: "g", name: "aceite de oliva" },
      { amount: 1.0, unit: "cucharaditas", name: "sal" },
      { amount: 1.0, unit: "cucharadita", name: "azucar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "PREFERMENTOAñadir en un bote 300g de agua, la harina de centeno y la levadura secamezclar con una cuchara de madera y esperar que doble el volumen",
      "Incorporar en el vaso del thermomixla harina de espelta, la sal, el azúcar, 200g de agua, el aceite y el Pre fermentoAMASAR 3 minutos",
      "Añadir la mezcla en un molde grande o dos moldes más pequeños y dejar reposar dentro del horno sin temperatura hasta que doble el volumen",
      "Cuando a doblado su volumen hornear 180 grados arriba y abajo sin aire",
      "Y listo para comer"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("PREFERMENTOAñadir en un bote 300g de agua, la harina de centeno y la levadura secamezclar con una cuchara de madera y esperar que doble el volumen\nIncorporar en el vaso del thermomixla harina de espelta, la sal, el azúcar, 200g de agua, el aceite y el Pre fermentoAMASAR 3 minutos\nAñadir la mezcla en un molde grande o dos moldes más pequeños y dejar reposar dentro del horno sin temperatura hasta que doble el volumen\nCuando a doblado su volumen hornear 180 grados arriba y abajo sin aire\nY listo para comer")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-toledo.es")
    expect(recipe.canonical_url).to eq("https://thermomix-toledo.es/raquel-puerto-prado/masas-panes-reposteria/pan-de-centeno-y-espelta-con-thermomix")
    expect(recipe.site_name).to eq("Thermomix Toledo")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("RAQUEL PUERTO PRADO")
    expect(recipe.description).to eq("Pan de Centeno y Espelta con Thermomix, una receta de Masas, panes y repostería, elaborada por RAQUEL PUERTO PRADO. Descubre las mejores recetas de Blogosfera Thermomix Toledo")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/ce4e92e1372c7e04dd025b03800e5425_f62b820856/ce4e92e1372c7e04dd025b03800e5425_f62b820856.jpg")
    expect(recipe.category).to eq("Masas, panes y repostería")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("20 servings")
    expect(recipe.total_time).to eq(6)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Pan de Centeno y Espelta con Thermomix", "Masas", "panes y repostería"])
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
