# frozen_string_literal: true

RSpec.describe "thermomix-talavera.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_talavera", url: "https://thermomix-talavera.es/raquel-ballesteros-lopez/postres-y-dulces/tiramisu-de-naranja-1") }

  it "reads the title" do
    expect(recipe.title).to eq("TIRAMISU DE NARANJA")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 huevo y 2 yemas de huevo",
      "500 gr de queso mascarpone",
      "130 gr de azucar",
      "300 gr de bizcocho soletillas",
      "250 gr de zumo de naranja",
      "1 cucharada de cacao en polvo",
      "1 cucharada de piel de naranja rallada"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "huevo y 2 yemas de huevo" },
      { amount: 500.0, unit: "gr", name: "queso mascarpone" },
      { amount: 130.0, unit: "gr", name: "azucar" },
      { amount: 300.0, unit: "gr", name: "bizcocho soletillas" },
      { amount: 250.0, unit: "gr", name: "zumo de naranja" },
      { amount: 1.0, unit: "cucharada", name: "cacao en polvo" },
      { amount: 1.0, unit: "cucharada", name: "piel de naranja rallada" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Colocar la mariposa en las cuchillas y añadir el huevo, las yemas y el azucar y batir 4min./ vel 3,5",
      "Añadir queso mascarpone, la piel de naranja y mezclar 30 seg./vel 3. Retirar mariposa",
      "Remojar brevemente la mitad de los bizcochos soletilla en el zumo de naranja y colocarlos en un fuente. Extender la mitad de la mezcla de mascarpone sobre los bizcochos. Repetir la operacion con el resto de bizcochos y mezcla.Refrigerar durante 5 horasEspolvorear con cacao y pepitas de piel de naranjaCorte, sirva y a disfrutar"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Colocar la mariposa en las cuchillas y añadir el huevo, las yemas y el azucar y batir 4min./ vel 3,5\nAñadir queso mascarpone, la piel de naranja y mezclar 30 seg./vel 3. Retirar mariposa\nRemojar brevemente la mitad de los bizcochos soletilla en el zumo de naranja y colocarlos en un fuente. Extender la mitad de la mezcla de mascarpone sobre los bizcochos. Repetir la operacion con el resto de bizcochos y mezcla.Refrigerar durante 5 horasEspolvorear con cacao y pepitas de piel de naranjaCorte, sirva y a disfrutar")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-talavera.es")
    expect(recipe.canonical_url).to eq("https://thermomix-talavera.es/raquel-ballesteros-lopez/postres-y-dulces/tiramisu-de-naranja-1")
    expect(recipe.site_name).to eq("Thermomix Talavera")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("RAQUEL BALLESTEROS LOPEZ")
    expect(recipe.description).to eq("TIRAMISU DE NARANJA, una receta de Postres y dulces, elaborada por RAQUEL BALLESTEROS LOPEZ. Descubre las mejores recetas de Blogosfera Thermomix Talavera")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/ac04e441693406d11684723e206d21ea_b47b639f5c/ac04e441693406d11684723e206d21ea_b47b639f5c.jpg")
    expect(recipe.category).to eq("Postres y dulces")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("4 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["TIRAMISU DE NARANJA", "Postres y dulces"])
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
