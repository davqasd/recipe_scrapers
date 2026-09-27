# frozen_string_literal: true

RSpec.describe "thermomix-mostoles.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_mostoles", url: "https://thermomix-mostoles.es/ainara-turuelo/postres-y-dulces/tiramisu-de-naranja") }

  it "reads the title" do
    expect(recipe.title).to eq("Tiramisú de naranja")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 huevo",
      "2 yemas de huevo",
      "130 gr azúcar",
      "500 gr mascarpone",
      "1 cucharada de piel de Naranja rallada",
      "300 gr bizcochos de soletilla o savoiardi",
      "250 gr zumo de naranja recién exprimido",
      "1 cucharada de cacao en polvo",
      "1 cucharada de piel de naranja rallada o en tiras finas"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "huevo" },
      { amount: 2.0, unit: nil, name: "yemas de huevo" },
      { amount: 130.0, unit: "gr", name: "azúcar" },
      { amount: 500.0, unit: "gr", name: "mascarpone" },
      { amount: 1.0, unit: "cucharada", name: "piel de Naranja rallada" },
      { amount: 300.0, unit: "gr", name: "bizcochos de soletilla o savoiardi" },
      { amount: 250.0, unit: "gr", name: "zumo de naranja recién exprimido" },
      { amount: 1.0, unit: "cucharada", name: "cacao en polvo" },
      { amount: 1.0, unit: "cucharada", name: "piel de naranja rallada o en tiras finas" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Coloque la mariposa en las cuchillas.Coloque la mariposa en las cuchillas.Añada el huevo, las yemas y el azúcar y bata 4 min/ vel 3,5",
      "Añade el queso Mascarpone y la piel de naranja y mezcle 30 seg/vel 3. Retire la mariposa.",
      "Remoje brevemente la mitad de los bizcochos de Soletilla en el zumo de naranja, lo justo para que se empapen sin romperse, y vaya colocándolos en el fondo de una fuente rectangular (23cmx15cmx8cm)",
      "Extienda la mitad de la mezcla de Mascarpone sobre la base de bizcochos.Extienda la mitad de la mezcla de mascarpone sobre la base de bizcochos.Remoje los bizcochos restantes, colóquelos sobre la crema y cubra con el resto de la crema de mascarpone.Cubra con film trasparente y refrigere durante 5 horas, espolvoree con piel de naranja rallada y cacao en polvo,corte y sirva."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Coloque la mariposa en las cuchillas.Coloque la mariposa en las cuchillas.Añada el huevo, las yemas y el azúcar y bata 4 min/ vel 3,5\nAñade el queso Mascarpone y la piel de naranja y mezcle 30 seg/vel 3. Retire la mariposa.\nRemoje brevemente la mitad de los bizcochos de Soletilla en el zumo de naranja, lo justo para que se empapen sin romperse, y vaya colocándolos en el fondo de una fuente rectangular (23cmx15cmx8cm)\nExtienda la mitad de la mezcla de Mascarpone sobre la base de bizcochos.Extienda la mitad de la mezcla de mascarpone sobre la base de bizcochos.Remoje los bizcochos restantes, colóquelos sobre la crema y cubra con el resto de la crema de mascarpone.Cubra con film trasparente y refrigere durante 5 horas, espolvoree con piel de naranja rallada y cacao en polvo,corte y sirva.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-mostoles.es")
    expect(recipe.canonical_url).to eq("https://thermomix-mostoles.es/ainara-turuelo/postres-y-dulces/tiramisu-de-naranja")
    expect(recipe.site_name).to eq("Thermomix Móstoles")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("* CRISTINA FONSECA")
    expect(recipe.description).to eq("Tiramisú de naranja, una receta de Postres y dulces, elaborada por * CRISTINA FONSECA. Descubre las mejores recetas de Blogosfera Thermomix Móstoles")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/fb22646b4a149d2ef836b8882511e1e1_eb1aa6391f/fb22646b4a149d2ef836b8882511e1e1_eb1aa6391f.jpg")
    expect(recipe.category).to eq("Postres y dulces")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to eq(20)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Tiramisú de naranja", "Postres y dulces"])
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
