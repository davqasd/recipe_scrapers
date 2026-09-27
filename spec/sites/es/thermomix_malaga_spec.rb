# frozen_string_literal: true

RSpec.describe "thermomix-malaga.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_malaga", url: "https://thermomix-malaga.es/lidia-martin/pescados-y-mariscos/curry-de-langostinos") }

  it "reads the title" do
    expect(recipe.title).to eq("Curry de langostinos")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "40g aceite",
      "100g cebolla en trozos",
      "10g cilantro fresco",
      "20g jenjibre",
      "3 dientes de ajo",
      "2 cucharaditas comino molido",
      "1/2 cucharadita de cúrcuma molida",
      "1 cucharadita de curry",
      "1 cucharadita sal",
      "70g de tomate concentrado",
      "400g leche coco",
      "800g langostinos crudos medianos pelados"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 40.0, unit: "g", name: "aceite" },
      { amount: 100.0, unit: "g", name: "cebolla en trozos" },
      { amount: 10.0, unit: "g", name: "cilantro fresco" },
      { amount: 20.0, unit: "g", name: "jenjibre" },
      { amount: 3.0, unit: "dientes", name: "ajo" },
      { amount: 2.0, unit: "cucharaditas", name: "comino molido" },
      { amount: 0.5, unit: "cucharadita", name: "cúrcuma molida" },
      { amount: 1.0, unit: "cucharadita", name: "curry" },
      { amount: 1.0, unit: "cucharadita", name: "sal" },
      { amount: 70.0, unit: "g", name: "tomate concentrado" },
      { amount: 400.0, unit: "g", name: "leche coco" },
      { amount: 800.0, unit: "g", name: "langostinos crudos medianos pelados" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Pasos de preparaciónPonga en el vaso el aceite, la cebolla, las hojas de cilantro, el jengibre y los ajos y triture 10 seg/vel 5. Con la espátula, baje los ingredientes hacia el fondo del vaso y, sin poner el cubilete, sofría 6 min/120°C/vel 2.",
      "Añada el comino molido, la cúrcuma molida, el curry y la sal y, sin poner el cubilete, programe 5 min/100°C/vel 2.",
      "Añada el tomate concentrado y la leche de coco y programe 5 min/100°C/vel 2. Triture 30 seg, vel 8.",
      "Añada al vaso del Thermomix los langostinos y programe 4 min/90°C/ giro inverso/ vel cuchara.",
      "Retire del vaso el curry de langostinos, espolvoree con hojas de cilantro fresco y sirva con arroz basmati."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Pasos de preparaciónPonga en el vaso el aceite, la cebolla, las hojas de cilantro, el jengibre y los ajos y triture 10 seg/vel 5. Con la espátula, baje los ingredientes hacia el fondo del vaso y, sin poner el cubilete, sofría 6 min/120°C/vel 2.\nAñada el comino molido, la cúrcuma molida, el curry y la sal y, sin poner el cubilete, programe 5 min/100°C/vel 2.\nAñada el tomate concentrado y la leche de coco y programe 5 min/100°C/vel 2. Triture 30 seg, vel 8.\nAñada al vaso del Thermomix los langostinos y programe 4 min/90°C/ giro inverso/ vel cuchara.\nRetire del vaso el curry de langostinos, espolvoree con hojas de cilantro fresco y sirva con arroz basmati.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-malaga.es")
    expect(recipe.canonical_url).to eq("https://thermomix-malaga.es/lidia-martin/pescados-y-mariscos/curry-de-langostinos")
    expect(recipe.site_name).to eq("Thermomix Málaga")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("LIDIA MARTIN DIAZ")
    expect(recipe.description).to eq("Curry de langostinos, una receta de Pescados y mariscos, elaborada por LIDIA MARTIN DIAZ. Descubre las mejores recetas de Blogosfera Thermomix Málaga")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/43ab2f691a9441bce13cb3f5b87d6cbc_8e1514787b/43ab2f691a9441bce13cb3f5b87d6cbc_8e1514787b.jpg")
    expect(recipe.category).to eq("Pescados y mariscos")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("0 servings")
    expect(recipe.total_time).to eq(10)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Curry de langostinos", "Pescados y mariscos"])
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
