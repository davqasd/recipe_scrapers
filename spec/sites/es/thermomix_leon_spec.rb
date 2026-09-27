# frozen_string_literal: true

RSpec.describe "thermomix-leon.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_leon", url: "https://thermomix-leon.es/eva-fernandez-malillos/postres-y-dulces/san-valentin") }

  it "reads the title" do
    expect(recipe.title).to eq("San Valentín")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "2 manzanas reineta",
      "Ron",
      "Mantequilla",
      "Masa de hojaldre"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 2.0, unit: nil, name: "manzanas reineta" },
      { amount: nil, unit: nil, name: "Ron" },
      { amount: nil, unit: nil, name: "Mantequilla" },
      { amount: nil, unit: nil, name: "Masa de hojaldre" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Mezclar los ingredientes y poner 8 minutos al varoma las manzanas en láminas",
      "Montar las rosas con tiras de hojaldre"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Mezclar los ingredientes y poner 8 minutos al varoma las manzanas en láminas\nMontar las rosas con tiras de hojaldre")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-leon.es")
    expect(recipe.canonical_url).to eq("https://thermomix-leon.es/eva-fernandez-malillos/postres-y-dulces/san-valentin")
    expect(recipe.site_name).to eq("Thermomix León")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("EVA FERNANDEZ MALILLOS")
    expect(recipe.description).to eq("San Valentín, una receta de Postres y dulces, elaborada por EVA FERNANDEZ MALILLOS. Descubre las mejores recetas de Blogosfera Thermomix León")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/94a7154cd1b160792d06af702feff000_0d0e264e87/94a7154cd1b160792d06af702feff000_0d0e264e87.jpg")
    expect(recipe.category).to eq("Postres y dulces")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("6 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["San Valentín", "Postres y dulces"])
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
