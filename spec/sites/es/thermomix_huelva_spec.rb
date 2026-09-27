# frozen_string_literal: true

RSpec.describe "thermomix-huelva.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_huelva", url: "https://thermomix-huelva.es/maria-jose-canaveras-trillo/masas-panes-reposteria/bizcocho-de-yogur-en-thermomix-el-clasico-que-siempre-sale-bien") }

  it "reads the title" do
    expect(recipe.title).to eq("Bizcocho de yogur en Thermomix: el clásico que siempre sale bien")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1 yogur natural (125 g)",
      "3 huevos",
      "180 g de azúcar",
      "100 g de aceite de girasol o suave de oliva",
      "220 g de harina de repostería",
      "1 sobre de levadura química",
      "Una pizca de sal",
      "Ralladura de limón o vainilla (opcional)"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1.0, unit: nil, name: "yogur natural" },
      { amount: 3.0, unit: nil, name: "huevos" },
      { amount: 180.0, unit: "g", name: "azúcar" },
      { amount: 100.0, unit: "g", name: "aceite de girasol o suave de oliva" },
      { amount: 220.0, unit: "g", name: "harina de repostería" },
      { amount: 1.0, unit: nil, name: "sobre de levadura química" },
      { amount: nil, unit: nil, name: "Una pizca de sal" },
      { amount: nil, unit: nil, name: "Ralladura de limón o vainilla" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Precalienta el horno a 180°C y engrasa un molde de unos 22 cm.",
      "Pon en el vaso el yogur, los huevos, el azúcar y el aceite. Mezcla 30 seg / vel 4.",
      "Añade la harina, la levadura, la sal y la ralladura de limón si la usas. Mezcla 15 seg / vel 5.",
      "Termina de integrar con la espátula y vierte la masa en el molde.",
      "Hornea durante 35-40 minutos, o hasta que al pinchar con un palillo salga limpio."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Precalienta el horno a 180°C y engrasa un molde de unos 22 cm.\nPon en el vaso el yogur, los huevos, el azúcar y el aceite. Mezcla 30 seg / vel 4.\nAñade la harina, la levadura, la sal y la ralladura de limón si la usas. Mezcla 15 seg / vel 5.\nTermina de integrar con la espátula y vierte la masa en el molde.\nHornea durante 35-40 minutos, o hasta que al pinchar con un palillo salga limpio.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-huelva.es")
    expect(recipe.canonical_url).to eq("https://thermomix-huelva.es/maria-jose-canaveras-trillo/masas-panes-reposteria/bizcocho-de-yogur-en-thermomix-el-clasico-que-siempre-sale-bien")
    expect(recipe.site_name).to eq("Thermomix Huelva")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("MARIA JOSE CAÑAVERAS TRILLO")
    expect(recipe.description).to eq("Bizcocho de yogur en Thermomix: el clásico que siempre sale bien, una receta de Masas, panes y repostería, elaborada por MARIA JOSE CAÑAVERAS TRILLO. Descubre las mejores recetas de Blogosfera Thermomix Huelva")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/bizcocho_7e178d3e52/bizcocho_7e178d3e52.png")
    expect(recipe.category).to eq("Masas, panes y repostería")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("8 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Bizcocho de yogur en Thermomix: el clásico que siempre sale bien", "Masas", "panes y repostería"])
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
