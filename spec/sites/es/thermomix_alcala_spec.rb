# frozen_string_literal: true

RSpec.describe "thermomix-alcala.es" do
  subject(:recipe) { scrape_cassette("es/thermomix_alcala", url: "https://thermomix-alcala.es/tugba-munoz-benitez/postres-y-dulces/mejor-receta-de-la-historia-de-thermomixat-tarta-de-crema-pastelera-y-fresas-estamos-celebrando-el-140-aniversario-de-vorwerk") }

  it "reads the title" do
    expect(recipe.title).to eq("Mejor receta de la historia de Thermomix@\" Tarta de crema pastelera y fresas Estamos celebrando el 140 aniversario de Vorwerk")
  end

  it "reads every ingredient line" do
    expect(recipe.ingredients).to eq([
      "80 g de azúcar",
      "5 tiras de piel de limón solo la parte amarilla",
      "120 g mantequilla en trozos",
      "2 yemas de huevo",
      "1 vaina de vainilla (sólo la raspadura)",
      "1 pellizco de sal",
      "210 g de harina de repostería",
      "1 clara de huevo",
      "500 g de leche",
      "5 yemas de huevo",
      "100 g de azúcar",
      "40 g de harina de reposteria",
      "10 g de maicena",
      "1 pellizco de sal",
      "250 g de fresas cortadas por la mitad o lo largo"
    ])
  end

  it "parses every ingredient line into an amount, a unit and an ingredient" do
    expect(recipe.parsed_ingredients.map(&:to_h)).to eq([
      { amount: 80.0, unit: "g", name: "azúcar" },
      { amount: 5.0, unit: nil, name: "tiras de piel de limón solo la parte amarilla" },
      { amount: 120.0, unit: "g", name: "mantequilla en trozos" },
      { amount: 2.0, unit: nil, name: "yemas de huevo" },
      { amount: 1.0, unit: nil, name: "vaina de vainilla" },
      { amount: 1.0, unit: nil, name: "pellizco de sal" },
      { amount: 210.0, unit: "g", name: "harina de repostería" },
      { amount: 1.0, unit: nil, name: "clara de huevo" },
      { amount: 500.0, unit: "g", name: "leche" },
      { amount: 5.0, unit: nil, name: "yemas de huevo" },
      { amount: 100.0, unit: "g", name: "azúcar" },
      { amount: 40.0, unit: "g", name: "harina de reposteria" },
      { amount: 10.0, unit: "g", name: "maicena" },
      { amount: 1.0, unit: nil, name: "pellizco de sal" },
      { amount: 250.0, unit: "g", name: "fresas cortadas por la mitad o lo largo" }
    ])
  end

  it "reads every instruction step" do
    expect(recipe.instructions_list).to eq([
      "Ponga en el vaso el azúcar y la piel de limón y pulverice 15 seg/vel 10. Con la espátula, baje los ingredientes hacia el fondo del vaso.",
      "Coloque la mariposa en las cuchillas. Añada la mantequilla y bata 2 min/vel 3. Con la espátula, baje los ingredientes hacia el fondo del vaso.",
      "Añada las yemas, la raspadura de la vainilla y la sal y mezcle 2 min/vel 4. Retire la mariposa.",
      "Incorpore la harina y mezcle 30 seg/vel 4. Ponga la masa en la superficie de trabajo y forme una bola. Envuelva en film transparente y reserve en el frigorífico durante 30 minutos.",
      "Precaliente el horno a 170°C. Engrase un molde de tarta de Ø 26 cm.Con el rodillo, estire la masa hasta obtener un disco de aprox. Ø 28-30 cm (puede hacerlo entre 2 láminas de papel de hornear o entre 2 plásticos) y colóquela cubriendo el fondo y las paredes del molde. Pinche con un tenedor toda la superficie y los laterales de la masa. Cubra la masa con papel de hornear y ponga encima las legumbres secas o bolitas de cerámica para que la masa no suba al hornearse.Hornee durante 15 minutos (170°C). Retire las legumbres y el papel para hornear y hornee otros 10 minutos (170°C) o hasta que esté dorada. Retire del horno y pincele con la clara de huevo ligeramente batida.Ponga en el vaso la leche, las yemas, el azúcar, la harina, la maicena y la sal y programe 7 min/100°C/vel 4. Vierta la crema sobre la tarta y extiéndala de manera uniforme con la espátula.Coloque las fresas sobre la crema. Reserve en el frigorífico durante al menos 1 hora. Corte en porciones y sirva."
    ])
  end

  it "keeps every ingredient in one unnamed group" do
    expect(recipe.ingredient_groups.map(&:to_h)).
      to eq([{ purpose: nil, ingredients: recipe.ingredients, parsed_ingredients: recipe.parsed_ingredients }])
  end

  it "joins the steps into the instructions text" do
    expect(recipe.instructions).to eq("Ponga en el vaso el azúcar y la piel de limón y pulverice 15 seg/vel 10. Con la espátula, baje los ingredientes hacia el fondo del vaso.\nColoque la mariposa en las cuchillas. Añada la mantequilla y bata 2 min/vel 3. Con la espátula, baje los ingredientes hacia el fondo del vaso.\nAñada las yemas, la raspadura de la vainilla y la sal y mezcle 2 min/vel 4. Retire la mariposa.\nIncorpore la harina y mezcle 30 seg/vel 4. Ponga la masa en la superficie de trabajo y forme una bola. Envuelva en film transparente y reserve en el frigorífico durante 30 minutos.\nPrecaliente el horno a 170°C. Engrase un molde de tarta de Ø 26 cm.Con el rodillo, estire la masa hasta obtener un disco de aprox. Ø 28-30 cm (puede hacerlo entre 2 láminas de papel de hornear o entre 2 plásticos) y colóquela cubriendo el fondo y las paredes del molde. Pinche con un tenedor toda la superficie y los laterales de la masa. Cubra la masa con papel de hornear y ponga encima las legumbres secas o bolitas de cerámica para que la masa no suba al hornearse.Hornee durante 15 minutos (170°C). Retire las legumbres y el papel para hornear y hornee otros 10 minutos (170°C) o hasta que esté dorada. Retire del horno y pincele con la clara de huevo ligeramente batida.Ponga en el vaso la leche, las yemas, el azúcar, la harina, la maicena y la sal y programe 7 min/100°C/vel 4. Vierta la crema sobre la tarta y extiéndala de manera uniforme con la espátula.Coloque las fresas sobre la crema. Reserve en el frigorífico durante al menos 1 hora. Corte en porciones y sirva.")
  end

  it "reads the recipe metadata", :aggregate_failures do
    expect(recipe.host).to eq("thermomix-alcala.es")
    expect(recipe.canonical_url).to eq("https://thermomix-alcala.es/tugba-munoz-benitez/postres-y-dulces/mejor-receta-de-la-historia-de-thermomixat-tarta-de-crema-pastelera-y-fresas-estamos-celebrando-el-140-aniversario-de-vorwerk")
    expect(recipe.site_name).to eq("Thermomix Alcalá de Henares")
    expect(recipe.language).to eq("es")
    expect(recipe.author).to eq("TUGBA MUÑOZ BENITEZ")
    expect(recipe.description).to eq("Mejor receta de la historia de Thermomix@\" Tarta de crema pastelera y fresas Estamos celebrando el 140 aniversario de Vorwerk, una receta de Postres y dulces, elaborada por TUGBA MUÑOZ BENITEZ. Descubre las mejores recetas de Blogosfera Thermomix Alcalá de Henares")
    expect(recipe.image).to eq("https://medias.blogosferathermomix.es/blog-images-production/36340531e94493783f5637d32f78ad60_028a28ea9e/36340531e94493783f5637d32f78ad60_028a28ea9e.jpg")
    expect(recipe.category).to eq("Postres y dulces")
    expect(recipe.cuisine).to be_nil
    expect(recipe.cooking_method).to be_nil
    expect(recipe.yields).to eq("10 servings")
    expect(recipe.total_time).to be_nil
    expect(recipe.prep_time).to be_nil
    expect(recipe.cook_time).to be_nil
    expect(recipe.keywords).to eq(["Mejor receta de la historia de Thermomix@\" Tarta de crema pastelera y fresas Estamos celebrando el 140 aniversario de Vorwerk", "Postres y dulces"])
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
