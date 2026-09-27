# frozen_string_literal: true

RSpec.describe "thermomix-gijon.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_gijon", url: "https://thermomix-gijon.es/isabel-fernandez-rodriguez-1/postres-y-dulces/leche-frita") }

  it "reads the title" do
    expect(recipe.title).to eq("LECHE FRITA")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "1000 g de leche entera",
      "250 g de azúcar",
      "200 g de harina de repostería",
      "50 g de maicena",
      "1 ½ cucharaditas de canela molida",
      "1 pellizco de sal",
      "2 huevos batidos (para rebozar)",
      "300 g de aceite para freír"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 1000.0, unit: "g", name: "leche entera" },
      { amount: 250.0, unit: "g", name: "azúcar" },
      { amount: 200.0, unit: "g", name: "harina de repostería" },
      { amount: 50.0, unit: "g", name: "maicena" },
      { amount: 1.5, unit: "cucharaditas", name: "canela molida" },
      { amount: 1.0, unit: nil, name: "pellizco de sal" },
      { amount: 2.0, unit: nil, name: "huevos batidos" },
      { amount: 300.0, unit: "g", name: "aceite para freír" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Ponga en el vaso la leche, 150 g de azúcar, 100 g de harina, la maicena, ½ cucharadita de canela y la sal. Sin poner el cubilete, programe 12 min/100°C/vel 4. Vierta la crema en un molde de silicona cuadrado de aprox. 25x25 cm (tiene que quedar de un espesor de aprox. 2 cm), deje enfriar y reserve en el frigorífico durante aprox. 2 horas o hasta que esté bien cuajada.",
      "Corte la crema fría en 24 porciones, páselas por harina (los 100 g restantes) y huevo batido y fríalas en abundante aceite caliente. Rebócelas en una mezcla de 100 g de azúcar y 1 cucharadita de canela y listo"
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Ponga en el vaso la leche, 150 g de azúcar, 100 g de harina, la maicena, ½ cucharadita de canela y la sal. Sin poner el cubilete, programe 12 min/100°C/vel 4. Vierta la crema en un molde de silicona cuadrado de aprox. 25x25 cm (tiene que quedar de un espesor de aprox. 2 cm), deje enfriar y reserve en el frigorífico durante aprox. 2 horas o hasta que esté bien cuajada.\nCorte la crema fría en 24 porciones, páselas por harina (los 100 g restantes) y huevo batido y fríalas en abundante aceite caliente. Rebócelas en una mezcla de 100 g de azúcar y 1 cucharadita de canela y listo")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-gijon.es")
    expect(recipe.canonical_url).to eq("https://thermomix-gijon.es/isabel-fernandez-rodriguez-1/postres-y-dulces/leche-frita")
    expect(recipe.site_name).to eq("Thermomix Asturias")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("ISABEL FERNANDEZ RODRIGUEZ")
    expect(recipe.description).to eq("LECHE FRITA, una receta de Postres y dulces, elaborada por ISABEL FERNANDEZ RODRIGUEZ. Descubre las mejores recetas de Blogosfera Thermomix Asturias")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/32b847459c8e55ac94a31eb74991006b_1b7cf43df9/32b847459c8e55ac94a31eb74991006b_1b7cf43df9.jpg")
    expect(recipe.category).to eq("Postres y dulces")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("12 servings")
    expect(recipe.total_time).to eq(2)
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["LECHE FRITA", "Postres y dulces"])
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
