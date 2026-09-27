# frozen_string_literal: true

RSpec.describe "thermomix-pontevedra.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_pontevedra", url: "https://thermomix-pontevedra.es/edith-marg-fernandez-zamora/bebidas/receta-facil-y-veraniega-con-thermomix-batido-de-pina-y-leche-de-coco") }

  it "reads the title" do
    expect(recipe.title).to eq("\"Receta fácil y veraniega con Thermomix®: BATIDO DE PIÑA Y LECHE DE COCO")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "500 g de piña fresca pelada y en trozos",
      "500 g de leche de coco",
      "200 g de cubitos de hielo",
      "100 g de azúcar",
      "20 g de zumo de limón",
      "6 trozos de piña para decorar"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 500.0, unit: "g", name: "piña fresca pelada y en trozos" },
      { amount: 500.0, unit: "g", name: "leche de coco" },
      { amount: 200.0, unit: "g", name: "cubitos de hielo" },
      { amount: 100.0, unit: "g", name: "azúcar" },
      { amount: 20.0, unit: "g", name: "zumo de limón" },
      { amount: 6.0, unit: "trozos", name: "piña para decorar" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Ponga la piña, la leche de coco, el hielo, el azúcar , el zumo de limón, en el vaso e inicie Triturar /2 min.",
      "Ponerle el jengibre si lo desea también con el resto de ingredientes,Vierta en una jarra y sirva luego en cada vaso o copa y decore cada uno con un trozo de piña."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Ponga la piña, la leche de coco, el hielo, el azúcar , el zumo de limón, en el vaso e inicie Triturar /2 min.\nPonerle el jengibre si lo desea también con el resto de ingredientes,Vierta en una jarra y sirva luego en cada vaso o copa y decore cada uno con un trozo de piña.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-pontevedra.es")
    expect(recipe.canonical_url).to eq("https://thermomix-pontevedra.es/edith-marg-fernandez-zamora/bebidas/receta-facil-y-veraniega-con-thermomix-batido-de-pina-y-leche-de-coco")
    expect(recipe.site_name).to eq("Thermomix Pontevedra")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("EDITH MARG FERNANDEZ ZAMORA")
    expect(recipe.description).to eq("\"Receta fácil y veraniega con Thermomix®: BATIDO DE PIÑA Y LECHE DE COCO, una receta de Bebidas, elaborada por EDITH MARG FERNANDEZ ZAMORA. Descubre las mejores recetas de Blogosfera Thermomix Pontevedra")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/766e16b941475aed3f6f384b62ece65f_11da95c116/766e16b941475aed3f6f384b62ece65f_11da95c116.jpg")
    expect(recipe.category).to eq("Bebidas")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["\"Receta fácil y veraniega con Thermomix®: BATIDO DE PIÑA Y LECHE DE COCO", "Bebidas"])
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
